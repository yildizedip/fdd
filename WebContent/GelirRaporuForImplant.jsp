<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script src="script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" src="js/jquery.ui.datepicker-tr.js"></script>


<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<title></title>
</head>



<body style="color:black ; background-color: white;">

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
			<div class="page-header ">
			<div class="page-title" style="font-size: 20px;">
			
				Implant Durumu
			
			</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>

<div class="col-lg-6">



		<form action="getDoktorOperasyonListesi.do" method="post">

		<table class="table table-bordered">
			<tr>
				<td colspan="4" class="bg-info"  >SORGULA</td>
			</tr>
			<tr>
				<td style="width: 115px;">Hasta Ad- Soyad</td>
				<td style="width: 164px;"><input class=inputTextfield
					name="hastaAd" id="hastaAd"></td>
				<td>/</td>
				<td><input class=inputTextfield name="hastaSoyad" id="hastaSoyad"></td>
			</tr>
			<tr>
			<td> Durum</td>
			<td colspan="3">
			<select size="1" name="durum" class="">
			<option label="Durum Seçiniz.." value="-1"/>
			<option  label="Devam Ediyor" value="A" >
			<option  label="Bitmiþ"  value="B">
			
			</select>
			<input type="hidden" name="kuId" value="${sessionScope.sessionMember[0].kuId }" id="kuId">
			<input type="hidden" name="islemTip" value="<%=GenelDegiskenler.ImplantliOperasyon._VAR %>" id="islemTip">			
			</td>
			</tr>
			
			<tr>
				<td colspan="4" style="text-align: center;"><input
					type="submit" name="btn_Sorgula" value="Sorgula"></td>
			</tr>
			
		</table>
		</form>
		
		<font color="Red"> ${resquestScope.warn} </font> 
		 <br>
		 </div>

<table class="table table-bordered">
			<tr>
				<th class="bg-success" colspan="11" > <h4 align="center"> Tedavi Listesi </h4> </th>
			</tr>
			<tr>			
				<td class=""/>
				<td class="">P. No</td>
				<td class="">Ad Soyad</td>
				<td class="">Operasyon</td>
				<td class="">Tarihi</td>
				<td class="">Adet</td>
				<td class="">Açýklama</td>
				<td class="">Ücret</td>
				<td class="">Durum</td>
				<td class=""></td>
				
			</tr>
			<c:forEach items="${doktorOperasyonListesi}" var="operasyon" varStatus="count">
				<tr>
					<td class="">${count.count}</td>
					<td class="">${operasyon.hasta.protokolNo}</td>
					<td class="">${operasyon.hasta.ad} ${operasyon.hasta.soyad}</td>
					<td class="">${operasyon.islemTip.ad}</td>					
					<td class="">${operasyon.islemTarihiStr}</td>
					<td class="">${operasyon.disAdet}</td>
					<td class="">${operasyon.aciklama}</td>
					<td class="">${operasyon.miktar}</td>
					<td class="">
					<c:choose>					
						<c:when test="${operasyon.durumu eq 'A'}">Dvm E.</c:when>
						<c:when test="${operasyon.durumu eq 'B'}">Bitti</c:when>
					</c:choose>
					</td>
					<td class=""> 						
						<html:link action="/HastaOdemeListesiGetir?islemId=${operasyon.id}
						&hastaId=${operasyon.hastaId}&tip=6"> Ödeme Listesi Görüntüle</html:link>
					</td>

				</tr>

			</c:forEach>

		</table>


</body>
</html>