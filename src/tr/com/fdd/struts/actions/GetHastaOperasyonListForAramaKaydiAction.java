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

import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.TAramaForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class GetHastaOperasyonListForAramaKaydiAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Connection conn = null;
		try {
			conn = DbConnection.getMySqlConneciton();
			String tip= request.getParameter("tip");
			String operasyonTip=request.getParameter("islemTipi");
			TAramaForm aramaForm= (TAramaForm) form;
			
			int doktorId = -1;
			
			HttpSession httpSession = request.getSession();
			Object[] sessionInf = (Object[]) httpSession
					.getAttribute("sessionMember");
			TKullaniciLoginDTO loginDTO = (TKullaniciLoginDTO) sessionInf[0];
			if (GenelDegiskenler.KullaniciTurleri.DOKTOR.equals(loginDTO.getKuTur()))
				doktorId = loginDTO.getKuId();
			Integer subeId = (Integer) request.getSession().getAttribute(
					"subeId");
			SQLUtils sqlUtils = new SQLUtils();
			
//			List<TIslemDTO> hastaOperasyonListesi = sqlUtils.getHastaListesiForArama(conn, doktorId,
//							subeId.intValue(), 
//							tip, aramaForm., 
//							hastaForm.getAd(), hastaForm.getSoyad(),
//							hastaForm.getBasTar(),hastaForm.getBitTar(), operasyonTip);
//
//			if (hastaOperasyonListesi.size() == 0) {
//				request.setAttribute("noContent", "Kay�t Bulunamad�");
//				return mapping.findForward("noContent");
//			} else {
//				double toplamUcret= getToplamUcret(hastaOperasyonListesi);
//				request.setAttribute("operasyonuKesinlesmemisHastaListesi",
//						hastaOperasyonListesi);
//				request.setAttribute("toplamUcret",
//						toplamUcret
//						);
				return mapping.findForward("success");
			

		} catch (Exception e) {
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
		} finally {
			try {
				MysqlUtil.instance.closeConnection(conn);
			} catch (SQLException e) {

				e.printStackTrace();
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
		}
	}

	private double getToplamUcret(List<TIslemDTO> hastaOperasyonListesi) {
		double ucret=0;
		for (int i = 0; i < hastaOperasyonListesi.size(); i++) {
			
			TIslemDTO dto=hastaOperasyonListesi.get(i);
			ucret=ucret+dto.getMiktar();
		}
		return ucret;
	}

}
