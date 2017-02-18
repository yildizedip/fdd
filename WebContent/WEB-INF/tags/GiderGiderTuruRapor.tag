
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true"%>
<%@ attribute name="implantSayfasimi" required="false"
	rtexprvalue="true"%>


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


<link type="text/css" rel="stylesheet"
	href="/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="/styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/styles/main.css">
<link rel="stylesheet" href="/css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="/css/edip.css" type="text/css" />

</head>
<body>
	<c:if test="${not empty giderIstatistikler[0]}">



		<table class="table table-bordered">
			<tr>
				<td colspan="2"
					 class="bg-warning" align="center" > Gider Bazli Rapor
				</td>
			</tr>
			<tr>
				<td class="helpHed">Gider Turu</td>

				<td class="helpHed">Toplam Tutar</td>
			</tr>
			<c:forEach items="${giderIstatistikler[0]}" var="dto">
				<tr>
					<td class="helpBod">${dto.giderTuru }</td>

					<td class="helpBod">${dto.miktar}${dto.paraBirimi}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>