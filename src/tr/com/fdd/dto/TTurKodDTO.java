package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.List;

import tr.com.fdd.struts.form.SubeForm;

public class TTurKodDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int turId;
	private String turAd;
	private int turTip;
	private int turKod;
	private String turDurum;
	private List<SubeForm> turSubeList;
	
	
	public int getTurId() {
		return turId;
	}
	public void setTurId(int turId) {
		this.turId = turId;
	}
	public String getTurAd() {
		return turAd;
	}
	public void setTurAd(String turAd) {
		this.turAd = turAd;
	}
	public int getTurTip() {
		return turTip;
	}
	public void setTurTip(int turTip) {
		this.turTip = turTip;
	}
	public int getTurKod() {
		return turKod;
	}
	public void setTurKod(int turKod) {
		this.turKod = turKod;
	}
	public void setTurDurum(String turDurum) {
		this.turDurum = turDurum;
	}
	public String getTurDurum() {
		return turDurum;
	}
	public void setTurSubeList(List<SubeForm> turSubeList) {
		this.turSubeList = turSubeList;
	}
	public List<SubeForm> getTurSubeList() {
		return turSubeList;
	}

}
