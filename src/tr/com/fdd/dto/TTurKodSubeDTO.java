package tr.com.fdd.dto;

import java.io.Serializable;

public class TTurKodSubeDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int tkId;
	private int subeId;
	private String durum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public String getDurum() {
		return durum;
	}
	public int getTkId() {
		return tkId;
	}
	public void setTkId(int tkId) {
		this.tkId = tkId;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}

}
