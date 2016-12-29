package tr.com.fdd.dto;

import java.io.Serializable;

public class TRolMenuDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int menuId;
	private int rolId;
	private String durum;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public int getRolId() {
		return rolId;
	}
	public void setRolId(int rolId) {
		this.rolId = rolId;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
}
