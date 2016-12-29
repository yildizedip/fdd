package tr.com.fdd.dto;

import java.util.Date;

import tr.com.fdd.utils.enums.ProvaTip;

public class TLabrotuvarProvaDTO {
	
	private int id;
	private int labIslemId;
	private int provaTip;
	private ProvaTip provaTipEnm;
	private Date provaTar;
	private String durum;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getLabIslemId() {
		return labIslemId;
	}
	public void setLabIslemId(int labIslemId) {
		this.labIslemId = labIslemId;
	}
	public int getProvaTip() {
		return provaTip;
	}
	public void setProvaTip(int provaTip) {
		this.provaTip = provaTip;
	}
	public Date getProvaTar() {
		return provaTar;
	}
	public void setProvaTar(Date provaTar) {
		this.provaTar = provaTar;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	
	public ProvaTip getProvaTipEnm() {
		return provaTipEnm;
	}
	public void setProvaTipEnm(ProvaTip provaTipEnm) {
		this.provaTipEnm = provaTipEnm;
	}
	
	

}
