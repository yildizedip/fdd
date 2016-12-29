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

<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true" %>


<link rel="stylesheet" href="css/edip.css" type="text/css" />
</head>
<body>
	<c:if test="${not empty giderList}">
	<label class="fonte">   <jsp:doBody /> tarihleri arasinda ; <br> </label>
		
		<table width="700" class="sofT">
		<tr> <td class="helpHed" colspan="8" > Gider Listesi </td> </tr> 
			<tr>
				<td class="helpHed"></td>
				<td class="helpHed">Tarih</td>
				<td class="helpHed">Gider Türü</td>
				<td class="helpHed">Odeme Sekli</td>
				<td class="helpHed">Miktar</td>
				<td class="helpHed">Aciklama</td>
				<c:if test="${silAktif ne '0' }">
				<c:if test="${sessionScope.sessionMember[0].kuTur eq '4' }">
				<td class="helpHed"></td>
				<td class="helpHed"></td>
				</c:if>
				</c:if>
			</tr>
			<c:forEach items="${giderList}" var="gider"
				varStatus="count">
				<tr>
					<td class="helpBod" >${count.count}</td>
					<td class="helpBod" >${gider.tarihStr}</td>
					<td class="helpBod" >${gider.turAd}</td>
					<td class="helpBod" >${gider.odemeSekliStr}</td>
					<td class="helpBod" >${gider.miktar} ${gider.paraBirimi }</td>
					<td class="helpBod" >${gider.aciklama}</td>
					<c:if test="${silAktif ne '0' }">
						<c:if test="${sessionScope.sessionMember[0].kuTur eq '4' }">
						<td class="helpBod"><html:link action="/SilGider?id=${gider.id}"> Sil </html:link>
						</td>
						<td class="helpBod"><html:link action="/GiderGuncelle?id=${gider.id}"> Güncelle </html:link>
						</td>
						</c:if>
					</c:if>
				</tr>

			</c:forEach>
			<tr> <td colspan="4" class="helpBod" style="font-size: 13px; color: blue; " > TOPLAM MIKTAR </td> <td class="helpBod" style="font-size: 13px; color: blue; " > ${toplamGider} </td> <td class="helpBod" colspan="3"></td> </tr>


		</table>
	</c:if>
</body>
</html>