package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.text.SimpleDateFormat;
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
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.dto.TIslemSafahatDTO;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class OperasyonuKesinlestirAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {

		Transaction tran = null;

		try {
			String islemId = request.getParameter("islemId");
			int id = Integer.parseInt(islemId);

			IslemForm islemForm = (IslemForm) form;
			TIslemDTO islemDto = new TIslemDTO();
			TIslemSafahatDTO islemSafahatDto = new TIslemSafahatDTO();
			
			if (islemForm.getIslemTarihiStr() == null)
				islemForm.setIslemTarihi(new Date());
			else {
				String tarihStr = islemForm.getIslemTarihiStr();

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
				Date convertedDate = dateFormat.parse(tarihStr);
				islemForm.setIslemTarihi(convertedDate);
			}

			BeanUtils.copyProperties(islemDto, islemForm);
			BeanUtils.copyProperties(islemSafahatDto, islemForm);
			islemSafahatDto.setDurumu("K");
			islemSafahatDto.setAciklama("Kesinlesmemis Kayit");

			tran = sess.beginTransaction();
			/**
			 * safahata kayit ekleniyor.
			 */
			sess.save(islemSafahatDto);
			/**
			 * hasta kesinlesti..
			 */
			Query query = sess.createQuery("from tr.com.fdd.dto.TIslemDTO  p where p.id = :var");
			query.setInteger("var", id);
			TIslemDTO result = (TIslemDTO) query.uniqueResult();

		//	result.setIslemTip(islemDto.getIslemTip());
		//	result.setIslemTipi(islemDto.getIslemTipi());
			//result.setDoktorId(islemDto.getDoktorId());
		//	result.setMiktar(islemDto.getMiktar());
			result.setGuncellenmeTarihi(new Date());
		//	result.setAciklama(islemDto.getAciklama());
			result.setIslemTarihi(islemDto.getIslemTarihi());
			result.setDurumu("A");

			tran.commit();

			request.setAttribute("warn", GUIMessages.OPERASYON_KESINLESTI);
			
			Commons.refreshSelectedHasta(request, connection, result.getHastaId());

			return mapping.findForward("success");

		} catch (Exception e) {
			e.printStackTrace();
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", GUIMessages.ISLEM_BASARISIZ);
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
