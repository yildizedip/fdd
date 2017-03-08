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

import tr.com.fdd.dto.TDoktorDTO;

public class HastaRandevuSorgulamaGunlukAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = SQLUtils.getMySqlConneciton();
		try {
			
			SQLUtils sqlUtils = new SQLUtils();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			List<TDoktorDTO> doktorList4Randevu = sqlUtils.getDoktorList(conn, subeId, true);
			
			if (doktorList4Randevu.size() == 0) {
				request.setAttribute("noContent", "Kayıt Bulunamadı");
				return mapping.findForward("noContent");

			} else {
				request.setAttribute("doktorList4Randevu", doktorList4Randevu);
				return mapping.findForward("success");
			}

		} catch (SQLException e) {
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
