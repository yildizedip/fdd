package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;

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
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class HastaGuncelleAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session session, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction tran) {

		//Transaction tran = null;
		try {
			
			
			String hastaId = request.getParameter("id");
			int id = new Integer(hastaId).intValue();

			HastaForm hastaForm = (HastaForm) form;
			hastaForm.setDurum("A");
			hastaForm.setGuncellenmeTarihi(new Date());
			THastaDTO hastaDto = new THastaDTO();

			BeanUtils.copyProperties(hastaDto, hastaForm);

			tran = session.beginTransaction();
			Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.id = :var");
			query.setInteger("var", new Integer(id).intValue());
			THastaDTO result = (THastaDTO) query.uniqueResult();
			result.setAd(hastaDto.getAd());
			result.setSoyad(hastaDto.getSoyad());
			result.setProtokolNo(hastaDto.getProtokolNo());
			result.setTckimlik(hastaDto.getTckimlik());
			result.setTel(hastaDto.getTel());
			result.setProtokolNo(hastaDto.getProtokolNo());
			result.setAdres(hastaDto.getAdres());
			result.setGuncellenmeTarihi(new Date());
			result.setGuncelleyenKisi(Commons.getActiveSession(request).getKuId());

			tran.commit();

			request.setAttribute("warn", GUIMessages.KAYIT_GUNCELLEME_BASARILI);
			
			Commons.refreshSelectedHasta(request, connection, Integer.parseInt(hastaId));
	//		Commons.updateHastaFromHastaList(result, request);

			return mapping.findForward("success");

		} catch (Exception e) {

			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			try {
				connection.rollback();
				connection.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("warn", GUIMessages.KAYIT_GUNCELLEME_BASARISIZ);
			return mapping.findForward("exception");
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {

					e.printStackTrace();
				}
		}

	}

}
