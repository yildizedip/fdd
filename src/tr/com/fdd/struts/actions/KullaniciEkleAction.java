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
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class KullaniciEkleAction extends Action {

	@SuppressWarnings("unchecked")
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Transaction tran = null;
		Session session = null;

		TKullaniciLoginDTO tkullaniciLoginDTO = new TKullaniciLoginDTO();
		Connection conn = null;
		SQLUtils sqlUtils = null;
		try {
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();

			/**
			 * KULLANICI LOGIN EKLEME
			 */
			LoginForm frm = (LoginForm) form;
			frm.setDurum("A");

			tkullaniciLoginDTO.setKuMail(frm.getUserName());
			tkullaniciLoginDTO.setKuSifre(frm.getPassword());
			tkullaniciLoginDTO.setKuTarih(new Date());
			tkullaniciLoginDTO.setKuTur(frm.getKuTur());
			tkullaniciLoginDTO.setDurum(frm.getDurum());

			Query queryLogin = session
					.createQuery("from tr.com.fdd.dto.TKullaniciLoginDTO  p where p.durum='A' and p.kuMail = :mail");

			queryLogin.setString("mail", tkullaniciLoginDTO.getKuMail());

			List<TKullaniciLoginDTO> result = queryLogin.list();
			int loginId = 0;
			if (result.size() != 0) {
				tran.commit();
				request.setAttribute("warn", GUIMessages.KAYIT_VAR);
				return mapping.findForward("exception");
			}

			else {
				loginId = (Integer) session.save(tkullaniciLoginDTO);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
				// tran.commit();

			}

			/**
			 * KULLANICI BILGI EKLEME
			 */

			TKullaniciBilgiDTO tKullaniciBilgiDTO = new TKullaniciBilgiDTO();
			tKullaniciBilgiDTO.setKuLoginId(loginId);
			tKullaniciBilgiDTO.setKuAd(frm.getAd());
			tKullaniciBilgiDTO.setKuSoyad(frm.getSoyad());
			tKullaniciBilgiDTO.setKuTel(frm.getTel());
			tKullaniciBilgiDTO.setKuAdres(frm.getAdres());

			session.save(tKullaniciBilgiDTO);

			/**
			 * DOKTOR EKLEME
			 */

			if (frm.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.DOKTOR)) {

				TDoktorDTO doktorDTO = new TDoktorDTO();
				doktorDTO.setdAd(frm.getAd());
				doktorDTO.setdMemberId(loginId);
				doktorDTO.setdSoyad(frm.getSoyad());
				doktorDTO.setdBrans("Diþ Hekimi");
				doktorDTO.setdDurum("A");

				session.save(doktorDTO);
			}
			tran.commit();
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
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("exception");

		} catch (Exception e) {
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("exception");

		} finally {
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
