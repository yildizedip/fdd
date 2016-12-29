package tr.com.fdd.struts.form;

import org.apache.struts.action.ActionForm;

public class LabrotuvarForm extends ActionForm {

	private int id;
	private String islemId;
	private String metalProva;
	private String iskeletProva;
	private String zirkonProva;
	private String disliProva;
	private String dentinProva;

	private String metalProvaTar;
	private String zirkonProvaTar;
	private String disliProvaTar;
	private String dentinProvaTar;
	private String iskeletProvaTar;

	private String klinikCikisTarStr;
	private String labCikisTarStr;
	private String bitimTarStr;

	private String durum;
	private String aciklama;
	private String labAciklama;
	
	
	private int gonderenKisi;
	private int alanKisi;
	
	private int labIslemTipId;
	private String labIslemAd;
	private String labIslemPuan;
	private String labIslemOnayRed;
	private String klinikDegerlendirmeTar;
	private String sube;
	
	private String hastaProtokolNo;
	private String hastaAd;
	private String hastaSoyad;
	private String klinikCikisTarBas;
	private String klinikCikisTarBit;
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getIslemId() {
		return islemId;
	}

	public void setIslemId(String islemId) {
		this.islemId = islemId;
	}

	
	public String getDurum() {
		return durum;
	}

	public void setDurum(String durum) {
		this.durum = durum;
	}


	public int getGonderenKisi() {
		return gonderenKisi;
	}

	public void setGonderenKisi(int gonderenKisi) {
		this.gonderenKisi = gonderenKisi;
	}

	public int getAlanKisi() {
		return alanKisi;
	}

	public void setAlanKisi(int alanKisi) {
		this.alanKisi = alanKisi;
	}

	public String getMetalProva() {
		return metalProva;
	}

	public void setMetalProva(String metalProva) {
		this.metalProva = metalProva;
	}

	public String getZirkonProva() {
		return zirkonProva;
	}

	public void setZirkonProva(String zirkonProva) {
		this.zirkonProva = zirkonProva;
	}

	public String getDisliProva() {
		return disliProva;
	}

	public void setDisliProva(String disliProva) {
		this.disliProva = disliProva;
	}

	public String getDentinProva() {
		return dentinProva;
	}

	public void setDentinProva(String dentinProva) {
		this.dentinProva = dentinProva;
	}

	public String getMetalProvaTar() {
		return metalProvaTar;
	}

	public void setMetalProvaTar(String metalProvaTar) {
		this.metalProvaTar = metalProvaTar;
	}

	public String getZirkonProvaTar() {
		return zirkonProvaTar;
	}

	public void setZirkonProvaTar(String zirkonProvaTar) {
		this.zirkonProvaTar = zirkonProvaTar;
	}

	public String getDisliProvaTar() {
		return disliProvaTar;
	}

	public void setDisliProvaTar(String disliProvaTar) {
		this.disliProvaTar = disliProvaTar;
	}

	public String getDentinProvaTar() {
		return dentinProvaTar;
	}

	public void setDentinProvaTar(String dentinProvaTar) {
		this.dentinProvaTar = dentinProvaTar;
	}

	public String getBitimTarStr() {
		return bitimTarStr;
	}

	public void setBitimTarStr(String bitimTarStr) {
		this.bitimTarStr = bitimTarStr;
	}

	public String getIskeletProva() {
		return iskeletProva;
	}

	public void setIskeletProva(String iskeletProva) {
		this.iskeletProva = iskeletProva;
	}

	public String getIskeletProvaTar() {
		return iskeletProvaTar;
	}

	public void setIskeletProvaTar(String iskeletProvaTar) {
		this.iskeletProvaTar = iskeletProvaTar;
	}

	public String getKlinikCikisTarStr() {
		return klinikCikisTarStr;
	}

	public void setKlinikCikisTarStr(String klinikCikisTarStr) {
		this.klinikCikisTarStr = klinikCikisTarStr;
	}

	public String getLabCikisTarStr() {
		return labCikisTarStr;
	}

	public void setLabCikisTarStr(String labCikisTarStr) {
		this.labCikisTarStr = labCikisTarStr;
	}

	public String getAciklama() {
		return aciklama;
	}

	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}

	public String getLabAciklama() {
		return labAciklama;
	}

	public void setLabAciklama(String labAciklama) {
		this.labAciklama = labAciklama;
	}



	public String getLabIslemAd() {
		return labIslemAd;
	}

	public void setLabIslemAd(String labIslemAd) {
		this.labIslemAd = labIslemAd;
	}

	public String getLabIslemPuan() {
		return labIslemPuan;
	}

	public void setLabIslemPuan(String labIslemPuan) {
		this.labIslemPuan = labIslemPuan;
	}

	public String getLabIslemOnayRed() {
		return labIslemOnayRed;
	}

	public void setLabIslemOnayRed(String labIslemOnayRed) {
		this.labIslemOnayRed = labIslemOnayRed;
	}

	public String getKlinikDegerlendirmeTar() {
		return klinikDegerlendirmeTar;
	}

	public void setKlinikDegerlendirmeTar(String klinikDegerlendirmeTar) {
		this.klinikDegerlendirmeTar = klinikDegerlendirmeTar;
	}

	public int getLabIslemTipId() {
		return labIslemTipId;
	}

	public void setLabIslemTipId(int labIslemTipId) {
		this.labIslemTipId = labIslemTipId;
	}

	public String getSube() {
		return sube;
	}

	public void setSube(String sube) {
		this.sube = sube;
	}

	public String getHastaProtokolNo() {
		return hastaProtokolNo;
	}

	public void setHastaProtokolNo(String hastaProtokolNo) {
		this.hastaProtokolNo = hastaProtokolNo;
	}

	public String getHastaAd() {
		return hastaAd;
	}

	public void setHastaAd(String hastaAd) {
		this.hastaAd = hastaAd;
	}

	public String getHastaSoyad() {
		return hastaSoyad;
	}

	public void setHastaSoyad(String hastaSoyad) {
		this.hastaSoyad = hastaSoyad;
	}

	public String getKlinikCikisTarBas() {
		return klinikCikisTarBas;
	}

	public void setKlinikCikisTarBas(String klinikCikisTarBas) {
		this.klinikCikisTarBas = klinikCikisTarBas;
	}

	public String getKlinikCikisTarBit() {
		return klinikCikisTarBit;
	}

	public void setKlinikCikisTarBit(String klinikCikisTarBit) {
		this.klinikCikisTarBit = klinikCikisTarBit;
	}

}
