package tr.com.fdd.struts.actions;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TLabrotuvarDTO;
import tr.com.fdd.mysql.DbConnection;

public class LaboratuvarRandevuVerPageOpenAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Connection connection=null;
		try {
			
			String labIslemIdStr= request.getParameter("id");
			
			connection= DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils= new SQLUtils();
			TLabrotuvarDTO labIslem = sqlUtils.getLabratuvarIslem(connection, Integer.parseInt(labIslemIdStr));
			request.setAttribute("labIslem", labIslem);
			
			return mapping.findForward("success");
		
		} catch (Exception e) {
			e.printStackTrace();
			connection.close();
			request.setAttribute("warn", e.getMessage());
			return mapping.findForward("exception");
		}
		finally{
			connection.close();			
		}
				
		
		
	}
	
}
