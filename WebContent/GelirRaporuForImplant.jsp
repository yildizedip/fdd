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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<title></title>
</head>
<body>

<div align="center">
<div align="left" >
<hr>

 <font style="font-size: 12px; font-family: monospace; color: graytext; ">
		..: Implant Durumu
		</font>

<hr>
</div>
<table>
	<tr>
		<td align="left" valign="top" bgcolor="white">

		<form action="getDoktorOperasyonListesi.do" method="post">

		<table class="sorgulama">
			<tr>
				<td colspan="4"
					style="text-align: center; font: bold; font-size: 12px">Sorgula
				</td>
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
			<select size="1" name="durum" class="giderTuru">
			<option label="Durum Seçiniz.." value="-1"/>
			<option  label="Devam Ediyor" value="A" >
			<option  label="Bitmiş"  value="B">
			
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

<table class="sofT">
			<tr>
				<td colspan="10" class="helpHed">OPERASYON LİSTESİ</td>
			</tr>
			<tr>			
				<td class="helpHed"/>
				<td class="helpHed">P. No</td>
				<td class="helpHed">Ad Soyad</td>
				<td class="helpHed">Operasyon</td>
				<td class="helpHed">Tarihi</td>
				<td class="helpHed">Adet</td>
				<td class="helpHed">Açıklama</td>
				<td class="helpHed">Ücret</td>
				<td class="helpHed">Durum</td>
				<td class="helpHed"></td>
				
			</tr>
			<c:forEach items="${doktorOperasyonListesi}" var="operasyon" varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${operasyon.hasta.protokolNo}</td>
					<td class="helpBod">${operasyon.hasta.ad} ${operasyon.hasta.soyad}</td>
					<td class="helpBod">${operasyon.islemTip.ad}</td>					
					<td class="helpBod">${operasyon.islemTarihiStr}</td>
					<td class="helpBod">${operasyon.disAdet}</td>
					<td class="helpBod">${operasyon.aciklama}</td>
					<td class="helpBod">${operasyon.miktar}</td>
					<td class="helpBod">
					<c:choose>					
						<c:when test="${operasyon.durumu eq 'A'}">Dvm E.</c:when>
						<c:when test="${operasyon.durumu eq 'B'}">Bitti</c:when>
					</c:choose>
					</td>
					<td class="helpBod"> 						
						<html:link action="/HastaOdemeListesiGetir?islemId=${operasyon.id}
						&hastaId=${operasyon.hastaId}&tip=6"> Ödeme Listesi Görüntüle</html:link>
					</td>

				</tr>

			</c:forEach>

		</table>
		</td>
	</tr>
	<tr>
		<td width="308" bgcolor="#FFFFFF"></td>
		<td width="657" bgcolor="#FFFFFF"></td>
	</tr>
</table>
</div>
</body>
</html>