package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.TIslemDTO;
import tr.com.fdd.utils.GenelDegiskenler;


public class GetDoktorOperasyonListesiAction extends Action {
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {	
		Connection conn=null;
		try{			 
			
		String kullaniciId=request.getParameter("kuId");
		String hastaAd=request.getParameter("hastaAd");
		String hastaSoyad=request.getParameter("hastaSoyad");
		String durum=request.getParameter("durum");
		String islemTip=request.getParameter("islemTip");
		
		String basTar = request.getParameter("bas_tar");
		String bitTar = request.getParameter("bit_tar");
		
		SQLUtils sqlUtils= new SQLUtils();
		conn =SQLUtils.getMySqlConneciton();
		TDoktorDTO doktor= sqlUtils.getDoktor(Integer.parseInt(kullaniciId), conn);

		Integer subeId= (Integer) request.getSession().getAttribute("subeId");
		
		List<TIslemDTO>  operasyonListesi= sqlUtils.getDoktorOperasyonLisesi( doktor.getdId(),hastaAd, hastaSoyad,durum, Integer.parseInt(islemTip),  conn, subeId.intValue(),basTar,bitTar);
		 
//			if( operasyonListesi.size()==0 )
//			{
//				request.setAttribute("noContent", "Kay�t Bulunamad�" );
//				return mapping.findForward("noContent");
//								
//			}
//			else 
				if(islemTip.equals(GenelDegiskenler.ImplantliOperasyon._VAR.toString())){
				request.setAttribute("doktorOperasyonListesi", operasyonListesi);
				return mapping.findForward("gotoDoktorImplantPage");
			}
			else
			{
				
				request.setAttribute("doktorOperasyonListesi", operasyonListesi);
				
				return mapping.findForward("success");			
			}
				
		 }
	 catch (Exception e) {
				try {
					conn.rollback();
					conn.close();
					request.setAttribute("exception", e);
				} catch (SQLException e1) {
					request.setAttribute("exception", e);
					return mapping.findForward("exception");
				}
				request.setAttribute("exception", e);
				return mapping.findForward("exception");
			} 
	 finally {
				try {
					conn.close();
				} catch (SQLException e) {
					
					e.printStackTrace();
					request.setAttribute("exception", e);
					return mapping.findForward("exception");
			}
	}		 
	}

	
}
