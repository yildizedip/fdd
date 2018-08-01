package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.DoktorForm;

public class DoktorSubeGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		DoktorForm frm = (DoktorForm) form;
		Connection connection = null;
		SQLUtils sqlUtil = new SQLUtils();
		try {
			connection = DbConnection.getMySqlConneciton();

			List<DoktorForm> doktorList = sqlUtil.getDoktorList(connection,
					frm.getdAd());

			
			request.setAttribute("doktorList", doktorList);

			TDoktorDTO dto = sqlUtil.getDoktor(frm.getDmemberId(),-1, connection,false,-1,null,null);

			request.setAttribute("doktor", dto);
			return mapping.findForward("success");

		} catch (Exception e) {
			e.printStackTrace();
			return mapping.findForward("exception");
		} finally {
			connection.close();
		}
	}
}
