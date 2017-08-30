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
<title>Dicle Fırat Diş</title>
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<style type="text/css">
body {
	background-image: url(Images/bg2.jpg);
	font-family: "Verdana", "Times New Roman", Times, serif;
	color: #666;
	background-repeat: repeat-x;
}

#main {
	width: 1250px;
	margin-right: auto;
	margin-left: auto;
}

#menu {
	padding-left: 7px;
	width: 1250px;
	text-align: center;

}
#banner {
	padding-left: 13px;
	margin: 13px;
	padding-top:5px;
	
	text-align: right;
	font:bold;
	
}



#icerik {
	margin: 2px;
	padding: 5px;
}

#alt {
	margin: 5px;
	text-align: right;
	font-size: 70%;
}


/* CSS bilgilerim - sifre gunceller */

#close{
font-size: 10px;
}

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}

#boxes .window {
	position: fixed;
	left: 0;
	top: 0;
	width: 440px;
	height: 200px;
	display: none;
	z-index: 9999;
	padding: 20px;
}

#boxes #dialogBilgilerimiGuncelle {
	width: 390px;
	height: 280px;
	padding: 10px;	
	background-image: url("Images/untitled.png");
	background-repeat:repeat-x;
}

#boxes #dialogSifremiDegistir {
	width: 420px;
	height: 220px;
	padding: 10px;	
	background-color: white;
}

/*......................*/

/* CSS DROPDOWN LIST MENU BASLA */
#nav,#nav ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
	list-style-position: outside;
	position: relative;
	line-height: 1.8em;
	
}

#nav a {

	display: block;
	padding: 0px 5px;
	border: 1px solid #333;
	font-size:13px;
	text-align:center;
	color:black;
	font:bold;
	text-shadow:blue;
	background-color:White;
	text-decoration: none;	
	width: 235px;
}

#nav a:hover {
	background-color: White;
	color:#0f8763;
	font-size: 15px;
	
	
}

#nav li {
	float: left;
	position: relative;
	
}

#nav ul {
	position: absolute;
	display: none;
	width: 12em;
	top: 1.8em;
	
}

#nav li ul a {
	width: 12em;
	height: auto;
	float: left;
	background-color:White;
	width: 235px;
	text-align: left;
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
		
		//select all the a tag with name equal to modal
		$('a[name=modal]').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			//Get the A tag
			var id = $(this).attr('href');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set heigth and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//transition effect		
			$('#mask').fadeIn(1000);
			$('#mask').fadeTo("slow", 0.8);

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			$(id).css('top', winH / 2 - $(id).height() / 2);
			$(id).css('left', winW / 2 - $(id).width() / 2);

			//transition effect
			$(id).fadeIn(2000);

		});

		//if close button is clicked
		$('.window .close').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			$('#mask').hide();
			$('.window').hide();
		});

		//if mask is clicked
		$('#mask').click(function() {
			$(this).hide();
			$('.window').hide();
		});

		$(window).resize(function() {

			var box = $('#boxes .window');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set height and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			box.css('top', winH / 2 - box.height() / 2);
			box.css('left', winW / 2 - box.width() / 2);
		
	});
	
	});
	
	
	
	
	document.onmousedown = click;
	function click() {
		if ((event.button == 2) || (event.button == 3)) {
			alert("Sağ tık çalışmamaktadır!");
			times++;
		}
	}
	
	function validateSifreForm(){
	
		var eskiSifre= document.forms["SifreForm"]["password"].value;
		var yeniSifre = document.forms["SifreForm"]["newPassword"].value;
		var yeniSifreTekrar = document.forms["SifreForm"]["reNewPassword"].value;
		
		if(eskiSifre != ${sessionScope.sessionMember[0].kuSifre}){
			alert("Eski şifre yanlış girildi.");
			return false;
		}	
		
		if(yeniSifre != yeniSifreTekrar){
			alert("Şifreler uyuşmamaktadır.");
			return false;		
		};


	};


	
</script>
</head>
<body >

<c:if test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.isNew();
		session.invalidate();
	%>
	<jsp:forward page="index.html"></jsp:forward>
</c:if>


<div id="main">

<div id="banner"> 
<font style="color:blue;">  ..: ${sessionScope.sessionMember[1].kuAd }	${sessionScope.sessionMember[1].kuSoyad } - ${sube.sAd} :..  </font>
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
							<c:choose>
								<c:when test="${subMenu.id eq 38}">
									 	<li> <a  href="${subMenu.menuPage}"> ..: ${subMenu.menuAd} </a>	 </li>
								</c:when>
								<c:when test="${subMenu.ustMenuId eq 37 && subMenu.id ne 38}">
																	
										<li> <a name="modal" href="${subMenu.menuPage}"> ..: ${subMenu.menuAd} </a>	 </li>
								</c:when>
								<c:otherwise>
							
										<li> <a href="${subMenu.menuPage}" target="frame" > ..: ${subMenu.menuAd} </a>	 </li> 		
								</c:otherwise>
							
							</c:choose>
					
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

<iframe src="main.jsp" name="frame" 
	width="1220" height="500" frameborder="0" scrolling="auto"></iframe>
	
</div>




<div id="icerikTemizle"></div>


<!--  BILGILERIM ALANLARI SETLENIYOR... -->

<div id="boxes">


<div id="dialogBilgilerimiGuncelle" class="window">

	<form action="KullaniciGuncelle.do?tip=kisiselBilgileriGuncelle" method="post" 
	onsubmit="return validateBilgiGuncelleForm()" name="BilgiGuncelleForm" >
      <div id="guncelle">BİLGİLERİM
        <hr>
        <div>
          <label> Ad...........:</label>
          <input readonly="readonly" class="inputTextfield"
		name="ad" value="${sessionScope.sessionMember[1].kuAd}">
		
		 <input readonly="readonly" type="hidden"
		name="kuloginId" value="${sessionScope.sessionMember[1].kuLoginId}">
		
		 <input readonly="readonly" type="hidden"
		name="kuTur" value="${sessionScope.sessionMember[0].kuTur}">
		
        </div>
        <div>
          <label> Soyad......:</label>
          <input
		class="inputTextfield" readonly="readonly" name="soyad" value="${sessionScope.sessionMember[1].kuSoyad}">
        </div>
        <div>
          <label> Tel...........:</label>
          <input class="inputTextfield"
		name="tel" value="${sessionScope.sessionMember[1].kuTel}"> *
        </div>
        <div>
          <label> Adres.......:</label>
          <textarea name="adres" rows="3" cols="20">${sessionScope.sessionMember[1].kuAdres}</textarea> *
		
        </div>
        <br>
       * : Güncellenebilir alan.
       <br>
        <div>
          <input type="submit" value="Güncelle">
        </div>
      </div>     
	</form>

<br>
<br>
<hr>
<hr>

 <!-- close button is defined as close class -->
<a id="close" href="#" class="close"> Kapat </a>

</div>



<div id="dialogSifremiDegistir" class="window">

	<form name="SifreForm" action="SifremiGuncelle.do?" method="post" onsubmit="return validateSifreForm()" >
      <div id="guncelle">ŞİFREMİ GÜNCELLE
        <hr>
        <div>
          <label> Eski Şifre..............:</label>
          <input type="password"
		name="password" >
		
		 <input type="hidden"
		name="kuloginId" value="${sessionScope.sessionMember[1].kuLoginId}">
		
        </div>
        <div>
          <label> Yeni Şifre..............:</label>
          <input type="password" name="newPassword" >
        </div>
        <div>
          <label> Yeni Şifre Tekrar...:</label>
          <input type="password" name="reNewPassword" > 
        </div>
<br>
<hr>
        <div>
          <input type="submit" value="Güncelle">
        </div>
      </div>     
	</form>

<div>
<a id="close" href="#" class="close"> Kapat </a>
</div> 

</div>
<!-- SIFREMI GUNCELLE DIV -->

<!-- Do not remove div#mask, because you'll need it to fill the whole screen -->
<div id="mask"></div>
</div>


<div id="alt">DF Grup &copy; 2012</div>

</div>
</body>
</html>