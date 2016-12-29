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
	width: 300px;
	float: left;
}
#guncelle {
	float: left;
	padding: 5px;
	width: 620px;
	background-color: #DFDFFF;
	border: 1px solid #060;
	margin-right: 5px;
	margin-left: 5px;
	margin-top: 10px;
}
#ekle {
	width: 300px;
	float: left;
	background-color: #DFDFFF;
	border: 1px solid #030;
	padding: 7px;
	margin-right: 5px;
	margin-left: 5px;
	height: 150px;
}
#mainPage #ekle form div {
}

#name {
	float: left;
}

#rowData {
	float: left;
	padding: 3px;
	width: 100px;
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
#clear{
clear: left;
}

#listClear {
	clear: left;
}
</style>
</head>
<script type="text/javascript">
function validationForEkle(){
	
	 var ad= document.forms["subeEkleForm"]["sAd"].value;
	 if(ad==""){
		alert("En az bir isim girmelisiniz.");
		 return false;
	 }
}

</script>
<body>
<div id="mainPage">

	<div id="ekle"> SUBE EKLE
	<hr>
		<form name="subeEkleForm" action="SubeEkle.do" method="post" onsubmit="return validationForEkle()">
			<div> <label>    Ad.............:</label>
			  <input class="inputTextfield" name="sAd" id="sAd">
			</div>
			<div > <label> Adres.........:</label> 
			
					<input class="inputTextfield" name="sAdres">
			</div>
			<div > <label>   Tel.............:</label> 
			
				<input class="inputTextfield" name="sTel">
			</div>
			<div>
				<input type="submit"value=" Ekle ">
				
			</div>
		</form>
	</div>

	
  <div id="Sorgulama">SUBE SORGULAMA
        
			<hr>
      <form action="SubeGetir.do" method="post" onsubmit="return validation()">
			<div id="name"><label> Ad :</label> 
			
					<input class="inputTextfield" name="sAd">
			</div>
			<div id="Search">
				<input type="submit"value="Sorgula">
				
			</div>
      </form>
			<div id="clean"></div>
		</div>
	
  <div id="SonucList"> SUBE LİSTESİ
      <hr>
    <c:forEach items="${subeList}" var="sube" varStatus="count">
        <div id="count"> ${count.count}- </div>
        <div id="rowData"> ${sube.sAd } </div>
        <div id="actionData">
          <html:link action="/SubeSil?subeId=${sube.sId}">     Sil        </html:link>
          <label style="width: 10px; color: white;" > ddd  </label>
          <html:link action="/SubeGetir?sId=${sube.sId}">    Güncelle   </html:link>
        </div>
        <div id="listClear"></div>
       <div></div>
    </c:forEach>
    </div>
    <c:if test="${sube ne null}">
		    
		    <form action="SubeGuncelle.do" method="post"> 
		    <div id="guncelle">
		    		SUBE GÜNCELLE
							<hr>
						<div >
						  <label> Ad.........:</label> 				
								<input class="inputTextfield" name="sAd" value="${sube.sAd}">
								<input type="hidden" name="sId" value="${sube.sId }">
						</div >
						<div > <label> Adres....:</label> 
			
							<input class="inputTextfield" name="sAdres" value="${sube.sAdres}">
						</div>
						<div > <label>   Tel........:</label> 
			
							<input class="inputTextfield" name="sTel" value="${sube.sTel}">
						</div>
						<div >
							<input type="submit"value="Güncelle">							
						</div>				 
				 
		    </div>
		    </form>
    </c:if>
     <div id="clear"> </div>
</div>

</body>
</html>