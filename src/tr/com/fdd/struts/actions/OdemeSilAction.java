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

import tr.com.fdd.dto.THastaOdemeDTO;

public class OdemeSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String odemeId=	request.getParameter("id");
		int id= Integer.parseInt(odemeId);
		Session sess= null;
		Transaction tran=null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
					
			
			Query query = sess.createQuery("from tr.com.fdd.dto.THastaOdemeDTO  p where p.id = :var");
			query.setInteger("var", id);
			THastaOdemeDTO result = (THastaOdemeDTO) query.uniqueResult();
			result.setDurumu("P");
	        
			tran.commit();	    
	            
	        request.setAttribute("warn", id+ "nolu kayit  silinmistir.");
	        
	        return mapping.findForward("success");
			
		}
		catch (Exception e) {
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
	
	
}
