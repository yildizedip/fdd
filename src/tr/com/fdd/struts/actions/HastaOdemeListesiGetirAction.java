package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
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
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaOdemeListesiGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = SQLUtils.getMySqlConneciton();
			String islemId = request.getParameter("islemId");
			String hastaId = request.getParameter("hastaId");
			String tip = request.getParameter("tip");
			SQLUtils sqlUtils = new SQLUtils();
			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");

			THastaDTO hasta = sqlUtils.getHasta(
					new Integer(hastaId).intValue(), conn, subeId.intValue());

			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
					.getHastaOperasyonListesi(hasta.getId(),
							Integer.parseInt(islemId), conn);

			List<THastaOdemeDTO> hastaOdemeListesi = new ArrayList<THastaOdemeDTO>();
			if (hastaOperasyonListesi.size() > 0) {
				hastaOdemeListesi = ((TIslemDTO) hastaOperasyonListesi.get(0))
						.getOdemeList();
				request.setAttribute("operasyon",
						(TIslemDTO) hastaOperasyonListesi.get(0));
			}
			if (hastaOdemeListesi.size() == 0) {
				request.setAttribute("odenenMiktar", new Double(0));
			} else {
				Double odenenMiktar = new Double(0);
				for (int i = 0; i < hastaOdemeListesi.size(); i++) {
					THastaOdemeDTO odeme = (THastaOdemeDTO) hastaOdemeListesi
							.get(i);
					if (odeme.getOdemeTuru() != 1) {
						odenenMiktar = odenenMiktar + odeme.getMiktar();
					}

				}
				request.setAttribute("odenenMiktar", odenenMiktar);

			}

			request.setAttribute("hasta", hasta);

			request.setAttribute("hastaOperasyonListesi", hastaOperasyonListesi);
			request.setAttribute("hastaOdemeListesi", hastaOdemeListesi);

			if (GenelDegiskenler.GELIR_EKLE.equals(tip)) {
				return mapping.findForward("gotoOdemeEkle");

			}
			if (hastaOdemeListesi.size() == 0) {
				request.setAttribute("noContent", "Kayýt Bulunamadý");
				return mapping.findForward("noContent");

			} else {
				return mapping.findForward("success");

			}

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
