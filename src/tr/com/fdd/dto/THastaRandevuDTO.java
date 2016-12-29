package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class THastaRandevuDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int hastaId;
	private THastaDTO hasta;	
	private Date randevuTarihi;
	private String randevuTarihiStr;
	private int randevuSaat;
	private int randevuDak;
	private int islem;	
	private int doktorId;
	private String doktorAd;
	private String doktorSoyad;
	private String islemAd;
	private String aciklama;
	private String durum;
	private Date eklenmeTarihi;
	private int ekleyenKisi;
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
	public Date getRandevuTarihi() {
		return randevuTarihi;
	}
	public void setRandevuTarihi(Date randevuTarihi) {
		this.randevuTarihi = randevuTarihi;
	}
	public int getRandevuSaat() {
		return randevuSaat;
	}
	public void setRandevuSaat(int randevuSaat) {
		this.randevuSaat = randevuSaat;
	}
	public int getRandevuDak() {
		return randevuDak;
	}
	public void setRandevuDak(int randevuDak) {
		this.randevuDak = randevuDak;
	}
	public int getIslem() {
		return islem;
	}
	public void setIslem(int islem) {
		this.islem = islem;
	}
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public Date getEklenmeTarihi() {
		return eklenmeTarihi;
	}
	public void setEklenmeTarihi(Date eklenmeTarihi) {
		this.eklenmeTarihi = eklenmeTarihi;
	}
	public int getEkleyenKisi() {
		return ekleyenKisi;
	}
	public void setEkleyenKisi(int ekleyenKisi) {
		this.ekleyenKisi = ekleyenKisi;
	}
	public void setRandevuTarihiStr(String randevuTarihiStr) {
		this.randevuTarihiStr = randevuTarihiStr;
	}
	public String getRandevuTarihiStr() {
		return randevuTarihiStr;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public String getDoktorAd() {
		return doktorAd;
	}
	public void setDoktorAd(String doktorAd) {
		this.doktorAd = doktorAd;
	}
	public String getDoktorSoyad() {
		return doktorSoyad;
	}
	public void setDoktorSoyad(String doktorSoyad) {
		this.doktorSoyad = doktorSoyad;
	}
	public String getIslemAd() {
		return islemAd;
	}
	public void setIslemAd(String islemAd) {
		this.islemAd = islemAd;
	}
}
