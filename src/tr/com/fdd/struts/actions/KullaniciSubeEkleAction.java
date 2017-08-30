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

import tr.com.fdd.dto.TKullaniciSubeDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;

public class KullaniciSubeEkleAction extends Action {

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SubeForm subeForm= (SubeForm) form;		
		Session sess= null;
		Transaction tran=null;
		Connection conn=null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();		
			
			TKullaniciSubeDTO dto= new TKullaniciSubeDTO();
			dto.setDurum("A");
			dto.setKuId(subeForm.getKullaniciId());
			dto.setsId(subeForm.getSubeId());
			
			Query query = sess.createQuery(" from tr.com.fdd.dto.TKullaniciSubeDTO " +
					" p where p.kuId = :var and p.sId =:sId and p.durum='A' ");
			query.setInteger("var", subeForm.getKullaniciId());
			query.setInteger("sId", subeForm.getSubeId());
			
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
				request.setAttribute("warn", "Kay�t Ekleme ��leminde Hata Olu�tu.");
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
