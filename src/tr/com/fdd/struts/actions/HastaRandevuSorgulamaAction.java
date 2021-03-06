package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.utils.Commons;

public class HastaRandevuSorgulamaAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = DbConnection.getMySqlConneciton();
		
		
		try {
			String doktorId= request.getParameter("doktor");
			SQLUtils sqlUtils = new SQLUtils();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			
			String today=Commons.getToday();
			
			String randevuBaslTarihStr= Commons.minusDays(today, 7);
			
			String randevuBitisTarihStr= Commons.addDays(today, 300);
			
			TDoktorDTO doktorDTO=sqlUtils.getDoktor(-1,Integer.parseInt(doktorId), conn, true,subeId,randevuBaslTarihStr,randevuBitisTarihStr);

//			List<THastaRandevuDTO> randevuListesi = sqlUtils.getRandevuListesi(
//					conn, subeId.intValue(), Integer.parseInt(doktorId)); // no doktor 
//
//		
//				request.setAttribute("randevuList", randevuListesi); 
				request.setAttribute("selectedDoctor", doktorDTO);
				
				return mapping.findForward("success");

		} catch (SQLException e) {
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

}
