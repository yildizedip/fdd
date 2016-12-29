package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.Date;
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
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.GUIMessages;

public class HastaEkleAction extends Action {
	@SuppressWarnings("unchecked")
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session=null;
		Connection conn =SQLUtils.getMySqlConneciton();
		
		try {
			THastaDTO tHastaDto = new THastaDTO();
			
			HastaForm hastaForm=(HastaForm) form;
			hastaForm.setDurum("A");
			hastaForm.setEklenmeTarihi(new Date());	
			
			BeanUtils.copyProperties(tHastaDto, hastaForm );					
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			
			Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.durum='A' " +
					" and p.subeId= :subeId and ( p.protokolNo = :protokolNo or ( p.ad= :ad and p.soyad=:soyad) )");
				query.setString("protokolNo", tHastaDto.getProtokolNo());
				query.setString("ad", tHastaDto.getAd());
				query.setString("soyad", tHastaDto.getSoyad());
				query.setInteger("subeId", tHastaDto.getSubeId());
				List<THastaDTO> result =  query.list();
			int hasta_id=0;
			if(result.size()!=0){
				tran.commit();
				request.setAttribute("warn", GUIMessages.HASTA_VAR);	
				return mapping.findForward("failure");
			}			
			else
			{
				hasta_id=(Integer) session.save(tHastaDto);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
				tran.commit();				
			}
			
			
			SQLUtils sqlUtils= new SQLUtils();
			Integer subeId= (Integer) request.getSession().getAttribute("subeId");
			THastaDTO  hasta= sqlUtils.getHasta(hasta_id, conn,subeId.intValue());			
				
			request.setAttribute("hasta", hasta);
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kay�t hatal�");
				return mapping.findForward("exception");
				
				
				
		}  finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
				
				MysqlUtil.instance.closeConnection(conn);			
		}
	}
}
