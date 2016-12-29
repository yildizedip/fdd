package tr.com.fdd.struts.actions;

import java.lang.reflect.InvocationTargetException;
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

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class SubeEkleAction extends Action {

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {		

		Transaction tran = null;
		Session session=null;
		Connection conn =null;
		
		SQLUtils sqlUtils= new SQLUtils();
		
		try {
			conn=SQLUtils.getMySqlConneciton();
			TSubeDTO tSubeDTO = new TSubeDTO();
			
			SubeForm subeForm=(SubeForm) form;
			subeForm.setsDurum("A");
			
			BeanUtils.copyProperties(tSubeDTO, subeForm);					
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			
			Query query = session.createQuery("from tr.com.fdd.dto.TSubeDTO  p where p.sDurum='A' and p.sAd = :ad");

				query.setString("ad", tSubeDTO.getsAd());
				
				List<THastaDTO> result =  query.list();
			int id=0;
			if(result.size()!=0){
				tran.commit();
				request.setAttribute("warn", GUIMessages.KAYIT_VAR);	
				return mapping.findForward("failure");
			}
			
			else
			{
				id=(Integer) session.save(tSubeDTO);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
				tran.commit();
				
			}
						
			List<TSubeDTO>  subeList= sqlUtils.getSubeList(conn, "");	
			request.setAttribute("subeList", subeList);
			request.setAttribute("tarihStr", GenelDegiskenler.getGunlukTarih());
			
			
			return mapping.findForward("success");
		} catch (HibernateException e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kayýt hatalý");
				return mapping.findForward("exception");
		} catch (IllegalAccessException e) {
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("exception");

		} catch (InvocationTargetException e) {
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("exception");

		} finally {
			MysqlUtil.instance.closeConnection(conn);
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	
		
		
	}

}
