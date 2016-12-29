package tr.com.fdd.struts.actions;

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

public class SifremiGuncelleAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String yeniSifre = request.getParameter("newPassword");
		String kuId = request.getParameter("kuloginId");

		 Session session=null;
		 Transaction transaction=null;

		try {

		session=GenericAction.getHibernateSession();
		transaction=session.beginTransaction();
	
		Query query = session.createQuery("from tr.com.fdd.dto.TKullaniciLoginDTO  p where p.kuId = :var");
		query.setInteger("var", new Integer(kuId).intValue());
		
		TKullaniciLoginDTO dto= (TKullaniciLoginDTO) query.uniqueResult();
		dto.setKuSifre(yeniSifre);
		transaction.commit();	    
        
        request.setAttribute("warn", kuId+ "nolu kayit guncellenmiþtir.");
			
		return mapping.findForward("success");
			

		} 	catch (Exception e) {
			if (transaction != null)
				try {
					transaction.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
				return mapping.findForward("exception");
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}

		
	}

}
