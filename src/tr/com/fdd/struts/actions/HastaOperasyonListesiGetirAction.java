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

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaOperasyonListesiGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String hastaId = request.getParameter("id");
		String tip = request.getParameter("type");

		Connection conn = null;
		try {

			SQLUtils sqlUtils = new SQLUtils();
			conn = SQLUtils.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			THastaDTO hasta = sqlUtils.getHasta(
					new Integer(hastaId).intValue(), conn, subeId.intValue());

//			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
//					.getHastaOperasyonListesiGoruntule(hasta.getId(), conn);
			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
					.getHastaOperasyonOdemeListesi(hasta.getId(), conn);
			
			setLabratuvarListToOperasyonList(hastaOperasyonListesi,sqlUtils, conn);

			request.setAttribute("hasta", hasta);
			if (hastaOperasyonListesi.size() == 0) {
				request.setAttribute("noContent", "Kayýt Bulunamadý");
				return mapping.findForward("noContent");

			} else {

				request.setAttribute("hastaOperasyonListesi",
						hastaOperasyonListesi);
				if (GenelDegiskenler.GELIR_GORUNTULE.equals(tip)) {
					return mapping.findForward("operasyonListForOdeme");
				}
				else if(GenelDegiskenler.GELIR_EKLE.equals(tip))
				{
					
					return mapping.findForward("operasyonListForOdemeEkle");
				}
				else if(GenelDegiskenler.LABROTUVAR_ISLEM.equals(tip)){
					
					
					
					return mapping.findForward("labrotuvarIslem");
				}
				else
					return mapping.findForward("success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
				conn.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
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

	private void setLabratuvarListToOperasyonList(
			List<TIslemDTO> hastaOperasyonListesi, SQLUtils sqlUtils, Connection conn) throws SQLException {
		
		
		for (int i = 0; i <hastaOperasyonListesi.size(); i++) {
			
			TIslemDTO dto= hastaOperasyonListesi.get(i);
			dto.setLabratuvarList(sqlUtils.getOperasyonLabratuvarIslemList(conn, dto.getId()));
		}
		
	}

}
