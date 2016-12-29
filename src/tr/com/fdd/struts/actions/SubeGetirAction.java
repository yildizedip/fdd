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

import tr.com.fdd.dto.TSubeDTO;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;

public class SubeGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		SubeForm subeForm = (SubeForm) form;
		Connection connection = null;
		SQLUtils sqlUutil = new SQLUtils();
		try {
			connection = SQLUtils.getMySqlConneciton();
			// sube sorgulama icin kullaniliyor.
		
			List<TSubeDTO> subeList = sqlUutil.getSubeList(connection,	subeForm.getsAd());
			
			if(subeForm.getsId()!=0)
			{
			TSubeDTO sube= sqlUutil.getSubeBilgi(connection, subeForm.getsId());
			
			request.setAttribute("sube", sube);
			}
			
			if(subeList.size()==0){
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");
			}
			request.setAttribute("subeList", subeList);
			return mapping.findForward("success");
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("exception");
		}
		finally {
			try {
				connection.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}

	}

}
