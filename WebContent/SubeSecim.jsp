<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<title>DF-Şube Seç</title>
<style type="text/css">
#main {
	height: 500px;
	width: 700px;
	margin-right: auto;
	margin-left: auto;
	background-color: #FFF;
	font-family: "Verdana", Courier, monospace;
	font-size: 12px;
	color: #999;
}

#HastaIstatistikleri {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
}

#KullanimIstatistikleri {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
	float: left;
}

#temizle {
	clear: left;
}

#topGider {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
	float: left;
}

body {
	background-image: url();
	background-repeat: repeat-x;
}
</style>
</head>
<body >
<div id="main">
<div id="HastaIstatistikleri">

	<c:if
			test="${sessionScope.sessionMember[0] eq null}">
			<%
				session.invalidate();
			%>
			<jsp:forward page="login4.jsp"></jsp:forward>
	</c:if>


<c:if
	test="${sessionMemberSube[1] eq null  }">

</c:if> 

YEKİLİ OLUNAN ŞUBELER...
<hr>
<table class="sofTSmall">
	<tr>
		<td class="helpHed" ></td>
		<td class="helpHed">Şube Ad</td>
		<td class="helpHed"></td>
	</tr>
	<c:forEach items="${sessionMemberSube}" var="sube" varStatus="count">
		<tr>
		<td class="helpBod">${count.count }</td>
			<td class="helpBod">${sube.sAd }</td>			
			<td class="helpBod"> 
			
			<form action="LoginSystemAction.do" method="post">
				
				<input type="submit" value="Giriş" />
				<input type="hidden" name="subeId" value="${sube.sId}" > <br>
				
			</form>
			
			</td>
		</tr>

	</c:forEach>

</table>
</div>
</div>
</body>
</html>