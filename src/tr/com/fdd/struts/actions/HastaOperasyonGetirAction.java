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
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaOperasyonGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String islem = request.getParameter("islem");
		String operasyonId = request.getParameter("operasyonId");
		String hastaId = request.getParameter("hastaId");
		Connection conn = null;
		try {
			conn = SQLUtils.getMySqlConneciton();

			SQLUtils sqlUtils = new SQLUtils();

			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			THastaDTO hasta = sqlUtils.getHasta(
					new Integer(hastaId).intValue(), conn, subeId.intValue());

			TIslemDTO operasyon = sqlUtils.getHastaOperasyon(
					Integer.parseInt(operasyonId), conn);

			List<THastaOdemeDTO> odemeListesi = sqlUtils.getHastaOdemeListesi(
					operasyon.getId(), conn, null, null);

			request.setAttribute("hasta", hasta);
			request.setAttribute("operasyon", operasyon);

			if (GenelDegiskenler.OPERASYON_GUNCELLE.equals(islem)) {

				if (odemeListesi.size() > 0) {
					request.setAttribute("odemeListesi", odemeListesi);
					request.setAttribute("warn", GUIMessages.ODEME_VAR);
				}

				return mapping.findForward("gotoOperasyonGuncelle");
			} else
				return mapping.findForward("success");

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
		} 
		catch (Exception e) {
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
