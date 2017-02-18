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
<c:if test="${not empty opersyonTuruneGoreGelirList}">
	<label class="fonte">Operasyon Turune Gore Gelir Durumu :</label>

	<br>
	<table class="sofT" >
		<tr>
			<td class="helpHed" >Operasyon Turu</td>
			<td class="helpHed" >Toplam Tutar</td>
		</tr>
		<c:forEach items="${opersyonTuruneGoreGelirList}"
			var="operasyonTuruList">
			<tr>
				<td class="helpBod" >
				
				${operasyonTuruList.islemTip.ad}
			
				
				</td>
				<td class="helpBod" >${operasyonTuruList.miktar} </td>
			</tr>
		</c:forEach>
	</table>
</c:if>
</body>
</html>