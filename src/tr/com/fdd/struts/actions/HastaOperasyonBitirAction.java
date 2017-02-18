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

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class HastaOperasyonBitirAction extends GenericAction {

	@Override
	public ActionForward  executeCode(Session sess, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) {
		
		Transaction tran=null;		
	
		try{
			String islemId=	request.getParameter("id");
			String hastaId=	request.getParameter("hastaId");
			String opBitTarihi= request.getParameter("tarihStr");
			
			Date date= null;
			
			if(opBitTarihi==null)
				date= new Date();
			else
				date=  Commons.convertStringToDate(opBitTarihi);
			
			
			int id=Integer.parseInt(islemId);	
			
			IslemForm islemForm=(IslemForm) form;
			TIslemDTO islemDto= new TIslemDTO();
			
			
			BeanUtils.copyProperties(islemDto, islemForm );	
			
			tran = sess.beginTransaction();
			Query query = sess.createQuery("from tr.com.fdd.dto.TIslemDTO  " +
					"p where p.id = :var");
			query.setInteger("var", id);
			TIslemDTO result = (TIslemDTO) query.uniqueResult();
			
			result.setDurumu("B");
			result.setIslemBitisTarihi(date);
			tran.commit();	    
	            
	        request.setAttribute("warn", GUIMessages.OPERASYON_BITIRILDI);
	        
	        Commons.refreshSelectedHasta(request, connection, result.getHastaId());
	        
	       
//	        /**
//	         * operasyon bitirildiginde tekrar sayfada verilerin goruntulenmesi icin eklendi
//	         */
//	        SQLUtils sqlUtils=  new SQLUtils();
//			
//	        Connection conn= SQLUtils.getMySqlConneciton();
//			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
//			THastaDTO hasta = sqlUtils.getHasta(new Integer(hastaId), conn, subeId.intValue());
//			
//			request.setAttribute("hasta", hasta);
//			
//			List<TIslemDTO> hastaOperasyonListesi = sqlUtils
//					.getHastaOperasyonOdemeListesi(hasta.getId(), conn);
//			request.setAttribute("hastaOperasyonListesi",		hastaOperasyonListesi);
	        
	        return mapping.findForward("success");
			
		}
		catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
			e.printStackTrace();
				request.setAttribute("warn", GUIMessages.HATA);
				return mapping.findForward("exception");
		}
		
		finally {
			if (sess != null && sess.isOpen())
				try {
					sess.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
		
		
		
	}
	
	
}
