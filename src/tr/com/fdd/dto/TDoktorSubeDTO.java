package tr.com.fdd.dto;

import java.io.Serializable;

public class TDoktorSubeDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int id;
	private int dId;
	private int sbId;
	private String durum;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getdId() {
		return dId;
	}

	public void setdId(int dId) {
		this.dId = dId;
	}

	public int getSbId() {
		return sbId;
	}

	public void setSbId(int sbId) {
		this.sbId = sbId;
	}

	public void setDurum(String durum) {
		this.durum = durum;
	}

	public String getDurum() {
		return durum;
	}

}
