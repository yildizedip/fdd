package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.utils.GenelDegiskenler;

public class GetGelirGiderDurumuAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.getSession().removeAttribute("gunlukKasaDurumu");
		request.getSession().removeAttribute("gunlukGelirGiderFarkListesi");
		request.getSession().removeAttribute("kasaDurumu");
		request.getSession().removeAttribute("gelirList");
		request.getSession().removeAttribute("giderList");

		String basTar = request.getParameter("bas_tar");
		String bitTar = request.getParameter("bit_tar");
		String doktorIdStr = request.getParameter("doktorId");
		String islemTipStr = request.getParameter("islemTipi");
		String giderTuru = request.getParameter("giderTuru");
		String islem = request.getParameter("islem");
		
		/**
		 * eger islem turu 
		 */
		String doktorAd = null;
		int doktorId = -1;
		int islemTip = -1;

		if (doktorIdStr != null)
			doktorId = Integer.parseInt(doktorIdStr);

		if (islemTipStr != null)
			islemTip = Integer.parseInt(islemTipStr);

		/**
		 * doktoroun gider turunu bulmak icin eklendi
		 */
		Object[] memberSession = (Object[]) request.getSession().getAttribute(
				"sessionMember");
		TKullaniciLoginDTO kullaniciLoginDTO = (TKullaniciLoginDTO) memberSession[0];
		TKullaniciBilgiDTO kullaniciBilgiDTO = (TKullaniciBilgiDTO) memberSession[1];

		String kuTur = kullaniciLoginDTO.getKuTur();

		if (basTar == null || bitTar == null) {

			Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			basTar = sdf.format(dat);
			bitTar = sdf.format(dat);

		}

		Connection conn = null;
		Integer subeId= (Integer) request.getSession().getAttribute("subeId");
		try {

			conn = MysqlUtil.instance.getConnection();
			SQLUtils sqlUtils = new SQLUtils();
			
		
			List<TGelirGiderDTO> giderList = sqlUtils.giderListesi(basTar,
					bitTar, giderTuru, conn, subeId.intValue());

			if (kuTur.equals(GenelDegiskenler.KullaniciTurleri.DOKTOR)) {
				doktorAd = kullaniciBilgiDTO.getKuAd();
				doktorId = ((TDoktorDTO) sqlUtils.getDoktor(
						kullaniciLoginDTO.getKuId(), -1, conn, false, -1)).getdId();
			}

			boolean implantGeliriGoster=false;
			if(islem.equals(GenelDegiskenler.GET_GELIR_TURU_FOR_IMPLANT))
				implantGeliriGoster=true;
			
			List<THastaOdemeDTO> gelirList = sqlUtils.gelirListesi(basTar,
					bitTar, doktorId, islemTip,subeId.intValue(), conn, implantGeliriGoster);

			if (gelirList.size() == 0 && giderList.size() == 0)

				request.setAttribute("warn", "Kayıt Bulunamadı");

			Double toplamGelir = new Double(0);
			Double toplamGider = new Double(0);

			for (int i = 0; i < gelirList.size(); i++) {
				THastaOdemeDTO odeme = gelirList.get(i);

				toplamGelir = toplamGelir + odeme.getMiktar();

			}

			for (int i = 0; i < giderList.size(); i++) {
				TGelirGiderDTO gider = giderList.get(i);

				toplamGider = toplamGider + gider.getMiktar();
			}

		
			

			/**
			 * odeme sekline gore gelir list
			 */
			List<THastaOdemeDTO> odemeSeklineGoreGelirList = sqlUtils
					.odemeSeklineGoreGelirListesi(basTar, bitTar, doktorId,
							islemTip, conn, subeId.intValue());

			request.setAttribute("odemeSeklineGoreGelirList",
					odemeSeklineGoreGelirList);
			
			/**
			 * doktora gore gelir list hesaplanirken 
			 */
			List<THastaOdemeDTO> doktoraGoreGelirList = sqlUtils
			.doktoraGoreGelirListesi(basTar, bitTar, doktorId, islemTip, conn, subeId.intValue());
			
			request.setAttribute("doktoraGoreGelirList",
					doktoraGoreGelirList);
			
			List<THastaOdemeDTO> opersyonTuruneGoreGelirList = sqlUtils
			.operasyonTuruneGoreGelirListesi(basTar, bitTar, doktorId, islemTip, conn, subeId.intValue());
			
			request.setAttribute("opersyonTuruneGoreGelirList",
					opersyonTuruneGoreGelirList);

			/**
			 * gider turleri icin raprolar hazirlaniyor
			 */

			List<TGelirGiderDTO> giderGiderTurBazliRaporu = sqlUtils
					.giderGiderTurBazliRapor(basTar, bitTar, conn, doktorAd,
							kuTur,subeId.intValue());
			List<TGelirGiderDTO> giderOdemeSekliMiktarRaporu = sqlUtils
					.giderOdemeSekliMiktarRaporu(basTar, bitTar, conn,
							doktorAd, kuTur,subeId.intValue());
//			List<TGelirGiderDTO> giderTuruneGoreGiderList = sqlUtils
//			.giderGiderTurBazliRapor(basTar, bitTar, conn, doktorAd, kuTur);
			// List<TGelirGiderDTO> giderParaBirimiOdemeRaporu
			// =sqlUtils.giderParaBirimiRaporu(basTar,bitTar,conn,doktorAd,kuTur);

			Object[] giderIstatistikler = new Object[] {
					giderGiderTurBazliRaporu, null, giderOdemeSekliMiktarRaporu };
			request.setAttribute("giderIstatistikler", giderIstatistikler);

			request.setAttribute("toplamGelir", toplamGelir);
			request.setAttribute("toplamGider", toplamGider);
			request.setAttribute("gelirList", gelirList);
			request.setAttribute("giderList", giderList);
			request.setAttribute("basTar", basTar);
			request.setAttribute("bitTar", bitTar);
			if (GenelDegiskenler.GET_GUNSONU_RAPORU.equals(islem)) {
				return mapping.findForward("goGunSonuRaporu");
			}

			else if (GenelDegiskenler.GET_GELIR_RAPORU.equals(islem) ) {
				return mapping.findForward("goGelirRaporu");
			} 
			else if (GenelDegiskenler.GET_GELIR_TURU_FOR_IMPLANT.equals(islem)) {
				return mapping.findForward("goGelirRaporuImplant");
			} 			
			else if (GenelDegiskenler.GET_GIDER_RAPOR.equals(islem)) {
				return mapping.findForward("goGiderRaporu");
			} else
				return mapping.findForward("success");

			//
			// if (gelirList.size() == 0) {
			// request.setAttribute("noContent", "Kay�t Bulunamad�");
			// return mapping.findForward("noContent");
			//
			// }
			// if (giderList.size() == 0) {
			// request.setAttribute("noContent", "Kay�t Bulunamad�");
			// return mapping.findForward("noContent");
			//
			// }
			//
			// else {

			// List<TGelirGiderDTO> gunlukGelirGiderFarkListesi=
			// sqlUtils.gelirGiderFarkListesi(gunlukTarih,gunlukTarih,conn);
			// request.getSession().setAttribute("gunlukGelirGiderFarkListesi",
			// gunlukGelirGiderFarkListesi);

			// List<TGelirGiderDTO> gelirToplami=
			// sqlUtils.gelirToplami(gunlukTarih, gunlukTarih, conn);
			// List<TGelirGiderDTO> giderToplami=
			// sqlUtils.giderToplami(gunlukTarih, gunlukTarih, conn);
			//
			// List<TGelirGiderDTO> gunlukFark=
			// sqlUtils.getGunlukFark(gelirToplami,giderToplami);
			// request.getSession().setAttribute("gunlukGelirGiderFarkListesi",
			// gunlukFark);
			//
			// List<TGelirGiderDTO> kasaDurumu=
			// sqlUtils.kasaAnalizi(gunlukTarih,conn);
			// request.getSession().setAttribute("kasaDurumu", kasaDurumu);
			//
			// List< TGelirGiderDTO> gunlukGelirListesiDetay=
			// sqlUtils.gelirListesi(gunlukTarih, gunlukTarih, conn);
			// request.getSession().setAttribute("gelirList",
			// gunlukGelirListesiDetay);
			// List< TGelirGiderDTO> gunlukGiderListesiDetay=
			// sqlUtils.giderListesi(gunlukTarih, gunlukTarih, conn);
			// request.getSession().setAttribute("giderList",
			// gunlukGiderListesiDetay);

			// }

		} catch (Exception e) {
			try {

				if(conn!=null)
				conn.rollback();
				MysqlUtil.instance.closeConnection(conn);

			} catch (SQLException e1) {
				e1.printStackTrace();

				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		}  finally {
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
