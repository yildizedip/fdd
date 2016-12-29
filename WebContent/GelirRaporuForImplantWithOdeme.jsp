<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript"> 
		 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("bas_tar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bit_tar"));
					<%  Date dat = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
						String date = sdf.format(dat);	
						String basTar= (String)request.getAttribute("basTar");
						String bitTar= (String)request.getAttribute("bitTar");
						if(basTar==null) basTar=date;
						if(bitTar==null) bitTar=date;
					%>	
				
					document.getElementById("bas_tar").value="<%=basTar%>";
					document.getElementById("bit_tar").value="<%=bitTar%>";	
		}
</script>

<title></title>
</head>
<body>

<div align="center">
<hr>
<div align="left" >
		<table>
		<tr> <td align="left"> 
 <font style="font-size: 12px; font-family: monospace; color: graytext; ">
		..: Implant Gelir Raporu
		</font></td> 
		<td style="width: 51px; ">
		
		  <form>
				       <input type="button"  style="background-image:url('Images/printIcon2.jpg'); height: 24px; width: 32px" onclick="window.print()" >
		</form>
		</td> </tr>
		</table>

<hr>
</div>
<table style="width: 900px; ">
	<tr>
		<td align="left" valign="top" bgcolor="white">

		<form action="getGelirGiderDurumu.do" method="post">
		<!-- 
		islem turu 13 olmasi durumunda sadece implant isleminin gelir raporu getirilir.
		 -->
		<input type="hidden" value="13" name="islem" > <font color="Red"> </font>
		<table class="sorgulama">
			<tr>
				<td colspan="4"
					style="text-align: center; font: bold; font-size: 12px">Sorgula
				</td>
			</tr>
			<tr>
				<td style="width: 56px;">Tarih :</td>
				<td style="width: 164px;"><input class=inputTextfield
					name="bas_tar" id="bas_tar"></td>
				<td>/</td>
				<td><input class=inputTextfield name="bit_tar" id="bit_tar"></td>
			</tr>
			
				<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
				
				<tr > <td>Doktor</td> 
				<td colspan="4">  <select size="1" name="doktorId" class="giderTuru">
						<option label="Doktor Seçiniz.." value="-1"></option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } " value="${doktorDTO.dId }"></option>
						</c:forEach>
					</select></td> 
					</tr>
					
				</c:if>	
			
			<!-- 
			
			<tr> 
			<td>İşlem</td>
			<td colspan="3">
			
			<select size="1" name="islemTipi" class="giderTuru">
						<option label="Operasyon Seçiniz.." value="-1"/>

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id }"/>
						</c:forEach>
					</select>
			</td>
			</tr>
			
			 -->
			
			<tr>
				<td colspan="4" style="text-align: center;"><input
					type="submit" name="btn_Sorgula" value="Sorgula"></td>
			</tr>
			<tr>
				<td colspan="4"><input type="hidden" name="doctor"
					value="${sessionScope.sessionMember[0].kuId }" id="bas_tar">
				</td>
			</tr>
		</table>
		</form>
		
		<font color="Red"> ${resquestScope.warn} </font> <%
			Date bugun = new Date();
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String gunlukTarih = sdff.format(bugun);
			request.setAttribute("bugun", gunlukTarih);
		%>
		<c:if test="${sessionScope.sessionMember[0].kuTur eq '3' }">
		<br>    <myTagFiles:GelirRaporu silAktif="0" implantSayfasimi="evet">
						<c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					</myTagFiles:GelirRaporu>
		</c:if>
					
					<br>
								
					 </td>		
								
	</tr>
	
</table>
</div>
</body>
</html>