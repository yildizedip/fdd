package tr.com.fdd.dto;

import java.io.Serializable;

public class TSubeDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int sId;
	private String sAd;
	private String sAdres;
	private String sTel;
	private String sDurum;
	public int getsId() {
		return sId;
	}
	public void setsId(int sId) {
		this.sId = sId;
	}
	public String getsAd() {
		return sAd;
	}
	public void setsAd(String sAd) {
		this.sAd = sAd;
	}
	public String getsAdres() {
		return sAdres;
	}
	public void setsAdres(String sAdres) {
		this.sAdres = sAdres;
	}
	public String getsTel() {
		return sTel;
	}
	public void setsTel(String sTel) {
		this.sTel = sTel;
	}
	public String getsDurum() {
		return sDurum;
	}
	public void setsDurum(String sDurum) {
		this.sDurum = sDurum;
	}
	
}
