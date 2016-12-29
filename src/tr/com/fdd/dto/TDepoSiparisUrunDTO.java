package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class TDepoSiparisUrunDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int siparisId;
	private int urunTipId;
	private double depoFiyat;
	private double subeFiyat;
	private int adet;
	private int depoId;
	private Date gondermeTar;
	private Date eklemeTar;
	private String eklemeTarStr;
	private String aciklama;
	private int durum;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getUrunTipId() {
		return urunTipId;
	}
	public void setUrunTipId(int urunTipId) {
		this.urunTipId = urunTipId;
	}
	public double getDepoFiyat() {
		return depoFiyat;
	}
	public void setDepoFiyat(double depoFiyat) {
		this.depoFiyat = depoFiyat;
	}
	public double getSubeFiyat() {
		return subeFiyat;
	}
	public void setSubeFiyat(double subeFiyat) {
		this.subeFiyat = subeFiyat;
	}
	public int getAdet() {
		return adet;
	}
	public void setAdet(int adet) {
		this.adet = adet;
	}
	public int getDepoId() {
		return depoId;
	}
	public void setDepoId(int depoId) {
		this.depoId = depoId;
	}
	public Date getGondermeTar() {
		return gondermeTar;
	}
	public void setGondermeTar(Date gondermeTar) {
		this.gondermeTar = gondermeTar;
	}
	public Date getEklemeTar() {
		return eklemeTar;
	}
	public void setEklemeTar(Date eklemeTar) {
		this.eklemeTar = eklemeTar;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public int getDurum() {
		return durum;
	}
	public void setDurum(int durum) {
		this.durum = durum;
	}
	
	public String getEklemeTarStr() {
		return eklemeTarStr;
	}
	public void setEklemeTarStr(String eklemeTarStr) {
		this.eklemeTarStr = eklemeTarStr;
	}
	public int getSiparisId() {
		return siparisId;
	}
	public void setSiparisId(int siparisId) {
		this.siparisId = siparisId;
	}
	
}
