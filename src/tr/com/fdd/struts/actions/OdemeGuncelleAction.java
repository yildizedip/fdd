package tr.com.fdd.struts.actions;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.struts.form.HastaOdemeForm;
import tr.com.fdd.utils.GUIMessages;

public class OdemeGuncelleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Transaction tran = null;
		try {

			String odemeId = request.getParameter("id");
			int id = Integer.parseInt(odemeId);

			HastaOdemeForm odemeForm = (HastaOdemeForm) form;

			if (odemeForm.getOdemeTarihiStr() == null)
				odemeForm.setOdemeTarihi(new Date());
			else {
				String tarihStr = odemeForm.getOdemeTarihiStr();

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
				Date convertedDate = dateFormat.parse(tarihStr);
				odemeForm.setOdemeTarihi(convertedDate);
			}

			sess = GenericAction.getHibernateSession();
			THastaOdemeDTO dto = new THastaOdemeDTO();
			BeanUtils.copyProperties(dto, odemeForm);
			tran = sess.beginTransaction();

			Query query = sess
					.createQuery("from tr.com.fdd.dto.THastaOdemeDTO  p where p.id = :var");
			query.setInteger("var", id);
			THastaOdemeDTO result = (THastaOdemeDTO) query.uniqueResult();

			result.setAciklama(dto.getAciklama());
			result.setGuncellenmeTarihi(new Date());
			result.setMiktar(dto.getMiktar());
			result.setOdemeTuru(dto.getOdemeTuru());
			result.setOdemeTarihi(dto.getOdemeTarihi());
			tran.commit();

			request.setAttribute("warn", GUIMessages.KAYIT_GUNCELLEME_BASARILI);

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
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

}
