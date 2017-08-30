package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.mysql.DbConnection;

public class HastaOdemeGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Connection conn = null;
		try {
			String odemeId = request.getParameter("id");
			conn = DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils = new SQLUtils();
			THastaOdemeDTO hastaOdeme = sqlUtils.getHastaOdeme(
					Integer.parseInt(odemeId), conn);

			request.setAttribute("odeme", hastaOdeme);

			return mapping.findForward("success");

		} catch (Exception e) {
			try {
				conn.rollback();
				conn.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}

}
