package tr.com.fdd.dto;

import java.io.Serializable;

public class TDepoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String depoAd;
	private String adres;
	private int durum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDepoAd() {
		return depoAd;
	}
	public void setDepoAd(String depoAd) {
		this.depoAd = depoAd;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public int getDurum() {
		return durum;
	}
	public void setDurum(int durum) {
		this.durum = durum;
	}
	
	
}
