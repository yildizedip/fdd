package tr.com.fdd.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class GenelDegiskenler {

	public static String RANDEVU_EKLE = "1";
	public static String GELIR_EKLE = "2";
	public static String GUNCELLE = "3";
	public static String OPERASYON_EKLE = "4";
	public static String OPERASYON_LISTESI = "5";
	public static String GELIR_GORUNTULE = "6";
	public static String OPERASYON_GUNCELLE = "7";
	public static String OPERASYON_BITIR = "7";
	public static String LABROTUVAR_ISLEM = "8";
	public static String GET_GUNSONU_RAPORU = "10";
	public static String GET_GELIR_RAPORU = "11";
	public static String GET_GIDER_RAPOR = "12";
	public static String GET_GELIR_TURU_FOR_IMPLANT = "13";
	public static String LAB_ISLEM_ONAYLA_RED = "14";
	public static String LAB_ISLEM_DETAY_GOSTER = "15";
	public static String RANDEVU_GETIR = "randevu-getir";
	public static String RANDEVU_GETIR_HASTA_ISLEMLERI = "randevu-getir-hasta-islemleri";

	public static String OP_KESINLESMEMIS = "1";
	public static String OP_KESINLESMIS = "2";
	public static String OP_KESINLESMEMIS_ARAMA_KAYDI = "3";

	public static class KullaniciTurleri {
		public static String ADMIN = "1";
		public static String DOKTOR = "3";
		public static String SEKRETER = "4";
		public static String MUDUR = "2";
		public static String LABTEKNISYENI = "5";
		public static String DIS_HEKIMI = "Diş Hekimi";
		

	}

	public static String CONNECTIONSTRING_TEST = "jdbc:mysql://127.0.0.1:3306/dfdiscom_db?"
			+ "autoReconnect=true&useUnicode=true&characterEncoding=latin5";
	public static String USERNAME_TEST = "root";
	public static String PASSWORD_TEST = "danger";

	public static String CONNECTIONSTRING_GERCEK = "jdbc:mysql://176.9.128.172:3306/dfdiscom_db?"
			+ "autoReconnect=true&useUnicode=true&characterEncoding=latin5";
	public static String USERNAME_GERCEK = "dfdis";
	public static String PASSWORD_GERCEK = "danger";

	public static String CONNECTIONSTRING_GERCEK_TEST = "jdbc:mysql://176.9.128.172:3306/dfdiscom_test?"
			+ "autoReconnect=true&useUnicode=true&characterEncoding=latin5";
	public static String USERNAME_GERCEK_TEST = "tester";
	public static String PASSWORD_GERCEK_TEST = "danger";

	public ArrayList<String> getHours() {

		ArrayList<String> saatler = new ArrayList<String>();

		for (int i = 6; i < 25; i++) {
			saatler.add(new Integer(i).toString());
		}
		return saatler;

	}

	public ArrayList<String> getDakikalar(int devir) {
		ArrayList<String> dakikalar = new ArrayList<String>();
		int dakika = 0;
		for (int i = 0; i < 60 / devir; i++) {
			dakikalar.add(new Integer(dakika).toString());
			dakika = dakika + devir;

		}
		return dakikalar;

	}

	public boolean karakterVarmi(String ifade) {
		if (ifade == "")
			return true;
		if (ifade.contains("A") || ifade.contains("B") || ifade.contains("C")
				|| ifade.contains("Ç") || ifade.contains("D")
				|| ifade.contains("E") || ifade.contains("F")
				|| ifade.contains("G") || ifade.contains("Ğ")
				|| ifade.contains("H") || ifade.contains("I")
				|| ifade.contains("İ") || ifade.contains("J")
				|| ifade.contains("K") || ifade.contains("L")
				|| ifade.contains("M") || ifade.contains("N")
				|| ifade.contains("O") || ifade.contains("Ö")
				|| ifade.contains("P") || ifade.contains("R")
				|| ifade.contains("S") || ifade.contains("Ş")
				|| ifade.contains("T") || ifade.contains("U")
				|| ifade.contains("Ü") || ifade.contains("V")
				|| ifade.contains("Y") || ifade.contains("Z")
				|| ifade.contains("a") || ifade.contains("b")
				|| ifade.contains("c") || ifade.contains("ç")
				|| ifade.contains("d") || ifade.contains("e")
				|| ifade.contains("f") || ifade.contains("g")
				|| ifade.contains("ğ") || ifade.contains("h")
				|| ifade.contains("ı") || ifade.contains("i")
				|| ifade.contains("j") || ifade.contains("k")
				|| ifade.contains("l") || ifade.contains("m")
				|| ifade.contains("n") || ifade.contains("o")
				|| ifade.contains("ö") || ifade.contains("p")
				|| ifade.contains("r") || ifade.contains("s")
				|| ifade.contains("ş") || ifade.contains("t")
				|| ifade.contains("u") || ifade.contains("ü")
				|| ifade.contains("v") || ifade.contains("y")
				|| ifade.contains("z")) {
			return true;
		}

		return false;
	}

	public static String getGunlukTarih() {
		Date bugun = new Date();
		SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
		String gunlukTarih = sdff.format(bugun);
		return gunlukTarih;
	}

	public static class OperasyonTipleri {

		public static Integer IMPLANT = 24;
		public static Integer IMPLANT_USTU_OPERASYON = 43;
		public static Integer IMPLANT_DESTEK = 45;
		public static Integer IMPLANT_CERRAH = 46;

	}

	public static class DoktorTipleri {

		public static Integer DOKTOR_IMPLANT = 11;

	}

	public static class ReturnTypes {

		public static String FAILURE = "failure";
		public static String WARN = "warn";
		public static String SUCCESS = "success";
		public static String SUCCESS_KESINLESMEDI = "successKesinlesmedi";
		public static String GO_TO_IMPLANT_USTU_PROTEZ_PAGE = "gotoImplantUstuProtezPage";

	}
	public static class FormMessages {
		
		public static String ERROR = "Hata Oluştu.";
		public static String CHECK_RANDEVU_DATE = "Lütfen  randevu tarihini kontrol ediniz.";
		public static String SUCCESS = "İşlem Başarı ile Gerçekleştirildi. !!";
		public static String SUCCESS_KESINLESMEDI = "successKesinlesmedi";
		public static String GO_TO_IMPLANT_USTU_PROTEZ_PAGE = "gotoImplantUstuProtezPage";
		public static String SUCCESS_SADECE_HASTA = "Hasta Ekleme işlemi gerçekleştirildi. Tedavi bilgileri girilmediğinden ya da eksik olduğundan dolayı eklenmedi.";
		public static String SUCCESS_HASTA_GIR = "Hasta Bilgilerinde Eksiklik bulunmaktadır.";
		
	}

	public static class ImplantliOperasyon {
		public static Integer _VAR = 9999;
	}

}
