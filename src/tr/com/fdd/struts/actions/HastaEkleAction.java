package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.HastaKartiForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaEkleAction extends GenericAction {

	private static int IMPLANT = 1;
	private static int IMPLANT_CERRAH = 2;
	private static int IMPLANT_DESTEK = 3;

	@Override
	protected ActionForward executeCode(Session session, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction tran) {

		// Transaction tran = null;

		try {
			SQLUtils sqlUtils = new SQLUtils();

			THastaDTO tHastaDto = new THastaDTO(); // hasta bilgieri
			TIslemDTO tIslemDto = new TIslemDTO(); // Operasyon Bilgileri
			THastaOdemeDTO tOdemeDto = new THastaOdemeDTO(); // Ucret Bilgileri

			HastaKartiForm hastaKartiForm = (HastaKartiForm) form;

			if (hastaKartiForm.getAd().equals("") || hastaKartiForm.getSoyad().equals("")
					|| hastaKartiForm.getTel().equals("")) {

				request.setAttribute("warn", GenelDegiskenler.FormMessages.SUCCESS);
				return mapping.findForward("success");
			}

			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			setFormInfoToDtos(hastaKartiForm, tHastaDto, tIslemDto, tOdemeDto, subeId);  // form bilgileridto lara eklenir.
			tran = session.beginTransaction();
			// hasta ekle
			Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.durum='A' "
					+ " and p.subeId= :subeId and  p.ad= :ad and p.soyad=:soyad ");
			query.setString("ad", tHastaDto.getAd());
			query.setString("soyad", tHastaDto.getSoyad());
			query.setInteger("subeId", subeId);
		//	query.setString("tel", hastaKartiForm.getTel());

			List<THastaDTO> result = query.list();

			int hasta_id = 0;
			if (result.size() != 0) {
				request.setAttribute("warn", GUIMessages.HASTA_VAR);
				return mapping.findForward("failure");
			} else {
				long lastPorotkolNo = sqlUtils.getLastProtokolNo(connection, subeId);

				tHastaDto.setProtokolNo(Long.toString(lastPorotkolNo + 1));
				hasta_id = (Integer) session.save(tHastaDto);
				tIslemDto.setHastaId(hasta_id);
				Commons.addHasta2HastaList(tHastaDto, request);
			}

			// operasyon ekle
			// if(hastaKartiForm.getImplantAktif()==null){

			if (hastaKartiForm.getIslemTarihiStr() != null && !hastaKartiForm.getIslemTarihiStr().equals("")
					&& hastaKartiForm.getDisNo() != null && !hastaKartiForm.getDisNo().equals("")
					&& hastaKartiForm.getOperasyonUcret() != 0 && hastaKartiForm.getDoktorId() != -1) {
				
				HastaOperasyonEkleAction action = new HastaOperasyonEkleAction();
				hastaKartiForm.setHastaId(hasta_id);
				action.executeCode(session, connection, mapping, hastaKartiForm, request, response, tran);

			}

			else {
				tran.commit();
				request.setAttribute("warn", GenelDegiskenler.FormMessages.SUCCESS);

			}
			
			Commons.refreshSelectedHasta(request, connection, hasta_id);
			
			return mapping.findForward("success");
			
			// Integer islemId = (Integer) session.save(tIslemDto);
			// // operasyona ait ilk odeme bilgisi setleniyor...
			// THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			// hastaOdemeDTO.setIslemId(islemId.intValue());
			// hastaOdemeDTO.setHastaId(tIslemDto.getHastaId());
			// hastaOdemeDTO.setDoktorId(tIslemDto.getDoktorId());
			// hastaOdemeDTO.setOdemeTarihi(tIslemDto.getEklenmeTarihi());
			// hastaOdemeDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			// hastaOdemeDTO.setMiktar(tIslemDto.getMiktar());
			// hastaOdemeDTO.setKalanMiktar(tIslemDto.getMiktar());
			// hastaOdemeDTO.setEklenmeTarihi(tIslemDto.getEklenmeTarihi());
			// hastaOdemeDTO.setDurumu("A");
			// hastaOdemeDTO.setAciklama("Toplam Ucret");
			//
			// Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);
			//
			// // secili odeme ekleniyor
			//
			//
			// THastaOdemeDTO tHastaOdemeDto = new THastaOdemeDTO();
			// tHastaOdemeDto.setAciklama(hastaKartiForm.getOdemeAciklama());
			// tHastaOdemeDto.setDoktorId(tIslemDto.getDoktorId());
			// tHastaOdemeDto.setIslemId(islemId);
			// tHastaOdemeDto.setHastaId(hasta_id);
			// tHastaOdemeDto.setDurumu("A");
			// tHastaOdemeDto.setOdemeTuru(2);
			// tHastaOdemeDto.setEklenmeTarihi(new Date());
			// tHastaOdemeDto.setKalanMiktar(hastaKartiForm.getKalanMiktar());
			// tHastaOdemeDto.setMiktar(hastaKartiForm.getOdemeMiktar());
			//
			// if (hastaKartiForm.getOdemeTarihiStr() == null)
			// tHastaOdemeDto.setOdemeTarihi(new Date());
			// else {
			// String tarihStr = hastaKartiForm.getOdemeTarihiStr();
			// tHastaOdemeDto.setOdemeTarihi(Commons.convertStringToDate(tarihStr));
			// }
			//
			// Integer hastaGelir= (Integer) session.save(tHastaOdemeDto);
			//
			// tran.commit();
			// }
			//
			// //Implant aktiff
			// else{
			// TIslemDTO implantAnaDto=new TIslemDTO();
			//
			// getImpantIslem(IMPLANT,hastaKartiForm,implantAnaDto,hasta_id);
			//
			// Integer islemAnaId = (Integer) session.save(implantAnaDto);
			//
			// TIslemDTO implantDTO= new TIslemDTO();
			// implantDTO.setIliskiliIslemId(islemAnaId);
			// getImpantIslem(IMPLANT_CERRAH,hastaKartiForm,implantDTO,hasta_id);
			//
			// Integer islemId = (Integer) session.save(implantDTO);
			//
			// TIslemDTO implantBaglayanDTO= new TIslemDTO();
			// implantBaglayanDTO.setIliskiliIslemId(islemId);
			//
			// getImpantIslem(IMPLANT_DESTEK,hastaKartiForm,implantBaglayanDTO,hasta_id);
			//
			// Integer islemIdOperasyon = (Integer)
			// session.save(implantBaglayanDTO);
			//
			// //implant operaasyonuna ait ilk odeme ekleniyor..
			//
			// THastaOdemeDTO hastaOdemeAnaDTO = new THastaOdemeDTO();
			// hastaOdemeAnaDTO.setIslemId(islemAnaId.intValue());
			// hastaOdemeAnaDTO.setDoktorId(implantAnaDto.getDoktorId());
			// hastaOdemeAnaDTO.setMiktar(implantAnaDto.getMiktar());
			// hastaOdemeAnaDTO.setKalanMiktar(implantAnaDto.getMiktar());
			// getIslemOdeme(hastaOdemeAnaDTO,hasta_id);
			//
			// Integer hastaGelirAnaId = (Integer)
			// session.save(hastaOdemeAnaDTO);
			//
			// // implanta ait sayfadan gelen odeme
			//
			// THastaOdemeDTO tHastaOdemeDtoForm = new THastaOdemeDTO();
			// tHastaOdemeDtoForm.setAciklama(hastaKartiForm.getOdemeAciklama());
			// tHastaOdemeDtoForm.setDoktorId(implantAnaDto.getDoktorId());
			// tHastaOdemeDtoForm.setIslemId(islemAnaId);
			// tHastaOdemeDtoForm.setHastaId(hasta_id);
			// tHastaOdemeDtoForm.setDurumu("A");
			// tHastaOdemeDtoForm.setEklenmeTarihi(new Date());
			// tHastaOdemeDtoForm.setKalanMiktar(hastaKartiForm.getKalanMiktar());
			// tHastaOdemeDtoForm.setMiktar(hastaKartiForm.getOdemeMiktar());
			//
			// if (hastaKartiForm.getOdemeTarihiStr() == null)
			// tHastaOdemeDtoForm.setOdemeTarihi(new Date());
			// else {
			// String tarihStr = hastaKartiForm.getOdemeTarihiStr();
			// tHastaOdemeDtoForm.setOdemeTarihi(Commons.convertStringToDate(tarihStr));
			// }
			//
			// Integer hastaGelir= (Integer) session.save(tHastaOdemeDtoForm);
			//
			//
			// THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			// hastaOdemeDTO.setIslemId(islemId.intValue());
			// hastaOdemeDTO.setDoktorId(implantDTO.getDoktorId());
			// hastaOdemeDTO.setMiktar(implantDTO.getMiktar());
			// hastaOdemeDTO.setKalanMiktar(implantDTO.getMiktar());
			// getIslemOdeme(hastaOdemeDTO,hasta_id);
			//
			// Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);
			//
			// THastaOdemeDTO hastaOdemeBaglayanDTO = new THastaOdemeDTO();
			// hastaOdemeBaglayanDTO.setIslemId(islemIdOperasyon);
			// hastaOdemeBaglayanDTO.setDoktorId(implantBaglayanDTO.getDoktorId());
			// hastaOdemeBaglayanDTO.setMiktar(implantBaglayanDTO.getMiktar());
			// hastaOdemeBaglayanDTO.setKalanMiktar(implantBaglayanDTO.getMiktar());
			// getIslemOdeme(hastaOdemeBaglayanDTO,hasta_id);
			// Integer hastaGelirImplantBaglayanId = (Integer)
			// session.save(hastaOdemeBaglayanDTO );
			// tran.commit();
			// }

			

		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GenelDegiskenler.FormMessages.ERROR);
			return mapping.findForward("exception");

		} finally {
			if (session != null && session.isOpen())
				try {

					session.close();
					MysqlUtil.instance.closeConnection(connection);
				} catch (HibernateException e) {

					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				}

			;
		}
	}

	private void getIslemOdeme(THastaOdemeDTO hastaOdemeAnaDTO, int hasta_id) {
		hastaOdemeAnaDTO.setOdemeTuru(1);
		hastaOdemeAnaDTO.setDurumu("A");
		hastaOdemeAnaDTO.setAciklama("Toplam Ucret");
		hastaOdemeAnaDTO.setEklenmeTarihi(new Date());
		hastaOdemeAnaDTO.setOdemeTarihi(new Date());
		hastaOdemeAnaDTO.setHastaId(hasta_id);

	}

	private void getImpantIslem(int operasyonImplantType, HastaKartiForm hastaKartiForm, TIslemDTO implantAnaDTO,
			int hasta_id) throws ParseException {
		implantAnaDTO.setAciklama(hastaKartiForm.getOperasyonAciklama());

		if (operasyonImplantType == IMPLANT) {
			implantAnaDTO.setDoktorId(GenelDegiskenler.DoktorTipleri.DOKTOR_IMPLANT);
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT);
			implantAnaDTO.setMiktar(hastaKartiForm.getOperasyonUcret());
		} else if (operasyonImplantType == IMPLANT_CERRAH) {
			implantAnaDTO.setDoktorId(hastaKartiForm.getImplantCerrahId());
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_CERRAH);
			implantAnaDTO.setMiktar(0);
		} else if (operasyonImplantType == IMPLANT_DESTEK) {
			implantAnaDTO.setDoktorId(hastaKartiForm.getImplantBaglayanDoktorId());
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK);
			implantAnaDTO.setMiktar(0);
		}
		// implantDTO.setMiktar(impCerrahBirimFiyat);

		if (hastaKartiForm.getOperasyonDurum() == null)
			hastaKartiForm.setOperasyonDurum("A");
		else if (hastaKartiForm.getOperasyonDurum().equals("on"))
			hastaKartiForm.setOperasyonDurum("K");

		implantAnaDTO.setDurumu(hastaKartiForm.getOperasyonDurum());

		if (hastaKartiForm.getIslemTarihiStr() == null)
			implantAnaDTO.setIslemTarihi(new Date());
		else {
			String tarihStr = hastaKartiForm.getIslemTarihiStr();

			implantAnaDTO.setIslemTarihi(Commons.convertStringToDate(tarihStr));
		}

		implantAnaDTO.setHastaId(hasta_id);
		implantAnaDTO.setEklenmeTarihi(new Date());
		implantAnaDTO.setDisAdet(hastaKartiForm.getDisAdet());

	}

	private void setFormInfoToDtos(HastaKartiForm hastaKartiForm, THastaDTO tHastaDto, TIslemDTO tIslemDto,
			THastaOdemeDTO tOdemeDto, Integer subeId) throws ParseException {

		tHastaDto.setAd(hastaKartiForm.getAd());
		tHastaDto.setSoyad(hastaKartiForm.getSoyad());
		tHastaDto.setTckimlik(hastaKartiForm.getTckimlik());
		tHastaDto.setTel(hastaKartiForm.getTel());
		tHastaDto.setDurum("A");
		tHastaDto.setEklenmeTarihi(new Date());
		tHastaDto.setSubeId(subeId);

		// operasyon setleme islemi

		if (hastaKartiForm.getOperasyonDurum() == null)
			hastaKartiForm.setOperasyonDurum("A");
		else if (hastaKartiForm.getOperasyonDurum().equals("on"))
			hastaKartiForm.setOperasyonDurum("K");

		tIslemDto.setAciklama(hastaKartiForm.getOperasyonAciklama());
		tIslemDto.setDisAdet(hastaKartiForm.getDisAdet());
		tIslemDto.setDoktorId(hastaKartiForm.getDoktorId());
		tIslemDto.setDurumu(hastaKartiForm.getOperasyonDurum());
		tIslemDto.setEklenmeTarihi(new Date());
		tIslemDto.setIslemTarihiStr(hastaKartiForm.getIslemTarihiStr());

		if (hastaKartiForm.getIslemTarihiStr() == null || hastaKartiForm.getIslemTarihiStr().equals(""))
			tIslemDto.setIslemTarihi(new Date());
		else {
			String tarihStr = hastaKartiForm.getIslemTarihiStr();

			tIslemDto.setIslemTarihi(Commons.convertStringToDate(tarihStr));
		}
		tIslemDto.setIslemTipi(hastaKartiForm.getIslemTipi());
		tIslemDto.setMiktar(hastaKartiForm.getOperasyonUcret());
		// ucret setleme

	}
}
