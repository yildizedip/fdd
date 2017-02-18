package tr.com.fdd.struts.actions;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

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

public class HastaLabrotuvarOnaylaRedAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Transaction tran = null;

		try {
			
			LabrotuvarForm labIslemForm = (LabrotuvarForm) form;		
		
			int id=labIslemForm.getId();
			
			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.TLabrotuvarDTO  p where p.id = :var");
			query.setInteger("var", id);
			
			TLabrotuvarDTO result = (TLabrotuvarDTO) query.uniqueResult();
			
			
		
			result.setAciklama(result.getAciklama() +" --- "+labIslemForm.getAciklama());
			result.setKlinikDegerlendirmeTar(Commons.convertStringToDate(labIslemForm.getKlinikDegerlendirmeTar()));
			result.setPuan(labIslemForm.getLabIslemPuan());
			
			
			if(labIslemForm.getLabIslemOnayRed().equals("1"))
				result.setDurum(LaboratuvarIslemDurum.LAB_ISLEM_OK.getState());
				
			else if (labIslemForm.getLabIslemOnayRed().equals("2")) {
				result.setDurum(LaboratuvarIslemDurum.LAB_ISLEM_RED.getState());
				insertLabIslemForRPT(labIslemForm, sess, result,request);
			}
			
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_BASARILI);

			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GUIMessages.HATA +" : "+ e.getMessage());
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

	private void insertLabIslemForRPT(LabrotuvarForm labForm, Session session,TLabrotuvarDTO result, HttpServletRequest request) throws HibernateException, ParseException {
		
		TLabrotuvarDTO labrotuvarDTO = new TLabrotuvarDTO();
		

		String klinikCikisTarStr = labForm.getKlinikDegerlendirmeTar();
		
		if (!klinikCikisTarStr.equals(""))
			labrotuvarDTO.setKlinikCikisTar(Commons.convertStringToDate(klinikCikisTarStr));
		
	      labrotuvarDTO.setIslemId(result.getIslemId());

			Object[] sessionsArr = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			
		labrotuvarDTO.setGonderenKisi(((TKullaniciLoginDTO) sessionsArr[0]).getKuId());
		labrotuvarDTO.setGondermeTar(new Date());
		labrotuvarDTO.setDurum(LaboratuvarIslemDurum.LABRATUVARDA.getState());
		labrotuvarDTO.setAciklama(labForm.getAciklama());
		labrotuvarDTO.setLabIslemTipId(result.getLabIslemTipId());
		
		int labIslemId = (Integer) session.save(labrotuvarDTO);
		
		/*
		 * eski lab islemine ait provalar guncelleniyor.
		 */
		
		Query labProvaQuery = session
				.createQuery("from tr.com.fdd.dto.TLabrotuvarProvaDTO  p where p.labIslemId = :var");
		labProvaQuery.setInteger("var", result.getId());
		
		List<?> list = labProvaQuery.list();
		
		for (int i = 0; i < list.size(); i++) {
			
			TLabrotuvarProvaDTO dto=(TLabrotuvarProvaDTO) list.get(i);
			updateProva(session,dto);
			insertProva(session,dto,labIslemId);
		}
		
	}

	private void insertProva(Session session, TLabrotuvarProvaDTO dto, int newLabIslemId) throws HibernateException {
		TLabrotuvarProvaDTO provaDTO= new TLabrotuvarProvaDTO();
		provaDTO.setDurum("A");
		provaDTO.setLabIslemId(newLabIslemId);
		provaDTO.setProvaTip(dto.getProvaTip());
		session.save(provaDTO);
		
	}

	private void updateProva(Session session, TLabrotuvarProvaDTO dto) throws HibernateException {
		
		Query labProvaQuery = session
				.createQuery("from tr.com.fdd.dto.TLabrotuvarProvaDTO  p where p.id = :var");
		labProvaQuery.setInteger("var", dto.getId());
		TLabrotuvarProvaDTO provaDTO= (TLabrotuvarProvaDTO) labProvaQuery.uniqueResult();
		
		provaDTO.setDurum("P");
		
	}


}
