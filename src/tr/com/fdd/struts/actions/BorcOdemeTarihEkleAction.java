package tr.com.fdd.struts.actions;


import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDepoSiparisDTO;
import tr.com.fdd.dto.THastaIslemBorcTakipDTO;
import tr.com.fdd.struts.form.DepoSiparisUrunForm;
import tr.com.fdd.struts.form.IslemBorcOdemeTakipForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class BorcOdemeTarihEkleAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session=null;
		try {
			THastaIslemBorcTakipDTO dto= new THastaIslemBorcTakipDTO();
			
			IslemBorcOdemeTakipForm frm= (IslemBorcOdemeTakipForm) form;
			if(frm.getBorcOdemeTarihiStr().equals("")){
				request.setAttribute("warn", "LÜTFEN BORÇ ÖDEME TARÝHÝ GÝRÝNÝZ.");
				return mapping.findForward("noContent");
			}
			if(frm.getMiktar()==0.0){
				request.setAttribute("warn", "LÜTFEN BORÇ MÝKTARI GÝRÝNÝZ.");
				return mapping.findForward("noContent");
			}
			if( frm.getMiktar()>new Double(frm.getKalan()).doubleValue()){
				request.setAttribute("warn", "LÜTFEN BORÇ MÝKTARINI KONTROL EDÝNÝZ. GÝRÝLEN MÝKTAR KALAN BORÇTAN FAZLA OLAMAZ.");
				return mapping.findForward("noContent");
			}
			frm.setDurum("A");
									
			BeanUtils.copyProperties(dto, frm);		
			dto.setBorcOdemeTarihi(Commons.convertStringToDate(frm.getBorcOdemeTarihiStr()));
			
			dto.setEklemeTarihi(new Date());
			dto.setEkleyenId(Commons.getActiveSession(request).getKuId());
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			session.save(dto);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);			
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
