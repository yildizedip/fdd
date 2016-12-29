<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title></title>
<style type="text/css">
#main {	
	margin-right: auto;
	margin-left: auto;
	font-family: "Verdana", Courier, monospace;
	font-size: 14px;
	color: Black;
}

#HastaIstatistikleri {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
}

#KullanimIstatistikleri {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
	float: left;
}

#temizle {
	clear: left;
}

#topGider {
	margin: 10px;
	border: 1px solid #CCC;
	padding: 10px;
	float: left;
}

body {
	background-image: url();
	background-repeat: repeat-x;
}
</style>
</head>
<body onload="">


<div id="main">

<c:if test="${ (sessionScope.sessionMember[0].kuTur eq '2')
				|| (sessionScope.sessionMember[0].kuTur eq '4')
				}">

	<div id="HastaIstatistikleri">

	<table>
		<tr >
			<td>DURUM RAPORU
			<hr>
			</td>
		</tr>
		<tr>
			<td>Sistemde bulunan aktif hasta sayısı : ${getHastaSayisi}</td>
		</tr>
		<tr>
			<td>Operasyonu kesinleşmemiş hasta sayısı :
			${getOperasyonuKesinlesmemisHastaSayisi}</td>
		</tr>
	</table>

	</div>



	<div id="KullanimIstatistikleri">

	<table>
		<tr align="center" >
			<td colspan="3">EN ÇOK GERÇEKLEŞTİRİLEN 10 OPERASYON
			<hr>
			</td>
		</tr>
		<tr>
			<td></td>
			<td>Operasyon <hr></td>
			<td>Sayı <hr></td>
		</tr>

		<c:forEach items="${getTopOperations}" var="element" varStatus="count">
			<tr>
				<td>${count.count} - </td>
				<td>${element[0]}</td>
				<td>${element[1]}</td>
			</tr>
		</c:forEach>

	</table>

	</div>
<!-- 

	<div id="topGider">
	<table>
		<tr align="center">
			<td colspan="4"> GIDER  <hr></td>
		</tr>
		<tr>
			<td></td>
			<td>Gider Ad <hr></td>
			<td>Sayı <hr></td>
			<td>Miktar <hr></td>
		</tr>

		<c:forEach items="${getTopGider}" var="element" varStatus="count">
			<tr>
				<td>${count.count} - </td>
				<td>${element[0]}</td>
				<td>${element[1]}</td>
				<td>${element[2]}</td>
			</tr>
		</c:forEach>

	</table>

	</div>
	
	 -->
	 
	 
	<div id="topGider">
	<table>
		<tr align="center">
			<td colspan="4"> DOKTOR OPERASYON LISTESI  <hr></td>
		</tr>
		<tr>
			<td></td>
			<td> Ad <hr></td>
			<td> Soyad <hr></td>
			<td> Islem <hr></td>
			<td> Sayi <hr></td>
		</tr>

		<c:forEach items="${getDoktorIslemOperations}" var="element" varStatus="count">
			<tr>
				<td>${count.count} - </td>
				<td>${element[0]}</td>
				<td>${element[1]}</td>
				<td>${element[2]}</td>
				<td>${element[3]}</td>
			</tr>
		</c:forEach>

	</table>

	</div>
	<div id="temizle"></div>


</c:if>

</div>
</body>
</html>