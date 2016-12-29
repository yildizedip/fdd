package tr.com.fdd.dto;

import java.io.Serializable;

public class TLabIslemTipDTO implements Serializable {
	
	private int id;
	private String ad;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAd() {
		return ad;
	}
	public void setAd(String ad) {
		this.ad = ad;
	}
	
	
}
