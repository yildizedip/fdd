package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TAramaKaydiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.HastaForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaAramaListGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;

		try {

			conn = DbConnection.getMySqlConneciton();
			
			String tip= request.getParameter("tip");
			String operasyonTip=request.getParameter("islemTipi");
			HastaForm hastaForm= (HastaForm) form;
			int doktorId = -1;
			HttpSession httpSession = request.getSession();
			Object[] sessionInf = (Object[]) httpSession.getAttribute("sessionMember");
			TKullaniciLoginDTO loginDTO = (TKullaniciLoginDTO) sessionInf[0];
			if (GenelDegiskenler.KullaniciTurleri.DOKTOR.equals(loginDTO.getKuTur()))
				doktorId = loginDTO.getKuId();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			SQLUtils sqlUtils = new SQLUtils();
			
			List<TAramaKaydiDTO> aramaKayitListesi = sqlUtils
					.hastaAramaKaydiListesiGetir(conn, doktorId,
							subeId.intValue(), 
							tip, hastaForm.getProtokolNo(), 
							hastaForm.getAd(), hastaForm.getSoyad(),
							hastaForm.getBasTar(),hastaForm.getBitTar(), operasyonTip);

			if (aramaKayitListesi.size() == 0) {
				request.setAttribute("warn", "Kay�t Bulunamad�");
				return mapping.findForward("noContent");
			} else {
				double toplamUcret= getToplamUcret(aramaKayitListesi);
				request.setAttribute("aramaKayitListesi",
						aramaKayitListesi);
				request.setAttribute("toplamUcret",
						toplamUcret
						);
				return mapping.findForward("success");
			}

		}
		catch (Exception e) {
			try {
				if(conn!=null){
				conn.rollback();
				conn.close();
				}
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("exception", e);
			return mapping.findForward("exception");
		} 
		finally {
			try {
				MysqlUtil.instance.closeConnection(conn);
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}

	private double getToplamUcret(List<TAramaKaydiDTO> hastaOperasyonListesi) {
		double ucret=0;
		for (int i = 0; i < hastaOperasyonListesi.size(); i++) {
			
			TAramaKaydiDTO dto=hastaOperasyonListesi.get(i);
			ucret=ucret+ dto.getIslem().getMiktar();
		}
		return ucret;
	}
}
