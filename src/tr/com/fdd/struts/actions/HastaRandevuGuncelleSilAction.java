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
import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.THastaRandevuDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.form.HastaRandevuForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaRandevuGuncelleSilAction extends GenericAction {

	@Override
	protected ActionForward executeCode(Session sess, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response , Transaction tran) {

//		Transaction tran = null;
		HastaRandevuForm hastaRandevuForm = null;
		String islem = request.getParameter("action");
		try {

			hastaRandevuForm = (HastaRandevuForm) form;

			tran = sess.beginTransaction();

			Query query = sess.createQuery("from tr.com.fdd.dto.THastaRandevuDTO  p where p.id = :var");
			query.setInteger("var", hastaRandevuForm.getId());

			THastaRandevuDTO result = (THastaRandevuDTO) query.uniqueResult();
			
			String aciklama=hastaRandevuForm.getAciklama().replaceAll("\r\n", " ");
			result.setAciklama(aciklama);
			result.setRandevuTarihiBaslangic(hastaRandevuForm.getRandevuTarihiBaslangic());
			result.setRandevuTarihiBitis(hastaRandevuForm.getRandevuTarihiBitis());
		//	result.setIslem(hastaRandevuForm.getIslem());
			result.setRandevuyaGelinmedi(hastaRandevuForm.getRandevuyaGelinmedi());
			
			if(islem.equals("Sil"))
			result.setDurum("P");
			

			tran.commit();

			SQLUtils sqlUtils = new SQLUtils();
			Connection conn = DbConnection.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");

			TDoktorDTO doktorDTO = sqlUtils.getDoktor(-1, hastaRandevuForm.getDoktorId(), conn, true, subeId);
			request.setAttribute("selectedDoctor", doktorDTO);

			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GenelDegiskenler.FormMessages.ERROR);
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
