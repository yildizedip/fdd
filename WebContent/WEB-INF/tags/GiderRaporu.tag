<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true" %>
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script src="/js/jquery-3.1.1.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/epoch_classes.js"></script>
<script src="/script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"	href="/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="/styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/styles/main.css">
<link rel="stylesheet" href="/css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="/css/edip.css" type="text/css" />
</head>
<body>
	<c:if test="${not empty giderList}">
		
		<table  class="table table-bordered">
		<tr> <td class="bg-warning" colspan="8" align="center"  > Gider Listesi </td> </tr> 
			<tr>
				<td class="helpHed"></td>
				<td class="helpHed">Tarih</td>
				<td class="helpHed">Gider Turu</td>
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