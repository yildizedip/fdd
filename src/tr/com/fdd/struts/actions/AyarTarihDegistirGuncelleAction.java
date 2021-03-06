package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TAyarDTO;
import tr.com.fdd.dto.TIslemTipDTO;
import tr.com.fdd.dto.TIslemTipSubeDTO;
import tr.com.fdd.utils.GUIMessages;

public class AyarTarihDegistirGuncelleAction extends GenericAction {

	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
	@Override
	public ActionForward executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans)
			 {

		Transaction tran = null;
		try {
			String id = request.getParameter("id");
			String value = request.getParameter("value");
			
			int idInt = Integer.parseInt(id);

			tran = sess.beginTransaction();
			Query query = sess.createQuery("from tr.com.fdd.dto.TAyarDTO  p where p.id = :var");
			
			query.setInteger("var", idInt);
			
			TAyarDTO result = (TAyarDTO) query.uniqueResult();
			
			result.setValue(value);
			tran.commit();
			
			
			//Commons.refreshSelectedHasta(request, connection, result.getHastaId());

			request.setAttribute("warn", GUIMessages.KAYIT_GUNCELLEME_BASARILI);

			return mapping.findForward("success");

		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GUIMessages.ISLEM_BASARISIZ);
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
