<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<title>Hasta Ekle</title>
<script type="text/javascript" src="lib/jquery-1.7.js">
	
</script>
<script type="text/javascript">

	function kontrol() {

		var protokolNo = document.getElementById("protokolNo").value;
		var tckimlik = document.getElementById("tckimlik").value;
		var tel = document.getElementById("tel").value;

		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;

		if (!regexNum.test(protokolNo) && regexLetter.test(protokolNnav-second-levelo)) {
			document.getElementById("protokolNo").value = "";
			alert("Yalnızca rakam girilebilir.");

		}

		if (!regexNum.test(tckimlik) && regexLetter.test(tckimlik)) {
			document.getElementById("tckimlik").value = "";
			alert("Yalnızca rakam girilebilir.");

		}
		if (!regexNum.test(tel) && regexLetter.test(tel)) {
			document.getElementById("tel").value = "";
			alert("Yalnızca rakam girilebilir.");

		}
	}
</script>
<style type="text/css">

#main {	
	margin-right: auto;
	margin-left: auto;
	font-family: "Verdana", Courier, monospace;
	font-size: 12px;
	color: #999;
	text-align: left;
}
</style>

</head>


<body >

<div id="main">
<table>
	<tr>
		<td>
		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Hasta Ekle </font>
		<hr>

		<form action="hastaEkle.do" method="post">

		<table class="sorgulama">
			<tr>

				<td colspan="2" style="text-align: center;">HASTA EKLE</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" 
					name="protokolNo" id="protokolNo" onkeyup="kontrol()" />  
					
					<input type="hidden"  name="subeId" value="${subeId}" >
					 </td>
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" id="tckimlik"
					onkeyup="kontrol()" name="tckimlik" id="tckimlik" /></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad" /> <input
					class="inputTextfield" name="soyad" id="soyad" /></td>
			</tr>

			<tr>
				<td>Tel</td>
				<td><input class="inputTextfield" name="tel" id="tel"
					onkeyup="kontrol()" /></td>
			</tr>
			<tr>

				<td colspan="3" style="text-align: center;"><input
					id="bntKaydet" type="submit" value="Kaydet" /></td>
			</tr>


			<tr>
				<td colspan="2" align="left"><label style="color: red;">
				${requestScope.warn }</label></td>

			</tr>
		</table>
		</form>
		<hr>
		</td>
</table>
<div id="cikti"></div>
</div>
</body>
</html>