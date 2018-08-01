package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaBazliToplamOdemeListesiAction extends GenericAction {

	@Override
	public ActionForward  executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans){
			HttpSession httpSession = null;
		try {
			httpSession = request.getSession();
			String tip = request.getParameter("tip");
			String basTar = request.getParameter("basTar");
			String bitTar = request.getParameter("bitTar");
			String protokol = request.getParameter("protokol");

			request.setAttribute("basTar", basTar);
			request.setAttribute("bitTar", bitTar);

			int doktorId = -1;
			request.setAttribute("raporIslemTipi", tip);

			Object[] sessionInf = (Object[]) httpSession.getAttribute("sessionMember");
			TKullaniciLoginDTO loginDTO = (TKullaniciLoginDTO) sessionInf[0];
			if (GenelDegiskenler.KullaniciTurleri.DOKTOR.equals(loginDTO.getKuTur()))
				doktorId = loginDTO.getKuId();

			SQLUtils sqlUtils = new SQLUtils();

			HastaForm frm = (HastaForm) form;

			List<THastaOdemeDTO> hastaBazliToplamOdemeListesi = null;

			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			hastaBazliToplamOdemeListesi = sqlUtils
					.hastaBazliToplamOdemeListesi(connection, "A", doktorId,
							subeId.intValue(), basTar, bitTar, frm.getAd(),
							frm.getSoyad(), protokol);

			boolean checkNull = true;
			for (int i = 0; i < hastaBazliToplamOdemeListesi.size(); i++) {	
				THastaOdemeDTO dto = hastaBazliToplamOdemeListesi.get(i);

				if (dto.getHasta().getProtokolNo() == null
						|| dto.getHasta().getProtokolNo().equals("0")  )
					checkNull = false;
			}

			if (checkNull)
				Collections.sort(hastaBazliToplamOdemeListesi,
						new HastaOdemeComparator());

			if (hastaBazliToplamOdemeListesi.size() == 0) {
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");

			} else {

				/**
				 * listede kalan miktar 0 ise odemeleri bitmis hastalar
				 * listelenir. bu liste request attribute olarak setlenip ilgili
				 * sayfalarda kullanilir.
				 * 
				 */

				ArrayList<THastaOdemeDTO> odemesiBitmisHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> operasyonuBitmisHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> operasyonuBitmisOdemesiDevamEdenHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> operasyonuBitmisOdemesiBitmisHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> operasyonuDevamEdenOdemesiBitmisHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> operasyonuDevamEdenHastaListesi = new ArrayList<THastaOdemeDTO>();
				ArrayList<THastaOdemeDTO> odemesiDevamEdenHastaListesi = new ArrayList<THastaOdemeDTO>();

				double toplamOdemeMiktari = 0;
				double toplamKalanMiktar = 0;
				double toplamUcret = 0;

				for (int i = 0; i < hastaBazliToplamOdemeListesi.size(); i++) {
					THastaOdemeDTO odeme = hastaBazliToplamOdemeListesi.get(i);

					if (odeme.getKalanMiktar() == 0) {
						odemesiBitmisHastaListesi.add(odeme);
					}
					if(odeme.getKalanMiktar() !=0)
					{
						odemesiDevamEdenHastaListesi.add(odeme);
					}
						
					if (odeme.getIslem().getIslemBitisTarihi() != null) {
						operasyonuBitmisHastaListesi.add(odeme);
					}
					if(odeme.getIslem().getIslemBitisTarihi() == null  ){
						operasyonuDevamEdenHastaListesi.add(odeme);
					}
						
						
						
						
					if (odeme.getIslem().getIslemBitisTarihi() != null
							&& odeme.getKalanMiktar() != 0) {
						operasyonuBitmisOdemesiDevamEdenHastaListesi.add(odeme);
					}
					if (odeme.getIslem().getIslemBitisTarihi() != null
							&& odeme.getKalanMiktar() == 0) {
						operasyonuBitmisOdemesiBitmisHastaListesi.add(odeme);
					}
					if (odeme.getIslem().getIslemBitisTarihi() == null
							&& odeme.getKalanMiktar() == 0) {
						operasyonuDevamEdenOdemesiBitmisHastaListesi.add(odeme);
					}

				}
				request.setAttribute("odemesiBitmisHastaListesi",
						odemesiBitmisHastaListesi);
				request.setAttribute("operasyonuBitmisHastaListesi",
						operasyonuBitmisHastaListesi);
				request.setAttribute(
						"operasyonuBitmisOdemesiDevamEdenHastaListesi",
						operasyonuBitmisOdemesiDevamEdenHastaListesi);
				request.setAttribute(
						"operasyonuBitmisOdemesiBitmisHastaListesi",
						operasyonuBitmisOdemesiBitmisHastaListesi);
				request.setAttribute(
						"operasyonuDevamEdenOdemesiBitmisHastaListesi",
						operasyonuDevamEdenOdemesiBitmisHastaListesi);
				request.setAttribute(
						"operasyonuDevamEdenHastaListesi",
						operasyonuDevamEdenHastaListesi);
				request.setAttribute(
						"odemesiDevamEdenHastaListesi",
						odemesiDevamEdenHastaListesi);
				
				Commons commons= new Commons();

				if ("10".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",hastaBazliToplamOdemeListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(hastaBazliToplamOdemeListesi);
					toplamKalanMiktar = commons.getToplamKalanMiktar(hastaBazliToplamOdemeListesi);
					toplamUcret = commons.getToplamUcret(hastaBazliToplamOdemeListesi);

				}
				if ("11".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",odemesiBitmisHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(odemesiBitmisHastaListesi);

					toplamKalanMiktar = commons.getToplamKalanMiktar(odemesiBitmisHastaListesi);
					toplamUcret = commons.getToplamUcret(odemesiBitmisHastaListesi);
				}
				if ("12".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",operasyonuBitmisHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(operasyonuBitmisHastaListesi);

					toplamKalanMiktar = commons.getToplamKalanMiktar(operasyonuBitmisHastaListesi);
					toplamUcret = commons.getToplamUcret(operasyonuBitmisHastaListesi);
				}
				if ("13".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi", operasyonuBitmisOdemesiDevamEdenHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(operasyonuBitmisOdemesiDevamEdenHastaListesi);

					toplamKalanMiktar = commons.getToplamKalanMiktar(operasyonuBitmisOdemesiDevamEdenHastaListesi);
					toplamUcret = commons.getToplamUcret(operasyonuBitmisOdemesiDevamEdenHastaListesi);
				}
				if ("14".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",	operasyonuBitmisOdemesiBitmisHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(operasyonuBitmisOdemesiBitmisHastaListesi);

					toplamKalanMiktar =commons.getToplamKalanMiktar(operasyonuBitmisOdemesiBitmisHastaListesi);
					toplamUcret = commons.getToplamUcret(operasyonuBitmisOdemesiBitmisHastaListesi);
				}
				if ("15".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",	operasyonuDevamEdenOdemesiBitmisHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(operasyonuDevamEdenOdemesiBitmisHastaListesi);

					toplamKalanMiktar = commons.getToplamKalanMiktar(operasyonuDevamEdenOdemesiBitmisHastaListesi);
					toplamUcret = commons.getToplamUcret(operasyonuDevamEdenOdemesiBitmisHastaListesi);
				}
				if ("16".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",	operasyonuDevamEdenHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(operasyonuDevamEdenHastaListesi);
					
					toplamKalanMiktar = commons.getToplamKalanMiktar(operasyonuDevamEdenHastaListesi);
					toplamUcret = commons.getToplamUcret(operasyonuDevamEdenHastaListesi);
				}
				if ("17".equals(tip)) {
					request.setAttribute("hastaBazliToplamOdemeListesi",	odemesiDevamEdenHastaListesi);
					toplamOdemeMiktari = commons.getToplamOdemeMiktari(odemesiDevamEdenHastaListesi);
					
					toplamKalanMiktar = commons.getToplamKalanMiktar(odemesiDevamEdenHastaListesi);
					toplamUcret = commons.getToplamUcret(odemesiDevamEdenHastaListesi);
				}

				request.setAttribute("toplamMiktar", toplamOdemeMiktari);

				request.setAttribute("toplamKalanMiktar", toplamKalanMiktar);
				request.setAttribute("toplamUcret", toplamUcret);

				return mapping.findForward("success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
				connection.close();
				e.printStackTrace();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				e.printStackTrace();
				return mapping.findForward("exception");
			}
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}

	}

	

	class HastaOdemeComparator implements Comparator<THastaOdemeDTO> {

		@Override
		public int compare(THastaOdemeDTO o1, THastaOdemeDTO o2) {

			return o1.getHasta().getProtokolNo()
					.compareTo(o2.getHasta().getProtokolNo());
		}

	}
}
