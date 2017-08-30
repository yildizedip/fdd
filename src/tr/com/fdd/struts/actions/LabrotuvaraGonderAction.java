package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TLabrotuvarDTO;
import tr.com.fdd.dto.TLabrotuvarProvaDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LabrotuvarForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;
import tr.com.fdd.utils.enums.LaboratuvarIslemDurum;
import tr.com.fdd.utils.enums.ProvaTip;

public class LabrotuvaraGonderAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session = null;
		Connection conn = DbConnection.getMySqlConneciton();

		try {
			TLabrotuvarDTO labrotuvarDTO = new TLabrotuvarDTO();
			LabrotuvarForm labForm = (LabrotuvarForm) form;

			String klinikCikisTarStr = labForm.getKlinikCikisTarStr();

			if (!klinikCikisTarStr.equals(""))
				labrotuvarDTO.setKlinikCikisTar(Commons
						.convertStringToDate(klinikCikisTarStr));

			if (!labForm.getIslemId().equals(""))
				labrotuvarDTO
						.setIslemId(Integer.parseInt(labForm.getIslemId()));

			Object[] sessionsArr = (Object[]) request.getSession()
					.getAttribute("sessionMember");
			labrotuvarDTO.setGonderenKisi(((TKullaniciLoginDTO) sessionsArr[0])
					.getKuId());
			labrotuvarDTO.setGondermeTar(new Date());
			labrotuvarDTO.setDurum(LaboratuvarIslemDurum.LABRATUVARDA
					.getState());
			labrotuvarDTO.setAciklama(labForm.getAciklama());
			labrotuvarDTO.setLabIslemTipId(labForm.getLabIslemTipId());

			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();

			int id = (Integer) session.save(labrotuvarDTO);
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
			 tran.commit();
			
			 session.clear();
			 session.close();
			 session = null;
			 tran = null;

			// }

			/**
			 * insert prova list.. create new session
			 */

			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();

			List<TLabrotuvarProvaDTO> provaList = new ArrayList<TLabrotuvarProvaDTO>();

			if (labForm.getDentinProva() != null
					&& labForm.getDentinProva().equals("on")) {
				provaList.add(createProva(ProvaTip.DENTIN.getVal(), id, null));
			}
			if (labForm.getMetalProva() != null
					&& labForm.getMetalProva().equals("on")) {
				provaList.add(createProva(ProvaTip.METAL.getVal(), id, null));
			}
			if (labForm.getIskeletProva() != null
					&& labForm.getIskeletProva().equals("on")) {
				provaList.add(createProva(ProvaTip.ISKELET.getVal(), id, null));
			}
			if (labForm.getDisliProva() != null
					&& labForm.getDisliProva().equals("on")) {
				provaList.add(createProva(ProvaTip.DISLI.getVal(), id, null));
			}
			if (labForm.getZirkonProva() != null
					&& labForm.getZirkonProva().equals("on")) {
				provaList.add(createProva(ProvaTip.ZIRKON.getVal(), id, null));
			}

			for (int i = 0; i < provaList.size(); i++) {

				session.save(provaList.get(i));
			}
			tran.commit();
			
			
			request.setAttribute("islem", GenelDegiskenler.LABROTUVAR_ISLEM);

			SQLUtils sqlUtils = new SQLUtils();
			String hastaId = request.getParameter("id");
			conn = DbConnection.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			THastaDTO hasta = sqlUtils.getHasta(
					new Integer(hastaId).intValue(), conn, subeId.intValue());

			// List<TIslemDTO> hastaOperasyonListesi = sqlUtils
			// .getHastaOperasyonListesiGoruntule(hasta.getId(), conn);
			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
					.getHastaOperasyonOdemeListesi(hasta.getId(), conn);

			setLabratuvarListToOperasyonList(hastaOperasyonListesi, sqlUtils,
					conn);

			request.setAttribute("hasta", hasta);

			return mapping.findForward("success");
		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kay�t hatal�");
			return mapping.findForward("exception");

		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
					session = null;
				} catch (HibernateException e) {

					e.printStackTrace();
				}

			MysqlUtil.instance.closeConnection(conn);
		}
	}

	private TLabrotuvarProvaDTO createProva(int provaTip, int islemId,
			Date provaTar) {

		TLabrotuvarProvaDTO provaDTO = new TLabrotuvarProvaDTO();
		provaDTO.setDurum("A");
		provaDTO.setLabIslemId(islemId);
		provaDTO.setProvaTar(provaTar);
		provaDTO.setProvaTip(provaTip);

		return provaDTO;
	}

	private void setLabratuvarListToOperasyonList(
			List<TIslemDTO> hastaOperasyonListesi, SQLUtils sqlUtils,
			Connection conn) throws SQLException {

		for (int i = 0; i < hastaOperasyonListesi.size(); i++) {
			TIslemDTO dto = hastaOperasyonListesi.get(i);
			dto.setLabratuvarList(sqlUtils.getOperasyonLabratuvarIslemList(
					conn, dto.getId()));
		}
	}
}
