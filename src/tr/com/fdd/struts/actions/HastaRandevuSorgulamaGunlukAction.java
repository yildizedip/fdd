package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.utils.Commons;

public class HastaRandevuSorgulamaGunlukAction extends Action {
	
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		String randevuBaslTarihStr=request.getParameter("randevuTarih");
		
		if(randevuBaslTarihStr==null) randevuBaslTarihStr= Commons.getToday();
		else{
			 String[] st=randevuBaslTarihStr.split("\\/");
			 
			 String dt=st[2]+"."+st[1]+"."+st[0];
			 randevuBaslTarihStr=dt;
		}
		
		
		String randevuBitisTarihStr= Commons.addDays(randevuBaslTarihStr, 1);
		
		Connection conn = DbConnection.getMySqlConneciton();
		try {
			
			SQLUtils sqlUtils = new SQLUtils();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			List<TDoktorDTO> doktorList4Randevu = sqlUtils.getDoktorList(conn, subeId, true, randevuBaslTarihStr,randevuBitisTarihStr);
			
			if (doktorList4Randevu.size() == 0) {
				request.setAttribute("noContent", "Kayıt Bulunamadı");
				return mapping.findForward("noContent");

			} else {
				request.setAttribute("doktorList4Randevu", doktorList4Randevu);
				 String[] st=randevuBaslTarihStr.split("\\.");
				 
				 String dt=st[2]+"/"+st[1]+"/"+st[0];
				
				request.setAttribute("randevuBaslTarihStr", dt);
				return mapping.findForward("success");
			}
			
			

		} catch (SQLException e) {
			
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

}
