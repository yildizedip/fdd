package tr.com.fdd.struts.form;

public class DoktorForm  extends LoginForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int dId;
	private int dmemberId;
	private String dBrans;
	private String dAd;
	private String dSoyad;
	
	
	public int getdId() {
		return dId;
	}
	public void setdId(int dId) {
		this.dId = dId;
	}
	public int getDmemberId() {
		return dmemberId;
	}
	public void setDmemberId(int dmemberId) {
		this.dmemberId = dmemberId;
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
	
	
	
}
