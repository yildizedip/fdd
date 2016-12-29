<%@ page language="java" contentType="text/html; charset=iso-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
<title>Dicle Fırat Diş Hastanesi Giriş</title>

<link href="css/login-box.css" rel="stylesheet" type="text/css" />




<style type="text/css">
body {
	background-image: url("Images/366_6.jpg");
	background-repeat: repeat-x;
}
#main {
	padding: 13px;
	width: 600px;
	margin-right: auto;
	margin-left: auto;
	background-color: #FBFBFB;
}
#alt {
	padding: 7px;
	width: 700px;
	margin-top: 7px;
	margin-right: auto;
	margin-left: auto;
	background-color: #FFF;
	color: #666;
}
#main #menu ul {
	margin: 0px;
	padding: 0px;
	list-style-type: none;
}
#main #menu ul li {
	float: none;
}
#main #menu ul li a {
	display: block;
	color: #999;
	text-decoration: none;
	background-color: #FFFFCC;
	line-height: 24px;
	padding-top: 2px;
	padding-right: 5px;
	padding-bottom: 2px;
	padding-left: 12px;
}
#telefon {
	margin-left: 210px;
	width: 230px;
	font-size: 30px;
	color: #74B0EE;
	background-image:url("Images/BrowserInfo_box.png");
	background-repeat: no-repeat;
	height: 70px;
	padding-top: 25px;
	padding-left: 65px;
	margin-top: 10px;
}
#copyright {
	margin: 5px;
	text-align: right;
	font-size: 70%;
	font-family: Verdana, Geneva, sans-serif;
	color: #999;
}
#media {
}
#main #menu ul li a:hover {
	background-color: #F1F1F1;
}
#menu {
	float: right;
	margin-top: 30px;
	width: 200px;
	font-size: 12px;
	font-family: Verdana, Geneva, sans-serif;
}
#loginName {
	width: 150px;
	float: left;
	margin-right: 10px;
	margin-left: 230px;
	color: #F00;
}
#loginPass {
	width: 150px;
	float: left;
}
#submit {
padding-left:5px;
	float: left;
}
#loginTemizle {
	clear: left;
}
#ustTemizle {
	clear: both;
}
#logo {
	float: left;
	margin-right: 5px;	
}
#login {
	margin-top: 10px;
	padding-top: 5px;
	padding-bottom: 5px;
	padding-left: 5px;
}

</style>

<script type="text/javascript">

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
	function userNameYaz(metin) {
		document.getElementById("txt_userName").value = metin;
	}
	function userNameSil() {
		document.getElementById("txt_userName").value = "";
	}

	function passwordYaz(metin) {
		document.getElementById("txt_password").value = metin;

	}
	function passwordSil() {
		document.getElementById("txt_password").value = "";
	}

	function textleriDoldur(metin1, metin2) {
		//document.getElementById("txt_password").value=metin2;
		document.getElementById("txt_password").value = metin2;

		document.getElementById("txt_userName").value = metin1;

	}
</script>
</head>
<body>

		
		
<div id="main">
  <div id="logo">
  <img src="Images/banner2.gif"  alt="banner" />
  
  </div>
  <div id="menu">
    <ul>
      <li><a href="#" target="frame">..: Ana Sayfa</a></li>
      <li><a href="#">..: Duyurular</a></li>
      <li><a href="#">..: Şubelerimiz </a></li>
      <li><a href="#">..: Doktorlarımız  </a></li>
      <li><a href="#">..: İletişim</a></li>
      <li></li>
    </ul>
  </div>
  <div id="ustTemizle"></div>
  <div id="login">
   <label id="lbl_error"
			style="font: italic; font-size: 13px; color: red;">${failure}
		</label>
			<form action="login.do" method="post">
				<div id="loginName">

					<input type="text" id="txt_userName" name="userName"
						value="Kullanıcı Ad.." onfocus="textleriDoldur('', '')" />
				</div>
				<div id="loginPass">
					<input type="password" id="txt_password" name="password"
						value="sifre" tabindex="0" />
				</div>
				<div id="submit">
					<input type="submit" id="txt_userName" name="userName"
						tabindex="-1" value="..." />
				</div>
			</form>

			<div id="loginTemizle"></div>
  </div>
</div>

<div id="alt">
  <div id="media">
    <p>
    <iframe src="htmlPages/imageSlider.html" name="frame"
	width="700" height="410" frameborder="0" scrolling="auto"></iframe>   
    </p>
</div>
  
  <div id="copyright">
    Dicle Fırat Diş Polikliği &copy; 2012
</div>
</div>

</body>
</html>