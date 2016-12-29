package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.DoktorForm;
import tr.com.fdd.utils.GUIMessages;

public class DoktorListesiGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		DoktorForm frm = (DoktorForm) form;
		Connection connection = null;
		SQLUtils sqlUtil = new SQLUtils();
		try {
			connection = SQLUtils.getMySqlConneciton();			
		
			List<DoktorForm> doktorList = sqlUtil.getDoktorList(connection,frm.getdAd());
			
			if(doktorList.size()==0){
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");
			}
			request.setAttribute("doktorList", doktorList);
			return mapping.findForward("success");
						
			
		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("exception");
		}
		finally{
			MysqlUtil.instance.closeConnection(connection);
		}

	}

}
