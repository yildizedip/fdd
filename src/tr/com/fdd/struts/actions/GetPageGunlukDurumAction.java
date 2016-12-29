package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.mysql.MysqlUtil;

public class GetPageGunlukDurumAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Connection conn = null;
		try {
			request.getSession().removeAttribute("gunlukKasaDurumu");
			request.getSession().removeAttribute("gunlukGelirGiderFarkListesi");
			request.getSession().removeAttribute("kasaDurumu");
			request.getSession().removeAttribute("gelirList");
			request.getSession().removeAttribute("giderList");

			String gunlukTarih = request.getParameter("bas_tar");
			if (gunlukTarih == null) {

				Date dat = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
				gunlukTarih = sdf.format(dat);
			}
			conn = MysqlUtil.instance.getConnection();

			String sql = " select o.odeme_sekli, g.para_birimi, sum(g.miktar) miktar from t_gelir_gider g ,t_odeme_sekli o"
					+ " where g.tip=1 " + " and g.odeme_sekli= o.kod ";
			if (gunlukTarih != null) {
				sql += " and g.tarih  <=  '" + gunlukTarih;
			}
			sql += "' group by o.odeme_sekli, g.para_birimi ";

			System.out.println(sql);
			Statement stm = conn.createStatement();
			List<TGelirGiderDTO> list = new ArrayList<TGelirGiderDTO>();
			ResultSet rs = stm.executeQuery(sql);
			while (rs.next()) {
				TGelirGiderDTO dto = new TGelirGiderDTO();
				dto.setMiktar(rs.getDouble("miktar"));
				dto.setOdemeSekliStr(rs.getString("odeme_sekli"));
				dto.setParaBirimi(rs.getString("para_birimi"));
				list.add(dto);
			}

			if (list.size() == 0) {
				request.setAttribute("noContent", "Kayýt Bulunamadý");
				return mapping.findForward("noContent");

			} else {

				request.getSession().setAttribute("gunlukKasaDurumu", list);
				SQLUtils sqlUtils = new SQLUtils();

				// List<TGelirGiderDTO> gunlukGelirGiderFarkListesi=
				// sqlUtils.gelirGiderFarkListesi(gunlukTarih,gunlukTarih,conn);
				// request.getSession().setAttribute("gunlukGelirGiderFarkListesi",
				// gunlukGelirGiderFarkListesi);

				Integer subeId = (Integer) request.getSession().getAttribute(
						"subeId");
				List<TGelirGiderDTO> gelirToplami = sqlUtils.gelirToplami(
						gunlukTarih, gunlukTarih, conn, subeId.intValue());
				List<TGelirGiderDTO> giderToplami = sqlUtils.giderToplami(
						gunlukTarih, gunlukTarih, conn, subeId.intValue());

				List<TGelirGiderDTO> gunlukFark = sqlUtils.getGunlukFark(
						gelirToplami, giderToplami);
				request.getSession().setAttribute(
						"gunlukGelirGiderFarkListesi", gunlukFark);

				List<TGelirGiderDTO> kasaDurumu = sqlUtils.kasaAnalizi(
						gunlukTarih, conn, subeId.intValue());
				request.getSession().setAttribute("kasaDurumu", kasaDurumu);

				// List< TGelirGiderDTO> gunlukGelirListesiDetay=
				// sqlUtils.gelirListesi(gunlukTarih, gunlukTarih, conn);
				// request.getSession().setAttribute("gelirList",
				// gunlukGelirListesiDetay);
				// List< TGelirGiderDTO> gunlukGiderListesiDetay=
				// sqlUtils.giderListesi(gunlukTarih, gunlukTarih, conn);
				// request.getSession().setAttribute("giderList",
				// gunlukGiderListesiDetay);

			}
			return mapping.findForward("success");
		}  catch (Exception e) {
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
}
