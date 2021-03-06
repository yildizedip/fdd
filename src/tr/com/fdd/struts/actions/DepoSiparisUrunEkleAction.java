package tr.com.fdd.struts.actions;


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

import tr.com.fdd.dto.TDepoSiparisDTO;
import tr.com.fdd.struts.form.DepoSiparisUrunForm;
import tr.com.fdd.utils.GUIMessages;

public class DepoSiparisUrunEkleAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Transaction tran = null;
		Session session=null;
		try {
			TDepoSiparisDTO dto= new TDepoSiparisDTO();
			
			DepoSiparisUrunForm frm= (DepoSiparisUrunForm) form;
			frm.setDurum(1);
			
			BeanUtils.copyProperties(dto, frm);					
			
			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			session.save(dto);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);			
			
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", GUIMessages.HATA);
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
