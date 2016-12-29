package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;

public class HastaSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String hastaId = request.getParameter("id");
		int id = new Integer(hastaId).intValue();
		Session sess = null;
		Transaction tran = null;
		Connection conn = null;
		try {
			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();

			Query query = sess.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.id = :var");
			query.setInteger("var", new Integer(id).intValue());
			THastaDTO result = (THastaDTO) query.uniqueResult();
			result.setDurum("P");

			tran.commit();

			request.setAttribute("warn", id + "nolu kayit  silinmistir.");

			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			conn = SQLUtils.getMySqlConneciton();
			SQLUtils sqlUtils = new SQLUtils();
			List<THastaDTO> hastaListesi = sqlUtils.getHastaListesi(null, null,
					null, conn, subeId.intValue(), null, null, null);

			// request.setAttribute("hastaListesi", hastaListesi);
			request.setAttribute("hastaListesi", hastaListesi);

			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
			return mapping.findForward("exception");
		} finally {
			conn.close();
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

}
