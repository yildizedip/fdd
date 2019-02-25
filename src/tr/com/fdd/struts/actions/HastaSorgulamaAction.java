package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaSorgulamaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			request.setCharacterEncoding("ISO-8859-9");
			String islemTip = request.getParameter("islem");
			String hastaId = request.getParameter("hastaId");
			String doktorId = request.getParameter("doktorId");
			String islemId = request.getParameter("islemId");
			
			
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			SQLUtils sqlUtils = new SQLUtils();
			THastaDTO hasta= sqlUtils.getHasta(Integer.parseInt(hastaId), conn, subeId);
			
			
//			List<THastaDTO> hastaListesi = sqlUtils.getHastaListesi(
//					hastaForm.getAd(), hastaForm.getSoyad(),
//					hastaForm.getProtokolNo(), conn, subeId.intValue(),
//					hastaForm.getBasTar(), hastaForm.getBitTar(), hastaForm.getTel());
//
//			if (hastaListesi.size() == 0) {
//				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
//				return mapping.findForward("noContent");
//
//			}
			response.setContentType("text/html");
			
			
			//request.setAttribute("hasta", hasta);
			
			if(GenelDegiskenler.RANDEVU_GETIR.equals(islemTip) || GenelDegiskenler.RANDEVU_GETIR_HASTA_ISLEMLERI.equals(islemTip) ){
				
				String today=Commons.getToday();
				
				String randevuBaslTarihStr= Commons.minusDays(today, 7);
				
				String randevuBitisTarihStr= Commons.addDays(today, 60);
				
				TDoktorDTO doktorDTO=sqlUtils.getDoktor(-1,Integer.parseInt(doktorId), conn, true,subeId,randevuBaslTarihStr,randevuBitisTarihStr);

				TIslemDTO randevuTedavi= null;
				
				if(islemId!=null){
				for (TIslemDTO tedavi : hasta.getHastaOperasyonList()) {
					if(tedavi.getId()==Integer.parseInt(islemId)){
						randevuTedavi=tedavi;
						break;
					}
				}
				request.setAttribute("randevuTedavi", randevuTedavi);
				}
				request.setAttribute("selectedDoctor", doktorDTO);
				
				
				List<TIslemDTO> hastaSelectedDoktorOperasyonList= new ArrayList<TIslemDTO>();
				
				for (TIslemDTO tedavi : hasta.getHastaOperasyonList()) {
					if(tedavi.getDoktorId()==doktorDTO.getdId()){
						
						hastaSelectedDoktorOperasyonList.add(tedavi);
					}
				}
				
				hasta.setHastaSelectedDoktorOperasyonList(hastaSelectedDoktorOperasyonList);
				
				String randevuBasTar = request.getParameter("randevuBasTar");
				String randevuBitTar = request.getParameter("randevuBitTar");
				String randevuAciklama = request.getParameter("randevuAciklama");
				
				request.setAttribute("randevuBasTar", randevuBasTar);
				request.setAttribute("randevuBitTar", randevuBitTar);
				request.setAttribute("randevuAciklama", randevuAciklama);
				
			}

			
			List<THastaDTO> hastaListesi= new ArrayList<THastaDTO>();
			hastaListesi.add(hasta);
			
			request.setAttribute("hastaListesi", hastaListesi);
			request.setAttribute("lastHasta", hasta);
			
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
			else if (GenelDegiskenler.RANDEVU_GETIR.equals(islemTip)){
					request.setAttribute("actionTip", 2);
					return mapping.findForward("randevu");
			}
			else if (GenelDegiskenler.RANDEVU_GETIR_HASTA_ISLEMLERI.equals(islemTip)){
				request.setAttribute("actionTip", 1);
				return mapping.findForward("randevu");
			}
			else
				return mapping.findForward("success");
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
