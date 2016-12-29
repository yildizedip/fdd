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

#ekle {
	width: 300px;
	float: left;
	background-color: #DFDFFF;
	border: 1px solid #030;
	padding: 7px;
	margin-right: 5px;
	margin-left: 5px;
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
		alert("Tüm alanları doldurun");
		 return false;
	 }	
}

function openDoktorPopUp(){

	 var kuTur= document.forms["kullaniciEkleForm"]["kuTur"].value;
	
}

</script>
<body>
<div id="mainPage">


<div id="ekle">KULLANICI EKLE
<hr>
<form name="kullaniciEkleForm" action="KullaniciEkle.do" method="post"
	onsubmit="return validationForEkle()">
<div><label> Mail...........:</label> <input
	class="inputTextfield" name="userName" id="userName"></div>
<div><label> Şifre..........:</label> <input
	class="inputTextfield" name="password" id="password"></div>

<div><label> Ad.............:</label> <input
	class="inputTextfield" name="ad" id="ad"></div>

<div><label> Soyad.... ...:</label> <input class="inputTextfield"
	name="soyad" id="soyad"></div>

<div><label> Tel.............:</label> <input
	class="inputTextfield" name="tel" id="tel"></div>

<div><label> Adres.........:</label> <input
	class="inputTextfield" name="adres" id="adres"></div>

<div><label> Tür.............:</label> <select name="kuTur"
	id="kuTur" onchange="openDoktorPopUp()">
	<option value="-1" label="Seçiniz...">
	<option value="2" label="Müdür">
	<option value="3" label="Doktor">
	<option value="4" label="Sekreter">
	<option value="5" label="Lab Teknisyeni">
	<option value="6" label="Yardımcı Personel">
	<option value="7" label="Depo Takip">
</select></div>

<div><input type="submit" value=" Ekle "></div>
</form>
</div>
<div id="Sorgulama">KULLANICI SORGULAMA
<hr>
<form action="KullaniciGetir.do" method="post"
	onsubmit="return validation()">
<div id="name"><label> Ad :</label> <input class="inputTextfield"
	name="userName"></div>
<div id="Search"><input type="submit" value="Sorgula"></div>
</form>
<div id="clean"></div>
</div>

<div id="warn">${warn}</div>
<div id="SonucList"><strong>KULLANICI LİSTESİ</strong>
  <hr>

<table>

	<tr>
		<td bgcolor="#DFDFFF"></td>
		<td bgcolor="#DFDFFF"><strong>GİRİŞ AD</strong></td>
		<td bgcolor="#DFDFFF"><strong>PAROLA</strong></td>
		<td bgcolor="#DFDFFF"><strong>TUR</strong></td>
		<td bgcolor="#DFDFFF"><strong>AD</strong></td>		
		<td bgcolor="#DFDFFF"><strong>TEL</strong></td>
		<td bgcolor="#DFDFFF"><strong>ADRES</strong></td>
		<td bgcolor="#DFDFFF"><strong>GİDER KODU</strong></td>
		<td bgcolor="#DFDFFF"><strong>ŞUBELER</strong></td>
		<td bgcolor="#DFDFFF"><strong></strong></td>
		<td bgcolor="#DFDFFF"><strong></strong></td>
			<td bgcolor="#DFDFFF"><strong></strong></td>
	</tr>

	<c:forEach items="${kullaniciList}" var="kullanici" varStatus="count">
		<tr>

			<td bgcolor="#DFDFFF">${count.count}-</td>
			<td bgcolor="#DFDFFF">${kullanici.userName }</td>
			<td bgcolor="#DFDFFF">${kullanici.password }</td>
			<td bgcolor="#DFDFFF">
			<c:choose>
			<c:when test="${kullanici.kuTur eq 1}">
			Admin
			</c:when>
			<c:when test="${kullanici.kuTur eq 2}">
			Müdür
			</c:when>
			<c:when test="${kullanici.kuTur eq 3}">
			Doktor
			</c:when>
			<c:when test="${kullanici.kuTur eq 4}">
			Sekreter
			</c:when>
			<c:when test="${kullanici.kuTur eq 5}">
			Lab Teknisyeni
			</c:when>
			<c:when test="${kullanici.kuTur eq 6}">
			Yardımcı Personel
			</c:when>
			<c:otherwise>
		
			</c:otherwise>
			</c:choose>			
			</td>
			<td bgcolor="#DFDFFF">${kullanici.ad} ${kullanici.soyad }</td>
		
			<td bgcolor="#DFDFFF">${kullanici.tel }</td>
			<td bgcolor="#DFDFFF">${kullanici.adres }</td>
			<td bgcolor="#DFDFFF">${kullanici.giderKodu }</td>
			<td bgcolor="#DFDFFF">
				<c:forEach items="${kullanici.kuSubeList}" var="sube">
				
				${sube.sAd },
				
				
				</c:forEach>
			
			
			
			</td>
			
			
			<td bgcolor="#DFDFFF" width="70px">
			
			<!-- <html:link	action="/KullaniciSil?kuloginId=${kullanici.kuloginId}">Sil</html:link> -->
			
				
				
			<html:link action="/KullaniciGetir?kuloginId=${kullanici.kuloginId}">Güncelle</html:link>
			</td>
			<td bgcolor="#DFDFFF" width="70px"> 
			<html:link action="/KullaniciSubeGetir?kuloginId=${kullanici.kuloginId}">Şube Sil</html:link>
			</td>
			<td bgcolor="#DFDFFF" width="70px"> 
			<html:link action="/KullaniciSubeGetirForEkle?kuloginId=${kullanici.kuloginId}">Şube Ekle</html:link>
			</td>
		</tr>
	</c:forEach>

</table>


<div id="listClear"></div>


</div>
<c:if test="${kullanici ne null}">

	<form action="KullaniciGuncelle.do" method="post">
      <div id="guncelle">KULLANICI GÜNCELLE
        <hr>
        <div>
          <label> Mail.........:</label>
          <input
		class="inputTextfield" name="userName" value="${kullanici.userName}">
          <input type="hidden" name="kuloginId" value="${kullanici.kuloginId }">
        </div>
        <div>
          <label> Şifre........:</label>
          <input class="inputTextfield"
		name="password" value="${kullanici.password}">
        </div>
        <div>
          <label> Tür..........:</label>
          <select name="kuTur"
				id="kuTur" onchange="openDoktorPopUp()">
            <option value="-1" label="Seçiniz..."  >
            <option value="2" label="Müdür"
				
				<c:if test="${kullanici.kuTur eq 2}">
				selected="selected"
				</c:if>
				>
            <option value="3" label="Doktor"
					<c:if test="${kullanici.kuTur eq 3}">
				selected="selected"
				</c:if>
				>
            <option value="4" label="Sekreter"
					<c:if test="${kullanici.kuTur eq 4}">
				selected="selected"
				</c:if>
				>
				
			<option value="5" label="Lab Teknisyeni"
					<c:if test="${kullanici.kuTur eq 5}">
				selected="selected"
				</c:if>
				>
				
			<option value="6" label="Yardımcı Personel"
					<c:if test="${kullanici.kuTur eq 6}">
				selected="selected"
				</c:if>
				>
				
			<option value="7" label="Depo Takip"
					<c:if test="${kullanici.kuTur eq 7}">
				selected="selected"
				</c:if>
				>
          </select>
        </div>
        <div>
          <label> Ad...........:</label>
          <input class="inputTextfield"
		name="ad" value="${kullanici.ad}">
        </div>
        <div>
          <label> Soyad......:</label>
          <input
		class="inputTextfield" name="soyad" value="${kullanici.soyad}">
        </div>
        <div>
          <label> Tel...........:</label>
          <input class="inputTextfield"
		name="tel" value="${kullanici.tel}">
        </div>
        <div>
          <label> Adres.......:</label>
          <input
		class="inputTextfield" name="adres" value="${kullanici.adres}">
        </div>
          <div>
          <label> Gider Kodu.......:</label>
          <input
		class="inputTextfield" name="giderKodu" value="${kullanici.giderKodu}">
        </div>
        <div>
          <input type="submit" value="Güncelle">
        </div>
      </div>
     
	</form>
</c:if>

<c:if test="${kullaniciSubeList ne null}">
  <div id="subeList"> ${kullaniciSubeList.ad}  ${kullaniciSubeList.soyad} YEKİLİ OLUNAN ŞUBELER:
    <hr>
    <table class="sofTSmall">
      <tr>
        <td class="helpHed" ></td>
        <td class="helpHed">Şube</td>
        <td class="helpHed"></td>
      </tr>
      <c:forEach items="${kullaniciSubeList.kuSubeList}" var="sube" varStatus="count">
        <tr>
          <td class="helpBod">${count.count}- </td>
          <td class="helpHed">${sube.sAd}</td>
          <td class="helpBod"><html:link action="/KullaniciSubeSil?kullaniciSubeId=${sube.kullaniciSubeId}">Sil</html:link></td>
        </tr>
      </c:forEach>
    </table>
  </div> 
  

</c:if>

<c:if test="${kullaniciSubeList ne null}">
<div id="subeEkle">
${kullaniciSubeList.ad}  ${kullaniciSubeList.soyad}
<form action="KullaniciSubeEkle.do" method="post">
 
 <hr>
 <input type="hidden" value="${kullaniciSubeList.kuloginId}"  name="kullaniciId" >
   <div id="subeler">
   
  			<select size="1" name="subeId" class="subeler">
						<option label="Şube Seçiniz.." value="-1"></option>
						<c:forEach items="${subelerList}" var="sube">
							<option label="${sube.sAd }"
								value="${sube.sId}"></option>
						</c:forEach>
					</select>
   </div>
   <div>
   <input type="submit" value="Şube Yetkilendir">
  
   </div>
   </form>
 </div>
</c:if>
<div id="clear"></div>
</div>

</body>
</html>