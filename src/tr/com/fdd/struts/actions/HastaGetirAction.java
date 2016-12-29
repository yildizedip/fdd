package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaGetirAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Connection conn =null;
		SQLUtils ut = new SQLUtils();

		try {
			conn = SQLUtils.getMySqlConneciton();
			String hastaId = request.getParameter("id");
			String tip = request.getParameter("type");

			int hasta_id = new Integer(hastaId).intValue();

			sess = GenericAction.getHibernateSession();

			Query query = sess
					.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.id = :var");
			query.setInteger("var", new Integer(hasta_id).intValue());
			THastaDTO result = (THastaDTO) query.uniqueResult();

			request.getSession().setAttribute("hasta", result);
			GenelDegiskenler deg = new GenelDegiskenler();
			request.setAttribute("saatler", deg.getHours());
			request.setAttribute("dakikalar", deg.getDakikalar(5));

			List<TIslemDTO> hastaOperasyonListesi = null;

			if (GenelDegiskenler.RANDEVU_EKLE.equals(tip))
				return mapping.findForward("randevuEkle");
			else if (GenelDegiskenler.GELIR_EKLE.equals(tip)
					|| GenelDegiskenler.GELIR_GORUNTULE.equals(tip)) {
				hastaOperasyonListesi = ut.getHastaOperasyonOdemeListesi(
						hasta_id, conn);

				if (hastaOperasyonListesi.size() == 0) {
					request.setAttribute("warn",
							GUIMessages.OPERASYON_YOK);

					return mapping.findForward("operasyonYok");
				} else {

					List<THastaOdemeDTO> odemeList = (List<THastaOdemeDTO>) hastaOperasyonListesi
							.get(0).getOdemeList();
					if (odemeList.size() == 0) {
						request.setAttribute("odenenMiktar", new Double(0));
					} else {
						Double odenenMiktar = new Double(0);
						for (int i = 0; i < odemeList.size(); i++) {
							THastaOdemeDTO odeme = (THastaOdemeDTO) odemeList
									.get(i);
							if (odeme.getOdemeTuru() != 1) {
								odenenMiktar = odenenMiktar + odeme.getMiktar();
							}

						}
						request.setAttribute("odenenMiktar", odenenMiktar);

					}

					request.setAttribute("hastaOperasyonListesi",
							hastaOperasyonListesi);

					if (GenelDegiskenler.GELIR_GORUNTULE.equals(tip))
						return mapping.findForward("gelirGoruntule");
					else
						return mapping.findForward("gelirEkle");
				}
			}

			else if (GenelDegiskenler.GUNCELLE.equals(tip))
				return mapping.findForward("guncelle");
			else if (GenelDegiskenler.OPERASYON_EKLE.equals(tip)) {
				hastaOperasyonListesi = ut.getHastaOperasyonListesi(hasta_id,
						0, conn);
				request.setAttribute("hastaOperasyonListesi",
						hastaOperasyonListesi);
			//	operasyon kesinlesmemis ise kesinlemedi uyarisi veriyor..
				if (ut.kesinlesmemisOperasyonVarmi(hasta_id, conn)) {

					request.setAttribute("warn",
							GUIMessages.KESINLESMEMIS_OPERASYON_VAR);
				//	return mapping.findForward("failureForOperasyonEkle");
					return mapping.findForward("operasyonEkle");

				}

				else {
					//kesinlesmis operasyon var uyari veriyor ve isleme devam..
					
					return mapping.findForward("operasyonEkle");
				}
				
	//			return mapping.findForward("operasyonEkle");

			} else if (GenelDegiskenler.OPERASYON_LISTESI.equals(tip))
				return mapping.findForward("operasyonListesi");

			else if (GenelDegiskenler.OPERASYON_BITIR.equals(tip)) {
				hastaOperasyonListesi = ut.getHastaOperasyonListesi(hasta_id,
						0, conn);
				if (hastaOperasyonListesi.size() == 0) {

					request.setAttribute("warn", GUIMessages.OPERASYON_YOK);
					return mapping.findForward("operasyonBitir");
				} else {
					request.setAttribute("hastaOperasyonListesi",
							hastaOperasyonListesi);
					return mapping.findForward("operasyonBitir");
				}
			}
			
			else
				return mapping.findForward("success");
		} catch (Exception e) {
			try {
				conn.rollback();
				conn.close();
				request.setAttribute("exception", e);
			} catch (SQLException e1) {
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			}
			request.setAttribute("warn", GUIMessages.HATA);
			return mapping.findForward("exception");
		} finally {
			
			MysqlUtil.instance.closeConnection(conn);
			
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}
		}

	}

}
