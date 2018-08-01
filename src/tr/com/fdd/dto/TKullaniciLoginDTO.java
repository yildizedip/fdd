package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.Date;

public class TKullaniciLoginDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int kuId;
	private String kuMail;
	private String kuSifre;
	private String kuTur;
	private Date kuTarih;
	private String durum;
	private String userIp;
	private Date kuGuncellenmeTarihi;

	public String getKuMail() {
		return kuMail;
	}

	public void setKuMail(String kuMail) {
		this.kuMail = kuMail;
	}

	public String getKuSifre() {
		return kuSifre;
	}

	public void setKuSifre(String kuSifre) {
		this.kuSifre = kuSifre;
	}

	public String getKuTur() {
		return kuTur;
	}

	public void setKuTur(String kuTur) {
		this.kuTur = kuTur;
	}

	public int getKuId() {
		return kuId;
	}

	public void setKuId(int kuId) {
		this.kuId = kuId;
	}

	public void setKuTarih(Date kuTarih) {
		this.kuTarih = kuTarih;
	}

	public Date getKuTarih() {
		return kuTarih;
	}

	public void setDurum(String durum) {
		this.durum = durum;
	}

	public String getDurum() {
		return durum;
	}

	public void setKuGuncellenmeTarihi(Date kuGuncellenmeTarihi) {
		this.kuGuncellenmeTarihi = kuGuncellenmeTarihi;
	}

	public Date getKuGuncellenmeTarihi() {
		return kuGuncellenmeTarihi;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

}
