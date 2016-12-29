package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;

public class TLabrotuvarDTO implements Serializable {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int id;
	private int labIslemTipId;
	private String labIslemTipAd;	
	private int	islemId;
	private Date klinikCikisTar;
	private Date labCikisTar;
	private Date bitimTarStr;
	private Date gondermeTar;
	private Date labGondermeTar;
	private Date klinikDegerlendirmeTar;
	private String durum;
	private String puan;
	private int  gonderenKisi;
	private int  alanKisi;
	private String aciklama;
	private String labAciklama;
	private int disSay;
	private List<TLabrotuvarProvaDTO> provaList;
	private TSubeDTO subeDTO;
	private THastaDTO hastaDTO;
	private TDoktorDTO doktorDTO;
	private TIslemTipDTO islemTipDTO;
	private LaboratuvarIslemDurum laboratuvarIslemDurum;
	
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
	
	
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getPuan() {
		return puan;
	}
	public void setPuan(String puan) {
		this.puan = puan;
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
	public List<TLabrotuvarProvaDTO> getProvaList() {
		return provaList;
	}
	public void setProvaList(List<TLabrotuvarProvaDTO> provaList) {
		this.provaList = provaList;
	}
	
	public Date getBitimTarStr() {
		return bitimTarStr;
	}
	public void setBitimTarStr(Date bitimTarStr) {
		this.bitimTarStr = bitimTarStr;
	}
	public Date getGondermeTar() {
		return gondermeTar;
	}
	public void setGondermeTar(Date gondermeTar) {
		this.gondermeTar = gondermeTar;
	}
	public Date getKlinikCikisTar() {
		return klinikCikisTar;
	}
	public void setKlinikCikisTar(Date klinikCikisTar) {
		this.klinikCikisTar = klinikCikisTar;
	}
	public Date getLabCikisTar() {
		return labCikisTar;
	}
	public void setLabCikisTar(Date labCikisTar) {
		this.labCikisTar = labCikisTar;
	}
	public TSubeDTO getSubeDTO() {
		return subeDTO;
	}
	public void setSubeDTO(TSubeDTO subeDTO) {
		this.subeDTO = subeDTO;
	}
	public THastaDTO getHastaDTO() {
		return hastaDTO;
	}
	public void setHastaDTO(THastaDTO hastaDTO) {
		this.hastaDTO = hastaDTO;
	}
	public TDoktorDTO getDoktorDTO() {
		return doktorDTO;
	}
	public void setDoktorDTO(TDoktorDTO doktorDTO) {
		this.doktorDTO = doktorDTO;
	}
	public TIslemTipDTO getIslemTipDTO() {
		return islemTipDTO;
	}
	public void setIslemTipDTO(TIslemTipDTO islemTipDTO) {
		this.islemTipDTO = islemTipDTO;
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
	public int getLabIslemTipId() {
		return labIslemTipId;
	}
	public void setLabIslemTipId(int labIslemTipId) {
		this.labIslemTipId = labIslemTipId;
	}
	public String getLabIslemTipAd() {
		return labIslemTipAd;
	}
	public void setLabIslemTipAd(String labIslemTipAd) {
		this.labIslemTipAd = labIslemTipAd;
	}
	public LaboratuvarIslemDurum getLaboratuvarIslemDurum() {
		return laboratuvarIslemDurum;
	}
	public void setLaboratuvarIslemDurum(LaboratuvarIslemDurum laboratuvarIslemDurum) {
		this.laboratuvarIslemDurum = laboratuvarIslemDurum;
	}
	public Date getLabGondermeTar() {
		return labGondermeTar;
	}
	public void setLabGondermeTar(Date labGondermeTar) {
		this.labGondermeTar = labGondermeTar;
	}
	public int getDisSay() {
		return disSay;
	}
	public void setDisSay(int disSay) {
		this.disSay = disSay;
	}
	public Date getKlinikDegerlendirmeTar() {
		return klinikDegerlendirmeTar;
	}
	public void setKlinikDegerlendirmeTar(Date klinikDegerlendirmeTar) {
		this.klinikDegerlendirmeTar = klinikDegerlendirmeTar;
	}
	
}
