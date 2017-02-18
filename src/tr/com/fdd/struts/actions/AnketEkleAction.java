package tr.com.fdd.struts.actions;


import java.sql.Connection;
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

import tr.com.fdd.dto.TAnketDTO;
import tr.com.fdd.struts.form.AnketForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class AnketEkleAction extends GenericAction {
	@Override
	public ActionForward executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans){
		Transaction tran = null;
		try {
			TAnketDTO anketDTO= new TAnketDTO();
			
			AnketForm anketForm=(AnketForm) form;
			String saat=anketForm.getSaat();
			String dk=anketForm.getDakika();
			
			anketForm.setSaat(saat+":"+dk);
			anketForm.setDurum("A");
			anketForm.setArayanKisi(Commons.getActiveSession(request).getKuId());
			if(anketForm.getTarihStr()==null)
				anketForm.setTarih(new Date());
			else{
			String tarihStr= anketForm.getTarihStr();			
		    anketForm.setTarih(Commons.convertStringToDate(tarihStr));
			}
			
			anketForm.setKayitTarihi(new Date());
		
			BeanUtils.copyProperties(anketDTO, anketForm );					
			
			tran = session.beginTransaction();
			session.save(anketDTO);
			tran.commit();
			request.setAttribute("warn", GUIMessages.KAYIT_EKLEME_BASARILI);	
			
			Commons.refreshSelectedHasta(request, connection, anketForm.getHastaId());
			
			
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
