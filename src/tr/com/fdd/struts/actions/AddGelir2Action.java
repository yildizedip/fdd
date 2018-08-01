package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.struts.form.GelirGiderForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class AddGelir2Action extends GenericAction {

	@Override
	protected ActionForward executeCode(Session session, Connection connection, ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) throws Exception {

		Transaction tran = null;
		TGelirGiderDTO tGelirGiderDto = new TGelirGiderDTO();

		GelirGiderForm gelirGiderForm = (GelirGiderForm) form;
		gelirGiderForm.setDurum("A");
		gelirGiderForm.setGirenKisi(Commons.getActiveSession(request).getKuId());
		if (gelirGiderForm.getTarihStr() == null)
			gelirGiderForm.setTarih(new Date());
		else {
			String tarihStr = gelirGiderForm.getTarihStr();
			gelirGiderForm.setTarih(Commons.convertStringToDate(tarihStr));
		}
		// gelir 1 gider 2 olarak tanimlandi
		gelirGiderForm.setTip(1);
		
		BeanUtils.copyProperties(tGelirGiderDto, gelirGiderForm);

		session = GenericAction.getHibernateSession();
		tran = session.beginTransaction();
		tGelirGiderDto.setEklenmeTarihi(Commons.getNow());
		tGelirGiderDto.setGirenKisi(Commons.getActiveSession(request).getKuId());
		session.save(tGelirGiderDto);
		tran.commit();
		request.setAttribute("warn", GUIMessages.KAYIT_BASARILI);

		return mapping.findForward("success");
	}
}
