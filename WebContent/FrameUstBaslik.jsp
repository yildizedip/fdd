<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

<title></title>

<link rel="stylesheet" href="css/edip.css" type="text/css" />
<style type="text/css">
#ana {
	font-size: 11px;
	color:rgb(186,165,80);
}

#banner {
	float: left;
}

#guncelle {
	float: left;
	padding: 5px;
	width: 370px;
	background-color: #DFDFFF;
	border: 1px solid #060;
	margin-right: 5px;
	margin-left: 5px;
	margin-top: 10px;
	font-size: 11px;
}
#userInf {
	float: right;
	width: 810px;
	text-align: right;
}

#temizle {
	clear: both;
}
#ana #userInf table tr td select {
	list-style-type: circle;
	font-size: 10px;
	
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	
}




</style>
<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>
<script type="text/javascript">




</script>

</head>

<body>
<c:if test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.invalidate();
	%>
	<jsp:forward page="login.jsp"></jsp:forward>
</c:if>

<div id="ana">

<table class="sofT" >
	<tr>
		<td>
		<p>Hoşgeldiniz ${sessionScope.sessionMember[1].kuAd }	${sessionScope.sessionMember[1].kuSoyad },
		<p>
		</td>

		<td >
		<p>${sube.sAd},
		<p>
		</td>
		<td> <a href="#dialogBilgilerimiGuncelle"  name="modal" 
			style=" text-decoration: none">
		Bilgilerim </a> </td>
		
		
		<td> <a href="#dialogSifremiDegistir"  name="modal" 
			style=" text-decoration: none">
		Şifremi Değiştir </a> </td>

		<td>
		<p><a href="logout.jsp" 
			style="color: red; font-style: oblique; text-decoration: none">
		Çıkış </a>
		</td>

	</tr>

</table>

<div id="temizle"></div>
</div>

<!--  BILGILERIM ALANLARI SETLENIYOR... -->
</body>
</html>