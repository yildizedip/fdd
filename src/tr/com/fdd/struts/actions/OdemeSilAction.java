package tr.com.fdd.struts.actions;

import java.sql.Connection;

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
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class OdemeSilAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans){
		
		String odemeId=	request.getParameter("id");
		int id= Integer.parseInt(odemeId);
		Transaction tran=null;
		try{
			tran = sess.beginTransaction();
					
			
			Query query = sess.createQuery("from tr.com.fdd.dto.THastaOdemeDTO  p where p.id = :var");
			query.setInteger("var", id);
			THastaOdemeDTO result = (THastaOdemeDTO) query.uniqueResult();
			result.setDurumu("P");
	        
			tran.commit();	    
	          Commons.refreshSelectedHasta(request, connection, result.getHastaId());
			
	        request.setAttribute("warn", GUIMessages.ISLEM_BASARILI);
	        
	        return mapping.findForward("success");
			
		}
		catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kay�t Silme ��leminde Hata Olu�tu.");
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
