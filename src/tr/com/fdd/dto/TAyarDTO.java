package tr.com.fdd.dto;

import java.io.Serializable;

public class TAyarDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String value;
	private String state;
	private int subeId;
	private String subeAd;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public String getSubeAd() {
		return subeAd;
	}
	public void setSubeAd(String subeAd) {
		this.subeAd = subeAd;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

}
