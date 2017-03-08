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
import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.utils.GUIMessages;

public class GetGiderSorgulamaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			request.getSession().removeAttribute("giderList");
			request.getSession().removeAttribute("giderIstatistikler");
			// varsa request parametresi alinir.
			String basTar = request.getParameter("bas_tar");
			String bitTar = request.getParameter("bit_tar");
			String aciklama = request.getParameter("aciklama");
			/**
			 * doktoroun gider turunu bulmak icin eklendi
			 */
			Object[] memberSession = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			TKullaniciLoginDTO kullaniciLoginDTO = (TKullaniciLoginDTO) memberSession[0];
			String kuTur = kullaniciLoginDTO.getKuTur();
			TKullaniciBilgiDTO kullaniciBilgiDTO = (TKullaniciBilgiDTO) memberSession[1];
			String doktorAd = kullaniciBilgiDTO.getKuAd();
			int giderKodu = -1;
			giderKodu = kullaniciBilgiDTO.getGiderKodu();

			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			conn = MysqlUtil.instance.getConnection();

			SQLUtils sqlUtils = new SQLUtils();
			List<TGelirGiderDTO> giderListesi = sqlUtils
					.giderListesi(basTar, bitTar, conn, aciklama, giderKodu,
							kuTur, subeId.intValue());

			if (giderListesi.size() == 0) {
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");

			} else {

				request.getSession().setAttribute("giderList", giderListesi);

				Double toplamGider = new Double(0);

				for (int i = 0; i < giderListesi.size(); i++) {
					TGelirGiderDTO gider = giderListesi.get(i);

					toplamGider = toplamGider + gider.getMiktar();
				}
				request.setAttribute("toplamGider", toplamGider);

				// istatistikler hesaplaniyor. true olmasi gunluk oldugunu
				// gosterir.
				List<TGelirGiderDTO> giderGiderTurBazliRaporu = sqlUtils
						.giderGiderTurBazliRapor(basTar, bitTar, conn,
								doktorAd, kuTur, subeId.intValue());
				List<TGelirGiderDTO> giderOdemeSekliMiktarRaporu = sqlUtils
						.giderOdemeSekliMiktarRaporu(basTar, bitTar, conn,
								doktorAd, kuTur, subeId.intValue());
				List<TGelirGiderDTO> giderParaBirimiOdemeRaporu = sqlUtils
						.giderParaBirimiRaporu(basTar, bitTar, conn, doktorAd,
								kuTur, subeId.intValue());

				Object[] giderIstatistikler = new Object[] {
						giderGiderTurBazliRaporu, giderParaBirimiOdemeRaporu,
						giderOdemeSekliMiktarRaporu };
				request.getSession().setAttribute("giderIstatistikler",
						giderIstatistikler);
			}

			return mapping.findForward("success");
		} 
		catch (Exception e) {
			try {
				if(conn!=null){
				conn.rollback();
				conn.close();
				}
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		} finally {

			try {
				MysqlUtil.instance.closeConnection(conn);
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}

}
