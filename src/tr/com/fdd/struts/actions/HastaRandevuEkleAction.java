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

import tr.com.fdd.dto.TDoktorDTO;
import tr.com.fdd.dto.THastaDTO;
import tr.com.fdd.dto.THastaRandevuDTO;
import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.struts.form.HastaRandevuForm;
import tr.com.fdd.utils.Commons;
import tr.com.fdd.utils.GUIMessages;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaRandevuEkleAction extends Action {
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HastaRandevuForm hastaRandevuForm = null;
		
		Transaction tran = null;
		Session session=null;

		try {
			
			SQLUtils sqlUtils = new SQLUtils();
			Connection conn = SQLUtils.getMySqlConneciton();
			Integer subeId = (Integer) request.getSession().getAttribute("subeId");
			
			
			hastaRandevuForm = (HastaRandevuForm) form;
			
//			if (hastaRandevuForm.getRandevuTarihiStr() == null)
//				hastaRandevuForm.setRandevuTarihi(new Date());
//			else {
//				String tarihStr = hastaRandevuForm.getRandevuTarihiStr();
//
////				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
////				Date convertedDate = dateFormat.parse(tarihStr);
////				hastaRandevuForm.setRandevuTarihi(convertedDate);
//			}
			

			session=GenericAction.getHibernateSession();
			tran = session.beginTransaction();
			
			THastaDTO tHastaDto=null;
			///yeni girilen hasta icin ekleme
			if(hastaRandevuForm.getHastaId()==0){
				
				tHastaDto = new THastaDTO();
				tHastaDto.setAd(hastaRandevuForm.getHastaAd());
				tHastaDto.setSoyad(hastaRandevuForm.getHastaSoyad());
				tHastaDto.setTel(hastaRandevuForm.getTelefon());
				tHastaDto.setSubeId(subeId);
				tHastaDto.setDurum("A");
				tHastaDto.setEklenmeTarihi(new Date());
				long lastProtokolNo=sqlUtils.getLastProtokolNo(conn, subeId);
				long protokolNo=lastProtokolNo+1;
				tHastaDto.setProtokolNo(Long.toString(protokolNo));
				
				Query query = session.createQuery("from tr.com.fdd.dto.THastaDTO  p where p.durum='A' " +
						" and p.subeId= :subeId and p.ad= :ad and p.soyad=:soyad and p.tel=:tel");
					query.setString("ad", tHastaDto.getAd());
					query.setString("soyad", tHastaDto.getSoyad());
					query.setString("tel", tHastaDto.getTel());
					query.setInteger("subeId", tHastaDto.getSubeId());
					List<THastaDTO> result =  query.list();
					
				int hasta_id=0;
				if(result.size()!=0){
					request.setAttribute("warn", GUIMessages.HASTA_VAR_RANDEVu);	
					return mapping.findForward("failure");
				}			
				else
				{
					hasta_id=(Integer) session.save(tHastaDto);
					hastaRandevuForm.setHastaId(hasta_id);
					
					Commons.addHasta2HastaList(tHastaDto, request);
				}
			}
			Object[] kullaniciBilgileri = (Object[]) request.getSession().getAttribute("sessionMember");
			TKullaniciLoginDTO kullanici = (TKullaniciLoginDTO) kullaniciBilgileri[0];
			hastaRandevuForm.setEkleyenKisi(kullanici.getKuId());
			hastaRandevuForm.setEklenmeTarihi(new Date());
			hastaRandevuForm.setDurum("A");
			
			THastaRandevuDTO tHastaRandevu = new THastaRandevuDTO();
			BeanUtils.copyProperties(tHastaRandevu, hastaRandevuForm );					
			session.save(tHastaRandevu);
			tran.commit();
			
			 conn = SQLUtils.getMySqlConneciton();
			
			request.setAttribute("warn", GenelDegiskenler.FormMessages.SUCCESS);
			TDoktorDTO doktorDTO=sqlUtils.getDoktor(-1,hastaRandevuForm.getDoktorId(), conn, true,subeId);
			
			request.setAttribute("selectedDoctor", doktorDTO);

			return mapping.findForward("success");
		} catch (Exception e) {
			if (tran != null)
				try {
					tran.rollback();
				} catch (HibernateException e1) {
					
					e1.printStackTrace();
				}
				request.setAttribute("warn", "Islem gercekleştirilirken hata oluştu.");
				return mapping.findForward("exception");
		} finally {
			if (session != null && session.isOpen())
				try {
					session.close();
				} catch (HibernateException e) {
				
					e.printStackTrace();
				}
		}
	}
}
