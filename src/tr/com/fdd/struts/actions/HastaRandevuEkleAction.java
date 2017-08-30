package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.THastaRandevuDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.HastaRandevuForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaRandevuEkleAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HastaRandevuForm hastaRandevuForm = null;

		Transaction tran = null;
		Session session = null;

		try {
			String tedavi = request.getParameter("islemTipi");
			String implantAktif = request.getParameter("implantAktif");
			String operasyonDurum = request.getParameter("operasyonDurum");
			String implantBaglayanDoktorId = request.getParameter("implantBaglayanDoktorId");
			String implantCerrahId = request.getParameter("implantCerrahId");
			String tedaviTarih = request.getParameter("tedaviTarih");
			String tedaviUcret = request.getParameter("tedaviUcret");
			String tedaviDisNo = request.getParameter("tedaviDisNo");
			String tedaviAciklama = request.getParameter("tedaviAciklama");
			String disAdet = request.getParameter("disAdet");

			SQLUtils sqlUtils = new SQLUtils();
			Connection conn = DbConnection.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			hastaRandevuForm = (HastaRandevuForm) form;
			hastaRandevuForm.setAciklama(hastaRandevuForm.getAciklama().replaceAll("\r\n", " "));
			

			// if (hastaRandevuForm.getRandevuTarihiStr() == null)
			// hastaRandevuForm.setRandevuTarihi(new Date());
			// else {

			// String tarihStr = hastaRandevuForm.getRandevuTarihiStr();
			//
			//// SimpleDateFormat dateFormat = new
			// SimpleDateFormat("yyyy.MM.dd");
			//// Date convertedDate = dateFormat.parse(tarihStr);
			//// hastaRandevuForm.setRandevuTarihi(convertedDate);
			// }

			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();

			THastaDTO tHastaDto = null;
			/// yeni girilen hasta icin ekleme
			if (hastaRandevuForm.getHastaId() == 0 && !hastaRandevuForm.getHastaAd().equals("")
					&& !hastaRandevuForm.getHastaSoyad().equals("") && !hastaRandevuForm.getTelefon().equals("")) {

				tHastaDto = new THastaDTO();
				tHastaDto.setAd(hastaRandevuForm.getHastaAd());
				tHastaDto.setSoyad(hastaRandevuForm.getHastaSoyad());
				tHastaDto.setTel(hastaRandevuForm.getTelefon());
				tHastaDto.setSubeId(subeId);
				tHastaDto.setDurum("A");
				tHastaDto.setEklenmeTarihi(new Date());
				long lastProtokolNo = sqlUtils.getLastProtokolNo(conn, subeId);
				long protokolNo = lastProtokolNo + 1;
				tHastaDto.setProtokolNo(Long.toString(protokolNo));

//				Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.durum='A' "
//						+ " and p.subeId= :subeId and p.ad= :ad and p.soyad=:soyad and p.tel=:tel");
				Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.durum='A' "
						+ " and p.subeId= :subeId and p.ad= :ad and p.soyad=:soyad ");
				query.setString("ad", tHastaDto.getAd());
				query.setString("soyad", tHastaDto.getSoyad());
			//	query.setString("tel", tHastaDto.getTel());
				query.setInteger("subeId", tHastaDto.getSubeId());
				List<THastaDTO> result = query.list();

				int hasta_id = 0;
				if (result.size() != 0) {
					request.setAttribute("warn", GUIMessages.HASTA_VAR_RANDEVu);
					return mapping.findForward("failure");
				} else {
					hasta_id = (Integer) session.save(tHastaDto);
					hastaRandevuForm.setHastaId(hasta_id);

					// tedavi eklenir....

				//	addTedavi(hastaRandevuForm, session, tedavi, implantAktif, operasyonDurum, implantBaglayanDoktorId,	implantCerrahId, tedaviTarih, tedaviUcret, tedaviDisNo, tedaviAciklama, disAdet, hasta_id);

					// Commons.addHasta2HastaList(tHastaDto, request);
				}

			}
			
			
			if(hastaRandevuForm.getHastaId() != 0 && hastaRandevuForm.getIslemId() == 0){
			//	addTedavi(hastaRandevuForm, session, tedavi, implantAktif, operasyonDurum, implantBaglayanDoktorId,		implantCerrahId, tedaviTarih, tedaviUcret, tedaviDisNo, tedaviAciklama, disAdet, hastaRandevuForm.getHastaId());
				
			}
			
			
				if (hastaRandevuForm.getRandevuBosSaatAktif() != null
						&& hastaRandevuForm.getRandevuBosSaatAktif().equals("on")) {
					
				THastaDTO hasta = sqlUtils.getHasta(conn, "RESERVE",subeId);
				
				if(hasta!=null)
					 hastaRandevuForm.setHastaId(hasta.getId());
				 else{
					 THastaDTO tHastaReservDto = new THastaDTO();
					 tHastaReservDto.setAd("RESERVE");
					 tHastaReservDto.setSubeId(subeId);
					 tHastaReservDto.setDurum("A");
					 tHastaReservDto.setEklenmeTarihi(new Date());
						long lastProtokolNo = sqlUtils.getLastProtokolNo(conn, subeId);
						long protokolNo = lastProtokolNo + 1;
						tHastaReservDto.setProtokolNo(Long.toString(protokolNo));
					int	hasta_id_reserv = (Integer) session.save(tHastaReservDto);
					hastaRandevuForm.setHastaId(hasta_id_reserv);
				 }
					
					hastaRandevuForm.setAciklama("REZERVE");
				}

				Object[] kullaniciBilgileri = (Object[]) request.getSession().getAttribute("sessionMember");
				TKullaniciLoginDTO kullanici = (TKullaniciLoginDTO) kullaniciBilgileri[0];
				hastaRandevuForm.setEkleyenKisi(kullanici.getKuId());
				hastaRandevuForm.setEklenmeTarihi(new Date());
				hastaRandevuForm.setDurum("A");

				THastaRandevuDTO tHastaRandevu = new THastaRandevuDTO();
				BeanUtils.copyProperties(tHastaRandevu, hastaRandevuForm);
				session.save(tHastaRandevu);
				tran.commit();

				conn = DbConnection.getMySqlConneciton();

				request.setAttribute("warn", GenelDegiskenler.FormMessages.SUCCESS);
				TDoktorDTO doktorDTO = sqlUtils.getDoktor(-1, hastaRandevuForm.getDoktorId(), conn, true, subeId);

				request.setAttribute("selectedDoctor", doktorDTO);

				return mapping.findForward("success");
			
				
				
		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GUIMessages.ISLEM_BASARISIZ);
			return mapping.findForward("exception");
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}
	}

	private void addTedavi(HastaRandevuForm hastaRandevuForm, Session session, String tedavi, String implantAktif,
			String operasyonDurum, String implantBaglayanDoktorId, String implantCerrahId, String tedaviTarih,
			String tedaviUcret, String tedaviDisNo, String tedaviAciklama, String disAdet, int hasta_id)
			throws ParseException, HibernateException {
		TIslemDTO tIslemDto = new TIslemDTO();
		tIslemDto.setAciklama(tedaviAciklama);
		if (disAdet.equals(""))
			tIslemDto.setDisAdet(0);
		else {
			tIslemDto.setDisAdet(Integer.parseInt(disAdet));
		}
		tIslemDto.setDisNo(tedaviDisNo);
		tIslemDto.setDoktorId(hastaRandevuForm.getDoktorId());

		if (operasyonDurum == null)
			tIslemDto.setDurumu("A");
		else if (operasyonDurum.equals("on"))
			tIslemDto.setDurumu("K");

		tIslemDto.setEklenmeTarihi(new Date());
		tIslemDto.setIslemTarihiStr(tedaviTarih);

		if (tedaviTarih == null || tedaviTarih.equals(""))
			tIslemDto.setIslemTarihi(new Date());
		else {

			tIslemDto.setIslemTarihi(Commons.convertStringToDate(tedaviTarih));
		}

		tIslemDto.setIslemTipi(Integer.parseInt(tedavi));
		if (tedaviUcret.equals(""))
			tIslemDto.setMiktar(0);
		else
			tIslemDto.setMiktar(Double.parseDouble(tedaviUcret));

		tIslemDto.setHastaId(hasta_id);

		if (implantAktif == null) {

			Integer islemId = (Integer) session.save(tIslemDto);

			hastaRandevuForm.setIslemId(islemId);

			// operasyona ait ilk odeme bilgisi setleniyor...
			THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			hastaOdemeDTO.setIslemId(islemId.intValue());
			hastaOdemeDTO.setHastaId(tIslemDto.getHastaId());
			hastaOdemeDTO.setDoktorId(tIslemDto.getDoktorId());
			hastaOdemeDTO.setOdemeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setOdemeTuru(1); // 1 anlasilan fiyat
											// demektir.
			hastaOdemeDTO.setMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setKalanMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setEklenmeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setDurumu("A");
			hastaOdemeDTO.setAciklama("Toplam Ucret");

			Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);
		}

		// IMPLANT

		else {

			TIslemDTO implantAnaDTO = new TIslemDTO();

			implantAnaDTO.setAciklama(tedaviAciklama);
			implantAnaDTO.setHastaId(hasta_id);
			implantAnaDTO.setEklenmeTarihi(new Date());
			implantAnaDTO.setDisAdet(Integer.parseInt(disAdet));
			implantAnaDTO.setDisNo(tedaviDisNo);

			if (operasyonDurum == null)
				implantAnaDTO.setDurumu("A");
			else if (operasyonDurum.equals("on"))
				implantAnaDTO.setDurumu("K");

			if (tedaviTarih == null || tedaviTarih.equals(""))
				implantAnaDTO.setIslemTarihi(new Date());
			else {

				implantAnaDTO.setIslemTarihi(Commons.convertStringToDate(tedaviTarih));
			}

			implantAnaDTO.setDoktorId(GenelDegiskenler.DoktorTipleri.DOKTOR_IMPLANT);
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT);
			implantAnaDTO.setMiktar(Double.parseDouble(tedaviUcret));

			Integer islemAnaId = (Integer) session.save(implantAnaDTO);
			hastaRandevuForm.setIslemId(islemAnaId);

			// iliskili islem d

			TIslemDTO implantCerrahDTO = new TIslemDTO();

			implantCerrahDTO.setIliskiliIslemId(islemAnaId);

			implantCerrahDTO.setAciklama(tedaviAciklama);
			implantCerrahDTO.setHastaId(hasta_id);
			implantCerrahDTO.setEklenmeTarihi(new Date());
			implantCerrahDTO.setDisAdet(Integer.parseInt(disAdet));
			implantCerrahDTO.setDisNo(tedaviDisNo);

			if (operasyonDurum == null)
				implantCerrahDTO.setDurumu("A");
			else if (operasyonDurum.equals("on"))
				implantCerrahDTO.setDurumu("K");

			if (tedaviTarih == null || tedaviTarih.equals(""))
				implantCerrahDTO.setIslemTarihi(new Date());
			else {

				implantCerrahDTO.setIslemTarihi(Commons.convertStringToDate(tedaviTarih));
			}

			implantCerrahDTO.setDoktorId(Integer.parseInt(implantCerrahId));
			implantCerrahDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_CERRAH);
			implantCerrahDTO.setMiktar(0);

			Integer islemId = (Integer) session.save(implantCerrahDTO);
			// yardimci

			TIslemDTO implantBaglayanDTO = new TIslemDTO();
			implantBaglayanDTO.setIliskiliIslemId(islemId);

			implantBaglayanDTO.setAciklama(tedaviAciklama);
			implantBaglayanDTO.setHastaId(hasta_id);
			implantBaglayanDTO.setEklenmeTarihi(new Date());
			implantBaglayanDTO.setDisAdet(Integer.parseInt(disAdet));
			implantBaglayanDTO.setDisNo(tedaviDisNo);

			if (operasyonDurum == null)
				implantBaglayanDTO.setDurumu("A");
			else if (operasyonDurum.equals("on"))
				implantBaglayanDTO.setDurumu("K");

			if (tedaviTarih == null || tedaviTarih.equals(""))
				implantBaglayanDTO.setIslemTarihi(new Date());
			else {

				implantBaglayanDTO.setIslemTarihi(Commons.convertStringToDate(tedaviTarih));
			}
			implantBaglayanDTO.setDoktorId(Integer.parseInt(implantBaglayanDoktorId));
			implantBaglayanDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK);
			implantBaglayanDTO.setMiktar(0);
			Integer islemIdOperasyon = (Integer) session.save(implantBaglayanDTO);

			THastaOdemeDTO hastaOdemeAnaDTO = new THastaOdemeDTO();
			hastaOdemeAnaDTO.setIslemId(islemAnaId.intValue());
			hastaOdemeAnaDTO.setDoktorId(implantAnaDTO.getDoktorId());
			hastaOdemeAnaDTO.setMiktar(implantAnaDTO.getMiktar());
			hastaOdemeAnaDTO.setKalanMiktar(implantAnaDTO.getMiktar());
			hastaOdemeAnaDTO.setOdemeTuru(1);
			hastaOdemeAnaDTO.setDurumu("A");
			hastaOdemeAnaDTO.setAciklama("Toplam Ucret");
			hastaOdemeAnaDTO.setEklenmeTarihi(new Date());
			hastaOdemeAnaDTO.setOdemeTarihi(new Date());
			hastaOdemeAnaDTO.setHastaId(hasta_id);

			Integer hastaGelirAnaId = (Integer) session.save(hastaOdemeAnaDTO);

		}
	}

}
