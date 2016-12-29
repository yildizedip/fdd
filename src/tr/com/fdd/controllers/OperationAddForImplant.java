package tr.com.fdd.controllers;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.actions.GenericAction;
import tr.com.fdd.struts.actions.SQLUtils;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GenelDegiskenler;

/**
 * implant icin operasyon eklendiginde
 * ayrica implant adetine gore ikinci operasyon eklenir. 
 * @author Administrator
 *
 */
public class OperationAddForImplant implements IOperationAddController {

	@Override
	public String addOperation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		
		Transaction tran = null;
		Session session = null;
		
		SQLUtils utils=new SQLUtils();
	    Connection conn=	SQLUtils.getMySqlConneciton();
		
		try {
			
			IslemForm islemForm = generateForm(form);		
					
			// implant adetini al..adeti gunluk implant birim fiyati ile carp...
			
			int impAdet=islemForm.getDisAdet();	
			
		    
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();			
			
			// implant doktoru icin ..ana kisim
			int implantDoktorAnaID=GenelDegiskenler.DoktorTipleri.DOKTOR_IMPLANT;
			
			
			// yardimci kismi
			Double impBirimFiyat=utils.getImplantDestekBirimFiyat(conn);	
			impBirimFiyat=impBirimFiyat*islemForm.getDisAdet();
			
			// cerrah kismi
			Double impCerrahBirimFiyat=utils.getImplantCerrahBirimFiyat(conn);	
			impCerrahBirimFiyat=impCerrahBirimFiyat*islemForm.getDisAdet();
			
			
			// implant ana operasyonunu olustur..VT YE EKLE
			
			TIslemDTO implantAnaDTO= new TIslemDTO();	
			implantAnaDTO.setAciklama(islemForm.getAciklama());
			implantAnaDTO.setDoktorId(implantDoktorAnaID);
			//implantDTO.setMiktar(impCerrahBirimFiyat);
			implantAnaDTO.setMiktar(islemForm.getMiktar());
			implantAnaDTO.setDurumu(islemForm.getDurumu());
			implantAnaDTO.setIslemTarihi(islemForm.getIslemTarihiImpl());
			implantAnaDTO.setHastaId(islemForm.getHastaId());
			implantAnaDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT);
			implantAnaDTO.setEklenmeTarihi(islemForm.getEklenmeTarihi());
			implantAnaDTO.setDurumu(islemForm.getDurumu());
			implantAnaDTO.setDisAdet(islemForm.getDisAdet());
			
			
			Integer islemAnaId = (Integer) session.save(implantAnaDTO);
			
			
			
			// implant operasyonunu olustur.. vt ye ekle
			
			TIslemDTO implantDTO= new TIslemDTO();	
			implantDTO.setAciklama(islemForm.getAciklama());
			implantDTO.setDoktorId(islemForm.getImplantCerrahId());
			//implantDTO.setMiktar(impCerrahBirimFiyat);
			implantDTO.setMiktar(0);
			implantDTO.setDurumu(islemForm.getDurumu());
			implantDTO.setIslemTarihi(islemForm.getIslemTarihiImpl());
			implantDTO.setHastaId(islemForm.getHastaId());
			implantDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_CERRAH);
			implantDTO.setEklenmeTarihi(islemForm.getEklenmeTarihi());
			implantDTO.setDurumu(islemForm.getDurumu());
			implantDTO.setDisAdet(islemForm.getDisAdet());
			implantDTO.setIliskiliIslemId(islemAnaId);
			
			Integer islemId = (Integer) session.save(implantDTO);
			
			
			
			
			// implant baglayan operasyonunu olustur..vt ye ekle
			TIslemDTO implantBaglayanDTO= new TIslemDTO();	
			implantBaglayanDTO.setAciklama(islemForm.getAciklama());
			implantBaglayanDTO.setDoktorId(islemForm.getImplantBaglayanDoktorId()); // degisen bolum
			//implantBaglayanDTO.setMiktar(impBirimFiyat); // degisen bolum
			implantBaglayanDTO.setMiktar(0);
			implantBaglayanDTO.setDurumu(islemForm.getDurumu());
			implantBaglayanDTO.setIslemTarihi(islemForm.getIslemTarihiImpl());
			implantBaglayanDTO.setHastaId(islemForm.getHastaId());
			implantBaglayanDTO.setIslemTipi(GenelDegiskenler.OperasyonTipleri.IMPLANT_DESTEK); // degisen bolum
			implantBaglayanDTO.setEklenmeTarihi(islemForm.getEklenmeTarihi());
			implantBaglayanDTO.setDurumu(islemForm.getDurumu());
			implantBaglayanDTO.setDisAdet(islemForm.getDisAdet());
			implantBaglayanDTO.setIliskiliIslemId(islemId);
			Integer islemIdOperasyon = (Integer) session.save(implantBaglayanDTO);
			
		
		//--- ODEME EKE BASLA----
		
			// implant ana operasyon odeme ekle
			THastaOdemeDTO hastaOdemeAnaDTO = new THastaOdemeDTO();
			hastaOdemeAnaDTO.setIslemId(islemAnaId.intValue());
			hastaOdemeAnaDTO.setHastaId(implantDTO.getHastaId());
			hastaOdemeAnaDTO.setDoktorId(implantDoktorAnaID);
			hastaOdemeAnaDTO.setOdemeTarihi(implantDTO.getEklenmeTarihi());
			hastaOdemeAnaDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			hastaOdemeAnaDTO.setMiktar(implantDTO.getMiktar());
			hastaOdemeAnaDTO.setKalanMiktar(implantDTO.getMiktar());
			hastaOdemeAnaDTO.setEklenmeTarihi(implantDTO.getEklenmeTarihi());
			hastaOdemeAnaDTO.setDurumu("A");
			hastaOdemeAnaDTO.setAciklama("Toplam Ücret");
			Integer hastaGelirAnaId = (Integer) session.save(hastaOdemeAnaDTO);
			
			
			// implant operasyon odeme ekle
			THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			hastaOdemeDTO.setIslemId(islemId.intValue());
			hastaOdemeDTO.setHastaId(implantDTO.getHastaId());
			hastaOdemeDTO.setDoktorId(implantDTO.getDoktorId());
			hastaOdemeDTO.setOdemeTarihi(implantDTO.getEklenmeTarihi());
			hastaOdemeDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			hastaOdemeDTO.setMiktar(implantDTO.getMiktar());
			hastaOdemeDTO.setKalanMiktar(implantDTO.getMiktar());
			hastaOdemeDTO.setEklenmeTarihi(implantDTO.getEklenmeTarihi());
			hastaOdemeDTO.setDurumu("A");
			hastaOdemeDTO.setAciklama("Toplam Ücret");
			Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);			
			
			
			
			
			//  implant baglayan odeme ekle
			THastaOdemeDTO hastaOdemeBaglayanDTO = new THastaOdemeDTO();
			hastaOdemeBaglayanDTO.setIslemId(islemIdOperasyon);
			hastaOdemeBaglayanDTO.setHastaId(implantBaglayanDTO.getHastaId());
			hastaOdemeBaglayanDTO.setDoktorId(implantBaglayanDTO.getDoktorId());
			hastaOdemeBaglayanDTO.setOdemeTarihi(implantBaglayanDTO.getEklenmeTarihi());
			hastaOdemeBaglayanDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			hastaOdemeBaglayanDTO.setMiktar(implantBaglayanDTO.getMiktar());
			hastaOdemeBaglayanDTO.setKalanMiktar(implantBaglayanDTO.getMiktar());
			hastaOdemeBaglayanDTO.setEklenmeTarihi(implantBaglayanDTO.getEklenmeTarihi());
			hastaOdemeBaglayanDTO.setDurumu("A");
			hastaOdemeBaglayanDTO.setAciklama("Toplam Ücret");
			Integer hastaGelirImplantBaglayanId = (Integer) session.save(hastaOdemeBaglayanDTO );
			
			tran.commit();
			
			
			
			// sayfaya gidecek attribute leri setle
			
			conn=SQLUtils.getMySqlConneciton(); // yenilemeyince commit yemiyor..
			
			
			SQLUtils sqlUtils = new SQLUtils();
			List<TIslemDTO> hastaOperasyonListesi = sqlUtils.getHastaOperasyonListesi(implantDTO.getHastaId(), 0, conn);

			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			THastaDTO hasta = sqlUtils.getHasta(implantDTO.getHastaId(), conn,subeId.intValue());
			request.setAttribute("hasta", hasta);
			request.setAttribute("hastaOperasyonListesi", hastaOperasyonListesi);
			
			// return
			
			request.setAttribute("iliskiliIslemId", islemId);
			
		//	request.setAttribute("operasyonDoktorId", islemForm.getDoktorId() );
			request.setAttribute("operasyonEklemeTarihi",islemForm.getIslemTarihiStr() );
			
			
			return GenelDegiskenler.ReturnTypes.GO_TO_IMPLANT_USTU_PROTEZ_PAGE;
			
			
		} catch (Exception e) {		
			
			try {
				conn.rollback();
				conn.close();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
			
			e.printStackTrace();			
		}
		finally{

			try {
				if (tran != null)
					tran.rollback();
				if (session != null && session.isOpen())
					session.close();
				
				MysqlUtil.instance.closeConnection(conn);
			} catch (HibernateException e1) {

				e1.printStackTrace();
			}
			catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return GenelDegiskenler.ReturnTypes.FAILURE;
	

	}
	
	private IslemForm generateForm(ActionForm form) throws ParseException {
		IslemForm islemForm = (IslemForm) form;
		if (islemForm.getDurumu() == null)
			islemForm.setDurumu("A");
		else if (islemForm.getDurumu().equals("on"))
			islemForm.setDurumu("K");

		islemForm.setEklenmeTarihi(new Date());
		if (islemForm.getIslemTarihiStr() == null)
			islemForm.setIslemTarihi(new Date());
		else {
			String tarihStr = islemForm.getIslemTarihiStr();
			
			islemForm.setIslemTarihi(Commons.convertStringToDate(tarihStr));
		}
		
		if (islemForm.getIslemTarihiImplStr() == null)
			islemForm.setIslemTarihiImpl(new Date());
		else {
			String tarihStr = islemForm.getIslemTarihiImplStr();
		
			islemForm.setIslemTarihiImpl(Commons.convertStringToDate(tarihStr));
		}
		
		return islemForm;
	}

}
