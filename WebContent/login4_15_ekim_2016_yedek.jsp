<%@ page language="java" contentType="text/html; charset=iso-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@page import="botdetect.web.Captcha"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9">
<title>..DF Group..</title>

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
	background-color: white;
}

#badi {
	
}

#reklam {
	float: left;
	margin-top: 150px;
}
#yildizSepeti {
	background-color: blue;
	width: 100;
}

#alt {
	float: left;
	padding: 7px;
	width: 650px;
	margin-top: 7px;
	margin-right: auto;
	margin-left: auto;
	background-color: #FFF;
	color: #666;
}

#badiTemizle {
	clear: both;
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
	background-image: url("Images/BrowserInfo_box.png");
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
	width: 147px;
	float: left;
	margin-right: 1px;
	margin-left: 200px;
	color: #F00;
}

#loginPass {
	width: 147px;
	margin-left: 2px;
	float: left;
}

#submit {
	padding-left: 5px;
	margin-left: 2px;
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
			<table>
				<tr>
					<td rowspan="3"><img src="Images/banner_3.png" alt="banner"
						align="middle" /></td>
					<td style="font-size: 32px; color: gray; font-family: Tahoma;">
						<br> <br> <br>

					</td>

				</tr>
				<tr>
					<td align="right">
						<form action="login.do" method="post">

							<table align="right">
								<tr>
									<td align="right"><input type="text" id="txt_userName"
										name="userName" value="Kullanıcı Ad.."
										onfocus="textleriDoldur('', '')" align="right" /></td>
									<td align="right"><input type="password" id="txt_password"
										name="password" value="sifre" tabindex="0" align="right" /></td>

								
								<tr>
								<tr>
									<td>
									
									<%
							        // Adding BotDetect Captcha to the page
							        Captcha captcha = Captcha.load(request, "basicCaptcha");
							        captcha.setUserInputClientId("captchaCode");
							        captcha.renderCaptchaMarkup(pageContext.getServletContext(), 
							        pageContext.getOut());
      				  				%>
        
        
									
									
									</td>
								</tr>
								<tr>
									<td>
									
									<input id="captchaCode" type="text" name="captchaCode" />
									
									</td>
								</tr>
								<tr>
									<td>
										<td align="right"><input type="submit" id="txt_userName"
										name="userName" tabindex="-1" value="Giriş" /></td>
									
								</tr>
								<tr>
									<td><label id="lbl_error"
										style="font: italic; font-size: 13px; color: red;">${failure}
									</label></td>
								</tr>
							</table>

						</form>

					</td>
				</tr>

			</table>



		</div>

		<div id="ustTemizle"></div>
		<div id="login">

			<div id="loginTemizle"></div>

		</div>
	</div>


	<div id="badi">

		<div id="reklam" style="width: 330px; " >
			
				<p>
				
					<a href="http://www.yildizsepeti.com" target="_blank" >
					<img alt="" src="Images/yildiz_sepeti.png" style="margin-left: 30px;" >
					</a>
					
				
				</p>
			

		</div>

		<div id="alt">
			<div id="media" align="center">
				<p>
					<iframe src="htmlPages/imageSlider.html" name="frame" width="650"
						height="440" frameborder="0" scrolling="auto"></iframe>
				</p>
			</div>



			<div id="copyright">DF Grup &copy; 2012</div>
		</div>

<div id="reklam" style="width: 330px; " >
			
				<p>
				
					<a href="http://www.yildizsepeti.com" target="_blank" >
					<img alt="" src="Images/yildiz_sepeti.png" style="margin-left: 30px;" >
					</a>
					
				
				</p>
			

		</div>
		<div id="badiTemizle"></div>

	</div>

</body>
</html>