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

import tr.com.fdd.dto.THastaRandevuDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.struts.form.HastaRandevuForm;

public class HastaRandevuEkleAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HastaRandevuForm hastaRandevuForm = null;
		
		Transaction tran = null;
		Session session=null;

		try {
			hastaRandevuForm = (HastaRandevuForm) form;
			if (hastaRandevuForm.getRandevuTarihiStr() == null)
				hastaRandevuForm.setRandevuTarihi(new Date());
			else {
				String tarihStr = hastaRandevuForm.getRandevuTarihiStr();

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
				Date convertedDate = dateFormat.parse(tarihStr);
				hastaRandevuForm.setRandevuTarihi(convertedDate);
			}
			Object[] kullaniciBilgileri = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			TKullaniciLoginDTO kullanici = (TKullaniciLoginDTO) kullaniciBilgileri[0];
			hastaRandevuForm.setEkleyenKisi(kullanici.getKuId());
			hastaRandevuForm.setEklenmeTarihi(new Date());
			hastaRandevuForm.setDurum("A");
			System.out.println(hastaRandevuForm);
			
			THastaRandevuDTO tHastaRandevu = new THastaRandevuDTO();
			BeanUtils.copyProperties(tHastaRandevu, hastaRandevuForm );					
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			session.save(tHastaRandevu);
			tran.commit();
			request.setAttribute("warn", "Kayýt baþarýlý");	

			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kayýt hatalý");
				return mapping.findForward("exception");
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	}
}
