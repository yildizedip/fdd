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
<link rel="stylesheet" href="css/edip.css" 	type="text/css" />

<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true"%>
</head>
<body>
<c:if test="${not empty sessionScope.gelirList}">
<label class="fonte">   <jsp:doBody /> tarihleri arasinda ; <br> </label>
<label class="fonte">Gelir Listesi</label>
	<table class="sofT" >	
		<tr>
			<td class="helpHed" ></td>
			<td class="helpHed">Tarih</td>
			<td class="helpHed" >Doktor</td>
			<td class="helpHed">Ödeme Sekli</td>
			<td class="helpHed">Miktar</td>
			<td class="helpHed">Aciklama</td>
			<c:if test="${silAktif ne '0' }">
						<td class="helpHed" > </td>
			</c:if>
	
		</tr>
		<c:forEach items="${sessionScope.gelirList}" var="gelir" varStatus="count">
		<tr>
		    <td class="helpBod" > ${count.count}</td>
			<td class="helpBod">${gelir.tarih}</td>
			<td class="helpBod">${gelir.dAd}  ${gelir.dSoyAd}  </td>
			<td class="helpBod">${gelir.odemeSekliStr}</td>
			<td class="helpBod">${gelir.miktar} ${gelir.paraBirimi }</td>
			<td class="helpBod">${gelir.aciklama}</td>
			<c:if test="${silAktif ne '0' }">
					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
					<td class="helpBod" ><html:link action="/SilGelir?id=${gelir.id}"> Sil </html:link>  </td>
			</c:if>			
			
			</c:if>			
		</tr>
	
		</c:forEach>
		
	</table>
</c:if>
</body>
</html>