package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.struts.form.GelirGiderForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class AddGiderAction extends GenericAction {
	
	@Override
	public ActionForward executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {
		Transaction tran = null;
		try {
			TGelirGiderDTO tGelirGiderDto = new TGelirGiderDTO();
				
			GelirGiderForm gelirGiderForm=(GelirGiderForm) form;
			gelirGiderForm.setDurum("A");
		//	gelirGiderForm.setOdemeSekli("1");
			gelirGiderForm.setGirenKisi(Commons.getActiveSession(request).getKuId());
			
			if(gelirGiderForm.getTarihStr()==null)
				gelirGiderForm.setTarih(new Date());
			
			else{
			String tarihStr= gelirGiderForm.getTarihStr();
			
		    gelirGiderForm.setTarih(Commons.convertStringToDate(tarihStr));
			}
			// gelir 1 gider 2 olarak tanimlandi
			
			gelirGiderForm.setTip(2);			
			BeanUtils.copyProperties(tGelirGiderDto, gelirGiderForm );	
			
			tGelirGiderDto.setEklenmeTarihi(Commons.getNow());
			
			tran = session.beginTransaction();
			session.save(tGelirGiderDto);
			tran.commit();
			request.setAttribute("warn", GUIMessages.ISLEM_BASARILI);	
			request.setAttribute("tarih",gelirGiderForm.getTarihStr());
			
			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn",GUIMessages.ISLEM_BASARISIZ);
				return mapping.findForward("exception");
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
					return mapping.findForward("failure");
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
				else return mapping.findForward("failure");
		}
	}
}
