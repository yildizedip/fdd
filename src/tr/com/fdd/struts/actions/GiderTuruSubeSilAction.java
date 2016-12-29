package tr.com.fdd.struts.actions;

import java.sql.Connection;
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

import tr.com.fdd.dto.TTurKodSubeDTO;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GUIMessages;

public class GiderTuruSubeSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String giderTuruSubeId = request.getParameter("giderTuruSubeId");
		Session sess = null;
		Transaction tran = null;

		Connection conn = SQLUtils.getMySqlConneciton();
		SQLUtils sqlUtils = new SQLUtils();
		try {
			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();

			Query query = sess
					.createQuery("from tr.com.fdd.dto.TTurKodSubeDTO "
							+ " p where p.id = :var");
			query.setInteger("var", Integer.parseInt(giderTuruSubeId));
			TTurKodSubeDTO result = (TTurKodSubeDTO) query.uniqueResult();
			result.setDurum("P");
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_SILME_BASARILI);

			conn = SQLUtils.getMySqlConneciton();
			sqlUtils = new SQLUtils();
			List<LoginForm> kullaniciList = sqlUtils.getKullaniciList(conn, "");
			request.setAttribute("kullaniciList", kullaniciList);

			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
			conn.rollback();
			conn.close();
			return mapping.findForward("exception");
		} finally {
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}

			conn.close();
		}
	}

}
