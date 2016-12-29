<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Dicle Fırat Diş Hastanesi Giriş</title>
<style type="text/css">
#stylefour {
	position: relative;
	display: block;
	height: 39px;
	font-size: 11px;
	font-weight: bold;
	background: transparent url(../img/bgOFF.gif) repeat-x top left;
	font-family: Arial, Verdana, Helvitica, sans-serif;
	border-top: 4px solid #B30000;
}

#stylefour ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
	width: auto;
}

#stylefour ul li {
	display: block;
	float: left;
	margin: 0;
}

#stylefour ul li a {
	display: block;
	float: left;
	color: #666;
	text-decoration: none;
	padding: 11px 20px 0 20px;
	height: 23px;
	background: transparent url(../img/bgDIVIDER.gif) no-repeat top right;
}

#stylefour ul li a:hover,#stylefour ul li a.current {
	color: #B30000;
	background: #fff url(../img/bgON.gif) no-repeat top right;
}
</style>

<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<script type="text/javascript">
	function load() {
		var load = window
				.open('login4.jsp');
								load.moveTo(0, 0);
	}
</script>
</head>
<body bgcolor="#F2F2F2" >
<div align="center">
<table border="0" width="963" cellspacing="1">
	<tr>
		<td colspan="2" align="left" width="0" height="0" valign="top"
			style="background-color: white;"><font color="#808080"> <img
			src="Images/Banner.jpg"> </font>
			</td>
	</tr>
	
	<tr>
		<td colspan="2" bgcolor="#F2F2F2"> 
		
		<div id="stylefour">
				<ul>
					<li><a href="htmlPages/main.html"
						title="css menus" target="frame" >Ana Sayfa</a></li>
					<li><a href="htmlPages/hizmetlerimiz.html"
						title="css menus" target="frame" >Hizmetlerimiz </a></li>
					<li><a href="htmlPages/main.html"
						title="css menu" target="frame" >Doktorlarımız</a></li>
					<li><a href="htmlPages/main.html"
						title="css menus" target="frame">Sıkça Sorulan Sorular</a></li>
					<li><a href="htmlPages/main.html"
						title="css menus" target="frame">İletişim</a></li>
					<li></li>
							<li>  </li>
									<li></li>
					<li style=" right: "><a id="btn_login"
					href="javascript:load()" style="text-decoration: none"> <font
					color="#008000"> İşlemler </font> </a></li>
				</ul>
				</div>		
		</td>		

	</tr>
	<tr>
		<td align=left valign=top bordercolor="#FFFFFF" bgcolor="#FFFFFF">

		<font
			color="#808080"> </font> <iframe src="htmlPages/main.html"
			scrolling="auto" align="top" name="frame" frameborder="0" width="900"
			height="500"> </iframe>

		</td>

		<td bordercolor="#FFFFFF" bgcolor="#FFFFFF" align="left" valign="top"></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" colspan="2"><span style="font-size: 11px">
		<font face="Tahoma" color="#C0C0C0"> </font><font face="Tahoma"
			color="#808080">Adres...:Cudi Mah. Adnan Menderes Cad. No:7
		Silopi / Şırnak </font> </span><font face="Tahoma"><font color="#808080">
		<span style="font-size: 11px"> </span></font> <font style="color: #808080;">
		<span style="font-size: 11px">   Telefon...: 0 486 518 21 00 -
		0 505 783 13 54 </span> </font></font>
		</td>

	</tr>
</table>
</div>
</body>
</html>