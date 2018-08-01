<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>


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


<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />


<script type="text/javascript"> 
		 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("bas_tar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bit_tar"));
					<%Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);
			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			if (basTar == null)
				basTar = date;
			if (bitTar == null)
				bitTar = date;%>	
				
					document.getElementById("bas_tar").value="<%=basTar%>";
					document.getElementById("bit_tar").value="<%=bitTar%>";
	}
</script>

<title></title>
</head>
<body style="color:black ; background-color: white;" >

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		<div class="page-header ">
			<div class="page-title" style="font-size: 20px;">GÜN SONU
				RAPORU</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>

<div class="col-lg-6">  
 
	<form action="getGelirGiderDurumu.do" method="post">
		<input type="hidden" value="10"	name="islem">

		<table class="table table-bordered">
		
		<tr>
				<td colspan="4"
					style="text-align: center; font: bold; font-size: 20px;" class="bg-blue" >Sorgula
				</td>
			</tr>
					
			 <tbody>
			<tr>
				<td  colspan="4"> Tarih : 
				
				<c:choose>
					
					<c:when test="${(odeme_tarih_degistir eq 'off') and (sessionScope.sessionMember[0].kuTur eq '4') }">
						<input class="inputTextfield" name="bas_tar" id="bas_tar" disabled="disabled"> /
						<input class="inputTextfield" name="bit_tar" id="bit_tar" disabled="disabled">
					 
					 </c:when>
					 
					 <c:otherwise>
					 	<input class="inputTextfield" name="bas_tar" id="bas_tar"> /
						<input class="inputTextfield" name="bit_tar" id="bit_tar">
					 
					 </c:otherwise>
				
				</c:choose>
				
				</td>

			</tr>
			<tr>
				<td colspan="2">
				<select size="1" name="doktorId"
					>
						<option label="Doktor Seçiniz.." value="-1">Doktor Seçiniz..</option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
								value="${doktorDTO.dId }">${doktorDTO.dAd } ${doktorDTO.dSoyad }</option>
						</c:forEach>
				</select></td>
				
				
				<td colspan="1"> <select size="1" name="islemTipi">
						<option label="Tedavi Seçiniz.." value="-1">Tedavi Seçiniz..</option>

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id }">${islem.ad}</option>
						</c:forEach>
				</select></td>
				<td><select size="1" name="giderTuru" >

						<option label="Gider Türü Seçiniz.." value="-1">Gider Türü Seçiniz..</option>
						<c:forEach items="${sessionScope.giderTurKodlari}" var="turKodDTO">
							<option label="${turKodDTO.turAd }" value="${turKodDTO.turKod }">${turKodDTO.turAd }</option>
						</c:forEach>
				</select></td>



			</tr>


			<tr>
				<td colspan="4" style="text-align: center;">
				<input
					type="submit" name="btn_Sorgula" value="Sorgula">
					<input
					type="hidden" name="doctor"
					value="${sessionScope.sessionMember[0].kuId }" id="bas_tar"></td>
			</tr>
			
			</tbody>

		</table>
	</form>

	<%
		Date bugun = new Date();
		SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
		String gunlukTarih = sdff.format(bugun);
		request.setAttribute("bugun", gunlukTarih);
	%>
	
	
	</div>
	<div class="clearfix"></div>
	
	

<div class="col-lg-8"> 
	<myTagFiles:GelirRaporu silAktif="0">
		<c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}
									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					</myTagFiles:GelirRaporu>
		</div>

<div class="col-lg-4">


	   <myTagFiles:GiderRaporu silAktif="0">
		<c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}
									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					</myTagFiles:GiderRaporu>
					
					</div>


</body>
</html>