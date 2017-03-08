package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TIslemTipDTO;
import tr.com.fdd.dto.TIslemTipSubeDTO;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class SubeTedaviFiyatGuncelleAction extends GenericAction {

	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
	@Override
	public ActionForward executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans)
			 {

		Transaction tran = null;
		try {
			String id = request.getParameter("id");
			String fiyat = request.getParameter("fiyat");
			String subeId = request.getParameter("subeId");
			
			int idInt = Integer.parseInt(id);

			tran = sess.beginTransaction();
			Query query = sess.createQuery("from tr.com.fdd.dto.TIslemTipSubeDTO  p where p.id = :var");
			
			query.setInteger("var", idInt);
			
			TIslemTipSubeDTO result = (TIslemTipSubeDTO) query.uniqueResult();

			result.setFiyat(Double.parseDouble(fiyat));

			tran.commit();
			
			SQLUtils sqlUtils= new SQLUtils();
			
			
			 List<TIslemTipDTO> islemTurList= sqlUtils.getOperasyonTurList(connection,Integer.parseInt(subeId));
			 request.setAttribute("islemTurListesi", islemTurList);
			
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
