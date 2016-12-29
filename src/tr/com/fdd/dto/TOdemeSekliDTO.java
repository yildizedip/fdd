package tr.com.fdd.dto;

import java.io.Serializable;

public class TOdemeSekliDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int kod;
	private String odemeSekli;
	public int getKod() {
		return kod;
	}
	public void setKod(int kod) {
		this.kod = kod;
	}
	public String getOdemeSekli() {
		return odemeSekli;
	}
	public void setOdemeSekli(String odemeSekli) {
		this.odemeSekli = odemeSekli;
	}
	
	
}
