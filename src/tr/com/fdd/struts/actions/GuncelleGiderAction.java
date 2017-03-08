package tr.com.fdd.struts.actions;

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

import tr.com.fdd.dto.TGelirGiderDTO;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;

public class GuncelleGiderAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		
		String idStr=	request.getParameter("id");
		int id= new Integer(idStr).intValue();	
		
		String miktar=request.getParameter("miktar");
		
		double miktarDouble= Double.parseDouble(miktar);
		
		String aciklama=request.getParameter("aciklama");
		String giderTuru=request.getParameter("giderTuru");
		String tarih=request.getParameter("tarihstr");
		
		
		
		Session sess= null;
		Transaction tran=null;
		try{
			sess=GenericAction.getHibernateSession();
			tran = sess.beginTransaction();
					
			
			Query gelirGiderDTO = sess.createQuery("from tr.com.fdd.dto.TGelirGiderDTO  p where p.id = :var");
			gelirGiderDTO.setInteger("var", new Integer(id).intValue());
			
			
			TGelirGiderDTO result = (TGelirGiderDTO) gelirGiderDTO.uniqueResult();
			result.setAciklama(aciklama);
			result.setMiktar(miktarDouble);
			result.setTarih(Commons.convertStringToDate(tarih));
			result.setGiderTuru(giderTuru);
	        
			tran.commit();
	            
	        request.setAttribute("warn", GUIMessages.ISLEM_BASARILI);
	        return mapping.findForward("success");
			
		}
		catch (Exception e) {
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
