package tr.com.fdd.dto;

import java.io.Serializable;



public class TKullaniciBilgiDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int kuId;
	private int kuLoginId;
	private int giderKodu;
	private String kuAd;
	private String kuSoyad;
	private String kuTel;
	private String kuAdres;
	
	public int getKuId() {
		return kuId;
	}
	public void setKuId(int kuId) {
		this.kuId = kuId;
	}
	public int getKuLoginId() {
		return kuLoginId;
	}
	public void setKuLoginId(int kuLoginId) {
		this.kuLoginId = kuLoginId;
	}
	public String getKuAd() {
		return kuAd;
	}
	public void setKuAd(String kuAd) {
		this.kuAd = kuAd;
	}
	public String getKuSoyad() {
		return kuSoyad;
	}
	public void setKuSoyad(String kuSoyad) {
		this.kuSoyad = kuSoyad;
	}
	public String getKuTel() {
		return kuTel;
	}
	public void setKuTel(String kuTel) {
		this.kuTel = kuTel;
	}
	public String getKuAdres() {
		return kuAdres;
	}
	public void setKuAdres(String kuAdres) {
		this.kuAdres = kuAdres;
	}
	public void setGiderKodu(int giderKodu) {
		this.giderKodu = giderKodu;
	}
	public int getGiderKodu() {
		return giderKodu;
	}


	
}
