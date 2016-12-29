package tr.com.fdd.struts.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;

public class IslemBorcOdemeTakipForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	private int id;
	private int islemId;
	private Date borcOdemeTarihi;
	private String borcOdemeTarihiStr;
	private String borcOdemeTarihiBaslamaStr;
	private String borcOdemeTarihiBitisStr;
	private String aciklama;
	private String kalan;
	
	private double miktar;
	private String protokolNo;
	private String ad;
	private String soyad;

	public String getProtokolNo() {
		return protokolNo;
	}
	public void setProtokolNo(String protokolNo) {
		this.protokolNo = protokolNo;
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
	public String getBorcOdemeTarihiBaslamaStr() {
		return borcOdemeTarihiBaslamaStr;
	}
	public void setBorcOdemeTarihiBaslamaStr(String borcOdemeTarihiBaslamaStr) {
		this.borcOdemeTarihiBaslamaStr = borcOdemeTarihiBaslamaStr;
	}
	public String getBorcOdemeTarihiBitisStr() {
		return borcOdemeTarihiBitisStr;
	}
	public void setBorcOdemeTarihiBitisStr(String borcOdemeTarihiBitisStr) {
		this.borcOdemeTarihiBitisStr = borcOdemeTarihiBitisStr;
	}
	private Date eklemeTarihi;
	private int ekleyenId;
	private String durum;
	
	private HastaForm hasta;
	
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
	public Date getBorcOdemeTarihi() {
		return borcOdemeTarihi;
	}
	public void setBorcOdemeTarihi(Date borcOdemeTarihi) {
		this.borcOdemeTarihi = borcOdemeTarihi;
	}
	public Date getEklemeTarihi() {
		return eklemeTarihi;
	}
	public void setEklemeTarihi(Date eklemeTarihi) {
		this.eklemeTarihi = eklemeTarihi;
	}
	public int getEkleyenId() {
		return ekleyenId;
	}
	public void setEkleyenId(int ekleyenId) {
		this.ekleyenId = ekleyenId;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getBorcOdemeTarihiStr() {
		return borcOdemeTarihiStr;
	}
	public void setBorcOdemeTarihiStr(String borcOdemeTarihiStr) {
		this.borcOdemeTarihiStr = borcOdemeTarihiStr;
	}
	public HastaForm getHasta() {
		return hasta;
	}
	public void setHasta(HastaForm hasta) {
		this.hasta = hasta;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public String getKalan() {
		return kalan;
	}
	public void setKalan(String kalan) {
		this.kalan = kalan;
	}
}
