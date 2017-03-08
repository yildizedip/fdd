package tr.com.fdd.dto;

import java.io.Serializable;

public class TIslemTipSubeDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int subeId;
	private String subeAd;
	private int islemId;
	private double fiyat;
	private int state;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public int getIslemId() {
		return islemId;
	}
	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public double getFiyat() {
		return fiyat;
	}
	public void setFiyat(double fiyat) {
		this.fiyat = fiyat;
	}
	public String getSubeAd() {
		return subeAd;
	}
	public void setSubeAd(String subeAd) {
		this.subeAd = subeAd;
	}


}
