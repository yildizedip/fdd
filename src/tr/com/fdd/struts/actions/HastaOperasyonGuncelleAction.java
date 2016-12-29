package tr.com.fdd.struts.actions;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Query;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.GUIMessages;

public class HastaOperasyonGuncelleAction extends Action {

	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Session sess = null;
		Transaction tran = null;

		try {
			String islemId = request.getParameter("islemId");
			int id = Integer.parseInt(islemId);

			IslemForm islemForm = (IslemForm) form;
			TIslemDTO islemDto = new TIslemDTO();

			if (islemForm.getIslemTarihiStr() != null && !islemForm.getIslemTarihiStr().equals("")){
				String tarihStr = islemForm.getIslemTarihiStr();

				
				Date convertedDate = dateFormat.parse(tarihStr);
				islemForm.setIslemTarihi(convertedDate);
			}

			if (islemForm.getIslemBitisTarihiStr() != null && !islemForm.getIslemBitisTarihiStr().equals(""))
			{
			
				String tarihStr = islemForm.getIslemBitisTarihiStr();
				Date convertedDate = dateFormat.parse(tarihStr);
				islemForm.setIslemBitisTarihi(convertedDate);
			}
			
			BeanUtils.copyProperties(islemDto, islemForm);

			sess = GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
			Query query = sess
					.createQuery("from tr.com.fdd.dto.TIslemDTO  p where p.id = :var");
			query.setInteger("var", id);
			TIslemDTO result = (TIslemDTO) query.uniqueResult();

			result.setIslemTip(islemDto.getIslemTip());
			result.setIslemTipi(islemDto.getIslemTipi());
			result.setDoktorId(islemDto.getDoktorId());
			result.setMiktar(islemDto.getMiktar());
			result.setGuncellenmeTarihi(new Date());
			result.setAciklama(islemDto.getAciklama());
			result.setIslemTarihi(islemDto.getIslemTarihi());
			result.setIslemBitisTarihi(islemDto.getIslemBitisTarihi());

			tran.commit();

			request.setAttribute("warn", GUIMessages.KAYIT_GUNCELLEME_BASARILI);

			return mapping.findForward("success");

		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {

					e1.printStackTrace();
				}
			request.setAttribute("warn", "Kayýt Silme Ýþleminde Hata Oluþtu.");
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
