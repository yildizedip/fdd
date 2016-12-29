package tr.com.fdd.dto;

import java.io.Serializable;
import java.util.List;

public class TMenuDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int ustMenuId;
	private String menuAd;
	private String menuPage;
	private String menuPath;
	private String durum;
	private List<TMenuDTO> subMenu;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUstMenuId() {
		return ustMenuId;
	}
	public void setUstMenuId(int ustMenuId) {
		this.ustMenuId = ustMenuId;
	}
	public String getMenuAd() {
		return menuAd;
	}
	public void setMenuAd(String menuAd) {
		this.menuAd = menuAd;
	}
	public String getMenuPage() {
		return menuPage;
	}
	public void setMenuPage(String menuPage) {
		this.menuPage = menuPage;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public void setMenuPath(String menuPath) {
		this.menuPath = menuPath;
	}
	public String getMenuPath() {
		return menuPath;
	}
	public void setSubMenu(List<TMenuDTO> subMenu) {
		this.subMenu = subMenu;
	}
	public List<TMenuDTO> getSubMenu() {
		return subMenu;
	}
	
	@Override
	public String toString() {
		
		return this.getMenuAd();
	}
}
