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

import tr.com.fdd.dto.TTurKodDTO;

public class GiderTuruGuncelleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String turId = request.getParameter("turId");
		String turAd = request.getParameter("turAd");
		String turKod = request.getParameter("turKod");
		Transaction tran = null;
		Session session = null;


		try {
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();


			Query query = session
					.createQuery("from tr.com.fdd.dto.TTurKodDTO  p "
							+ " where p.turId= :turId ");

			query.setInteger("turId", Integer.parseInt(turId));
		
				TTurKodDTO result = (TTurKodDTO) query.uniqueResult();
				result.setTurId(Integer.parseInt(turId));
				result.setTurAd(turAd);
				result.setTurKod(Integer.parseInt(turKod));
			
			tran.commit();

			       
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

		}finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}
	}

	

}
