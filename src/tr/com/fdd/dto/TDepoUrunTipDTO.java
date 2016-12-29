package tr.com.fdd.dto;

import java.io.Serializable;

public class TDepoUrunTipDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String urunAd;
	private int durum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUrunAd() {
		return urunAd;
	}
	public void setUrunAd(String urunAd) {
		this.urunAd = urunAd;
	}
	public int getDurum() {
		return durum;
	}
	public void setDurum(int durum) {
		this.durum = durum;
	}
	
	
}
