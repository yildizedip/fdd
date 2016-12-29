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
		<tr> <td style="width: 1434px; " align="left"> 
 <font style="font-size: 12px; font-family: monospace; color: graytext; ">
		..: Gider Raporu
		</font> </td> 
		<td style="width: 51px; ">
		
		  <form>
				       <input type="button"  style="background-image:url('Images/printIcon2.jpg'); height: 24px; width: 32px" onclick="window.print()" >
		</form>
		</td> </tr>
		</table>

<hr>
</div>
<table style="width: 780px; ">
	<tr>
		<td align="left" valign="top" bgcolor="white">

		<form action="getGelirGiderDurumu.do" method="post">
		<input type="hidden" value="12" name="islem" > <font color="Red"> ${warn} </font>
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
			<tr> <td style="width: 73px; ">Gider Türü</td> <td colspan="3">
			 <select size="1" name="giderTuru" class="giderTuru">

				<option label="Gider Türü Seçiniz.." value="-1"/>
										<c:forEach items="${sessionScope.giderTurKodlari}" var="turKodDTO">
											<option label="${turKodDTO.turAd }" value="${turKodDTO.turKod }"/>
										</c:forEach>
			</select> </td> </tr>
		
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
		
		 <%
			Date bugun = new Date();
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String gunlukTarih = sdff.format(bugun);
			request.setAttribute("bugun", gunlukTarih);
		%><br> 

		
		<br>
		<myTagFiles:GiderOdemeSeklineGoreRApor>
		
		
		</myTagFiles:GiderOdemeSeklineGoreRApor>
		
		<br>

		<myTagFiles:GiderGiderTuruRapor>
		
		</myTagFiles:GiderGiderTuruRapor>
		</td>
		
		
	</tr>
	
</table>
</div>
</body>
</html>