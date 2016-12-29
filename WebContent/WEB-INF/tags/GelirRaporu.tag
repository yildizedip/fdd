<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>odemeSekli</title>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true"%>
<%@ attribute name="implantSayfasimi" required="false" rtexprvalue="true"%>
</head>
<body>
<c:if test="${not empty gelirList}">
	<label class="fonte"> <jsp:doBody /> tarihleri arasinda ; <br>
	</label>
	
	<table class="sofT" >
	<tr> <td class="helpHed" colspan="10" > Gelir Listesi </td> </tr> 
		<tr>
			<td class="helpHed"></td>
			<td class="helpHed">Tarih</td>
			<td class="helpHed">Ptk. No</td>
			<td class="helpHed">Ad Soyad</td>
			<td class="helpHed">Operasyon</td>
			<td class="helpHed">Adet</td>
			<td class="helpHed">Doktor</td>			
			<td class="helpHed">Ödeme</td>
				<c:if test="${implantSayfasimi ne 'evet' }">
				
				<td class="helpHed">Miktar</td>
				
				</c:if>
			
			

			<td class="helpHed">Aciklama</td>
			<c:if test="${silAktif ne '0' }">
				<td class="helpHed"></td>
			</c:if>
			
			<c:if test="${implantSayfasimi eq 'evet' }">
				
				<td class="helpHed"></td>
				
				</c:if>

		</tr>
		<c:forEach items="${gelirList}" var="gelir" varStatus="count">
			<tr>
				<td class="helpBodSmall">${count.count}</td>
				<td class="helpBodSmall" style="width: 96px; ">${gelir.odemeTarihiStr}</td>
				<td class="helpBodSmall">${gelir.hasta.protokolNo}</td>
				<td class="helpBodSmall">${gelir.hasta.ad} ${gelir.hasta.soyad}</td>
				
				<td class="helpBodSmall"> ${gelir.islemTip.ad}  </td>
				<td class="helpBodSmall"> ${gelir.islem.disAdet}  </td>
				<td class="helpBodSmall">${gelir.doktor.dAd}   ${gelir.doktor.dSoyad}  </td>
			
				<td class="helpBodSmall">
				
				<c:choose>
					<c:when test="${gelir.odemeTuru eq 2}">
			Pesin
			</c:when>
					<c:when test="${gelir.odemeTuru eq 3}">
			Taksit
			</c:when>
				</c:choose></td>
				
				<c:if test="${implantSayfasimi ne 'evet' }">
				
				<td class="helpBodSmall">${gelir.miktar}</td>
				
				</c:if>
				<td class="helpBodSmall">${gelir.aciklama}</td>
				<c:if test="${silAktif ne '0' }">
					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
						<td class="helpBod"><html:link
							action="/SilGelir?id=${gelir.id}"> Sil </html:link></td>
					</c:if>

				</c:if>
				
				<c:if test="${implantSayfasimi eq 'evet' }">
				
				<td class="helpBodSmall"></td>
				
				</c:if>
			</tr>

		</c:forEach>
		
			<c:if test="${implantSayfasimi ne 'evet' }">
				
				<tr> <td colspan="8" class="helpBod" style="font-size: 13px; color: blue; " >
	
		 TOPLAM MIKTAR </td> <td class="helpBod" style="font-size: 13px; color: blue; " > ${toplamGelir} </td> <td class="helpBod"></td> </tr>

				
				</c:if>
		
		
	</table>
</c:if>
</body>
</html>