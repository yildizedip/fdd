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

import tr.com.fdd.dto.TTurKodDTO;
import tr.com.fdd.utils.GUIMessages;

public class SilGiderTuruAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String turId=	request.getParameter("turId");

		int id= new Integer(turId).intValue();		
		Session sess= null;
		Transaction tran=null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			
			Query gelirGiderDTO = sess.createQuery("  from TTurKodDTO as a where  a.turId = :var");
			gelirGiderDTO.setInteger("var", id);
			TTurKodDTO result = (TTurKodDTO) gelirGiderDTO.uniqueResult();
			result.setTurDurum("P");	        
			tran.commit();	          
				       
	        request.setAttribute("warn", GUIMessages.KAYIT_SILME_BASARILI);
	        return mapping.findForward("success");
			
		}
		catch (HibernateException e) {
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
