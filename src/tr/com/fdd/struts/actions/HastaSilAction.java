package tr.com.fdd.struts.actions;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class HastaSilAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction tran)
			 {

		String hastaId = request.getParameter("id");
		int id = new Integer(hastaId).intValue();
	//	Transaction tran = null;
		try {
			tran = sess.beginTransaction();
			Query query = sess.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.id = :var");
			query.setInteger("var", new Integer(id).intValue());
			THastaDTO result = (THastaDTO) query.uniqueResult();
			result.setDurum("P");

			tran.commit();
			Commons.removeHastaFromHastaList(result, request);
			request.setAttribute("warn", GUIMessages.KAYIT_SILME_BASARILI);
			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GUIMessages.KAYIT_SILME_BASARISIZ);
			return mapping.findForward("exception");
		} finally {
			
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

}
