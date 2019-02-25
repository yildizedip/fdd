package tr.com.fdd.struts.form;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

/**
 * Kullanici login form
 * @author User
 *
 */
public class LoginForm  extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int kuloginId;
	private int kuBilgiId;
	private String userName;
	private String password;
	private String kuTur;
	private String ad;
	private String soyad;
	private String tel;
	private String adres;
	private String durum;
	private List<SubeForm> kuSubeList;
	private String giderKodu;
	private int subeId;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors errors= new ActionErrors();
		
		if(  (userName!=null && userName.equals("") )  
				|| (password!=null && password.equals(""))){
			ActionMessages messages= new ActionMessages();
			messages.add("login", new ActionMessage("L�tfen kullan�c� ad veya parola giriniz."));
			request.setAttribute("errorMessage", "L�tfen kullan�c� ad veya parola giriniz.");
			errors.add(messages);
			
		}	
		
		return errors;
	}
	public String getKuTur() {
		return kuTur;
	}
	public void setKuTur(String kuTur) {
		this.kuTur = kuTur;
	}
	public String getAd() {
		return ad;
	}
	public void setAd(String ad) {
		this.ad = ad;
	}
	public String getSoyad() {
		return soyad;
	}
	public void setSoyad(String soyad) {
		this.soyad = soyad;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public String getDurum() {
		return durum;
	}
	public void setDurum(String durum) {
		this.durum = durum;
	}
	public int getKuloginId() {
		return kuloginId;
	}
	public void setKuloginId(int kuloginId) {
		this.kuloginId = kuloginId;
	}
	public int getKuBilgiId() {
		return kuBilgiId;
	}
	public void setKuBilgiId(int kuBilgiId) {
		this.kuBilgiId = kuBilgiId;
	}
	public void setKuSubeList(List<SubeForm> kuSubeList) {
		this.kuSubeList = kuSubeList;
	}
	public List<SubeForm> getKuSubeList() {
		return kuSubeList;
	}
	public void setGiderKodu(String giderKodu) {
		this.giderKodu = giderKodu;
	}
	public String getGiderKodu() {
		return giderKodu;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	

}
