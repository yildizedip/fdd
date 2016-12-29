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

import tr.com.fdd.dto.TDoktorSubeDTO;
import tr.com.fdd.dto.TKullaniciSubeDTO;
import tr.com.fdd.struts.form.DoktorForm;
import tr.com.fdd.utils.GUIMessages;

public class DoktorSubeEkleAction extends Action {

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String subeId=request.getParameter("subeId");
		String dId=request.getParameter("dId");
		
		Session sess= null;
		Transaction tran=null;
		 Connection conn =SQLUtils.getMySqlConneciton();
			SQLUtils sqlUtils= new SQLUtils();
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();		
			
			TDoktorSubeDTO dto= new TDoktorSubeDTO();
			dto.setDurum("A");
			dto.setSbId(Integer.parseInt(subeId));
			dto.setdId(Integer.parseInt(dId));
			
			Query query = sess.createQuery(" from tr.com.fdd.dto.TDoktorSubeDTO " +
					" p where p.dId = :var and p.sbId =:sbId and p.durum='A' ");
			query.setInteger("var", dto.getdId());
			query.setInteger("sbId", dto.getSbId());
			
			List<TKullaniciSubeDTO> result =  query.list();
			int id=0;
			if(result.size()!=0){
				tran.commit();
				request.setAttribute("warn", GUIMessages.KAYIT_VAR);	
				return mapping.findForward("exception");
			}
			
			else
			{
				id=(Integer) sess.save(dto);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
			//	tran.commit();
				
			}		
			
			tran.commit();	   	            
	        
			      
			   
	       
	        List<DoktorForm> doktorList = sqlUtils.getDoktorList(conn,null);
			
		
			request.setAttribute("doktorList", doktorList);
	        
			       
	        return mapping.findForward("success");
			
		}
		catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} 
				catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kay�t Ekleme ��leminde Hata Olu�tu.");
				return mapping.findForward("exception");
		} finally {
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {				
					e.printStackTrace();
				}
				
			conn.close();
		}
		
		
		
	}
	
	
}
