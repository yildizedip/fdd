package tr.com.fdd.dto;

import java.io.Serializable;

public class TKullaniciSubeDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int kuId;
	private int sId;
	private String durum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getKuId() {
		return kuId;
	}
	public void setKuId(int kuId) {
		this.kuId = kuId;
	}
	public int getsId() {
		return sId;
	}
	public void setsId(int sId) {
		this.sId = sId;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getDurum() {
		return durum;
	}

}
