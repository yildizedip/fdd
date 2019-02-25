package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TDoktorSubeDTO;
import tr.com.fdd.dto.TKullaniciBilgiDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TKullaniciSubeDTO;
import tr.com.fdd.dto.TTurKodDTO;
import tr.com.fdd.dto.TTurKodSubeDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.mysql.MysqlUtil;
import tr.com.fdd.struts.form.LoginForm;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class KullaniciEkleAction extends Action {

	@SuppressWarnings("unchecked")
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Transaction tran = null;
		Session session = null;

		TKullaniciLoginDTO tkullaniciLoginDTO = new TKullaniciLoginDTO();
		Connection conn = null;
		SQLUtils sqlUtils = null;
		try {
			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			
			conn = DbConnection.getMySqlConneciton();
			sqlUtils = new SQLUtils();

			/**
			 * KULLANICI LOGIN EKLEME
			 */
			LoginForm frm = (LoginForm) form;
			frm.setDurum("A");

			tkullaniciLoginDTO.setKuMail(frm.getUserName());
			tkullaniciLoginDTO.setKuSifre(frm.getPassword());
			tkullaniciLoginDTO.setKuTarih(new Date());
			tkullaniciLoginDTO.setKuTur(frm.getKuTur());
			tkullaniciLoginDTO.setDurum(frm.getDurum());

			Query queryLogin = session
					.createQuery("from tr.com.fdd.dto.TKullaniciLoginDTO  p where p.durum='A' and p.kuMail = :mail");

			queryLogin.setString("mail", tkullaniciLoginDTO.getKuMail());

			List<TKullaniciLoginDTO> result = queryLogin.list();
			int loginId = 0;
			if (result.size() != 0) {
				tran.commit();
				request.setAttribute("warn", GUIMessages.KAYIT_VAR);
				return mapping.findForward("exception");
			}

			else {
				loginId = (Integer) session.save(tkullaniciLoginDTO);
				request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);
				// tran.commit();

			}

			/**
			 * KULLANICI BILGI EKLEME
			 */

			TKullaniciBilgiDTO tKullaniciBilgiDTO = new TKullaniciBilgiDTO();
			tKullaniciBilgiDTO.setKuLoginId(loginId);
			tKullaniciBilgiDTO.setKuAd(frm.getAd());
			tKullaniciBilgiDTO.setKuSoyad(frm.getSoyad());
			tKullaniciBilgiDTO.setKuTel(frm.getTel());
			tKullaniciBilgiDTO.setKuAdres(frm.getAdres());

			session.save(tKullaniciBilgiDTO);
			
			/**
			 * sube ekleme
			 */

			TKullaniciSubeDTO dto= new TKullaniciSubeDTO();
			dto.setDurum("A");
			dto.setKuId(loginId);
			dto.setsId(frm.getSubeId());
			
			session.save(dto);
			/**
			 * DOKTOR EKLEME
			 */

			if (frm.getKuTur().equals(GenelDegiskenler.KullaniciTurleri.DOKTOR)) {

				TDoktorDTO doktorDTO = new TDoktorDTO();
				doktorDTO.setdAd(frm.getAd());
				doktorDTO.setdMemberId(loginId);
				doktorDTO.setdSoyad(frm.getSoyad());
				doktorDTO.setdBrans("Dis Hekimi");
				doktorDTO.setdDurum("A");
				doktorDTO.setdAktif("A");

				int doktor_id= (Integer)session.save(doktorDTO);
				
				/** 
				 * doktor gider turu ekle
				 */
				
				TTurKodDTO giderTurDto = new TTurKodDTO();
				
				giderTurDto.setTurAd(frm.getAd() + " " + frm.getSoyad());
				
				int maxGiderTurId=sqlUtils.getMaxGiderTur(conn);
				
				giderTurDto.setTurKod(maxGiderTurId+1);
				giderTurDto.setTurTip(1);
				giderTurDto.setTurDurum("A");
				
				int giderTurId = (Integer)	session.save(giderTurDto);
				
				/**
				 * doktor gider tur sube ekle
				 */
				
				TTurKodSubeDTO giderTurSubeDto = new TTurKodSubeDTO();
				giderTurSubeDto.setDurum("A");
				giderTurSubeDto.setSubeId(frm.getSubeId());
				giderTurSubeDto.setTkId(giderTurId);
				
				session.save(giderTurSubeDto);
				
				/**
				 * doktor kullanici guncelle
				 */
				
				tKullaniciBilgiDTO.setGiderKodu(giderTurId);
				session.update(tKullaniciBilgiDTO);
				
				/**
				 * doktor sube ekle
				 */
				
				TDoktorSubeDTO doktorSubeDto= new TDoktorSubeDTO();
				doktorSubeDto.setDurum("A");
				doktorSubeDto.setSbId(frm.getSubeId());
				doktorSubeDto.setdId(doktor_id);
				session.save(doktorSubeDto);
				
			}
			tran.commit();
			
			List<LoginForm> kullaniciList = sqlUtils.getKullaniciList(conn, "");
			request.setAttribute("kullaniciList", kullaniciList);

			return mapping.findForward("success");
		} catch (HibernateException e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn",GUIMessages.ISLEM_BASARILI);
			return mapping.findForward("exception");

		} catch (Exception e) {
			request.setAttribute("warn", GUIMessages.ISLEM_BASARISIZ);
			return mapping.findForward("exception");

		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
					e.printStackTrace();
				}

				MysqlUtil.instance.closeConnection(conn);
		}
	}

}
