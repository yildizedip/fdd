package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.SessionFactory;
import net.sf.hibernate.cfg.Configuration;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TMenuDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;
import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;
import botdetect.web.Captcha;

/**
 * kullanici login bilgileri ile kullanici bilgileri bulunur session objesine
 * eklenir. burda diger sayfalarda kullanilacak parametrelerde setlenir.
 * 
 * @author User
 * 
 */
public class GetUserLoginInfAction extends Action {

	/**
	 * mapping objesi ile dogru yonlendirmeler saglanir. (struts -config. xml
	 * okunur.) form bean ile validate edilmis form parametrelerine ulasilir.
	 * 
	 */
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
//		Captcha captcha = Captcha.load(request, "basicCaptcha");
//		
//		boolean isHuman = captcha.validate(request,
//                request.getParameter("captchaCode"));
//          if (!isHuman) {
//        	  request.setAttribute("failure",	GUIMessages.YANLIS_KOD_GIRILDI);
//				return mapping.findForward("failure");
//          } 
		
		SessionFactory sessions = null;
		Session session = null;
		Configuration cfg = null;
		Connection connection = null;
		LoginForm loginForm =null;
		SQLUtils sqlUtils=null;
		try {
			loginForm = (LoginForm) form;
			String uName = loginForm.getUserName();
			String pass = loginForm.getPassword();
			cfg = new Configuration().configure("/myhibernate.cfg.xml");
			sessions = cfg.buildSessionFactory();
			session = sessions.openSession(MysqlUtil.instance.getConnection());
			session.beginTransaction();

			sqlUtils = new SQLUtils();
			connection = SQLUtils.getMySqlConneciton();
			
			/**
			 * subeer listesi aliniyor.
			 */
			List<?> subelerList = subelerList(session);

			request.getSession().setAttribute("subelerList", subelerList);

			/**
			 * kullanici bilgileri alinir.
			 */

			List<?> loginInformations = getLoginInformation(session, uName,	pass);

			/**
			 * kullanici adi ve sifresinden donen sonuc yani member var ise
			 * session olusturulur.
			 */

			HttpSession sessionInf = request.getSession();

			if (loginInformations.size() > 0) {
				TKullaniciLoginDTO kullaniciLoginDTO = (TKullaniciLoginDTO) loginInformations
						.get(0);
				// kullanici bilgileri aliniyor.
				TKullaniciBilgiDTO kullaniciBilgiDTO = getKullaniciBilgi(
						session, kullaniciLoginDTO.getKuId());
				sessionInf.setAttribute("sessionMember", new Object[] {	kullaniciLoginDTO, kullaniciBilgiDTO });

				// menu bilgileri aliniyor..
				setMenuInformation(connection, sqlUtils, sessionInf,
						kullaniciLoginDTO);
				
				//labIslem bilgileri aliniyor.
				List<?> labIslemTipList = labIslemTipList(session);
				List<?> labDurumList = labDurumList();
				
				sessionInf.setAttribute("labIslemTipList", labIslemTipList);
				sessionInf.setAttribute("labDurumList", labDurumList);
				
				
				if (kullaniciLoginDTO.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.ADMIN)) {
					return mapping.findForward("gotoAdminPage");
				}
				if (kullaniciLoginDTO.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.LABTEKNISYENI)) {				
					return mapping.findForward("gotoLabTeknisyenPage");
				}
				
					// sube bilgileri aliniyor..
				int ku_id = kullaniciLoginDTO.getKuId();
				List<SubeForm> kullaniciSubeList = sqlUtils.getKullaniciSubeList(connection, ku_id);
				sessionInf.setAttribute("sessionMemberSube",kullaniciSubeList);

				return mapping.findForward("success");
			}

			else {
				request.setAttribute("failure",	GUIMessages.KULLANICI_BULUNAMADI);
				return mapping.findForward("failure");

			}
		} catch (Exception e) {
			request.setAttribute("exception", e);
			if(connection!=null){
			connection.rollback();
			connection.close();}
			
			return mapping.findForward("exception");
		} finally {
			if(connection!=null)
			connection.close();

			if (session != null && session.isOpen())
				try {
					session.close();

				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}

	}

	private void setMenuInformation(Connection connection, SQLUtils sqlUtils,
			HttpSession sessionInf, TKullaniciLoginDTO kullaniciLoginDTO)
			throws SQLException {
		int rol_id = Integer.parseInt(kullaniciLoginDTO.getKuTur());
		List<TMenuDTO> kullaniciMenuList = sqlUtils.getMenuList(connection, rol_id, 0);

		for (int i = 0; i < kullaniciMenuList.size(); i++) {
			TMenuDTO menu = kullaniciMenuList.get(i);

			setSubMenu(menu, connection, rol_id, sqlUtils);

		}
		sessionInf.setAttribute("kullaniciMenuList",kullaniciMenuList);
	}


	private void setSubMenu(TMenuDTO menu, Connection connection, int rol_id,
			SQLUtils utils) throws SQLException {

		menu.setSubMenu(utils.getMenuList(connection, rol_id, menu.getId()));

		if (menu.getSubMenu().size() > 0) {
			for (int i = 0; i < menu.getSubMenu().size(); i++) {
				TMenuDTO m = menu.getSubMenu().get(i);
				m.setSubMenu(utils.getMenuList(connection, rol_id, m.getId()));
			}
		}

	}

	private List<?> getLoginInformation(Session session, String uName,
			String pass) throws HibernateException {
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

	private List<?> subelerList(Session sess) throws HibernateException,
			ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		String sql = " from TSubeDTO p where p.sDurum='A' ";
		Query que = sess.createQuery(sql);
		List<?> result = que.list();
		return result;
	}
	private List<?> labIslemTipList(Session sess) throws HibernateException,
	ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
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
}
