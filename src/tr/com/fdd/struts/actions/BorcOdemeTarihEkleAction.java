package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaIslemBorcTakipDTO;
import tr.com.fdd.struts.form.IslemBorcOdemeTakipForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class BorcOdemeTarihEkleAction extends GenericAction {
	
	@Override
	public ActionForward executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {
		
		Transaction tran = null;
		try {
			THastaIslemBorcTakipDTO dto= new THastaIslemBorcTakipDTO();
			
			IslemBorcOdemeTakipForm frm= (IslemBorcOdemeTakipForm) form;
			if(frm.getBorcOdemeTarihiStr().equals("")){
				request.setAttribute("warn", "LUTFEN BORC ODEME TARIHI GIRINIZ.");
				return mapping.findForward("noContent");
			}
			if(frm.getMiktar()==0.0){
				request.setAttribute("warn", "LUTFEN BORC MIKTARI GIRINIZ.");
				return mapping.findForward("noContent");
			}
			if( frm.getMiktar()>new Double(frm.getKalan()).doubleValue()){
				request.setAttribute("warn", "LUTFEN BORC MIKTARINI KONTROL EDINIZ. GIRILEN MIKTAR BORCTAN FAZLA OLAMAZ.");
				return mapping.findForward("noContent");
			}
			frm.setDurum("A");
									
			BeanUtils.copyProperties(dto, frm);		
			dto.setBorcOdemeTarihi(Commons.convertStringToDate(frm.getBorcOdemeTarihiStr()));
			dto.setEklemeTarihi(new Date());
			dto.setEkleyenId(Commons.getActiveSession(request).getKuId());
			
			tran = session.beginTransaction();
			session.save(dto);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);	
			
			Commons.refreshSelectedHasta(request, connection, frm.getHastaId());
			
			return mapping.findForward("success");
		} catch (Exception e) {
			e.printStackTrace();
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
