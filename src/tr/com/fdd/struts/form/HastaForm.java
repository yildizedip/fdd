package tr.com.fdd.struts.form;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.utils.GenelDegiskenler;



public class HastaForm extends ActionForm {
	
	private static Logger logger = LoggerFactory.getLogger(HastaForm.class);

	private static final long serialVersionUID = 1L;
	private String protokolNo;
	private String ad;
	private String soyad;
	private String tel;
	private String tckimlik;
	private String durum;
	private Date eklenmeTarihi;
	private String basTar;
	private String bitTar;
	private Date guncellenmeTarihi;
	private int subeId;
	private int doktorId;
	public String getProtokolNo() {
		return protokolNo;
	}
	public void setProtokolNo(String protokolNo) {
		this.protokolNo = protokolNo;
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
	
	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors errors= null;
		String path=mapping.getPath();
		
		logger.debug("Hasta Form Validation..Path:"+path);
		
		if("/hastaSorgula".equals(path)
				||"/hastaSorgulaForRandevu".equals(path)
				||"/HastaRandevuEkle".equals(path)
				||"/operasyonuKesinlesmemisHastaListesi".equals(path)
		||"/hastaBazliToplamOdemeListesi".equals(path)	
		||"/hastaAramaKaydiListGetir".equals(path)	
		||"/hastaSorgulaForHastaAnket".equals(path)	
		||"/hastaAnketList".equals(path)		
		||"/hastaBasicSorgula".equals(path)		
		)
		{
			return errors;
			
		}
		
		errors= new ActionErrors();
		GenelDegiskenler kontrol= new GenelDegiskenler();
		
		if( protokolNo!=null && (protokolNo.equals("") || kontrol.karakterVarmi(protokolNo)) )
		{
				
			request.setAttribute("warn", "Lutfen protokol no  kontrol ediniz.");
			ActionMessages messages= new ActionMessages();
			messages.add("message", new ActionMessage("Hata Olustu."));	
			errors.add(messages);
		}
		else if( ad!=null && (ad.equals("")) )
		{
			
			request.setAttribute("warn", "Lutfen adı kontrol ediniz.");
			ActionMessages messages= new ActionMessages();
			messages.add("message", new ActionMessage("Hata Olustu."));	
			errors.add(messages);
		}
		else if( soyad!=null && (soyad.equals("")) )
		{
			
			request.setAttribute("warn", "Lutfen soyadı kontrol ediniz.");
			ActionMessages messages= new ActionMessages();
			messages.add("message", new ActionMessage("Hata Olustu."));	
			errors.add(messages);
		}
		else return null;
		return errors;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTckimlik() {
		return tckimlik;
	}
	public void setTckimlik(String tckimlik) {
		this.tckimlik = tckimlik;
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
	public void setGuncellenmeTarihi(Date guncellenmeTarihi) {
		this.guncellenmeTarihi = guncellenmeTarihi;
	}
	public Date getGuncellenmeTarihi() {
		return guncellenmeTarihi;
	}
	public int getSubeId() {
		return subeId;
	}
	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	public void setBasTar(String basTar) {
		this.basTar = basTar;
	}
	public String getBasTar() {
		return basTar;
	}
	public void setBitTar(String bitTar) {
		this.bitTar = bitTar;
	}
	public String getBitTar() {
		return bitTar;
	}
	public int getDoktorId() {
		return doktorId;
	}
	public void setDoktorId(int doktorId) {
		this.doktorId = doktorId;
	}
	
}
