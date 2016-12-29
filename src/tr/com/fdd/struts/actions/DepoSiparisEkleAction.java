package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.util.Date;
import java.util.List;
import java.util.Random;

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

import tr.com.fdd.dto.TDepoDTO;
import tr.com.fdd.dto.TDepoSiparisDTO;
import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class DepoSiparisEkleAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session=null;
		Connection connection=null;
		try {
			
			String  subeId=(String) request.getParameter("subeId");
			if(subeId==null) {
			
				request.setAttribute("warn", GUIMessages.HATA);
				return mapping.findForward("exception");
			}
			
			SQLUtils sqlUtils= new SQLUtils();
			
			connection =SQLUtils.getMySqlConneciton();
			TSubeDTO subeDTO= sqlUtils.getSubeBilgi(connection, Integer.parseInt(subeId));
			
			Random random= new Random();
			int da= random.nextInt(10000000);
			String siparisNo= subeDTO.getsAd().substring(0,3)+ new Integer(da).toString();
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			TDepoSiparisDTO dto= new TDepoSiparisDTO();
			dto.setDurum(1);
			dto.setSiparisNo(siparisNo);
			dto.setEklemeTar(new Date());
			dto.setEkleyenKisi(Commons.getActiveSession(request).getKuId());
			session.save(dto);
			
			String sql = "select new map(s.siparisNo, s.eklemeTar) from TDepoSiparisDTO  where durum=1  ";
			Query que = session.createQuery(sql);
			
			List siparisList = que.list();
			
			
			tran.commit();
			
			
			request.setAttribute("siparis", dto);
			request.setAttribute("siparisList", siparisList);
			
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);			
			
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", GUIMessages.HATA);
				return mapping.findForward("exception");
		} 
		 finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	}
}
