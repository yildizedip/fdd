package tr.com.fdd.struts.form;



import java.util.Date;

import org.apache.struts.action.ActionForm;

public class TAramaForm extends ActionForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int islemId;
	private int hastaId;
	private Date aramaTarih;
	private String aramaTarihStr;
	private Date kayitTarih;
	private String aramaSaat;
	private String saat;
	private String dakika;
	private String aciklama;
	private int arayanKisi;
	private String durum;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIslemId() {
		return islemId;
	}
	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}
	public Date getAramaTarih() {
		return aramaTarih;
	}
	public void setAramaTarih(Date aramaTarih) {
		this.aramaTarih = aramaTarih;
	}
	public Date getKayitTarih() {
		return kayitTarih;
	}
	public void setKayitTarih(Date kayitTarih) {
		this.kayitTarih = kayitTarih;
	}
	public String getAramaSaat() {
		return aramaSaat;
	}
	public void setAramaSaat(String aramaSaat) {
		this.aramaSaat = aramaSaat;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public int getArayanKisi() {
		return arayanKisi;
	}
	public void setArayanKisi(int arayanKisi) {
		this.arayanKisi = arayanKisi;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getAramaTarihStr() {
		return aramaTarihStr;
	}
	public void setAramaTarihStr(String aramaTarihStr) {
		this.aramaTarihStr = aramaTarihStr;
	}
	public String getSaat() {
		return saat;
	}
	public void setSaat(String saat) {
		this.saat = saat;
	}
	public String getDakika() {
		return dakika;
	}
	public void setDakika(String dakika) {
		this.dakika = dakika;
	}
	public int getHastaId() {
		return hastaId;
	}
	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}

}
