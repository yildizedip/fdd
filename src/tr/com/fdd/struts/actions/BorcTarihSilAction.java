package tr.com.fdd.struts.actions;

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

import tr.com.fdd.dto.TAnketDTO;
import tr.com.fdd.dto.THastaIslemBorcTakipDTO;

public class BorcTarihSilAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Session sess = null;
		Transaction tran = null;
		try {
			
			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();

			String borcId = request.getParameter("id");
			int id = new Integer(borcId).intValue();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.THastaIslemBorcTakipDTO  p where p.id = :var");
			query.setInteger("var", id);
			THastaIslemBorcTakipDTO result = (THastaIslemBorcTakipDTO) query.uniqueResult();
			result.setDurum("P");

			tran.commit();

			request.setAttribute("warn",  " Kay�t ba�ar� ile silinmistir.");

			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kay�t Silme ��leminde Hata Olu�tu.");
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
