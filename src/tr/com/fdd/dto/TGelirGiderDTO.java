package tr.com.fdd.dto;

import java.io.Serializable;

import java.util.Date;

public class TGelirGiderDTO implements Serializable {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int tip;
	private double miktar;
	private String aciklama;
	private Date tarih;
	private String tarihStr;
	private int girenKisi;
	private int doktor;
	private String turAd ;
	
	private String gKisiAd;
	private String gKisiSoyAd;
	private String dAd;
	private String dSoyAd;
	private String giderTuru;
	private int odemeSekli;
	private String odemeSekliStr;
	private String paraBirimi;
	private double gelirMiktar;
	private double giderMiktar;
	private double fark;	
	private String durum;
	private int subeId;
	private THastaDTO hasta;
	private TTurKodDTO turKodDTO;
	
	public int getTip() {
		return tip;
	}
	public void setTip(int tip) {
		this.tip = tip;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public Date getTarih() {
		return tarih;
	}
	public void setTarih(Date tarih) {
		this.tarih = tarih;
	}


	public int getDoktor() {
		return doktor;
	}
	public void setDoktor(int doktor) {
		this.doktor = doktor;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGirenKisi() {
		return girenKisi;
	}
	public void setGirenKisi(int girenKisi) {
		this.girenKisi = girenKisi;
	}
	
	public String getTurAd() {
		return turAd;
	}
	public void setTurAd(String turAd) {
		this.turAd = turAd;
	}
	public String getgKisiAd() {
		return gKisiAd;
	}
	public void setgKisiAd(String gKisiAd) {
		this.gKisiAd = gKisiAd;
	}
	public String getgKisiSoyAd() {
		return gKisiSoyAd;
	}
	public void setgKisiSoyAd(String gKisiSoyAd) {
		this.gKisiSoyAd = gKisiSoyAd;
	}
	public String getdAd() {
		return dAd;
	}
	public void setdAd(String dAd) {
		this.dAd = dAd;
	}
	public String getdSoyAd() {
		return dSoyAd;
	}
	public void setdSoyAd(String dSoyAd) {
		this.dSoyAd = dSoyAd;
	}
	public String getGiderTuru() {
		return giderTuru;
	}
	public void setGiderTuru(String giderTuru) {
		this.giderTuru = giderTuru;
	}
	
	public void setParaBirimi(String paraBirimi) {
		this.paraBirimi = paraBirimi;
	}
	public String getParaBirimi() {
		return paraBirimi;
	}
	public void setOdemeSekli(int odemeSekli) {
		this.odemeSekli = odemeSekli;
	}
	public int getOdemeSekli() {
		return odemeSekli;
	}
	public void setOdemeSekliStr(String odemeSekliStr) {
		this.odemeSekliStr = odemeSekliStr;
	}
	public String getOdemeSekliStr() {
		return odemeSekliStr;
	}
	public double getGelirMiktar() {
		return gelirMiktar;
	}
	public void setGelirMiktar(double gelirMiktar) {
		this.gelirMiktar = gelirMiktar;
	}
	public double getGiderMiktar() {
		return giderMiktar;
	}
	public void setGiderMiktar(double giderMiktar) {
		this.giderMiktar = giderMiktar;
	}
	public double getFark() {
		return fark;
	}
	public void setFark(double fark) {
		this.fark = fark;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getDurum() {
		return durum;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public void setTarihStr(String tarihStr) {
		this.tarihStr = tarihStr;
	}
	public String getTarihStr() {
		return tarihStr;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public TTurKodDTO getTurKodDTO() {
		return turKodDTO;
	}
	public void setTurKodDTO(TTurKodDTO turKodDTO) {
		this.turKodDTO = turKodDTO;
	}

	
}
