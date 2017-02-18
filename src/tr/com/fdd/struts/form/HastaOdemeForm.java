package tr.com.fdd.struts.form;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

public class HastaOdemeForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	
		private int hastaId;
		private Date odemeTarihi;
		private int odemeTuru;
		private double miktar;
		private double odenenMiktar;
		private double toplamMiktar;		
		private double kalanMiktar;
		private String aciklama;
		private String durumu;
		private Date eklenmeTarihi;
		private String odemeTarihiStr;		
		private int islemId;
		private int doktorId;
		public Date getOdemeTarihi() {
			return odemeTarihi;
		}
		public void setOdemeTarihi(Date odemeTarihi) {
			this.odemeTarihi = odemeTarihi;
		}
		public int getOdemeTuru() {
			return odemeTuru;
		}
		public void setOdemeTuru(int odemeTuru) {
			this.odemeTuru = odemeTuru;
		}
	
		
		public String getAciklama() {
			return aciklama;
		}
		public void setAciklama(String aciklama) {
			this.aciklama = aciklama;
		}
		public String getDurumu() {
			return durumu;
		}
		public void setDurumu(String durumu) {
			this.durumu = durumu;
		}
		public Date getEklenmeTarihi() {
			return eklenmeTarihi;
		}
		public void setEklenmeTarihi(Date eklenmeTarihi) {
			this.eklenmeTarihi = eklenmeTarihi;
		}
		public void setHastaId(int hastaId) {
			this.hastaId = hastaId;
		}
		public int getHastaId() {
			return hastaId;
		}
		public void setOdemeTarihiStr(String odemeTarihiStr) {
			this.odemeTarihiStr = odemeTarihiStr;
		}
		public String getOdemeTarihiStr() {
			return odemeTarihiStr;
		}
		
		public int getIslemId() {
			return islemId;
		}
		public void setIslemId(int islemId) {
			this.islemId = islemId;
		}
		public int getDoktorId() {
			return doktorId;
		}
		public void setDoktorId(int doktorId) {
			this.doktorId = doktorId;
		}
		
		
	
	@Override
	public ActionErrors validate(ActionMapping mapping,
		HttpServletRequest request) {

		ActionErrors errors= null;		
		errors= new ActionErrors();		
		if( kalanMiktar < 0 )
		{
				
			request.setAttribute("warn", "Kalan miktar negatif olamaz.");
			ActionMessages messages= new ActionMessages();
			messages.add("message", new ActionMessage("Hata Oluştu."));	
			errors.add(messages);
		}
//		if(  toplamMiktar==odenenMiktar)
//		{
//				
//			request.setAttribute("warn", "T�m �demeler ger�ekle�mi�tir.");
//			ActionMessages messages= new ActionMessages();
//			messages.add("message", new ActionMessage("Hata Olu�tu."));	
//			errors.add(messages);
//		}
	return errors;
	}
	public double getMiktar() {
		return miktar;
	}
	public void setMiktar(double miktar) {
		this.miktar = miktar;
	}
	public double getOdenenMiktar() {
		return odenenMiktar;
	}
	public void setOdenenMiktar(double odenenMiktar) {
		this.odenenMiktar = odenenMiktar;
	}
	public double getToplamMiktar() {
		return toplamMiktar;
	}
	public void setToplamMiktar(double toplamMiktar) {
		this.toplamMiktar = toplamMiktar;
	}
	public double getKalanMiktar() {
		return kalanMiktar;
	}
	public void setKalanMiktar(double kalanMiktar) {
		this.kalanMiktar = kalanMiktar;
	}
	
}
