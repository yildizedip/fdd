package tr.com.fdd.dto;

import java.io.Serializable;

public class TIslemTipDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String ad;
	private String kod;
	private String durum;
	
	private TIslemTipSubeDTO subeTip;

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

	public String getKod() {
		return kod;
	}

	public void setKod(String kod) {
		this.kod = kod;
	}

	public String getDurum() {
		return durum;
	}

	public void setDurum(String durum) {
		this.durum = durum;
	}

	public TIslemTipSubeDTO getSubeTip() {
		return subeTip;
	}

	public void setSubeTip(TIslemTipSubeDTO subeTip) {
		this.subeTip = subeTip;
	}
}
