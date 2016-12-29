package tr.com.fdd.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;

public class Commons {

	private static Logger logger = LoggerFactory.getLogger(Commons.class);
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd"); 
	
	public static Date convertStringToDate(String dateStr )
	{
		
	    Date convertedDate = null;
		try {
			convertedDate = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			
			e.printStackTrace();
		} 
	    return convertedDate;
	}
	
	
	
	public double getToplamOdemeMiktari(List<THastaOdemeDTO> list) {

		double sum = 0;
		for (int i = 0; i < list.size(); i++) {
			THastaOdemeDTO odeme = list.get(i);
			sum += odeme.getMiktar();

		}
		return sum;

	}

	public double getToplamKalanMiktar(List<THastaOdemeDTO> list) {
		
		logger.info("Commons getToplamKalanMiktar list size : "+list.size());

		double sum = 0;
		for (int i = 0; i < list.size(); i++) {
			THastaOdemeDTO odeme = list.get(i);
			sum += odeme.getKalanMiktar();

		}
		return sum;

	}

	public double getToplamUcret(List<THastaOdemeDTO> list) {

		double sum = 0;
		for (int i = 0; i < list.size(); i++) {
			THastaOdemeDTO odeme = list.get(i);
			sum += odeme.getUcret();

		}
		return sum;

	}
	public static TKullaniciLoginDTO getActiveSession(HttpServletRequest request) {
		HttpSession httpSession=request.getSession();
		Object[] sessionsArr=(Object[])httpSession.getAttribute("sessionMember");
		TKullaniciLoginDTO dto= ((TKullaniciLoginDTO)sessionsArr[0]);
		return dto;
	}
}
