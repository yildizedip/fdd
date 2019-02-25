package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaBasicSorgulamaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		
		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			request.setCharacterEncoding("ISO-8859-9");
			String islemTip = request.getParameter("islem");
			
			String hastaprm = request.getParameter("term");
			String prt = request.getParameter("protokolNo");
			
			HastaForm hastaForm = (HastaForm) form;
			
			if(hastaprm!=null) {	
			
				String[] adsoyad= hastaprm.split(" ");
				
				if(adsoyad.length > 0)
				{
					String ad=adsoyad[0];
					hastaForm.setAd(ad);
					
					if(adsoyad.length >1) {
						
						String soyad=adsoyad[1];
						hastaForm.setSoyad(soyad);
					}
					if(adsoyad.length >2) {
						
						String protokol =adsoyad[2];
						hastaForm.setProtokolNo(protokol);
					}
				}
			}
			
			
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			SQLUtils sqlUtils = new SQLUtils();
			
			
			List<THastaDTO> hastaListesi = sqlUtils.getHastaList(conn, subeId, 
					hastaForm.getAd(),
					hastaForm.getSoyad(), 
					hastaForm.getProtokolNo(),hastaForm.getTel(), false);

			if (hastaListesi.size() == 0) {
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				//return mapping.findForward("noContent");

			}
			request.setAttribute("hastaList", hastaListesi);

			if (GenelDegiskenler.RANDEVU_EKLE.equals(islemTip))
				return mapping.findForward("randevuEkle");
			else if (GenelDegiskenler.GELIR_EKLE.equals(islemTip))
				return mapping.findForward("gelirEkle");
			else if (GenelDegiskenler.GUNCELLE.equals(islemTip))
				return mapping.findForward("guncelle");
			else if (GenelDegiskenler.OPERASYON_EKLE.equals(islemTip))
				return mapping.findForward("operasyonEkle");
			else if (GenelDegiskenler.OPERASYON_LISTESI.equals(islemTip))
				return mapping.findForward("operasyonListesi");
			else if (GenelDegiskenler.GELIR_GORUNTULE.equals(islemTip))
				return mapping.findForward("gelirGoruntule");
			else if (GenelDegiskenler.OPERASYON_BITIR.equals(islemTip))
				return mapping.findForward("operasyonBitir");
			else if (GenelDegiskenler.LABROTUVAR_ISLEM.equals(islemTip))
				return mapping.findForward("labrotuvarEkle");
			else if ("randevu".equals(islemTip)){
				
				
				String doktorId = request.getParameter("doktorId");
				String randevuBasTar = request.getParameter("randevuBasTar");
				String randevuBitTar = request.getParameter("randevuBitTar");
				
				
//				List<THastaDTO> hastaListesiRandevu=sqlUtils.getDoktorHastaListesi(conn, subeId, Integer.parseInt(doktorId), hastaForm.getAd(),
//						hastaForm.getSoyad(), 
//						hastaForm.getProtokolNo());
				
//				if (hastaListesi.size() == 0) {
//					request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
//					return mapping.findForward("noContent");
//
//				}
		//		request.setAttribute("hastaList", hastaListesiRandevu); sadece secilen doktora iliskiin  hasta gelir
				TDoktorDTO doktorDTO= new TDoktorDTO();
				doktorDTO.setdId(Integer.parseInt(doktorId));
				request.setAttribute("selectedDoctor", doktorDTO);
				request.setAttribute("doktorId", doktorId);
				request.setAttribute("randevuBitTar", randevuBitTar);
				request.setAttribute("randevuBasTar", randevuBasTar);
				
//				JSONObject returnObject = new JSONObject();
//				
//				returnObject.put("aaa", "aaaa");
//				request.setAttribute("jsonObj", returnObject);
				
				
				return mapping.findForward("randevu");
				
				}
			else {
				
				String json = null;
		        
		        try {
		        	
	
		            json = new ObjectMapper().writeValueAsString(hastaListesi);
		            response.setCharacterEncoding("UTF-8");
		            response.setContentType("application/json");
		            response.getWriter().print(json);
		            
		        } catch (JsonProcessingException ex) {
		        	
		        	ex.printStackTrace();
		        }
				
				return null;
				//return mapping.findForward("success");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}

	}

}
