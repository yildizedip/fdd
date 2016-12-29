package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GUIMessages;

public class KullaniciGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		LoginForm frm = (LoginForm) form;
		Connection connection = null;
		SQLUtils sqlUtil = new SQLUtils();
		try {
			connection = SQLUtils.getMySqlConneciton();
			// sube sorgulama icin kullaniliyor.

			List<LoginForm> kullaniciList = sqlUtil.getKullaniciList(
					connection, frm.getUserName());

			if (frm.getKuloginId() != 0) {
				LoginForm sube = sqlUtil.getKullanici(connection,
						frm.getKuloginId());

				request.setAttribute("kullanici", sube);
			}

			if (kullaniciList.size() == 0) {
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");
			}
			request.setAttribute("kullaniciList", kullaniciList);
			return mapping.findForward("success");

		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("exception");
		} finally {
			try {
				MysqlUtil.instance.closeConnection(connection);
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}

	}

}
