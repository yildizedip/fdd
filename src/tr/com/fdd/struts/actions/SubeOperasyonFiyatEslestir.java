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

import tr.com.fdd.dto.TIslemTipDTO;
import tr.com.fdd.mysql.DbConnection;

public class SubeOperasyonFiyatEslestir extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			String subeIdStr=request.getParameter("subeId");
			Integer subeId=null;
			
			if(subeIdStr==null){
				
				subeId = (Integer) request.getSession().getAttribute("subeId");
			} else{
				subeId=Integer.parseInt(subeIdStr);
			}
			
			
			SQLUtils sqlUtils= new SQLUtils();
			
			 conn = DbConnection.getMySqlConneciton();
			 List<TIslemTipDTO> islemTurList= sqlUtils.getOperasyonTurList(conn,subeId);
			 request.setAttribute("islemTurListesi", islemTurList);
			 request.getSession().setAttribute("selectedSubeId", subeId);

			return mapping.findForward("success");
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

}
