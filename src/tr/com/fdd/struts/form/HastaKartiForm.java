package tr.com.fdd.struts.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HastaKartiForm  extends ActionForm{

	private static Logger logger = LoggerFactory.getLogger(HastaForm.class);

	private static final long serialVersionUID = 1L;
	private int hastaId;
	private String ad;
	private String soyad;
	private String tel;
	private String tckimlik;
	private String durum;
	
	private Date guncellenmeTarihi;
	
	private int subeId;
	private int doktorId;
	private String islemTarihiStr;
	private String implantAktif;
	private int implantCerrahId;
	private int implantBaglayanDoktorId;
	private int islemTipi;
	private int disAdet;
	private String disNo;
	private double operasyonUcret;
	private String operasyonDurum;
	private String operasyonAciklama;
	private String odemeTarihiStr;
	private double odemeMiktar;
	private double odenenMiktar;
	private double toplamMiktar;		
	private double kalanMiktar;
	
	private String odemeAciklama;
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
	public Date getGuncellenmeTarihi() {
		return guncellenmeTarihi;
	}
	public void setGuncellenmeTarihi(Date guncellenmeTarihi) {
		this.guncellenmeTarihi = guncellenmeTarihi;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	public String getIslemTarihiStr() {
		return islemTarihiStr;
	}
	public void setIslemTarihiStr(String islemTarihiStr) {
		this.islemTarihiStr = islemTarihiStr;
	}
	public String getImplantAktif() {
		return implantAktif;
	}
	public void setImplantAktif(String implantAktif) {
		this.implantAktif = implantAktif;
	}

	public int getIslemTipi() {
		return islemTipi;
	}
	public void setIslemTipi(int islemTipi) {
		this.islemTipi = islemTipi;
	}
	public int getDisAdet() {
		return disAdet;
	}
	public void setDisAdet(int disAdet) {
		this.disAdet = disAdet;
	}
	public double getOperasyonUcret() {
		return operasyonUcret;
	}
	public void setOperasyonUcret(double operasyonUcret) {
		this.operasyonUcret = operasyonUcret;
	}
	public String getOperasyonDurum() {
		return operasyonDurum;
	}
	public void setOperasyonDurum(String operasyonDurum) {
		this.operasyonDurum = operasyonDurum;
	}
	public String getOperasyonAciklama() {
		return operasyonAciklama;
	}
	public void setOperasyonAciklama(String operasyonAciklama) {
		this.operasyonAciklama = operasyonAciklama;
	}
	public String getOdemeTarihiStr() {
		return odemeTarihiStr;
	}
	public void setOdemeTarihiStr(String odemeTarihiStr) {
		this.odemeTarihiStr = odemeTarihiStr;
	}
	
	public String getOdemeAciklama() {
		return odemeAciklama;
	}
	public void setOdemeAciklama(String odemeAciklama) {
		this.odemeAciklama = odemeAciklama;
	}
	public int getImplantCerrahId() {
		return implantCerrahId;
	}
	public void setImplantCerrahId(int implantCerrahId) {
		this.implantCerrahId = implantCerrahId;
	}
	public int getImplantBaglayanDoktorId() {
		return implantBaglayanDoktorId;
	}
	public void setImplantBaglayanDoktorId(int implantBaglayanDoktorId) {
		this.implantBaglayanDoktorId = implantBaglayanDoktorId;
	}
	public double getOdemeMiktar() {
		return odemeMiktar;
	}
	public void setOdemeMiktar(double odemeMiktar) {
		this.odemeMiktar = odemeMiktar;
	}
	public double getOdenenMiktar() {
		return odenenMiktar;
	}
	public void setOdenenMiktar(double odenenMiktar) {
		this.odenenMiktar = odenenMiktar;
	}
	public double getToplamMiktar() {
		return toplamMiktar;
	}
	public void setToplamMiktar(double toplamMiktar) {
		this.toplamMiktar = toplamMiktar;
	}
	public double getKalanMiktar() {
		return kalanMiktar;
	}
	public int getHastaId() {
		return hastaId;
	}
	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}
	public void setKalanMiktar(double kalanMiktar) {
		this.kalanMiktar = kalanMiktar;
	}
	public String getDisNo() {
		return disNo;
	}
	public void setDisNo(String disNo) {
		this.disNo = disNo;
	}

}
