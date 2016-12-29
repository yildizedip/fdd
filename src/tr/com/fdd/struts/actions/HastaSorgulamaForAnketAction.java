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
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.GUIMessages;

public class HastaSorgulamaForAnketAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = SQLUtils.getMySqlConneciton();
			request.setCharacterEncoding("ISO-8859-9");
			HastaForm hastaForm = (HastaForm) form;
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			SQLUtils sqlUtils = new SQLUtils();
			List<THastaDTO> hastaListesi = sqlUtils.getHastaListesiForAnket(
					hastaForm.getAd(), hastaForm.getSoyad(),
					hastaForm.getProtokolNo(), conn, subeId.intValue(), hastaForm.getBasTar(), hastaForm.getBitTar());

			if (hastaListesi.size() == 0) {
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");

			}

			request.setAttribute("hastaListesi", hastaListesi);

				return mapping.findForward("success");
		} catch (Exception e) {
			e.printStackTrace();
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
