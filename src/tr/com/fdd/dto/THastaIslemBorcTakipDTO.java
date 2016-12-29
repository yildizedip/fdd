package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class THastaIslemBorcTakipDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int islemId;
	private Date borcOdemeTarihi;
	private Date eklemeTarihi;
	private int ekleyenId;
	private String durum;
	private String aciklama;
	private double miktar;
	
	private TIslemDTO islemDTO;
	
	
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
	public Date getEklemeTarihi() {
		return eklemeTarihi;
	}
	public void setEklemeTarihi(Date eklemeTarihi) {
		this.eklemeTarihi = eklemeTarihi;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public TIslemDTO getIslemDTO() {
		return islemDTO;
	}
	public void setIslemDTO(TIslemDTO islemDTO) {
		this.islemDTO = islemDTO;
	}
	


}
