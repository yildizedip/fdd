<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />


<title>Hasta Sorgula</title>

<script type="text/javascript">

function validation(){
	 var protokolNo= document.forms["sorgulaForm"]["protokolNo"].value;
	 var ad = document.forms["sorgulaForm"]["ad"].value;
	var soyad = document.forms["sorgulaForm"]["soyad"].value;
	var tel = document.forms["sorgulaForm"]["tel"].value;
	
	if(ad==""&&soyad==""&&protokolNo==""&& tel==""){
	alert("Lütfen en az bir sorgulama alani seciniz..");
	return false;
	}
	}
</script>
</head>

<body>
<div id="dt_example">
		<h1>
		<c:choose>
			<c:when test="${param.islem eq 1}">
				..: Hastalara randevu eklemek 
			</c:when>
			<c:when test="${param.islem eq 2}">
			..: Hastaların ödemelerini kaydetmek
			</c:when>
		
			<c:when test="${param.islem eq 4}">
				..: Hastalara operasyon eklemek 
			</c:when>

			<c:when test="${param.islem eq 5}">
				..: Hasta operasyon listesini görüntülemek 
			</c:when>
			<c:when test="${param.islem eq 6}">
			..: Hastaların ödemelerini görüntülemek 
			</c:when>
			<c:when test="${param.islem eq 7}">
			..: Hastanın operasyonunu bitirmek için 
			</c:when>
			
			<c:when test="${param.islem eq 8}">
			..: Hastanın operasyonuna ait labratuvar işlemleri için
			</c:when>
		</c:choose> için lütfen hasta sorgulayınız. </h1>
	
		<form action="hastaSorgulaForRandevu.do" method="post" 
		name="sorgulaForm" onsubmit="return validation()">
		<table class="sorgulama">
			<tr>
				<td colspan="4" style="text-align: center;">HASTA SORGULA</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" name="protokolNo"
					id="hstProtokol" />
					
					
					<input type="hidden" name="islem"
					value="${param.islem}" id="islem"></td>
					<td> Telefon:</td>
					<td> <input type="text" name="tel" id="tel" > </td>
					
					


			</tr>

			<tr>
				<td>Ad-Soyad</td>
				<td colspan="3"><input class="inputTextfield" name="ad" id="ad" />
				- <input class="inputTextfield" name="soyad" id="soyad"></td>

			</tr>

			<tr>
				<td colspan="4" style="text-align: center;"><input
					type="submit" value="Sorgula" name="bnt_gonder" /></td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center; color: red;">
				${requestScope.warn}</td>
			</tr>
		</table>

		</form>

		<hr>
		<br>


		<table class="sofT">
			<tr>
				<td class="helpHed"></td>
				<td class="helpHed">Protokol No</td>
				<td class="helpHed">Ad-Soyad</td>
				<td class="helpHed">Tel</td>

				<c:if test="${silAktif ne '0' }">
					<td class="helpHed"></td>

				</c:if>

			</tr>
			<c:forEach items="${hastaListesi}" var="hasta" varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${hasta.protokolNo}</td>
					<td class="helpBod">${hasta.ad} ${hasta.soyad}</td>
					<td class="helpBod">${hasta.tel}</td>

					<c:if test="${silAktif ne '0' }">
						<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
							<td class="helpBod"><c:choose>

								<c:when test="${param.islem eq 1 }">
									<html:link action="/HastaGetir?id=${hasta.id}&type=1"> Randevu Ver </html:link>
								</c:when>
								<c:when test="${param.islem eq 2 }">
								
								<!--  <html:link action="/HastaGetir?id=${hasta.id}&type=2"> Ödeme Gir </html:link>  -->
								
								<html:link
										action="/HastaOperasyonListesiGetir?id=${hasta.id}&type=2"> Ödemeleri Gir </html:link>
								
								
								</c:when>
								<c:when test="${param.islem eq 6 }">
									<html:link
										action="/HastaOperasyonListesiGetir?id=${hasta.id}&type=6"> Ödemeleri Görüntüle </html:link>
								</c:when>
								<c:when test="${param.islem eq 4 }">
									<html:link action="/HastaGetir?id=${hasta.id}&type=4"> Operasyon Ekle </html:link>
								</c:when>								
								<c:when test="${param.islem eq 5 }">
									<html:link action="/HastaOperasyonListesiGetir?id=${hasta.id}&type=5"> Operasyonları Görüntüle </html:link>
								</c:when>
								
								<c:when test="${param.islem eq 7 }">
									<html:link action="/HastaGetir?id=${hasta.id}&type=7"> Operasyonu Bitir </html:link>
								</c:when>
								
								<c:when test="${param.islem eq 8 }">
									<html:link action="/HastaOperasyonListesiGetir?id=${hasta.id}&type=8"> Operasyon Listesi </html:link>
								</c:when>
								
								
							</c:choose>
						</c:if>

					</c:if>
				</tr>

			</c:forEach>

		</table>
</div>
</body>
</html>