package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TTurKodDTO;
import tr.com.fdd.mysql.DbConnection;

public class GiderTuruSubeGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String turId=request.getParameter("turId");
		Connection connection = null;
		SQLUtils sqlUtil = new SQLUtils();
		try {
			connection = DbConnection.getMySqlConneciton();
		
			TTurKodDTO dto=sqlUtil.getGiderTur(connection, turId);			
			
			request.setAttribute("giderTurDto", dto);
			return mapping.findForward("success");						
			
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("exception");
		}
		finally {
			try {
				connection.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}
}
