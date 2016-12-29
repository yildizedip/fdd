package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.HastaOdemeForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class HastaOdemeEkleAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session = null;
		Connection conn = null;
	
		try {
		
			conn = SQLUtils.getMySqlConneciton();
			THastaOdemeDTO tHastaOdemeDto = new THastaOdemeDTO();

			HastaOdemeForm hastaOdemeForm = (HastaOdemeForm) form;
				
			
			hastaOdemeForm.setDurumu("A");
			hastaOdemeForm.setEklenmeTarihi(new Date());
			if (hastaOdemeForm.getOdemeTarihiStr() == null)
				hastaOdemeForm.setOdemeTarihi(new Date());
			else {
				String tarihStr = hastaOdemeForm.getOdemeTarihiStr();
				hastaOdemeForm.setOdemeTarihi(Commons.convertStringToDate(tarihStr));
			}
			BeanUtils.copyProperties(tHastaOdemeDto, hastaOdemeForm);
			if(tHastaOdemeDto.getDoktorId()!=0 && tHastaOdemeDto.getHastaId()!=0)
			{
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			
			session.save(tHastaOdemeDto);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
		
		//	List<TIslemDTO> hastaOperasyonListesi = sqlUtils.getHastaOperasyonListesi(tHastaOdemeDto.getHastaId(),0, conn);

		//	request.setAttribute("hastaOperasyonListesi", hastaOperasyonListesi);
			
			/**
			 * odeme eklnedikten sonra tekrar odeme ekleme sayfasina yonlendiriliyor..
			 */
			setHastaOperasyonBilgileri(request, hastaOdemeForm,conn);	
			
			return mapping.findForward("success");
			}
			else 
			{
				request.setAttribute("warn", GUIMessages.HATA);
			return mapping.findForward("failure");
			}
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
				
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
			request.setAttribute("warn", "Kayýt hatalý");
			return mapping.findForward("failure");
		} finally {
			try {
				MysqlUtil.instance.closeConnection(conn);
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

	private void setHastaOperasyonBilgileri(HttpServletRequest request,
			HastaOdemeForm hastaOdemeForm, Connection conn) throws SQLException {
		
		SQLUtils sqlUtils=  new SQLUtils();
		
		Integer subeId = (Integer) request.getSession().getAttribute("subeId");
		THastaDTO hasta = sqlUtils.getHasta(
				new Integer(hastaOdemeForm.getHastaId()).intValue(), conn, subeId.intValue());
		
		request.setAttribute("hasta", hasta);
		
		List<TIslemDTO> hastaOperasyonListesi = sqlUtils
				.getHastaOperasyonOdemeListesi(hasta.getId(), conn);
		request.setAttribute("hastaOperasyonListesi",
				hastaOperasyonListesi);
	
	}
}
