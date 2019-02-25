package tr.com.fdd.struts.form;

import java.io.Serializable;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import tr.com.fdd.utils.GenelDegiskenler;


public class HastaRandevuForm extends ActionForm implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int id;
	private int hastaId;
	private Date randevuTarihi;
	private int islemId;
	private int doktorId;
	private String aciklama;
	private String durum;
	private Date eklenmeTarihi;
	private int ekleyenKisi;
	private String randevuTarihiBaslangic;
	private String randevuTarihiBitis;
	private String hastaAd;
	private String hastaSoyad;
	private String telefon;
	private String randevuyaGelinmedi;
	private String randevuBosSaatAktif;
	private Integer beklenenOdeme;

	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
	
		ActionErrors errors= new ActionErrors();		
		ActionMessages messages= new ActionMessages();
		messages.add("message", new ActionMessage(GenelDegiskenler.FormMessages.ERROR));	
		String path=mapping.getPath();
//		if("/hastaRandevuSorgula".equals(path))
//		{
//			
//			if( randevuTarihiStr!=null && randevuTarihiStr.equals("")  )
//			{
//				request.setAttribute("warn", GenelDegiskenler.FormMessages.CHECK_RANDEVU_DATE);
//				errors.add(messages);
//			}			
//			return errors;			
//		}
		
//		if( randevuTarihiStr!=null && randevuTarihiStr.equals("")  )
//		{
//			request.setAttribute("warn", "Lütfen  randevu tarihini kontrol ediniz.");
//			errors.add(messages);
//		}
//		if( randevuSaat==0 )
//		{
//			
//			request.setAttribute("warn", "Lütfen saati kontrol ediniz.");
//			errors.add(messages);
//		}
//		if( randevuDak==0 )
//		{
//			
//			request.setAttribute("warn", "Lütfen randevu saatini kontrol ediniz.");
//			errors.add(messages);
//		}

//		if( islem==-1 )
//		{
//			
//			request.setAttribute("warn", "L�tfen i�lem se�iniz.");
//			errors.add(messages);
//		}
//		if( doktorId==-1 )
//		{
//			
//			request.setAttribute("warn", "Lutfen doktor se�iniz.");
//			errors.add(messages);
//		}
 
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

	public String getRandevuTarihiBaslangic() {
		return randevuTarihiBaslangic;
	}

	public void setRandevuTarihiBaslangic(String randevuTarihiBaslangic) {
		this.randevuTarihiBaslangic = randevuTarihiBaslangic;
	}

	public String getRandevuTarihiBitis() {
		return randevuTarihiBitis;
	}

	public void setRandevuTarihiBitis(String randevuTarihiBitis) {
		this.randevuTarihiBitis = randevuTarihiBitis;
	}

	
	public String getTelefon() {
		return telefon;
	}

	public void setTelefon(String telefon) {
		this.telefon = telefon;
	}

	public String getHastaAd() {
		return hastaAd;
	}

	public void setHastaAd(String hastaAd) {
		this.hastaAd = hastaAd;
	}

	public String getHastaSoyad() {
		return hastaSoyad;
	}

	public void setHastaSoyad(String hastaSoyad) {
		this.hastaSoyad = hastaSoyad;
	}

	public String getRandevuyaGelinmedi() {
		return randevuyaGelinmedi;
	}

	public void setRandevuyaGelinmedi(String randevuyaGelinmedi) {
		this.randevuyaGelinmedi = randevuyaGelinmedi;
	}

	public int getIslemId() {
		return islemId;
	}

	public void setIslemId(int islemId) {
		this.islemId = islemId;
	}

	public String getRandevuBosSaatAktif() {
		return randevuBosSaatAktif;
	}

	public void setRandevuBosSaatAktif(String randevuBosSaatAktif) {
		this.randevuBosSaatAktif = randevuBosSaatAktif;
	}

	public Integer getBeklenenOdeme() {
		return beklenenOdeme;
	}

	public void setBeklenenOdeme(Integer beklenenOdeme) {
		this.beklenenOdeme = beklenenOdeme;
	}


}
