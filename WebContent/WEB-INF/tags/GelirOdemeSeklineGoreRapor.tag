<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<title>odemeSekli</title>

<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</head>
<body>
<c:if test="${not empty odemeSeklineGoreGelirList}">
	<label class="fonte">Ödeme Sekline Göre Gelir Durumu :</label>

	<br>
	<table class="sofT" >
		<tr>
			<td class="helpHed" >Odeme Sekli</td>
			<td class="helpHed" >Toplam Tutar</td>
		</tr>
		<c:forEach items="${odemeSeklineGoreGelirList}"
			var="odemeSekliList">
			<tr>
				<td class="helpBod" >
				
				<c:choose>
				<c:when test="${odemeSekliList.odemeTuru eq '2'}"> Pesin</c:when>
				<c:when test="${odemeSekliList.odemeTuru eq '3' }"> Taksit</c:when>
				<c:when test="${odemeSekliList.odemeTuru eq '4' }"> Kredi Karti</c:when>
				
				</c:choose>
			
				
				</td>
				<td class="helpBod" >${odemeSekliList.miktar} </td>
			</tr>
		</c:forEach>
	</table>
</c:if>
</body>
</html>