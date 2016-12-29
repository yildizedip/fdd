package tr.com.fdd.struts.actions;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TLabrotuvarDTO;
import tr.com.fdd.dto.TLabrotuvarProvaDTO;
import tr.com.fdd.struts.form.LabrotuvarForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;
import tr.com.fdd.utils.enums.ProvaTip;

public class LaboratuvarRandevuVerAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Transaction tran = null;

		try {
			
			LabrotuvarForm labIslemForm = (LabrotuvarForm) form;		
		

			int id=labIslemForm.getId();
			
			Object[] sessionsArr = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			int alanisi=((TKullaniciLoginDTO) sessionsArr[0]).getKuId();

			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.TLabrotuvarDTO  p where p.id = :var");
			query.setInteger("var", id);
			TLabrotuvarDTO result = (TLabrotuvarDTO) query.uniqueResult();
			if(labIslemForm.getKlinikCikisTarStr()!=null )
			result.setLabCikisTar(Commons.convertStringToDate(labIslemForm.getLabCikisTarStr()));
			
			result.setDurum(LaboratuvarIslemDurum.KLINIK_ONAYDA.getState());
			result.setLabGondermeTar(new Date());
			result.setLabAciklama(labIslemForm.getLabAciklama());
			result.setAlanKisi(alanisi);
			
			
			if(labIslemForm.getMetalProvaTar()!=null){
				
				updateProvaDate(sess, labIslemForm.getMetalProvaTar(), id, ProvaTip.METAL.getVal());
			}
			
			if(labIslemForm.getIskeletProvaTar()!=null){
				
				updateProvaDate(sess, labIslemForm.getIskeletProvaTar(), id, ProvaTip.ISKELET.getVal());
			}
			if(labIslemForm.getZirkonProvaTar()!=null){
				
				updateProvaDate(sess, labIslemForm.getZirkonProvaTar(), id, ProvaTip.ZIRKON.getVal());
			}
			if(labIslemForm.getDentinProvaTar()!=null){
				
				updateProvaDate(sess, labIslemForm.getDentinProvaTar(), id, ProvaTip.DENTIN.getVal());
			}
			if(labIslemForm.getDisliProvaTar()!=null){
				
				updateProvaDate(sess, labIslemForm.getDisliProvaTar(), id, ProvaTip.DISLI.getVal());
			}			
			
			tran.commit();

			
			request.setAttribute("warn", GUIMessages.ISLEM_BASARILI);

			return mapping.findForward("success");

		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
			return mapping.findForward("exception");
		} finally {
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

	private void updateProvaDate(Session sess, String  dateStr,
			int id, int provaTip) throws HibernateException {
		Query queryProva=sess.createQuery(" from  tr.com.fdd.dto.TLabrotuvarProvaDTO as a where a.labIslemId = :p_lab_islem_id and a.provaTip = :p_prova_tip ");
		queryProva.setInteger("p_lab_islem_id", id);
		queryProva.setInteger("p_prova_tip",provaTip);
		
		TLabrotuvarProvaDTO resultProva=(TLabrotuvarProvaDTO) queryProva.uniqueResult();
		
		resultProva.setProvaTar(Commons.convertStringToDate(dateStr));
	}

}
