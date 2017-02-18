package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class THastaRandevuDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private int hastaId;
	private THastaDTO hasta;	
	private TDoktorDTO doktor;	
	private TIslemTipDTO islemTipDto;	
	private TIslemDTO islemDto;	
	private Date randevuTarihi;
	private int islemId;	
	private int doktorId;
	private String aciklama;
	private String durum;
	private Date eklenmeTarihi;
	private int ekleyenKisi;
	private String randevuTarihiBaslangic;
	private String randevuTarihiBitis;
	private String hastaAdSoyad;
	private String telefon;
	private String randevuyaGelinmedi;
	
	
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
	public THastaDTO getHasta() {
		return hasta;
	}
	public void setHasta(THastaDTO hasta) {
		this.hasta = hasta;
	}
	public TDoktorDTO getDoktor() {
		return doktor;
	}
	public void setDoktor(TDoktorDTO doktor) {
		this.doktor = doktor;
	}
	
	public Date getRandevuTarihi() {
		return randevuTarihi;
	}
	public void setRandevuTarihi(Date randevuTarihi) {
		this.randevuTarihi = randevuTarihi;
	}
	
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public Date getEklenmeTarihi() {
		return eklenmeTarihi;
	}
	public void setEklenmeTarihi(Date eklenmeTarihi) {
		this.eklenmeTarihi = eklenmeTarihi;
	}
	public int getEkleyenKisi() {
		return ekleyenKisi;
	}
	public void setEkleyenKisi(int ekleyenKisi) {
		this.ekleyenKisi = ekleyenKisi;
	}
	public String getRandevuTarihiBaslangic() {
		return randevuTarihiBaslangic;
	}
	public void setRandevuTarihiBaslangic(String randevuTarihiBaslangic) {
		this.randevuTarihiBaslangic = randevuTarihiBaslangic;
	}
	public String getRandevuTarihiBitis() {
		return randevuTarihiBitis;
	}
	public void setRandevuTarihiBitis(String randevuTarihiBitis) {
		this.randevuTarihiBitis = randevuTarihiBitis;
	}
	public String getHastaAdSoyad() {
		return hastaAdSoyad;
	}
	public void setHastaAdSoyad(String hastaAdSoyad) {
		this.hastaAdSoyad = hastaAdSoyad;
	}
	public String getTelefon() {
		return telefon;
	}
	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}
	public TIslemTipDTO getIslemTipDto() {
		return islemTipDto;
	}
	public void setIslemTipDto(TIslemTipDTO islemTipDto) {
		this.islemTipDto = islemTipDto;
	}
	public String getRandevuyaGelinmedi() {
		return randevuyaGelinmedi;
	}
	public void setRandevuyaGelinmedi(String randevuyaGelinmedi) {
		this.randevuyaGelinmedi = randevuyaGelinmedi;
	}
	public int getIslemId() {
		return islemId;
	}
	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}
	public TIslemDTO getIslemDto() {
		return islemDto;
	}
	public void setIslemDto(TIslemDTO islemDto) {
		this.islemDto = islemDto;
	}
	
	
	
	

}
