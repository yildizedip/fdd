package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


public class TIslemSafahatDTO implements Serializable {

	
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
	private String durumu;
	private String aciklama;
	private Date eklenmeTarihi;
	private Date islemBitisTarihi;
	private THastaDTO hasta;
	private TDoktorDTO doktor;
	private TIslemTipDTO islemTip;
	private Date guncellenmeTarihi;
	
	private List<THastaOdemeDTO> odemeList;
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
	

	
	
	

	
}
