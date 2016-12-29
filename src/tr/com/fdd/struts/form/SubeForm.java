package tr.com.fdd.struts.form;

import org.apache.struts.action.ActionForm;

public class SubeForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	private int sId;
	private String sAd;
	private String sAdres;
	private String sTel;
	private String sDurum;
	private int doktorSubeId;
	private int kullaniciSubeId;
	private int giderTuruSubeId;
	private int kullaniciId;
	private int subeId;

	public int getsId() {
		return sId;
	}

	public void setsId(int sId) {
		this.sId = sId;
	}

	public String getsAd() {
		return sAd;
	}

	public void setsAd(String sAd) {
		this.sAd = sAd;
	}

	public String getsAdres() {
		return sAdres;
	}

	public void setsAdres(String sAdres) {
		this.sAdres = sAdres;
	}

	public String getsTel() {
		return sTel;
	}

	public void setsTel(String sTel) {
		this.sTel = sTel;
	}

	public String getsDurum() {
		return sDurum;
	}

	public void setsDurum(String sDurum) {
		this.sDurum = sDurum;
	}

	public void setKullaniciSubeId(int kullaniciSubeId) {
		this.kullaniciSubeId = kullaniciSubeId;
	}

	public int getKullaniciSubeId() {
		return kullaniciSubeId;
	}

	public int getKullaniciId() {
		return kullaniciId;
	}

	public void setKullaniciId(int kullaniciId) {
		this.kullaniciId = kullaniciId;
	}

	public int getSubeId() {
		return subeId;
	}

	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}

	public void setGiderTuruSubeId(int giderTuruSubeId) {
		this.giderTuruSubeId = giderTuruSubeId;
	}

	public int getGiderTuruSubeId() {
		return giderTuruSubeId;
	}

	public void setDoktorSubeId(int doktorSubeId) {
		this.doktorSubeId = doktorSubeId;
	}

	public int getDoktorSubeId() {
		return doktorSubeId;
	}
}
