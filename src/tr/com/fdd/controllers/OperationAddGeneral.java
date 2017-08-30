package tr.com.fdd.controllers;

import java.sql.Connection;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaOdemeDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.actions.GenericAction;
import tr.com.fdd.struts.actions.SQLUtils;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class OperationAddGeneral implements IOperationAddController {
	private static Logger logger = LoggerFactory.getLogger(SQLUtils.class);

	@Override
	public String addOperation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		Transaction tran = null;
		Session session = null;
		try {

			IslemForm islemForm = generateForm(form);
			TIslemDTO tIslemDto = new TIslemDTO();
			BeanUtils.copyProperties(tIslemDto, islemForm);

			session = GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			Integer islemId = (Integer) session.save(tIslemDto);

			THastaOdemeDTO hastaOdemeDTO = new THastaOdemeDTO();
			hastaOdemeDTO.setIslemId(islemId.intValue());
			hastaOdemeDTO.setHastaId(tIslemDto.getHastaId());
			hastaOdemeDTO.setDoktorId(tIslemDto.getDoktorId());
			hastaOdemeDTO.setOdemeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setOdemeTuru(1); // 1 anlasilan fiyat demektir.
			hastaOdemeDTO.setMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setKalanMiktar(tIslemDto.getMiktar());
			hastaOdemeDTO.setEklenmeTarihi(tIslemDto.getEklenmeTarihi());
			hastaOdemeDTO.setDurumu("A");
			hastaOdemeDTO.setAciklama("Toplam Ucret");

			Integer hastaGelirId = (Integer) session.save(hastaOdemeDTO);
			logger.info("hasta gelir id=" + hastaGelirId);

			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);

			logger.info("operasyon id=" + islemId);
			logger.info("odeme id=" + hastaGelirId);

			Connection conn = DbConnection.getMySqlConneciton();
			SQLUtils sqlUtils = new SQLUtils();
			List<TIslemDTO> hastaOperasyonListesi = sqlUtils.getHastaOperasyonListesi(tIslemDto.getHastaId(), 0, conn);

			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			THastaDTO hasta = sqlUtils.getHasta(tIslemDto.getHastaId(), conn,subeId.intValue());
			request.setAttribute("hasta", hasta);
			request.setAttribute("hastaOperasyonListesi", hastaOperasyonListesi);
			
			/**
			 * tekrar operasyon ekleme sayfasina donecegi icin secili doktor ve tarih gonderiliyor.
			 */
			
			request.setAttribute("operasyonDoktorId", islemForm.getDoktorId() );
			request.setAttribute("operasyonEklemeTarihi",islemForm.getIslemTarihiStr() );
			
			/**
			 * islem tipi kesinlesmedi ise kesinlemedi ekranina gider.. islem
			 * tipi implant ise implant ustu protez islemi icin ekran acar...
			 */

			if ("K".equals(tIslemDto.getDurumu()))
				return GenelDegiskenler.ReturnTypes.SUCCESS_KESINLESMEDI;
			 else if (tIslemDto.getIslemTipi() == GenelDegiskenler.OperasyonTipleri.IMPLANT_USTU_OPERASYON) {

				request.setAttribute("warn", GUIMessages.KAYIT_BASARILI);
				return GenelDegiskenler.ReturnTypes.SUCCESS_KESINLESMEDI;
			} else
				return GenelDegiskenler.ReturnTypes.SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return GenelDegiskenler.ReturnTypes.SUCCESS_KESINLESMEDI;
		} finally {

			try {
				if (tran != null)
					tran.rollback();
				if (session != null && session.isOpen())
					session.close();
			} catch (HibernateException e1) {

				e1.printStackTrace();
			}
		}

	}

	private IslemForm generateForm(ActionForm form) throws ParseException {
		IslemForm islemForm = (IslemForm) form;
		if (islemForm.getDurumu() == null)
			islemForm.setDurumu("A");
		else if (islemForm.getDurumu().equals("on"))
			islemForm.setDurumu("K");

		islemForm.setEklenmeTarihi(new Date());
		if (islemForm.getIslemTarihiStr() == null)
			islemForm.setIslemTarihi(new Date());
		else {
			String tarihStr = islemForm.getIslemTarihiStr();
			
			islemForm.setIslemTarihi(Commons.convertStringToDate(tarihStr));
		}
		return islemForm;
	}
}
