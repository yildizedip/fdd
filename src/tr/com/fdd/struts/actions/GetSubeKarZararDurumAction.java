package tr.com.fdd.struts.actions;


import java.sql.Connection;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import net.sf.hibernate.Session;
import net.sf.hibernate.Transaction;
import tr.com.fdd.dto.TSubeKarZarar;


public class GetSubeKarZararDurumAction extends GenericAction {

	@Override
	public ActionForward executeCode(Session session, Connection conn,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans)
			throws Exception {

		String basTar = request.getParameter("baslangicTarihi");
		String bitTar = request.getParameter("bitisTarihi");
		
		try {

			SQLUtils sqlUtils = new SQLUtils();

			List<TSubeKarZarar> gelirList = sqlUtils.getTotalGelir(conn, basTar, bitTar);
			List<TSubeKarZarar> giderList = sqlUtils.getTotalGider(conn, basTar, bitTar);
			List<TSubeKarZarar> implantList = sqlUtils.getTotalImplantCount(conn, basTar, bitTar);
			List<TSubeKarZarar> implantListKesinlesmemis = sqlUtils.getTotalImplantKesinlesmemisCount(conn, basTar, bitTar);
			
			List<TSubeKarZarar> tedaviMiktar = sqlUtils.getTotalTedaviMiktar(conn, basTar, bitTar);
			List<TSubeKarZarar> tedaviMiktarKesinlesmemis = sqlUtils.getTotalTedaviKesinlesmemisMiktar(conn, basTar, bitTar);
			
			for (int i = 0; i < gelirList.size(); i++) {
				
				TSubeKarZarar gelir = gelirList.get(i);
				
				gelir.setGelirStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getGelir()));
				
				
				for (TSubeKarZarar gider : giderList) {
					if(gelir.getSubeId()==gider.getSubeId())
					{
						gelir.setGider(gider.getGider());
						
						gelir.setGiderStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getGider()));
						
						gelir.setKar(gelir.getGelir() - gelir.getGider());
						
						gelir.setKarStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getKar()));
					}
					
				}
				
				for (TSubeKarZarar implant : implantList) {
					
					if(gelir.getSubeId()==implant.getSubeId())
					{
						gelir.setImplantSay(implant.getImplantSay());
					}
					
				}
				
				for (TSubeKarZarar implant : implantListKesinlesmemis) {
					
					if(gelir.getSubeId()==implant.getSubeId())
					{
						gelir.setImplantSayKesinlesmemis(implant.getImplantSayKesinlesmemis());
					}
					
				}
				
				for (TSubeKarZarar implant : tedaviMiktar) {
					
					if(gelir.getSubeId()==implant.getSubeId())
					{
						gelir.setTedaviMiktar(implant.getTedaviMiktar());
						gelir.setTedaviMiktarStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getTedaviMiktar()));
					}
					
				}
				
				for (TSubeKarZarar implant : tedaviMiktarKesinlesmemis) {
					
					if(gelir.getSubeId()==implant.getSubeId())
					{
						gelir.setTedaviMiktarKesinlesmemis(implant.getTedaviMiktarKesinlesmemis());
						gelir.setTedaviMiktarKesinlesmemisStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getTedaviMiktarKesinlesmemis()));
						
						gelir.setMiktarFark(gelir.getTedaviMiktar()-gelir.getTedaviMiktarKesinlesmemis());
						
						gelir.setMiktarFarkStr(NumberFormat.getNumberInstance(Locale.US).format(gelir.getMiktarFark()));
						
					}
					
				}
				
				
				
			}
			
			
			
			if (gelirList.size() > 0) {
				request.setAttribute("subeKarZararList", gelirList);
			}
			
			return mapping.findForward("success");

		} catch (SQLException e) {
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
