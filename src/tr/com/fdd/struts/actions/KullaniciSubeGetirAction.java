package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.struts.form.SubeForm;
import tr.com.fdd.utils.GUIMessages;

public class KullaniciSubeGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		LoginForm frm = (LoginForm) form;
		Connection connection = null;
		SQLUtils sqlUtil = new SQLUtils();
		try {
			connection = DbConnection.getMySqlConneciton();
			// sube sorgulama icin kullaniliyor.
		
			List<LoginForm>  kullaniciList= sqlUtil.getKullaniciList(connection, "");	
			request.setAttribute("kullaniciList", kullaniciList);
			
			LoginForm loginForm=sqlUtil.getKullanici(connection, frm.getKuloginId());
			
			List<SubeForm> kullaniciSubeList = sqlUtil.getKullaniciSubeList(connection,frm.getKuloginId());
		
			loginForm.setKuSubeList(kullaniciSubeList);
			
			if(kullaniciSubeList.size()==0){
				request.setAttribute("noContent", GUIMessages.VERI_BULUNAMADI);
				return mapping.findForward("noContent");
			}
			request.setAttribute("kullaniciSubeList", loginForm);
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
