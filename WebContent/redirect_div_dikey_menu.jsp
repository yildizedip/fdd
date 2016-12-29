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
<title>DF-Ana Sayfa</title>

<style type="text/css">
body {
	background-image: url(Images/366_6.jpg);
	font-family: "Verdana", "Times New Roman", Times, serif;
	color: #666;
	background-repeat: repeat-x;
}

#main {
	background-color: #FFF;
	width: 1050px;
	margin-right: auto;
	margin-left: auto;
}

#menu {
	text-align: left;
	width: 220px;
	margin: 5px;
	float: left;
	font-size: 86%;
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

<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>
<script language=JavaScript>
	document.onmousedown = click;
	function click() {
		if ((event.button == 2) || (event.button == 3)) {
			alert("Sağ tık çalışmamaktadır!");
			times++;
		}
	}	
</script>
</head>
<body>
<div id="main"><c:if
	test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.invalidate();
	%>
	<jsp:forward page="login4.jsp"></jsp:forward>
</c:if>

<div id="banner"><c:import url="FrameUstBaslik.jsp"></c:import></div>

<div id="menu">
<!--  -->
<c:forEach items="${kullaniciMenuList}" var="menu">
<c:choose>
<c:when test="${menu.ustMenuId eq 0 }">
<h1> ${menu.menuAd}</h1>
</c:when>
<c:otherwise>
<ul>
<li> <a href="${menu.menuPage}" target="frame" >	${menu.menuAd}</a>
</li>
</ul>
</c:otherwise>
</c:choose>
</c:forEach>

</div>
<div id="icerik"><iframe src="Statistics.jsp" name="frame"
	width="770" height="520" frameborder="0" scrolling="auto"></iframe></div>
<div id="icerikTemizle"></div>
<div id="alt">DF Grup &copy; 2012</div>

</div>
</body>
</html>