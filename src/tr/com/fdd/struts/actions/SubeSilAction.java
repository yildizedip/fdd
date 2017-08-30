  package tr.com.fdd.struts.actions;

import java.sql.Connection;
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

import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;

public class SubeSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String subeId=	request.getParameter("subeId");
		int id= new Integer(subeId).intValue();		
		Session sess= null;
		Transaction tran=null;
		 Connection conn =null;
		 
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();					
			
			Query query = sess.createQuery("from tr.com.fdd.dto.TSubeDTO  p where p.sId = :var");
			query.setInteger("var", new Integer(id).intValue());
			TSubeDTO result = (TSubeDTO) query.uniqueResult();
			result.setsDurum("P");
	        
			tran.commit();	    
	            
	        request.setAttribute("warn", id+ "nolu kayit  silinmistir.");
	       
	         conn =DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils= new SQLUtils();
			List<TSubeDTO>  subeList= sqlUtils.getSubeList(conn, "");	
			request.setAttribute("subeList", subeList);
			       
	        return mapping.findForward("success");
			
		}
		catch (HibernateException e) {
			if (tran != null)
				try {
					tran.rollback();
				} 
				catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kay�t Silme ��leminde Hata Olu�tu.");
				return mapping.findForward("exception");
		} finally {
			
			MysqlUtil.instance.closeConnection(conn);
			
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {				
					e.printStackTrace();
				}
		}
		
		
		
	}
	
	
}
