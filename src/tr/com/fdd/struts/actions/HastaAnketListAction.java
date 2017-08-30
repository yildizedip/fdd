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

import tr.com.fdd.dto.TAnketDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.HastaForm;

public class HastaAnketListAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();			
			HastaForm hastaForm= (HastaForm) form;
			
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			SQLUtils sqlUtils = new SQLUtils();
			
			List<TAnketDTO> anketListesi = sqlUtils
					.hastaAnketListesiGetir(conn,
							subeId.intValue(), 
							hastaForm.getProtokolNo(), 
							hastaForm.getAd(), hastaForm.getSoyad(),
							hastaForm.getBasTar(),hastaForm.getBitTar());

			if (anketListesi.size() == 0) {
				request.setAttribute("warn", "Kay�t Bulunamad�");
				return mapping.findForward("noContent");
			} else {
				request.setAttribute("anketListesi",	anketListesi);
				return mapping.findForward("success");
			}

		}
		catch (Exception e) {
			try {
				if(conn!=null){
				conn.rollback();
				conn.close();
				}
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
				MysqlUtil.instance.closeConnection(conn);
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}

}
