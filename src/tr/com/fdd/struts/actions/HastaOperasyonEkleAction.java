package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.struts.form.HastaKartiForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaOperasyonEkleAction extends GenericAction {
	
	private static int IMPLANT=1;
	private static int IMPLANT_CERRAH=2;
	private static int IMPLANT_DESTEK=3;

	@Override
	public ActionForward executeCode(Session session, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction tran)  {
		//Transaction tran = null;
		
		try {
		
		HastaKartiForm hastaKartiForm= (HastaKartiForm) form;
		TIslemDTO tIslemDto= new TIslemDTO();
		
		if (hastaKartiForm.getOperasyonDurum() == null)
			hastaKartiForm.setOperasyonDurum("A");
		else if (hastaKartiForm.getOperasyonDurum().equals("on"))
			hastaKartiForm.setOperasyonDurum("K");
		
		
		tIslemDto.setAciklama(hastaKartiForm.getOperasyonAciklama());
		tIslemDto.setDisAdet(hastaKartiForm.getDisAdet());
		tIslemDto.setDisNo(hastaKartiForm.getDisNo());
		tIslemDto.setDoktorId(hastaKartiForm.getDoktorId());
		tIslemDto.setDurumu(hastaKartiForm.getOperasyonDurum());
		tIslemDto.setEklenmeTarihi(new Date());
		tIslemDto.setIslemTarihiStr(hastaKartiForm.getIslemTarihiStr());

		if (hastaKartiForm.getIslemTarihiStr() == null || hastaKartiForm.getIslemTarihiStr().equals("") )
			tIslemDto.setIslemTarihi(new Date());
		else {
			String tarihStr = hastaKartiForm.getIslemTarihiStr();
			
			tIslemDto.setIslemTarihi(Commons.convertStringToDate(tarihStr));
		}
		tIslemDto.setIslemTipi(hastaKartiForm.getIslemTipi());
		tIslemDto.setMiktar(hastaKartiForm.getOperasyonUcret());
		tIslemDto.setHastaId(hastaKartiForm.getHastaId());
		
		if(tran==null) // var olan transaction varsa yeniden baslatmaya gerek yok..
		tran = session.beginTransaction();
		
		
		// normal operasyon
		if(hastaKartiForm.getImplantAktif()==null){
			
			Integer islemId = (Integer) session.save(tIslemDto);
			// operasyona ait ilk odeme bilgisi setleniyor...
			THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			hastaOdemeDTO.setIslemId(islemId.intValue());
			hastaOdemeDTO.setHastaId(tIslemDto.getHastaId());
			hastaOdemeDTO.setDoktorId(tIslemDto.getDoktorId());
			hastaOdemeDTO.setOdemeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			hastaOdemeDTO.setMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setKalanMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setEklenmeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setDurumu("A");
			hastaOdemeDTO.setAciklama("Toplam Ucret");

			Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);
			
			// secili odeme ekleniyor
			if(hastaKartiForm.getOdemeMiktar()!=0 && hastaKartiForm.getOdemeTarihiStr() != null && !hastaKartiForm.getOdemeTarihiStr().equals(""))
			{
				THastaOdemeDTO tHastaOdemeDto = new THastaOdemeDTO();
				tHastaOdemeDto.setAciklama(hastaKartiForm.getOdemeAciklama());
				tHastaOdemeDto.setDoktorId(tIslemDto.getDoktorId());
				tHastaOdemeDto.setIslemId(islemId);
				tHastaOdemeDto.setHastaId(hastaKartiForm.getHastaId());
				tHastaOdemeDto.setDurumu("A");
				tHastaOdemeDto.setOdemeTuru(2);
				tHastaOdemeDto.setEklenmeTarihi(new Date());
				tHastaOdemeDto.setKalanMiktar(hastaKartiForm.getKalanMiktar());
				tHastaOdemeDto.setMiktar(hastaKartiForm.getOdemeMiktar());
				
				if (hastaKartiForm.getOdemeTarihiStr() == null || hastaKartiForm.getOdemeTarihiStr().equals("")) 
					tHastaOdemeDto.setOdemeTarihi(new Date());
				else {
					String tarihStr = hastaKartiForm.getOdemeTarihiStr();
					tHastaOdemeDto.setOdemeTarihi(Commons.convertStringToDate(tarihStr));
				}
				
				Integer hastaGelir= (Integer) session.save(tHastaOdemeDto);
			}
			
			tran.commit();
			
			Commons.refreshSelectedHasta(request, connection, hastaKartiForm.getHastaId());
			
			
		}
		
		//Implant aktiff
		else{
			TIslemDTO implantAnaDto=new TIslemDTO();
			
			getImpantIslem(IMPLANT,hastaKartiForm,implantAnaDto,hastaKartiForm.getHastaId());
			
			Integer islemAnaId = (Integer) session.save(implantAnaDto);
			
			TIslemDTO implantDTO= new TIslemDTO();	
			implantDTO.setIliskiliIslemId(islemAnaId);
			getImpantIslem(IMPLANT_CERRAH,hastaKartiForm,implantDTO,hastaKartiForm.getHastaId());
			
			Integer islemId = (Integer) session.save(implantDTO);
			
			TIslemDTO implantBaglayanDTO= new TIslemDTO();
			implantBaglayanDTO.setIliskiliIslemId(islemId);
			
			getImpantIslem(IMPLANT_DESTEK,hastaKartiForm,implantBaglayanDTO,hastaKartiForm.getHastaId());
			
			Integer islemIdOperasyon = (Integer) session.save(implantBaglayanDTO);
			
			//implant operaasyonuna ait ilk odeme ekleniyor..
			
			THastaOdemeDTO hastaOdemeAnaDTO = new THastaOdemeDTO();
			hastaOdemeAnaDTO.setIslemId(islemAnaId.intValue());
			hastaOdemeAnaDTO.setDoktorId(implantAnaDto.getDoktorId());
			hastaOdemeAnaDTO.setMiktar(implantAnaDto.getMiktar());
			hastaOdemeAnaDTO.setKalanMiktar(implantAnaDto.getMiktar());
			getIslemOdeme(hastaOdemeAnaDTO,hastaKartiForm.getHastaId());
			
			Integer hastaGelirAnaId = (Integer) session.save(hastaOdemeAnaDTO);
			
			// implanta ait sayfadan gelen odeme 
			
			if(hastaKartiForm.getOdemeMiktar()!=0 && hastaKartiForm.getOdemeTarihiStr() != null && !hastaKartiForm.getOdemeTarihiStr().equals(""))
			{
			
				THastaOdemeDTO tHastaOdemeDtoForm = new THastaOdemeDTO();
				tHastaOdemeDtoForm.setAciklama(hastaKartiForm.getOdemeAciklama());
				tHastaOdemeDtoForm.setDoktorId(implantAnaDto.getDoktorId());
				tHastaOdemeDtoForm.setIslemId(islemAnaId);
				tHastaOdemeDtoForm.setHastaId(hastaKartiForm.getHastaId());
				tHastaOdemeDtoForm.setDurumu("A");
				tHastaOdemeDtoForm.setEklenmeTarihi(new Date());
				tHastaOdemeDtoForm.setKalanMiktar(hastaKartiForm.getKalanMiktar());
				tHastaOdemeDtoForm.setMiktar(hastaKartiForm.getOdemeMiktar());
				
				if (hastaKartiForm.getOdemeTarihiStr() == null)
					tHastaOdemeDtoForm.setOdemeTarihi(new Date());
				else {
					String tarihStr = hastaKartiForm.getOdemeTarihiStr();
					tHastaOdemeDtoForm.setOdemeTarihi(Commons.convertStringToDate(tarihStr));
				}
				
				Integer hastaGelir= (Integer) session.save(tHastaOdemeDtoForm);
			
			}
			
			tran.commit();
			
			THastaDTO hastaDTO=Commons.getActiveHasta(request);
			hastaDTO.getHastaOperasyonList().add(implantAnaDto);
		}
		
		request.setAttribute("warn", GUIMessages.ISLEM_BASARILI);
		
		return mapping.findForward("success");
		
		} catch (Exception e) {

			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			try {
				connection.rollback();
				connection.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("warn", GUIMessages.HATA);
			return mapping.findForward("exception");
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

	// @Override
	// public ActionForward execute(Session session, Connection connection,
	// ActionMapping mapping, ActionForm form,
	// HttpServletRequest request, HttpServletResponse response)
	// {
	//
	// OperationAdder adder= new OperationAdder(mapping, form, request,
	// response);
	//
	// if(((IslemForm)form).getIslemTipi()==GenelDegiskenler.OperasyonTipleri.IMPLANT)
	// {
	// adder.setController(new OperationAddForImplant());
	// return mapping.findForward(adder.addOperation());
	// }
	// else
	// adder.setController(new OperationAddGeneral());
	// return mapping.findForward(adder.addOperation());
	//
	//
	// }
	
	private void getIslemOdeme(THastaOdemeDTO hastaOdemeAnaDTO, int hasta_id) {
		hastaOdemeAnaDTO.setOdemeTuru(1); 
		hastaOdemeAnaDTO.setDurumu("A");
		hastaOdemeAnaDTO.setAciklama("Toplam Ucret");
		hastaOdemeAnaDTO.setEklenmeTarihi(new Date());
		hastaOdemeAnaDTO.setOdemeTarihi(new Date());
		hastaOdemeAnaDTO.setHastaId(hasta_id);
		
	}

	private void getImpantIslem(int operasyonImplantType, HastaKartiForm hastaKartiForm, TIslemDTO implantAnaDTO, int hasta_id) throws ParseException {
		implantAnaDTO.setAciklama(hastaKartiForm.getOperasyonAciklama());
		
		
		if(operasyonImplantType==IMPLANT){
		 implantAnaDTO.setDoktorId(GenelDegiskenler.DoktorTipleri.DOKTOR_IMPLANT);
		 implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT);
		 implantAnaDTO.setMiktar(hastaKartiForm.getOperasyonUcret());
		}
		else if(operasyonImplantType==IMPLANT_CERRAH)
		{
			implantAnaDTO.setDoktorId(hastaKartiForm.getImplantCerrahId());
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_CERRAH);
			implantAnaDTO.setMiktar(0);
		}
		else if(operasyonImplantType==IMPLANT_DESTEK)
		{
			implantAnaDTO.setDoktorId(hastaKartiForm.getImplantBaglayanDoktorId());
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK);
			implantAnaDTO.setMiktar(0);
		}
		//implantDTO.setMiktar(impCerrahBirimFiyat);
		
		
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

}
