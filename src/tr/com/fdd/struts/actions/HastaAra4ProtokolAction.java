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

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaAra4ProtokolAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		
		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			request.setCharacterEncoding("ISO-8859-9");
			
			String hastaprm = request.getParameter("term");
			
			HastaForm hastaForm = (HastaForm) form;
			
			hastaForm.setProtokolNo(hastaprm);
			
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
