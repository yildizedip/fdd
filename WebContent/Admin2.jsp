<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title></title>

<style type="text/css">
body {
	background-image: url(Images/366_6.jpg);
	font-family: "Verdana", "Times New Roman", Times, serif;
	color: #666;
}

#mainPages {
	background-color: #FFF;
	width: 1050px;
	margin-right: auto;
	margin-left: auto;
}

#menu {
	text-align: left;
	width: 220px;
	margin: 10px;
	float: left;
	font-size: 80%;
}

#menu h1 {
	display: block;
	background-color: #FF9900;
	font-size: 80%;
	padding: 3px 0 5px 3px;
	border: 1px solid #000000;
	color: #333333;
	margin: 0px;
	width: 220px;
	text-align: center;
}

#menu ul {
	list-style: none;
	margin: 0px;
	padding: 0px;
	border: none;
}

#menu ul li {
	margin: 0px;
	padding: 0px;
}

#menu ul li a {
	font-size: 85%;
	display: block;
	border-bottom: 1px dashed #C39C4E;
	padding: 4px 0px 4px 3px;
	text-decoration: none;
	color: #666666;
	width: 220px;
}

#menu ul li a:hover,#menu ul li a:focus {
	color: #000000;
	background-color: #eeeeee;
}

#icerik {
	margin: 2px;
	padding: 2px;
	float: left;
}

#icerikTemizle {
	clear: left;
}

#alt {
	margin: 5px;
	text-align: right;
	font-size: 70%;
}

#banner {
	margin: 2px;
}
</style>
<script language=JavaScript>
	document.onmousedown = click;

	var times = 0;

	var times2 = 10;

	function click() {

		if ((event.button == 2) || (event.button == 3)) {

			if (times >= 1) {

			}

			alert("Sağ tık çalışmamaktadır!");

			times++;
		}
	}
</script>
</head>
<body>
<div >


<c:if
	test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.invalidate();
	%>
	<jsp:forward page="login4.jsp"></jsp:forward>
	
	
</c:if>

<div id="banner"><c:import url="FrameUstBaslik.jsp"></c:import></div>
<div id="menu">

<h1>TANIMLAMALAR</h1>
<ul>
	<li><html:link page="/SubeEkleGuncelleSil.jsp"
		target="frame"> Şube Ekle Güncelle Sil </html:link></li>
	<li><html:link page="/KullaniciEkleGuncelleSil.jsp"
		target="frame"> Kullanıcı Ekle Güncelle Sil </html:link></li>
	
	<li><html:link page="/DoktorEkleGuncelleSil.jsp"
		target="frame"> Doktor İşlemleri </html:link></li>
	
	<li><html:link page="/GiderTuruEkle.jsp"
		target="frame"> Gider Türü Ekle Güncelle Sil  </html:link></li>
		
		
	<li><html:link page="/SubeOperasyonFiyatEslestir.jsp"
		target="frame">Tedavi Fiyat Tanımla </html:link></li>

</ul>
</div>
<div id="icerik"><iframe src="Statistics.jsp" name="frame"
	width="770" height="520" frameborder="0" scrolling="auto"></iframe></div>
<div id="icerikTemizle"></div>
<div id="alt">DF Grup &copy; 2012</div>
</div>
</body>
</html>