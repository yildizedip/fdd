package tr.com.fdd.utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.struts.actions.SQLUtils;

public class Commons {

	private static Logger logger = LoggerFactory.getLogger(Commons.class);
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd"); 
	
	public static Date convertStringToDate(String dateStr ) throws ParseException
	{
		
	    Date convertedDate = null;
			convertedDate = dateFormat.parse(dateStr);
		
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
	
	//from session

	public static void removeHastaFromHastaList(THastaDTO hastaDTO, HttpServletRequest request){
		List<THastaDTO> hastaListesi = (List<THastaDTO>) request.getSession().getAttribute("hastaList");
		
		int index=-1;
		
		for (int i = 0; i < hastaListesi.size(); i++) {
			THastaDTO dto=hastaListesi.get(i);
			if(dto.getId()==hastaDTO.getId())
				index=i;
		}
		
		hastaListesi.remove(index);
	}
	
	public static void addHasta2HastaList(THastaDTO hastaDTO, HttpServletRequest request){
		List<THastaDTO> hastaListesi = (List<THastaDTO>) request.getSession().getAttribute("hastaList");
		if(hastaListesi!=null)		
		hastaListesi.add(hastaDTO);
	}	
	
	// from session
	public  static THastaDTO updateHastaFromHastaList(THastaDTO hastaDTO, HttpServletRequest request){
		List<THastaDTO> hastaListesi = (List<THastaDTO>) request.getSession().getAttribute("hastaList");
		THastaDTO tHastaDTO=null; 
		
		for (int i = 0; i < hastaListesi.size(); i++) {
			THastaDTO dto=hastaListesi.get(i);
			if(dto.getId()==hastaDTO.getId())
			{
				dto.setAd(hastaDTO.getAd());
				dto.setSoyad(hastaDTO.getSoyad());
				dto.setTckimlik(hastaDTO.getTckimlik());
				dto.setTel(hastaDTO.getTel());
				tHastaDTO=dto;
				break;
			}
		}
		return tHastaDTO;
	}	
	
	public static THastaDTO getActiveHasta( HttpServletRequest request){
		List<THastaDTO> hastaListesi = (List<THastaDTO>) request.getSession().getAttribute("hastaList");
		return hastaListesi.get(0);
		
	}
	
	public static void refreshSelectedHasta(HttpServletRequest request, Connection connection, int hastaId) throws SQLException{
		
		connection =SQLUtils.getMySqlConneciton();
		Integer subeId = (Integer) request.getSession().getAttribute("subeId");
		SQLUtils sqlUtils = new SQLUtils();
		
		THastaDTO hasta= sqlUtils.getHasta(hastaId, connection, subeId);
		
		// request and seesion update
		List<THastaDTO> hastaListesi= new ArrayList<THastaDTO>();
		hastaListesi.add(hasta);
		
		request.setAttribute("hastaListesi", hastaListesi);
	}
}
