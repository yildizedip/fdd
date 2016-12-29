package tr.com.fdd.struts.form;

import java.io.Serializable;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;


public class HastaRandevuForm extends ActionForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int id;
	private int hastaId;
	private Date randevuTarihi;
	private int randevuSaat;
	private int randevuDak;
	private int islem;
	private int doktorId;
	private String aciklama;
	private String durum;
	private Date eklenmeTarihi;
	private int ekleyenKisi;
	private String randevuTarihiStr;

	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
	
		ActionErrors errors= new ActionErrors();		
		ActionMessages messages= new ActionMessages();
		messages.add("message", new ActionMessage("Hata Oluþtu."));	
		String path=mapping.getPath();
		if("/hastaRandevuSorgula".equals(path))
		{
			
			if( randevuTarihiStr!=null && randevuTarihiStr.equals("")  )
			{
				request.setAttribute("warn", "Lütfen  randevu tarihini kontrol ediniz.");
				errors.add(messages);
			}			
			return errors;			
		}
		
		if( randevuTarihiStr!=null && randevuTarihiStr.equals("")  )
		{
			request.setAttribute("warn", "Lütfen  randevu tarihini kontrol ediniz.");
			errors.add(messages);
		}
		if( randevuSaat==0 )
		{
			
			request.setAttribute("warn", "Lütfen saati kontrol ediniz.");
			errors.add(messages);
		}
		if( randevuDak==0 )
		{
			
			request.setAttribute("warn", "Lütfen randevu saatini kontrol ediniz.");
			errors.add(messages);
		}

		if( islem==-1 )
		{
			
			request.setAttribute("warn", "Lütfen iþlem seçiniz.");
			errors.add(messages);
		}
		if( doktorId==-1 )
		{
			
			request.setAttribute("warn", "Lütfen doktor seçiniz.");
			errors.add(messages);
		}
 
		return errors;
		
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getHastaId() {
		return hastaId;
	}

	public void setHastaId(int hastaId) {
		this.hastaId = hastaId;
	}

	public Date getRandevuTarihi() {
		return randevuTarihi;
	}

	public void setRandevuTarihi(Date randevuTarihi) {
		this.randevuTarihi = randevuTarihi;
	}

	public int getRandevuSaat() {
		return randevuSaat;
	}

	public void setRandevuSaat(int randevuSaat) {
		this.randevuSaat = randevuSaat;
	}

	public int getRandevuDak() {
		return randevuDak;
	}

	public void setRandevuDak(int randevuDak) {
		this.randevuDak = randevuDak;
	}

	public int getIslem() {
		return islem;
	}

	public void setIslem(int islem) {
		this.islem = islem;
	}

	public int getDoktorId() {
		return doktorId;
	}

	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}

	public String getAciklama() {
		return aciklama;
	}

	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}

	public String getDurum() {
		return durum;
	}

	public void setDurum(String durum) {
		this.durum = durum;
	}

	public Date getEklenmeTarihi() {
		return eklenmeTarihi;
	}

	public void setEklenmeTarihi(Date eklenmeTarihi) {
		this.eklenmeTarihi = eklenmeTarihi;
	}

	public int getEkleyenKisi() {
		return ekleyenKisi;
	}

	public void setEkleyenKisi(int ekleyenKisi) {
		this.ekleyenKisi = ekleyenKisi;
	}

	public void setRandevuTarihiStr(String randevuTarihiStr) {
		this.randevuTarihiStr = randevuTarihiStr;
	}

	public String getRandevuTarihiStr() {
		return randevuTarihiStr;
	}

}
