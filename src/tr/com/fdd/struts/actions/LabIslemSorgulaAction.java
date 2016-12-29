package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TLabrotuvarDTO;

public class LabIslemSorgulaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		String requestPage = request.getParameter("requestPage");

		try {
			conn = SQLUtils.getMySqlConneciton();

			SQLUtils utils = new SQLUtils();

			List<TLabrotuvarDTO> labList = utils.getLabratuvarIslemList(conn,
					form);

			request.setAttribute("labIslemList", labList);
			if ("klinik".equals(requestPage))
				return mapping.findForward("gotoKlinikPage");
			else
				return mapping.findForward("gotoLabPage");
		} catch (Exception e) {
			request.setAttribute("warn", e.getMessage());
			return mapping.findForward("exception");
		} finally {
			conn.close();
		}

	}

}
