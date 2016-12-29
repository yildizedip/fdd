package tr.com.fdd.struts.actions;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class GetGiderGelirTurleriAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String tur = (String) request.getAttribute("gelirGiderTur");
		
		Session session =null;
		try {
			// hibernate session
			session= GenericAction.getHibernateSession();

			String hSQL = "from tr.com.fdd.dto.TTurKodDTO as a where "
					+ "a.turTip = :p_tip ";

			Query que = session.createQuery(hSQL);

			que.setInteger("p_tip", new Integer(tur));

			List<?> result = que.list();

			if (result.size() > 0) {
				request.setAttribute("turKodlari", result);
				return mapping.findForward("success");

			} else {
				request.setAttribute("noContent", "Kayýt Bulunamadý");
				return mapping.findForward("noContent");
			}

		} catch (Exception e) {
			request.setAttribute("exception",
					e.getMessage() + "" + e.getLocalizedMessage());
			return mapping.findForward("exception");
		}
		finally {
			if (session != null && session.isOpen())
				try {
					session.close();
					return mapping.findForward("failure");
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
				else return mapping.findForward("failure");
		}

	}
}
