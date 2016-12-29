<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="myTagLib" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>DF-Ana Sayfa</title>
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<style type="text/css">
body {
	background-image: url(Images/366_6.jpg);
	font-family: "Verdana", "Times New Roman", Times, serif;
	color: #666;
	background-repeat: repeat-x;
	font-size: 0.8em;
}

#main {
	background-color: #FFF;
	width: 1050px;
	margin-right: auto;
	margin-left: auto;
}

#menu {
	padding-left: 15px;
	text-align: center;

}
#banner {
	margin: 3px;
}



#icerik {
	margin: 2px;
	padding: 15px;
}

#alt {
	margin: 5px;
	text-align: right;
	font-size: 70%;
}

/* CSS DROPDOWN LIST MENU BASLA */
#nav,#nav ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
	list-style-position: outside;
	position: relative;
	line-height: 1.5em;
	
}

#nav a {

	display: block;
	padding: 0px 5px;
	border: 1px solid #333;
	font-size:11px;
	text-align:center;
	color:graytext;
	background-color: #CECEFF;
	text-decoration: none;	
	width: 250px;
}

#nav a:hover {
	background-color: #fff;
	color: #333;
	
}

#nav li {
	float: left;
	position: relative;
	
}

#nav ul {
	position: absolute;
	display: none;
	width: 12em;
	top: 1.5em;
	
}

#nav li ul a {
	width: 12em;
	height: auto;
	float: left;
	background-color:#CECEFF;
	width: 250px;
}

#nav ul ul {
	top: auto;
}

#nav li ul ul {
	left: 12em;
	margin: 0px 0 0 10px;
}

#nav li:hover ul ul,#nav li:hover ul ul ul,#nav li:hover ul ul ul ul {
	display: none;
}

#nav li:hover ul,#nav li li:hover ul,#nav li li li:hover ul,#nav li li li li:hover ul
	{
	display: block;
}
/* CSS DROPDOWN LIST MENU BITIR */
</style>

<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script language=JavaScript>
	function mainmenu() {
		$(" #nav ul ").css({
			display : "none"
		});
		$(" #nav li").hover(function() {
			$(this).find('ul:first').css({
				visibility : "visible",
				display : "none"
			}).show(400);
		}, function() {
			$(this).find('ul:first').css({
				visibility : "hidden"
			});
		});
	}

	$(document).ready(function() {
		mainmenu();
	});

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

<c:if test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.invalidate();
	%>
	<jsp:forward page="login4.jsp"></jsp:forward>
</c:if>


<div id="main">

<div id="banner">
<c:import url="FrameUstBaslik.jsp">

</c:import>



</div>


<div id="menu">
<c:forEach items="${kullaniciMenuList}" var="menu">
	<c:choose>
		<c:when test="${menu.ustMenuId eq 0 }">
			<ul id="nav" >
				<li> <a> ${menu.menuAd}   </a>  
					<c:if test="${menu.subMenu[0] ne null}">
					<ul>
					<c:forEach items="${menu.subMenu}" var="subMenu" >
						<li> <a href="${subMenu.menuPage}" target="frame" > ${subMenu.menuAd} </a>	 </li> 						
					</c:forEach>					
					</ul>					
					</c:if>
					
				</li>
			</ul>

		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</c:forEach>

</div>

<div id="icerik">

<iframe src="LabIslemSorgula.jsp" name="frame"
	width="1020" height="520" frameborder="0" scrolling="auto"></iframe>
	
</div>
<div id="icerikTemizle"></div>
<div id="alt">DF Grup &copy; 2012</div>

</div>
</body>
</html>