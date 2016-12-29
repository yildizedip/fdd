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
import tr.com.fdd.utils.GUIMessages;

public class GiderTuruEkleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String turAd = request.getParameter("turAd");
		String turKod = request.getParameter("turKod");
		Transaction tran = null;
		Session session = null;

		TTurKodDTO dto = new TTurKodDTO();

		try {
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();

			dto.setTurAd(turAd);
			dto.setTurKod(Integer.parseInt(turKod));
			dto.setTurTip(1);
			dto.setTurDurum("A");

			Query queryLogin = session
					.createQuery("from tr.com.fdd.dto.TTurKodDTO  p "
							+ " where p.turAd= :turAd order by p.turId ");

			queryLogin.setString("turAd", dto.getTurAd());
		
			@SuppressWarnings("unchecked")
			List<TTurKodDTO> result = queryLogin.list();
			
			if (result.size() != 0) {

				request.setAttribute("warn", GUIMessages.KAYIT_VAR);
				return mapping.findForward("exception");
			} else {
				session.save(dto);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);

			}
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

		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}
	}

	

}
