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

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.DbConnection;

public class HastaLabrotuvaraGonderPageOpenAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			String islemId = request.getParameter("islemId");
			String hastaId = request.getParameter("hastaId");
			SQLUtils sqlUtils = new SQLUtils();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			THastaDTO hasta = sqlUtils.getHasta(new Integer(hastaId).intValue(), conn, subeId.intValue());

			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
					.getHastaOperasyonListesi(hasta.getId(),
							Integer.parseInt(islemId), conn);
			
			TIslemDTO islemDTO= hastaOperasyonListesi.get(0);
			
			request.setAttribute("hasta", hasta);
			request.setAttribute("operasyon", islemDTO);
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
