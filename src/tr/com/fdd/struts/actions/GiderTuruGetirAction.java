package tr.com.fdd.struts.actions;

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

import tr.com.fdd.dto.TTurKodDTO;

public class GiderTuruGetirAction extends Action {

	@SuppressWarnings("unchecked")
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		
		
		
		Transaction tran = null;
		Session session = null;

		try {
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			String turId = request.getParameter("turId");
			Query queryLogin = session
					.createQuery("from tr.com.fdd.dto.TTurKodDTO  p "
							+ " where p.turId= :turId ");

			queryLogin.setInteger("turId",Integer.parseInt(turId));
		
			List<TTurKodDTO> result = queryLogin.list();
			tran.commit();
			request.setAttribute("giderTur", result.get(0));
			
			       
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("exception");

		}  finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}
	}

	

}
