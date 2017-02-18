package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.List;

import tr.com.fdd.struts.form.SubeForm;

public class TDoktorDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int dMemberId;
	private String dBrans;
	private String dAd;
	private String dSoyad;
	private int dId;
	private String dDurum;
	private String dAktif;
	private List<SubeForm> doktorSubeList;
	private List<THastaRandevuDTO> doktorRandevuList;

	public int getdMemberId() {
		return dMemberId;
	}

	public void setdMemberId(int dMemberId) {
		this.dMemberId = dMemberId;
	}

	public String getdBrans() {
		return dBrans;
	}

	public void setdBrans(String dBrans) {
		this.dBrans = dBrans;
	}

	public String getdAd() {
		return dAd;
	}

	public void setdAd(String dAd) {
		this.dAd = dAd;
	}

	public String getdSoyad() {
		return dSoyad;
	}

	public void setdSoyad(String dSoyad) {
		this.dSoyad = dSoyad;
	}

	public void setdId(int dId) {
		this.dId = dId;
	}

	public int getdId() {
		return dId;
	}

	public void setdDurum(String dDurum) {
		this.dDurum = dDurum;
	}

	public String getdDurum() {
		return dDurum;
	}

	public void setDoktorSubeList(List<SubeForm> doktorSubeList) {
		this.doktorSubeList = doktorSubeList;
	}

	public List<SubeForm> getDoktorSubeList() {
		return doktorSubeList;
	}

	public String getdAktif() {
		return dAktif;
	}

	public void setdAktif(String dAktif) {
		this.dAktif = dAktif;
	}

	public List<THastaRandevuDTO> getDoktorRandevuList() {
		return doktorRandevuList;
	}

	public void setDoktorRandevuList(List<THastaRandevuDTO> doktorRandevuList) {
		this.doktorRandevuList = doktorRandevuList;
	}
}
