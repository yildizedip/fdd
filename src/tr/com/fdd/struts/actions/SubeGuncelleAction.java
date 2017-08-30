package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.SubeForm;

public class SubeGuncelleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
	//	int id= new Integer(request.getParameter("subeId")).intValue();	
		
		SubeForm frm=(SubeForm) form;
		frm.setsDurum("A");
		
		TSubeDTO dto= new TSubeDTO();
		
		BeanUtils.copyProperties(dto, frm );	
		
		Session sess= null;
		Transaction tran=null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess.createQuery("from tr.com.fdd.dto.TSubeDTO  p where p.sId = :var");
			query.setInteger("var", frm.getsId());
			TSubeDTO result = (TSubeDTO) query.uniqueResult();
			result.setsAd(dto.getsAd());
			result.setsAdres(dto.getsAdres());
			result.setsTel(dto.getsTel());
			tran.commit();	    	            
	        request.setAttribute("warn", "kayit guncellenmi�tir.");	      
	        
	        Connection conn =DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils= new SQLUtils();
			List<TSubeDTO>  subeList= sqlUtils.getSubeList(conn, "");	
			request.setAttribute("subeList", subeList);
	        
	        return mapping.findForward("success");
			
		}
		catch (HibernateException e) {
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
