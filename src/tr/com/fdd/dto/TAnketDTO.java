package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class TAnketDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int hastaId;
	private Date tarih;
	private Date kayitTarihi;
	private String saat;
	private String aciklama;
	private int arayanKisi;
	private String durum;
	private String memnuniyetDerecesi;
	private THastaDTO hasta;
	
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
	public Date getTarih() {
		return tarih;
	}
	public void setTarih(Date tarih) {
		this.tarih = tarih;
	}
	public Date getKayitTarihi() {
		return kayitTarihi;
	}
	public void setKayitTarihi(Date kayitTarihi) {
		this.kayitTarihi = kayitTarihi;
	}
	public String getSaat() {
		return saat;
	}
	public void setSaat(String saat) {
		this.saat = saat;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public int getArayanKisi() {
		return arayanKisi;
	}
	public void setArayanKisi(int arayanKisi) {
		this.arayanKisi = arayanKisi;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public String getMemnuniyetDerecesi() {
		return memnuniyetDerecesi;
	}
	public void setMemnuniyetDerecesi(String memnuniyetDerecesi) {
		this.memnuniyetDerecesi = memnuniyetDerecesi;
	}
	

}
