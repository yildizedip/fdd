package tr.com.fdd.struts.form;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import tr.com.fdd.utils.GenelDegiskenler;

public class GelirGiderForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String miktar;
	private String aciklama;	
	private Date tarih;
	private Date basTarih;
	private Date bitTar;
	private int girenKisi;
	private int tip;
	private int doktor;
	private String giderTuru;
	private String odemeSekli;
	private String paraBirimi;	
	private String tarihStr;
	private String durum;
	private int subeId;
	
	
	
	@Override
	public ActionErrors validate(ActionMapping mapping,
			HttpServletRequest request) {
		ActionErrors errors= new ActionErrors();
		GenelDegiskenler kontrol= new GenelDegiskenler();
		if( miktar!=null && (miktar.equals("") ||   kontrol.karakterVarmi(miktar)) )
		{
			ActionMessages messages= new ActionMessages();
			messages.add("addGider", new ActionMessage("Miktar alanýný kontrol ediniz."));
			request.setAttribute("addGelirMesaj", "Lütfen Miktar alanýný kontrol ediniz.");
			request.setAttribute("warn", "Lütfen Miktar alanýný kontrol ediniz.");
			errors.add(messages);
		}	
		
		
		return errors;
	}
	
	
	
	public String getMiktar() {
		return miktar;
	}
	public void setMiktar(String miktar) {
		this.miktar = miktar;
	}
	public String getAciklama() {
		return aciklama;
	}
	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}


	public Date getTarih() {
		return tarih;
	}


	public void setTarih(Date tarih) {
		this.tarih = tarih;
	}


	public int getGirenKisi() {
		return girenKisi;
	}


	public void setGirenKisi(int girenKisi) {
		this.girenKisi = girenKisi;
	}


	public int getTip() {
		return tip;
	}


	public void setTip(int tip) {
		this.tip = tip;
	}


	public void setDoktor(int doktor) {
		this.doktor = doktor;
	}


	public int getDoktor() {
		return doktor;
	}


	public Date getBasTarih() {
		return basTarih;
	}


	public void setBasTarih(Date basTarih) {
		this.basTarih = basTarih;
	}


	public Date getBitTar() {
		return bitTar;
	}


	public void setBitTar(Date bitTar) {
		this.bitTar = bitTar;
	}


	public String getGiderTuru() {
		return giderTuru;
	}


	public void setGiderTuru(String giderTuru) {
		this.giderTuru = giderTuru;
	}


	public String getOdemeSekli() {
		return odemeSekli;
	}


	public void setOdemeSekli(String odemeSekli) {
		this.odemeSekli = odemeSekli;
	}


	public void setParaBirimi(String paraBirimi) {
		this.paraBirimi = paraBirimi;
	}


	public String getParaBirimi() {
		return paraBirimi;
	}


	public void setTarihStr(String tarihStr) {
		this.tarihStr = tarihStr;
	}


	public String getTarihStr() {
		return tarihStr;
	}


	public void setDurum(String durum) {
		this.durum = durum;
	}


	public String getDurum() {
		return durum;
	}



	public int getSubeId() {
		return subeId;
	}



	public void setSubeId(int subeId) {
		this.subeId = subeId;
	}
	
}
