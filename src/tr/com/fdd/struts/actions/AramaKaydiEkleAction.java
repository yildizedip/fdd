package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TAramaKaydiDTO;
import tr.com.fdd.struts.form.TAramaForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class AramaKaydiEkleAction extends GenericAction {
	@Override
	public ActionForward  executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {
		Transaction tran = null;
		try {
			TAramaKaydiDTO aramaKaydiDTO= new TAramaKaydiDTO();
			
			TAramaForm aramaForm=(TAramaForm) form;
			String saat=aramaForm.getSaat();
			String dk=aramaForm.getDakika();
			
			aramaForm.setAramaSaat(saat+":"+dk);
			aramaForm.setDurum("A");
			aramaForm.setArayanKisi(Commons.getActiveSession(request).getKuId());
			if(aramaForm.getAramaTarihStr()==null)
				aramaForm.setAramaTarih(new Date());
			else{
			String tarihStr= aramaForm.getAramaTarihStr();			
		    aramaForm.setAramaTarih(Commons.convertStringToDate(tarihStr));
			}
			
			aramaForm.setKayitTarih(new Date());
		
			BeanUtils.copyProperties(aramaKaydiDTO, aramaForm );					
			
			tran = session.beginTransaction();
			session.save(aramaKaydiDTO);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
			
			Commons.refreshSelectedHasta(request, connection, aramaKaydiDTO.getHastaId());
			
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", GUIMessages.HATA);
				return mapping.findForward("exception");
		} 
		 finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	}
}
