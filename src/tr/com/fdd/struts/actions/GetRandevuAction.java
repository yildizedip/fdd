package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaRandevuDTO;



public class GetRandevuAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session session, Connection conn,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans)
			throws Exception {

		String randevuTarihiBas = request.getParameter("baslangicTarihi");
		String randevuTarihiBit = request.getParameter("bitisTarihi");
		
		
		String protokolNo = request.getParameter("protokolNo");
		String ad = request.getParameter("ad");
		String page = request.getParameter("page");
		
		
		try {

			SQLUtils sqlUtils = new SQLUtils();

			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			

			List<THastaRandevuDTO> randevuListesi = sqlUtils.getRandevuList(conn, subeId, randevuTarihiBas, randevuTarihiBit,ad,	protokolNo);


			if (randevuListesi.size() > 0) {
				request.setAttribute("randevuListesi", randevuListesi);
			}
			
			if(page.equals("fromRandevu"))
				
				return mapping.findForward("randevu");
			else
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
		} 
		catch (Exception e) {
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
		}
		
		finally {
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
