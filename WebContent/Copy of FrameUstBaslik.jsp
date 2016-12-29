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


</style>
<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>
<script type="text/javascript">

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
	}
}



$(document).ready(function() {

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

<div id="banner"><img src="Images/banner_3.png" 
	height="80" /></div>


<div id="userInf">
<table align="right" cellpadding="2" cellspacing="4">
	<tr align="right">
		<td width="200" valign="bottom" >
		<p>Hoşgeldiniz ${sessionScope.sessionMember[1].kuAd }	${sessionScope.sessionMember[1].kuSoyad },
		<p>
		</td>

		<td width="90" valign="bottom">
		<p>${sube.sAd},
		<p>
		</td>

		<td width="90" valign="bottom">
		<p><a href="logout.jsp" 
			style="color: red; font-style: oblique; text-decoration: none">
		Çıkış </a>
		</td>

	</tr>
	<tr>
	<td colspan="2" align="right"> 
	<a href="#dialogBilgilerimiGuncelle"  name="modal" 
			style=" text-decoration: none">
		Bilgilerim </a>
	 </td>
	 <td colspan="2" align="right"> 
	<a href="#dialogSifremiDegistir"  name="modal" 
			style=" text-decoration: none">
		Şifremi Değiştir </a>
	 </td>
	</tr>
</table>
</div>
<div id="temizle"></div>
</div>


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

<!--  BILGILERIM ALANLARI SETLENIYOR... -->
</body>
</html>