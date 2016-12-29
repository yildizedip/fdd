package tr.com.fdd.struts.actions;

import java.util.Date;

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

import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.struts.form.GelirGiderForm;
import tr.com.fdd.utils.Commons;

public class AddGelirAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session=null;
		try {
			TGelirGiderDTO tGelirGiderDto = new TGelirGiderDTO();
			
			GelirGiderForm gelirGiderForm=(GelirGiderForm) form;
			gelirGiderForm.setDurum("A");
			gelirGiderForm.setGirenKisi( Commons.getActiveSession(request).getKuId() );
			if(gelirGiderForm.getTarihStr()==null)
				gelirGiderForm.setTarih(new Date());
			else{
			String tarihStr= gelirGiderForm.getTarihStr();			
		    gelirGiderForm.setTarih(Commons.convertStringToDate(tarihStr));
			}
			// gelir 1 gider 2 olarak tanimlandi
			gelirGiderForm.setTip(1);
			BeanUtils.copyProperties(tGelirGiderDto, gelirGiderForm );					
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			session.save(tGelirGiderDto);
			tran.commit();
			request.setAttribute("warn", "Kayýt baþarýlý");			
			
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Kayýt hatalý");
				return mapping.findForward("exception");
		} 
		 finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	}
}
