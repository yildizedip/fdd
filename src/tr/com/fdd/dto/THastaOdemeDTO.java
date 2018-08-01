package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;


public class THastaOdemeDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int hastaId;
	private Date odemeTarihi;
	private String odemeTarihiStr;
	private int odemeTuru;
	private double ucret;
	private double miktar;
	private double kalanMiktar;
	private String durumu;
	private String aciklama;
	private int islemId;
	private int doktorId;
	private Date eklenmeTarihi;
	private String eklenmeTarihiStr;
	private Date guncellenmeTarihi;
	private String guncellenmeTarihiStr;
	private THastaDTO hasta;
	private TDoktorDTO doktor;
	private TIslemDTO islem;
	private TIslemTipDTO islemTip;
	
	private double doktorHesap;
	private double sirketHesap;
	
	private Integer guncelleyenKisi;
	private Integer silen;
	private String silinmeTarihiStr;
	
	
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
	public Date getOdemeTarihi() {
		return odemeTarihi;
	}
	public void setOdemeTarihi(Date odemeTarihi) {
		this.odemeTarihi = odemeTarihi;
	}
	public int getOdemeTuru() {
		return odemeTuru;
	}
	public void setOdemeTuru(int odemeTuru) {
		this.odemeTuru = odemeTuru;
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
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public int getIslemId() {
		return islemId;
	}
	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	public void setOdemeTarihiStr(String odemeTarihiStr) {
		this.odemeTarihiStr = odemeTarihiStr;
	}
	public String getOdemeTarihiStr() {
		return odemeTarihiStr;
	}
	public void setGuncellenmeTarihi(Date guncellenmeTarihi) {
		this.guncellenmeTarihi = guncellenmeTarihi;
	}
	public Date getGuncellenmeTarihi() {
		return guncellenmeTarihi;
	}
	public TDoktorDTO getDoktor() {
		return doktor;
	}
	public void setDoktor(TDoktorDTO doktor) {
		this.doktor = doktor;
	}
	public TIslemDTO getIslem() {
		return islem;
	}
	public void setIslem(TIslemDTO islem) {
		this.islem = islem;
	}
	public void setIslemTip(TIslemTipDTO islemTip) {
		this.islemTip = islemTip;
	}
	public TIslemTipDTO getIslemTip() {
		return islemTip;
	}
	public void setUcret(double ucret) {
		this.ucret = ucret;
	}
	public double getUcret() {
		return ucret;
	}
	public void setEklenmeTarihiStr(String eklenmeTarihiStr) {
		this.eklenmeTarihiStr = eklenmeTarihiStr;
	}
	public String getEklenmeTarihiStr() {
		return eklenmeTarihiStr;
	}
	public double getDoktorHesap() {
		return doktorHesap;
	}
	public void setDoktorHesap(double doktorHesap) {
		this.doktorHesap = doktorHesap;
	}
	public double getSirketHesap() {
		return sirketHesap;
	}
	public void setSirketHesap(double sirketHesap) {
		this.sirketHesap = sirketHesap;
	}
	public String getGuncellenmeTarihiStr() {
		return guncellenmeTarihiStr;
	}
	public void setGuncellenmeTarihiStr(String guncellenmeTarihiStr) {
		this.guncellenmeTarihiStr = guncellenmeTarihiStr;
	}
	
	
	public String getSilinmeTarihiStr() {
		return silinmeTarihiStr;
	}
	public void setSilinmeTarihiStr(String silinmeTarihiStr) {
		this.silinmeTarihiStr = silinmeTarihiStr;
	}
	public Integer getSilen() {
		return silen;
	}
	public void setSilen(Integer silen) {
		this.silen = silen;
	}
	public Integer getGuncelleyenKisi() {
		return guncelleyenKisi;
	}
	public void setGuncelleyenKisi(Integer guncelleyenKisi) {
		this.guncelleyenKisi = guncelleyenKisi;
	}
	
	
	
}
