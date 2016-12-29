package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

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

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.struts.form.HastaForm;

public class HastaGuncelleAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Transaction tran = null;
		Connection conn = null;
		try {
			String hastaId = request.getParameter("id");
			int id = new Integer(hastaId).intValue();

			HastaForm hastaForm = (HastaForm) form;
			hastaForm.setDurum("A");
			hastaForm.setGuncellenmeTarihi(new Date());
			THastaDTO hastaDto = new THastaDTO();

			BeanUtils.copyProperties(hastaDto, hastaForm);

			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.id = :var");
			query.setInteger("var", new Integer(id).intValue());
			THastaDTO result = (THastaDTO) query.uniqueResult();
			result.setAd(hastaDto.getAd());
			result.setSoyad(hastaDto.getSoyad());
			result.setProtokolNo(hastaDto.getProtokolNo());
			result.setTckimlik(hastaDto.getTckimlik());
			result.setTel(hastaDto.getTel());
			result.setProtokolNo(hastaDto.getProtokolNo());

			tran.commit();

			request.setAttribute("warn", id + "nolu kayit guncellenmiþtir.");

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
			try {
				conn.rollback();
				conn.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
			return mapping.findForward("exception");
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

}
