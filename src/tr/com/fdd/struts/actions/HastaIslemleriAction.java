package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaDTO;



public class HastaIslemleriAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session session, Connection conn,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans)
			throws Exception {

		
		try {

			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			
			SQLUtils sqlUtils = new SQLUtils();

			THastaDTO lastHasta = sqlUtils.getLastHasta(conn, subeId);


			if (lastHasta!=null) {
				request.setAttribute("lastHasta", lastHasta);
			}
			
			return mapping.findForward("success");

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
