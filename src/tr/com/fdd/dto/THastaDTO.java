package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;



public class THastaDTO implements Serializable {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String protokolNo;	
	private String ad;
	private String soyad;
	private String tel;
	private String tckimlik;
	private String durum;
	private String adres;
	private Date eklenmeTarihi;
	private String eklenmeTarihiStr;
	private Date guncellenmeTarihi;
	private Integer guncelleyenKisi;
	private int subeId;
	private List<TIslemDTO> hastaOperasyonList;
	private List<TIslemDTO> hastaSelectedDoktorOperasyonList; //sadece belli bir doktorun yaptigi operasyonlar- randevu icin
	private List<TAnketDTO> hastaAnketList;
	private List<TAramaKaydiDTO> hastaAramaKaydiList;
	private List<THastaRandevuDTO> hastaRandevuList;
	private int hastaAnketSayisi;
	
	
	
	public int getHastaAnketSayisi() {
		if(getHastaAnketList()!=null)
		hastaAnketSayisi=getHastaAnketList().size();
		return hastaAnketSayisi;
	}
	public void setHastaAnketSayisi(int hastaAnketSayisi) {
		this.hastaAnketSayisi = hastaAnketSayisi;
	}
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
	public String getSoyad() {
		return soyad;
	}
	public void setSoyad(String soyad) {
		this.soyad = soyad;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTckimlik() {
		return tckimlik;
	}
	public void setTckimlik(String tckimlik) {
		this.tckimlik = tckimlik;
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
	public void setGuncellenmeTarihi(Date guncellenmeTarihi) {
		this.guncellenmeTarihi = guncellenmeTarihi;
	}
	public Date getGuncellenmeTarihi() {
		return guncellenmeTarihi;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setEklenmeTarihiStr(String eklenmeTarihiStr) {
		this.eklenmeTarihiStr = eklenmeTarihiStr;
	}
	public String getEklenmeTarihiStr() {
		return eklenmeTarihiStr;
	}
	
	public List<TIslemDTO> getHastaOperasyonList() {
		return hastaOperasyonList;
	}
	public void setHastaOperasyonList(List<TIslemDTO> hastaOperasyonList) {
		this.hastaOperasyonList = hastaOperasyonList;
	}
	
	public List<TAnketDTO> getHastaAnketList() {
		return hastaAnketList;
	}
	public void setHastaAnketList(List<TAnketDTO> hastaAnketList) {
		this.hastaAnketList = hastaAnketList;
	}
	public String getProtokolNo() {
		return protokolNo;
	}
	public void setProtokolNo(String protokolNo) {
		this.protokolNo = protokolNo;
	}
	public List<TAramaKaydiDTO> getHastaAramaKaydiList() {
		return hastaAramaKaydiList;
	}
	public void setHastaAramaKaydiList(List<TAramaKaydiDTO> hastaAramaKaydiList) {
		this.hastaAramaKaydiList = hastaAramaKaydiList;
	}
	public List<TIslemDTO> getHastaSelectedDoktorOperasyonList() {
		return hastaSelectedDoktorOperasyonList;
	}
	public void setHastaSelectedDoktorOperasyonList(List<TIslemDTO> hastaSelectedDoktorOperasyonList) {
		this.hastaSelectedDoktorOperasyonList = hastaSelectedDoktorOperasyonList;
	}
	public Integer getGuncelleyenKisi() {
		return guncelleyenKisi;
	}
	public void setGuncelleyenKisi(Integer guncelleyenKisi) {
		this.guncelleyenKisi = guncelleyenKisi;
	}
	
	 public String getValue() {
		 return String.format("%s %s", getAd(),getSoyad());
	 }
	 public String getLabel() {
		 return String.format("%s %s", getAd(),getSoyad());
	 }
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public List<THastaRandevuDTO> getHastaRandevuList() {
		return hastaRandevuList;
	}
	public void setHastaRandevuList(List<THastaRandevuDTO> hastaRandevuList) {
		this.hastaRandevuList = hastaRandevuList;
	}

}
