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

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class KullaniciSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String kullaniciLoginId=	request.getParameter("kuloginId");
		int id= new Integer(kullaniciLoginId).intValue();		
		Session sess= null;
		Transaction tran=null;
		 Connection conn =null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();					
			
			Query query = sess.createQuery("from tr.com.fdd.dto.TKullaniciLoginDTO " +
					" p where p.kuId = :var");
			query.setInteger("var", new Integer(id).intValue());
			TKullaniciLoginDTO result = (TKullaniciLoginDTO) query.uniqueResult();
			result.setDurum("P");	
			
			if(result.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.DOKTOR)){
				
					Query queryDoktor = sess.createQuery("from tr.com.fdd.dto.TDoktorDTO " +
					" p where p.dMemberId = :varDoktor");
					queryDoktor.setInteger("varDoktor", new Integer(id).intValue());
					TDoktorDTO resultDoktor = (TDoktorDTO) queryDoktor.uniqueResult();
					resultDoktor.setdDurum("P");	
			
			}
			tran.commit();	   	            
	        request.setAttribute("warn", id+ " nolu kayit  silinmistir.");	       
	        conn =DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils= new SQLUtils();
			List<LoginForm>  kullaniciList= sqlUtils.getKullaniciList(conn, "");	
			request.setAttribute("kullaniciList", kullaniciList);
			       
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
			conn.close();			
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {				
					e.printStackTrace();
				}
		}
		
		
		
	}
	
	
}
