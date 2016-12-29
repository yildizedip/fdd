package tr.com.fdd.struts.form;

import java.util.Date;

import org.apache.struts.action.ActionForm;



public class IslemForm extends ActionForm {
	
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private int hastaId;
	    private int islemId;
		private Date islemTarihi;
		private Date islemTarihiImpl;
		private Date islemBitisTarihi;
		private int doktorId;
		private int islemTipi;
		private double miktar;
		private double kalanMiktar;	
		private String aciklama;
		private String durumu;
		private Date eklenmeTarihi;
		
		private String islemTarihiStr;
		
		private String islemTarihiImplStr;
		
		private String islemBitisTarihiStr;
		private int iliskiliIslemId;
//		private double implantUcret;
//		private double implantProtezUcret;
		private int implantCerrahId;
		private int implantBaglayanDoktorId;
		private int disAdet;
		
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
		public Date getIslemTarihi() {
			return islemTarihi;
		}
		public void setIslemTarihi(Date islemTarihi) {
			this.islemTarihi = islemTarihi;
		}
		public int getDoktorId() {
			return doktorId;
		}
		public void setDoktorId(int doktorId) {
			this.doktorId = doktorId;
		}
		public String getIslemTarihiStr() {
			return islemTarihiStr;
		}
		public void setIslemTarihiStr(String islemTarihiStr) {
			this.islemTarihiStr = islemTarihiStr;
		}
		public void setIslemTipi(int islemTipi) {
			this.islemTipi = islemTipi;
		}
		public int getIslemTipi() {
			return islemTipi;
		}
		public void setMiktar(double miktar) {
			this.miktar = miktar;
		}
		public double getMiktar() {
			return miktar;
		}
		public void setKalanMiktar(double kalanMiktar) {
			this.kalanMiktar = kalanMiktar;
		}
		public double getKalanMiktar() {
			return kalanMiktar;
		}
		public void setIslemId(int islemId) {
			this.islemId = islemId;
		}
		public int getIslemId() {
			return islemId;
		}
		public void setIslemBitisTarihiStr(String islemBitisTarihiStr) {
			this.islemBitisTarihiStr = islemBitisTarihiStr;
		}
		public String getIslemBitisTarihiStr() {
			return islemBitisTarihiStr;
		}
		public void setIslemBitisTarihi(Date islemBitisTarihi) {
			this.islemBitisTarihi = islemBitisTarihi;
		}
		public Date getIslemBitisTarihi() {
			return islemBitisTarihi;
		}
//		public double getImplantUcret() {
//			return implantUcret;
//		}
//		public void setImplantUcret(double implantUcret) {
//			this.implantUcret = implantUcret;
//		}
//		public double getImplantProtezUcret() {
//			return implantProtezUcret;
//		}
//		public void setImplantProtezUcret(double implantProtezUcret) {
//			this.implantProtezUcret = implantProtezUcret;
//		}
//		public int getImplantCerrahId() {
//			return implantCerrahId;
//		}
//		public void setImplantCerrahId(int implantCerrahId) {
//			this.implantCerrahId = implantCerrahId;
//		}
//		public int getImplantAdet() {
//			return implantAdet;
//		}
//		public void setImplantAdet(int implantAdet) {
//			this.implantAdet = implantAdet;
//		}

		public void setIliskiliIslemId(int iliskiliIslemId) {
			this.iliskiliIslemId = iliskiliIslemId;
		}
		public int getIliskiliIslemId() {
			return iliskiliIslemId;
		}
	
		public void setImplantBaglayanDoktorId(int implantBaglayanDoktorId) {
			this.implantBaglayanDoktorId = implantBaglayanDoktorId;
		}
		public int getImplantBaglayanDoktorId() {
			return implantBaglayanDoktorId;
		}
		public void setImplantCerrahId(int implantCerrahId) {
			this.implantCerrahId = implantCerrahId;
		}
		public int getImplantCerrahId() {
			return implantCerrahId;
		}
		public int getDisAdet() {
			return disAdet;
		}
		public void setDisAdet(int disAdet) {
			this.disAdet = disAdet;
		}
		public void setIslemTarihiImplStr(String islemTarihiImplStr) {
			this.islemTarihiImplStr = islemTarihiImplStr;
		}
		public String getIslemTarihiImplStr() {
			return islemTarihiImplStr;
		}
		public void setIslemTarihiImpl(Date islemTarihiImpl) {
			this.islemTarihiImpl = islemTarihiImpl;
		}
		public Date getIslemTarihiImpl() {
			return islemTarihiImpl;
		}
	
	
}
