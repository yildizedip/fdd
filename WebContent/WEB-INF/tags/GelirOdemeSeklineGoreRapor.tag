<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>

<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
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


<c:if test="${not empty odemeSeklineGoreGelirList}">
	<h4>Ödeme Sekline Göre Gelir Durumu</h4>

	<table class="table" >
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