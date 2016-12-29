package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.dto.TDepoDTO;
import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.dto.TTurKodDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.utils.GenelDegiskenler;

public class LoginSystemAction extends Action {

	private static Logger logger = LoggerFactory
			.getLogger(LoginSystemAction.class);

	/**
	 * mapping objesi ile dogru yonlendirmeler saglanir. (struts -config. xml
	 * okunur.) form bean ile validate edilmis form parametrelerine ulasilir.
	 * 
	 */
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String sube_Id = request.getParameter("subeId");

		logger.info("sube_id :" + sube_Id);

		SessionFactory sessions = null;

		Session session = null;
		Configuration cfg = null;
		SQLUtils sqlUtils = null;
		Connection connection = null;
		try {
			sqlUtils = new SQLUtils();

			connection = SQLUtils.getMySqlConneciton();
			cfg = new Configuration().configure("/myhibernate.cfg.xml");
			sessions = cfg.buildSessionFactory();
			session = sessions.openSession(MysqlUtil.instance.getConnection());
			session.beginTransaction();

			/**
			 * sistemde kullanilacak genel bilgiler aliniyor.
			 */

			List<TTurKodDTO> odemeSekliList = getOdemeSekli(session);
			List<TDoktorDTO> doktorList = sqlUtils.getDoktorList(connection,Integer.parseInt(sube_Id));
			List<?> giderTurKodList = sqlUtils.getGiderTurList(connection,Integer.parseInt(sube_Id));
			List<?> gelirTurKodList = gelirTurListesi(session);
			List<?> islemTurList = islemTurList(session);

			GenelDegiskenler deg = new GenelDegiskenler();

		
			HttpSession sessionInf = request.getSession();

			// sube id sessiona ekleniyor.
			int subeId = new Integer(sube_Id);
			
			sessionInf.setAttribute("subeId", subeId);
			sessionInf.setAttribute("odemeSekliList", odemeSekliList);
			sessionInf.setAttribute("giderTurKodlari", giderTurKodList);
			sessionInf.setAttribute("gelirTurKodlari", gelirTurKodList);
			sessionInf.setAttribute("doktorList", doktorList);
			sessionInf.setAttribute("islemTurList", islemTurList);
			sessionInf.setAttribute("saatler", deg.getHours());
			sessionInf.setAttribute("dakikalar", deg.getDakikalar(5));

			/**
			 * gunluk tarih sessiona ekleniyor.
			 */
			Date bugun = new Date();
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String gunlukTarih = sdff.format(bugun);
			request.getSession().setAttribute("tarihStr", gunlukTarih);

			/**
			 * acilacak ilk sayfada istatistikler hesaplaniyor.
			 * 
			 */

			// sube seciliyor.

			TSubeDTO subeDTO = sqlUtils.getSubeBilgi(connection, subeId);
			sessionInf.setAttribute("sube", subeDTO);

			Integer getHastaSayisi = sqlUtils.getHastaSayisi(connection, subeId);
			Integer getOperasyonuKesinlesmemisHastaSayisi = sqlUtils.getOperasonuKesinlesmemisHastaSayisi(connection, subeId);
			List<Object[]> getTopOperations = sqlUtils.getTopOperations(connection, subeId);
			List<Object[]> getDoktorIslemOperations = sqlUtils.getDoktorIslemSayisi(connection, subeId);
			List<Object[]> getTopGider = sqlUtils.getTopGider(connection,subeId);
		//	sessionInf.setAttribute("getHastaSayisi", getHastaSayisi);
		//	sessionInf.setAttribute("getTopOperations", getTopOperations);
		//	sessionInf.setAttribute("getDoktorIslemOperations",	getDoktorIslemOperations);
		//	sessionInf.setAttribute("getTopGider", getTopGider);
		//	sessionInf.setAttribute("getOperasyonuKesinlesmemisHastaSayisi",getOperasyonuKesinlesmemisHastaSayisi);
			sessionInf.setAttribute("disSayisiList", getDisSayisiList());
			sessionInf.setAttribute("adetList", getAdetSayisiList());
		//	sessionInf.setAttribute("depoList", getDepoList(session));
		//	sessionInf.setAttribute("depoUrunTipList", getDepoUrunTipList(session));

			return mapping.findForward("success");
			// }

			// else {
			// request.setAttribute("failure",
			// GUIMessages.KULLANICI_BULUNAMADI);
			// return mapping.findForward("failure");

		} catch (Exception e) {
			request.setAttribute("exception", e);
			if(connection!=null){
			connection.rollback();
			connection.close();
			}
			return mapping.findForward("exception");
		} finally {
			if(connection!=null){
			connection.close();
			if (session != null && session.isOpen())
				try {
					session.close();

				} catch (HibernateException e) {
					e.printStackTrace();
				}
			}
		}

	}

	public List<TTurKodDTO> getOdemeSekli(Session sess)
			throws HibernateException, ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();

		String sql = " from TOdemeSekliDTO ";
		Query que = sess.createQuery(sql);
		@SuppressWarnings("unchecked")
		List<TTurKodDTO> result = que.list();
		return result;
	}
	
	public List<TDepoDTO> getDepoList(Session sess)
			throws HibernateException, ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		
		String sql = " from TDepoDTO where durum=1 ";
		Query que = sess.createQuery(sql);
		@SuppressWarnings("unchecked")
		List<TDepoDTO> result = que.list();
		return result;
	}
	public List<TDepoDTO> getDepoUrunTipList(Session sess)
			throws HibernateException, ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		
		String sql = " from TDepoUrunTipDTO where durum=1 ";
		Query que = sess.createQuery(sql);
		@SuppressWarnings("unchecked")
		List<TDepoDTO> result = que.list();
		return result;
	}

	private List<?> gelirTurListesi(Session sess) throws HibernateException,
			ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		String sql = " from TTurKodDTO as a where a.turTip = :p_tur_tip order by a.turAd";

		Query que = sess.createQuery(sql);
		que.setInteger("p_tur_tip", new Integer(1));

		List<?> result = que.list();
		return result;
	}

	private List<?> islemTurList(Session sess) throws HibernateException,
			ClassNotFoundException, SQLException {
		if (sess == null)
			sess = GenericAction.getHibernateSession();
		String sql = " from TIslemTipDTO order by ad  ";
		Query que = sess.createQuery(sql);
		List<?> result = que.list();
		return result;
	}

	private List<Integer> getDisSayisiList() {

		List<Integer> list = new ArrayList<Integer>();
		for (int i = 1; i < 35; i++) {
			list.add(i);
		}
		return list;
	}
	private List<Integer> getAdetSayisiList() {
		
		List<Integer> list = new ArrayList<Integer>();
		for (int i = 1; i < 100; i++) {
			list.add(i);
		}
		return list;
	}

}
