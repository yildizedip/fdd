package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class TAramaKaydiDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int islemId;
	private int hastaId;
	private Date aramaTarih;
	private Date kayitTarih;
	private String aramaSaat;
	private String aciklama;
	private int arayanKisi;
	private String durum;
	private TIslemDTO islem;
	private THastaDTO hasta;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIslemId() {
		return islemId;
	}
	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}
	public Date getAramaTarih() {
		return aramaTarih;
	}
	public void setAramaTarih(Date aramaTarih) {
		this.aramaTarih = aramaTarih;
	}
	public Date getKayitTarih() {
		return kayitTarih;
	}
	public void setKayitTarih(Date kayitTarih) {
		this.kayitTarih = kayitTarih;
	}
	public String getAramaSaat() {
		return aramaSaat;
	}
	public void setAramaSaat(String aramaSaat) {
		this.aramaSaat = aramaSaat;
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
	public TIslemDTO getIslem() {
		return islem;
	}
	public void setIslem(TIslemDTO islem) {
		this.islem = islem;
	}
	public int getHastaId() {
		return hastaId;
	}
	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}
	public THastaDTO getHasta() {
		return hasta;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	

}
