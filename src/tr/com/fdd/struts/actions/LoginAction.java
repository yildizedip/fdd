package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TLoginDTO;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;
import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;

/**
 * kullanici login bilgileri ile kullanici bilgileri bulunur session objesine
 * eklenir. burda diger sayfalarda kullanilacak parametrelerde setlenir.
 * 
 * @author User
 * 
 */

public class LoginAction extends GenericAction {

	/**
	 * mapping objesi ile dogru yonlendirmeler saglanir. (struts -config. xml
	 * okunur.) form bean ile validate edilmis form parametrelerine ulasilir.
	 * 
	 */
	@Override
	public ActionForward executeCode(Session session, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {
		// Captcha captcha = Captcha.load(request, "basicCaptcha");
		//
		// boolean isHuman = captcha.validate(request,
		// request.getParameter("captchaCode"));
		// if (!isHuman) {
		// request.setAttribute("failure", GUIMessages.YANLIS_KOD_GIRILDI);
		// return mapping.findForward("failure");
		// }

		LoginForm loginForm = null;
		SQLUtils sqlUtils = new SQLUtils();
		try {
			loginForm = (LoginForm) form;
			String uName = loginForm.getUserName();
			String pass = loginForm.getPassword();

			session.beginTransaction();

			HttpSession sessionInf = request.getSession();

			

			TKullaniciLoginDTO kullaniciLoginDTO = null;
			TKullaniciBilgiDTO kullaniciBilgiDTO = null;

			/**
			 * session bilgileri
			 */

			if (sessionInf.getAttribute("sessionMember") == null) {
				
				List<?> loginInformations = getLoginInformation(session, uName, pass);

				/**
				 * kullanici adi ve sifresinden donen sonuc yani member var ise
				 * session olusturulur.
				 */

				if (loginInformations.size() == 0) {
					request.setAttribute("failure", GUIMessages.KULLANICI_BULUNAMADI);
					return mapping.findForward("failure");

				}
				
				kullaniciLoginDTO = (TKullaniciLoginDTO) loginInformations.get(0);
				kullaniciBilgiDTO = getKullaniciBilgi(session, kullaniciLoginDTO.getKuId());
				sessionInf.setAttribute("sessionMember", new Object[] { kullaniciLoginDTO, kullaniciBilgiDTO });

			} else {
				kullaniciLoginDTO = (TKullaniciLoginDTO) ((Object[]) sessionInf.getAttribute("sessionMember"))[0];
				kullaniciBilgiDTO = (TKullaniciBilgiDTO) ((Object[]) sessionInf.getAttribute("sessionMember"))[1];

			}

			String ipAddress = request.getRemoteAddr();
			kullaniciLoginDTO.setUserIp(ipAddress);
			// check if login is

			TLoginDTO loginInfo = sqlUtils.getLoginInfo(connection, kullaniciLoginDTO.getKuId());

			if (loginInfo != null) {

				sqlUtils.addLogoutInfo(connection, loginInfo.getId(), ipAddress);
			//	sessionInf.invalidate();

			//	request.setAttribute("exception", GUIMessages.TEKRAR_GIRIS);
			//	return mapping.findForward("exception");
			}

			// adding login info
			sqlUtils.addLoginInfo(connection, kullaniciLoginDTO.getKuId(), ipAddress);
			// labIslem bilgileri aliniyor.
			// List<?> labIslemTipList = labIslemTipList(session);
			// List<?> labDurumList = labDurumList();

			// sessionInf.setAttribute("labIslemTipList", labIslemTipList);
			// sessionInf.setAttribute("labDurumList", labDurumList);

			if (kullaniciLoginDTO.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.ADMIN)) {

				List<?> subelerList = subelerList(session);
				// List<?> islemTurList = islemTurList(session);

				List<?> islemTurList = sqlUtils.getOperasyonTurList(connection, -1);
				sessionInf.setAttribute("islemTurList", islemTurList);

				request.getSession().setAttribute("subelerList", subelerList);

				return mapping.findForward("gotoAdminPage");
			}
			if (kullaniciLoginDTO.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.LABTEKNISYENI)) {
				return mapping.findForward("gotoLabTeknisyenPage");
			}

			// sube bilgileri aliniyor..
			int ku_id = kullaniciLoginDTO.getKuId();
			List<SubeForm> kullaniciSubeList = sqlUtils.getKullaniciSubeList(connection, ku_id);
			sessionInf.setAttribute("sessionMemberSube", kullaniciSubeList);

			return mapping.findForward("success");

		} catch (Exception e) {

			e.printStackTrace();

			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			if (session != null && session.isOpen())
				try {
					session.close();

				} catch (HibernateException ex) {
					ex.printStackTrace();
				}

			request.setAttribute("exception", e);

			return mapping.findForward("exception");
		} finally {

			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

			if (session != null && session.isOpen())
				try {
					session.close();

				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}

	}

	private List<?> getLoginInformation(Session session, String uName, String pass) throws HibernateException {
		String sql = "from tr.com.fdd.dto.TKullaniciLoginDTO as member where "
				+ "member.kuMail = :p_mail and member.kuSifre = :p_sifre ";
		Query queryLogin = session.createQuery(sql);

		queryLogin.setString("p_mail", uName);
		queryLogin.setString("p_sifre", pass);

		List<?> result = queryLogin.list();
		return result;
	}

	private TKullaniciBilgiDTO getKullaniciBilgi(Session session, int kuLoginId)
			throws HibernateException, ClassNotFoundException, SQLException {
		// session.close();
		// session = GenericAction.getHibernateSession();
		String sql = " from tr.com.fdd.dto.TKullaniciBilgiDTO as a where a.kuLoginId = :p_ku_login_id ";

		Query que = session.createQuery(sql);
		que.setInteger("p_ku_login_id", kuLoginId);
		List<?> result = que.list();

		if (result.size() > 0)
			return (TKullaniciBilgiDTO) result.get(0);
		else
			return null;

	}

	private List<?> subelerList(Session sess) throws HibernateException, ClassNotFoundException, SQLException {

		String sql = " from TSubeDTO p where p.sDurum='A' ";
		Query que = sess.createQuery(sql);
		List<?> result = que.list();
		return result;
	}

	private List<?> labIslemTipList(Session sess) throws HibernateException, ClassNotFoundException, SQLException {

		String sql = " from TLabIslemTipDTO order by id  ";
		Query que = sess.createQuery(sql);
		List<?> result = que.list();
		return result;
	}

	private List<?> labDurumList() {
		List<LaboratuvarIslemDurum> labDurumList = new ArrayList<LaboratuvarIslemDurum>();
		for (LaboratuvarIslemDurum s : LaboratuvarIslemDurum.values()) {
			labDurumList.add(s);
		}

		return labDurumList;

	}

	private List<?> islemTurList(Session sess) throws HibernateException, ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		String sql = " from TIslemTipDTO order by ad  ";
		Query que = sess.createQuery(sql);
		List<?> result = que.list();
		return result;
	}
}
