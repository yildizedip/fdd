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

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class KullaniciGuncelleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// tip degiskeni guncellemenin user tarafindan yapildigi durumlarda
		// aktif dir.
		String tip = request.getParameter("tip");

		LoginForm frm = (LoginForm) form;
		frm.setDurum("A");
		Session sess = null;
		Transaction tran = null;
		Connection conn = null;
		SQLUtils sqlUtils = null;
		
		try {
			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.TKullaniciLoginDTO  p where p.kuId = :var");
			query.setInteger("var", frm.getKuloginId());
			TKullaniciLoginDTO result = (TKullaniciLoginDTO) query
					.uniqueResult();
			if (frm.getUserName() != null && !frm.getUserName().equals(""))
				result.setKuMail(frm.getUserName());

			if (frm.getKuTur() != null && !frm.getKuTur().equals(""))
				result.setKuTur(frm.getKuTur());

			if (frm.getPassword() != null && !frm.getPassword().equals(""))
				result.setKuSifre(frm.getPassword());

			result.setKuGuncellenmeTarihi(new Date());

			if (frm.getDurum() != null && !frm.getDurum().equals(""))
				result.setDurum(frm.getDurum());

			Query queryBilgi = sess
					.createQuery("from tr.com.fdd.dto.TKullaniciBilgiDTO  p where p.kuLoginId = :var");
			queryBilgi.setInteger("var", frm.getKuloginId());
			TKullaniciBilgiDTO resultBilgi = (TKullaniciBilgiDTO) queryBilgi
					.uniqueResult();

			if (frm.getAd() != null && !frm.getAd().equals(""))
				resultBilgi.setKuAd(frm.getAd());

			if (frm.getSoyad() != null && !frm.getSoyad().equals(""))
				resultBilgi.setKuSoyad(frm.getSoyad());

			if (frm.getAdres() != null && !frm.getAdres().equals(""))
				resultBilgi.setKuAdres(frm.getAdres());

			if (frm.getTel() != null && !frm.getTel().equals(""))
				resultBilgi.setKuTel(frm.getTel());

			if (frm.getGiderKodu() != null && !frm.getGiderKodu().equals("0"))
				resultBilgi.setGiderKodu(Integer.parseInt(frm.getGiderKodu()));

			if (result.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.DOKTOR)) {

				Query queryDoktor = sess
						.createQuery("from tr.com.fdd.dto.TDoktorDTO "
								+ " p where p.dMemberId = :varDoktor");
				queryDoktor.setInteger("varDoktor", frm.getKuloginId());
				TDoktorDTO resultDoktor = (TDoktorDTO) queryDoktor
						.uniqueResult();
				resultDoktor.setdDurum("A");

				if (frm.getAd() != null && !frm.getAd().equals("0"))
					resultDoktor.setdAd(frm.getAd());

				if (frm.getSoyad() != null && !frm.getSoyad().equals("0"))
					resultDoktor.setdSoyad(frm.getSoyad());

				resultDoktor.setdBrans("Diþ Hekimi");

			}

			tran.commit();
			request.setAttribute("warn", "kayit guncellenmiþtir.");

			if (tip!=null && tip.equals("kisiselBilgileriGuncelle")) {
				return mapping.findForward("goToLogoutPage");
			}
			conn = SQLUtils.getMySqlConneciton();
			sqlUtils = new SQLUtils();
			List<LoginForm> kullaniciList = sqlUtils.getKullaniciList(conn, "");
			request.setAttribute("kullaniciList", kullaniciList);

			return mapping.findForward("success");

		} catch (HibernateException e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
			return mapping.findForward("exception");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
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
