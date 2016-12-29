package tr.com.fdd.struts.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;

public class AnketForm extends ActionForm {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int hastaId;
	private Date tarih;
	private String tarihStr;
	
	private String memnuniyetDerecesi;
	
	public String getTarihStr() {
		return tarihStr;
	}
	public void setTarihStr(String tarihStr) {
		this.tarihStr = tarihStr;
	}
	public String getKayitTarihiStr() {
		return kayitTarihiStr;
	}
	public void setKayitTarihiStr(String kayitTarihiStr) {
		this.kayitTarihiStr = kayitTarihiStr;
	}
	private Date kayitTarihi;
	private String kayitTarihiStr;
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
	public int getHastaId() {
		return hastaId;
	}
	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}
	public Date getTarih() {
		return tarih;
	}
	public void setTarih(Date tarih) {
		this.tarih = tarih;
	}
	public Date getKayitTarihi() {
		return kayitTarihi;
	}
	public void setKayitTarihi(Date kayitTarihi) {
		this.kayitTarihi = kayitTarihi;
	}
	public String getSaat() {
		return saat;
	}
	public void setSaat(String saat) {
		this.saat = saat;
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
	public String getDakika() {
		return dakika;
	}
	public void setDakika(String dakika) {
		this.dakika = dakika;
	}
	public String getMemnuniyetDerecesi() {
		return memnuniyetDerecesi;
	}
	public void setMemnuniyetDerecesi(String memnuniyetDerecesi) {
		this.memnuniyetDerecesi = memnuniyetDerecesi;
	}

}
