package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TLabrotuvarDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaLabrotuvarIslemleriAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			String labIslemId = request.getParameter("labIslemId");
			String labIslemTip = request.getParameter("labIslemTip");

			SQLUtils sqlUtils = new SQLUtils();
			// Integer subeId = (Integer)
			// request.getSession().getAttribute("subeId");

			TLabrotuvarDTO labrotuvarDTO = sqlUtils.getLabratuvarIslem(conn,
					Integer.parseInt(labIslemId));

			request.setAttribute("labIslem", labrotuvarDTO);

			if (labIslemTip.equals(GenelDegiskenler.LAB_ISLEM_ONAYLA_RED))
				return mapping.findForward("gotoLabOnayRedPage");
			else if (labIslemTip.equals(GenelDegiskenler.LAB_ISLEM_DETAY_GOSTER))
				return mapping.findForward("gotoLabIslemDetayGosterPage");
			else 
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
		}

		finally {
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
