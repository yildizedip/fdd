<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<title>Insert title here</title>
<style type="text/css">
#mainPage {
	padding: 5px;
	height: 400px;
	width: 700px;
	font-family: Verdana, Geneva, sans-serif;
	font-size: 11px;
	color: #666;
}

#Sorgulama {
	padding: 5px;
	border: 1px solid #030;
	width: 300px;
	color: #333;
	background-color: #DFDFFF;
	float: left;
	margin: 5px;
}

#Search {
	text-align: center;
	float: left;
}

#clean {
	clear: left;
}

#SonucList {
	margin-top: 10px;
	padding: 5px;
	border: 1px solid #030;
	width: 710px;
	float: left;
	margin-left: 5px;
	font-size: 10px;
}

#guncelle {
	float: left;
	padding: 5px;
	width: 280px;
	background-color: #DFDFFF;
	border: 1px solid #060;
	margin-right: 5px;
	margin-left: 5px;
	margin-top: 10px;
}

#subeList {
	background-color: #DFDFFF;
	margin: 10px;
	padding: 5px;
	width: 300px;
	border: 1px solid #060;
	float: left;
}

#mainPage #ekle form div {
	
}

#name {
	float: left;
}

#rowData {
	float: left;
	padding: 2px;
}

#count {
	float: left;
	padding: 3px;
	width: 20px;
}

#actionData {
	float: left;
	padding: 3px;
	margin-left: 10px;
	width: 100px;
}

#clear {
	clear: left;
}

#listClear {
	clear: left;
}

#warn {
	float: left;
	width: 200px;
	margin: 10px;
	color: #F00;
	padding: 10px;
}

#subeEkle {
	background-color: #DFDFFF;
	margin: 10px;
	padding: 5px;
	width: 300px;
	float: left;
	border: 1px solid #060;
}

#subeler {
	margin: 5px;
	padding: 5px;
	border: 1px solid #030;
}
</style>
</head>
<script type="text/javascript">
function validationForEkle(){
	
	 var ad= document.forms["kullaniciEkleForm"]["userName"].value;

	 var sifre= document.forms["kullaniciEkleForm"]["password"].value;
	 

	 var kuTur= document.forms["kullaniciEkleForm"]["kuTur"].value;
	 if(ad=="" || sifre=="" || kuTur=="-1"){
		alert("T�m alanlar� doldurun");
		 return false;
	 }	
}

function openDoktorPopUp(){

	 var kuTur= document.forms["kullaniciEkleForm"]["kuTur"].value;
	
}

</script>
<body>
<div id="mainPage">
<div id="Sorgulama">DOKTOR SORGULAMA
<hr>
<form action="DoktorListesiGetir.do" method="post"
	onsubmit="return validation()">
<div id="name"><label> Ad :</label> <input class="inputTextfield"
	name="dAd"></div>

<div id="Search"><input type="submit" value="Sorgula"></div>
</form>


<div id="clean"></div>
</div>

<div id="warn">
<p>Doktor ekleme guncelleme ve silmek icin kullan�c� i�lemlerini
kullan�n.</p>
<p>${warn}</p>
</div>
<div id="SonucList"><strong>DOKTOR L�STES�</strong>
<hr>

<table>

	<tr>
		<td bgcolor="#DFDFFF"></td>
		<td bgcolor="#DFDFFF"><strong>G�R�� AD</strong></td>
		<td bgcolor="#DFDFFF"><strong>AD</strong></td>
		<td bgcolor="#DFDFFF"><strong>G�DER KODU</strong></td>
		<td bgcolor="#DFDFFF"><strong>�UBELER</strong></td>
		<td bgcolor="#DFDFFF"><strong></strong></td>
	</tr>

	<c:forEach items="${doktorList}" var="doktor" varStatus="count">
		<tr>

			<td bgcolor="#DFDFFF">${count.count}-</td>
			<td bgcolor="#DFDFFF">${doktor.userName }</td>
			<td bgcolor="#DFDFFF">${doktor.dAd} ${doktor.dSoyad }</td>
			<td bgcolor="#DFDFFF">${doktor.giderKodu }</td>
			<td bgcolor="#DFDFFF"><c:forEach items="${doktor.kuSubeList}"
				var="sube">				
				${sube.sAd },				
				</c:forEach></td>

			<td bgcolor="#DFDFFF"><html:link
				action="/DoktorSubeGetir?dmemberId=${doktor.dmemberId}">�ube Sil - Ekle </html:link>
			</td>

		</tr>
	</c:forEach>

</table>


<div id="listClear"></div>


</div>


<c:if test="${doktor ne null}">
	<div id="subeList">${doktor.dAd} ${doktor.dSoyad} �ubeleri:
	<hr>
	<table class="sofTSmall">
		<tr>
			<td class="helpHed"></td>
			<td class="helpHed">�ube</td>
			<td class="helpHed"></td>
		</tr>
		<c:forEach items="${doktor.doktorSubeList}" var="sube"
			varStatus="count">
			<tr>
				<td class="helpBod">${count.count}-</td>
				<td class="helpHed">${sube.sAd}</td>
				<td class="helpBod"><html:link
					action="/DoktorSubeSil?doktorSubeId=${sube.doktorSubeId}">Sil</html:link></td>
			</tr>
		</c:forEach>
	</table>
	</div>


</c:if> <c:if test="${doktor ne null}">
	<div id="subeEkle">${doktor.dAd} ${doktor.dSoyad}
	<form action="DoktorSubeEkle.do" method="post">
	<hr>
	<input type="hidden" value="${doktor.dId}" name="dId">
	<div id="subeler"><select size="1" name="subeId" class="subeler">
		<option label="�ube Se�iniz.." value="-1"></option>
		<c:forEach items="${subelerList}" var="sube">
			<option label="${sube.sAd }" value="${sube.sId}"></option>
		</c:forEach>
	</select></div>
	<div><input type="submit" value="�ube Yetkilendir"></div>
	</form>
	</div>
</c:if>
<div id="clear"></div>
</div>

</body>
</html>