package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;


public class TIslemDTO implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int hastaId;
	private Date islemTarihi;
	private String islemTarihiStr;
	private int islemTipi;
	private int doktorId;
	private double miktar;
	private double kalanMiktar;
	private double toplamOdenenMiktar;
	private String durumu;
	private String aciklama;
	private Date eklenmeTarihi;
	private String eklenmeTarihiStr;
	private Date islemBitisTarihi;
	private String islemBitisTarihiStr;
	private THastaDTO hasta;
	private TDoktorDTO doktor;
	
	private TIslemTipDTO islemTip;
	private Date guncellenmeTarihi;
	private int iliskiliIslemId;
	
	private int hastaAranmaSayisi;
	
//	private double implantUcret;
//	private double implantProtezUcret;
//	private int implantCerrahId;
	private int disAdet;
	private String disNo;
//  private TDoktorDTO implantDoktor;
	
	private List<THastaOdemeDTO> odemeList;
	private List<TAramaKaydiDTO> aramaKayitListesi;
	private List<String> odemeListStr;
	private List<String> odemeTarihListStr;
	private TDoktorDTO implantCerrahDoktor;
	private TDoktorDTO implantDestekDoktor;
	
	
	
	
	public List<String> getOdemeListStr() {
		if(odemeListStr==null) odemeListStr= new ArrayList<String>();
		return odemeListStr;
	}
	public void setOdemeListStr(List<String> odemeListStr) {
		
		this.odemeListStr = odemeListStr;
	}
	public List<String> getOdemeTarihListStr() {
		if(odemeTarihListStr==null) odemeTarihListStr= new ArrayList<String>();
		return odemeTarihListStr;
	}
	public void setOdemeTarihListStr(List<String> odemeTarihListStr) {
		this.odemeTarihListStr = odemeTarihListStr;
	}
	private List<TLabrotuvarDTO> labratuvarList;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHastaId() {
		return hastaId;
	}
	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}
	
	public double getKalanMiktar() {
		return kalanMiktar;
	}
	public void setKalanMiktar(double kalanMiktar) {
		this.kalanMiktar = kalanMiktar;
	}
	public String getDurumu() {
		return durumu;
	}
	public void setDurumu(String durumu) {
		this.durumu = durumu;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public Date getEklenmeTarihi() {
		return eklenmeTarihi;
	}
	public void setEklenmeTarihi(Date eklenmeTarihi) {
		this.eklenmeTarihi = eklenmeTarihi;
	}

	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public Date getIslemTarihi() {
		return islemTarihi;
	}
	public void setIslemTarihi(Date islemTarihi) {
		this.islemTarihi = islemTarihi;
	}
	public int getIslemTipi() {
		return islemTipi;
	}
	public void setIslemTipi(int islemTipi) {
		this.islemTipi = islemTipi;
	}
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public TDoktorDTO getDoktor() {
		return doktor;
	}
	public void setDoktor(TDoktorDTO doktor) {
		this.doktor = doktor;
	}
	public TIslemTipDTO getIslemTip() {
		return islemTip;
	}
	public void setIslemTip(TIslemTipDTO islemTip) {
		this.islemTip = islemTip;
	}

	public List<THastaOdemeDTO> getOdemeList() {
		return odemeList;
	}
	public void setOdemeList(List<THastaOdemeDTO> odemeList) {
		this.odemeList = odemeList;
	}
	public void setIslemBitisTarihi(Date islemBitisTarihi) {
		this.islemBitisTarihi = islemBitisTarihi;
	}
	public Date getIslemBitisTarihi() {
		return islemBitisTarihi;
	}
	public void setIslemTarihiStr(String islemTarihiStr) {
		this.islemTarihiStr = islemTarihiStr;
	}
	public String getIslemTarihiStr() {
		return islemTarihiStr;
	}
	public void setGuncellenmeTarihi(Date guncellenmeTarihi) {
		this.guncellenmeTarihi = guncellenmeTarihi;
	}
	public Date getGuncellenmeTarihi() {
		return guncellenmeTarihi;
	}
	public String getEklenmeTarihiStr() {
		return eklenmeTarihiStr;
	}
	public void setEklenmeTarihiStr(String eklenmeTarihiStr) {
		this.eklenmeTarihiStr = eklenmeTarihiStr;
	}
	public String getIslemBitisTarihiStr() {
		return islemBitisTarihiStr;
	}
	public void setIslemBitisTarihiStr(String islemBitisTarihiStr) {
		this.islemBitisTarihiStr = islemBitisTarihiStr;
	}
//	public double getImplantUcret() {
//		return implantUcret;
//	}
//	public void setImplantUcret(double implantUcret) {
//		this.implantUcret = implantUcret;
//	}
//	public double getImplantProtezUcret() {
//		return implantProtezUcret;
//	}
//	public void setImplantProtezUcret(double implantProtezUcret) {
//		this.implantProtezUcret = implantProtezUcret;
//	}
//	public int getImplantCerrahId() {
//		return implantCerrahId;
//	}
//	public void setImplantCerrahId(int implantCerrahId) {
//		this.implantCerrahId = implantCerrahId;
//	}
//	public int getImplantAdet() {
//		return implantAdet;
//	}
//	public void setImplantAdet(int implantAdet) {
//		this.implantAdet = implantAdet;
//	}
//	public void setImplantDoktor(TDoktorDTO implantDoktor) {
//		this.implantDoktor = implantDoktor;
//	}
//	public TDoktorDTO getImplantDoktor() {
//		return implantDoktor;
//	}
//	
	public void setIliskiliIslemId(int iliskiliIslemId) {
		this.iliskiliIslemId = iliskiliIslemId;
	}
	public int getIliskiliIslemId() {
		return iliskiliIslemId;
	}
	public void setDisAdet(int disAdet) {
		this.disAdet = disAdet;
	}
	public int getDisAdet() {
		return disAdet;
	}
	public List<TLabrotuvarDTO> getLabratuvarList() {
		return labratuvarList;
	}
	public void setLabratuvarList(List<TLabrotuvarDTO> labratuvarList) {
		this.labratuvarList = labratuvarList;
	}
	public int getHastaAranmaSayisi() {
		return hastaAranmaSayisi;
	}
	public void setHastaAranmaSayisi(int hastaAranmaSayisi) {
		this.hastaAranmaSayisi = hastaAranmaSayisi;
	}
	public double getToplamOdenenMiktar() {
		return toplamOdenenMiktar;
	}
	public void setToplamOdenenMiktar(double toplamOdenenMiktar) {
		this.toplamOdenenMiktar = toplamOdenenMiktar;
	}
	public TDoktorDTO getImplantCerrahDoktor() {
		return implantCerrahDoktor;
	}
	public void setImplantCerrahDoktor(TDoktorDTO implantCerrahDoktor) {
		this.implantCerrahDoktor = implantCerrahDoktor;
	}
	public TDoktorDTO getImplantDestekDoktor() {
		return implantDestekDoktor;
	}
	public void setImplantDestekDoktor(TDoktorDTO implantDestekDoktor) {
		this.implantDestekDoktor = implantDestekDoktor;
	}
	public String getDisNo() {
		return disNo;
	}
	public void setDisNo(String disNo) {
		this.disNo = disNo;
	}
	public List<TAramaKaydiDTO> getAramaKayitListesi() {
		return aramaKayitListesi;
	}
	public void setAramaKayitListesi(List<TAramaKaydiDTO> aramaKayitListesi) {
		this.aramaKayitListesi = aramaKayitListesi;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return islemTip.getAd();
	}
	
		
}
