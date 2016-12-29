package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class TDepoSiparisDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String siparisNo;
	private Date eklemeTar;
	private int ekleyenKisi;
	private int durum;
	private int subeId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSiparisNo() {
		return siparisNo;
	}
	public void setSiparisNo(String siparisNo) {
		this.siparisNo = siparisNo;
	}
	public Date getEklemeTar() {
		return eklemeTar;
	}
	public void setEklemeTar(Date eklemeTar) {
		this.eklemeTar = eklemeTar;
	}
	public int getEkleyenKisi() {
		return ekleyenKisi;
	}
	public void setEkleyenKisi(int ekleyenKisi) {
		this.ekleyenKisi = ekleyenKisi;
	}
	public int getDurum() {
		return durum;
	}
	public void setDurum(int durum) {
		this.durum = durum;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	
	
	
}
