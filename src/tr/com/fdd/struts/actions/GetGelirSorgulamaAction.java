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
import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.DbConnection;

public class GetGelirSorgulamaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {

			request.getSession().removeAttribute("gelirList");
			request.getSession().removeAttribute("gelirIstatistikler");

			// varsa request parametresi alinir. doktor girisi varsa doktora
			// ozel
			// veri hazirlanir.
			// String doctorKuId= request.getParameter("doctor");
			response.setContentType("ISO-8859-9");

			Object[] memberSession = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			TKullaniciLoginDTO kullaniciLoginDTO = (TKullaniciLoginDTO) memberSession[0];
			String doctorKuId = new Integer(kullaniciLoginDTO.getKuId())
					.toString();
			String kuTur = kullaniciLoginDTO.getKuTur();
			String basTar = request.getParameter("bas_tar");
			String bitTar = request.getParameter("bit_tar");

			conn = DbConnection.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			String aciklama = request.getParameter("aciklama");
			SQLUtils sqlUtils = new SQLUtils();

			List<TGelirGiderDTO> gelirListesi = sqlUtils.gelirListesi(basTar,
					bitTar, conn, doctorKuId, kuTur, aciklama,
					subeId.intValue());

			if (gelirListesi.size() == 0) {
				request.setAttribute("noContent", "Kay�t Bulunamad�");
				return mapping.findForward("noContent");

			} else {
				request.getSession().setAttribute("gelirList", gelirListesi);

				// istatistikler hesaplaniyor. true olmasi gunluk oldugunu
				// gosterir.
				List<TGelirGiderDTO> gelirOdemeSekliMiktarRaporu = sqlUtils
						.gelirOdemeSekliMiktarRaporu(basTar, bitTar, conn,
								doctorKuId, kuTur, subeId.intValue());
				List<TGelirGiderDTO> gelirDoktorOdemeRaporu = sqlUtils
						.gelirDoktorMiktarRaporu(basTar, bitTar, conn,
								doctorKuId, kuTur, subeId.intValue());
				List<TGelirGiderDTO> gelirParaBirimiOdemeRaporu = sqlUtils
						.gelirParaBirimiRaporu(basTar, bitTar, conn,
								doctorKuId, kuTur, subeId.intValue());
				Object[] gelirIstatistikler = new Object[] {
						gelirOdemeSekliMiktarRaporu, gelirDoktorOdemeRaporu,
						gelirParaBirimiOdemeRaporu, subeId.intValue() };
				request.getSession().setAttribute("gelirIstatistikler",
						gelirIstatistikler);
			}

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
