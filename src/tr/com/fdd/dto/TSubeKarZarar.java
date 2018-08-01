package tr.com.fdd.dto;

import java.io.Serializable;

public class TSubeKarZarar implements Serializable {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long id;
	private int subeId;
	private String subeAd;
	private double gelir;
	private String gelirStr;
	private double gider;
	private String giderStr;
	private double kar;
	private String karStr;
	private int implantSay;
	private int implantSayKesinlesmemis;
	
	private double tedaviMiktar;
	private double tedaviMiktarKesinlesmemis;
	private String tedaviMiktarStr;
	private String tedaviMiktarKesinlesmemisStr;
	
	private double miktarFark;
	private String miktarFarkStr;
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public String getSubeAd() {
		return subeAd;
	}
	public void setSubeAd(String subeAd) {
		this.subeAd = subeAd;
	}
	public double getGelir() {
		return gelir;
	}
	public void setGelir(double gelir) {
		this.gelir = gelir;
	}
	public double getGider() {
		return gider;
	}
	public void setGider(double gider) {
		this.gider = gider;
	}
	public double getKar() {
		return kar;
	}
	public void setKar(double kar) {
		this.kar = kar;
	}
	public int getImplantSay() {
		return implantSay;
	}
	public void setImplantSay(int implantSay) {
		this.implantSay = implantSay;
	}
	public String getGelirStr() {
		return gelirStr;
	}
	public void setGelirStr(String gelirStr) {
		this.gelirStr = gelirStr;
	}
	public String getGiderStr() {
		return giderStr;
	}
	public void setGiderStr(String giderStr) {
		this.giderStr = giderStr;
	}
	public String getKarStr() {
		return karStr;
	}
	public void setKarStr(String karStr) {
		this.karStr = karStr;
	}
	public int getImplantSayKesinlesmemis() {
		return implantSayKesinlesmemis;
	}
	public void setImplantSayKesinlesmemis(int implantSayKesinlesmemis) {
		this.implantSayKesinlesmemis = implantSayKesinlesmemis;
	}
	public double getTedaviMiktar() {
		return tedaviMiktar;
	}
	public void setTedaviMiktar(double tedaviMiktar) {
		this.tedaviMiktar = tedaviMiktar;
	}
	public double getTedaviMiktarKesinlesmemis() {
		return tedaviMiktarKesinlesmemis;
	}
	public void setTedaviMiktarKesinlesmemis(double tedaviMiktarKesinlesmemis) {
		this.tedaviMiktarKesinlesmemis = tedaviMiktarKesinlesmemis;
	}
	public String getTedaviMiktarStr() {
		return tedaviMiktarStr;
	}
	public void setTedaviMiktarStr(String tedaviMiktarStr) {
		this.tedaviMiktarStr = tedaviMiktarStr;
	}
	public String getTedaviMiktarKesinlesmemisStr() {
		return tedaviMiktarKesinlesmemisStr;
	}
	public void setTedaviMiktarKesinlesmemisStr(String tedaviMiktarKesinlesmemisStr) {
		this.tedaviMiktarKesinlesmemisStr = tedaviMiktarKesinlesmemisStr;
	}
	public double getMiktarFark() {
		return miktarFark;
	}
	public void setMiktarFark(double miktarFark) {
		this.miktarFark = miktarFark;
	}
	public String getMiktarFarkStr() {
		return miktarFarkStr;
	}
	public void setMiktarFarkStr(String miktarFarkStr) {
		this.miktarFarkStr = miktarFarkStr;
	}
	
	

}
