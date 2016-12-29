<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<title></title>

<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("odemeTarihiStr"));

	}
	function hesapla() {
		var toplamMiktar = document.getElementById("toplamMiktar").value;

		var miktar = document.getElementById("miktar").value;
		var odenenMiktar = document.getElementById("odenenMiktar").value;

		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;
		

		if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			document.getElementById("miktar").value = "";
			alert("Yalnızca rakam girilebilir.");

		} else {
			var kalanMiktar = toplamMiktar - miktar - odenenMiktar;

			document.getElementById("kalanMiktar").value = kalanMiktar;
			if (kalanMiktar < 0) {
				alert("Kalan miktar değeri negatif olamaz.");
				
			}
			
		}
	}
</script>

</head>
<body>
<br>
<hr>
<font style="font-size: 12px; font-family: monospace; color: graytext;">
..: Operasyon Bitir </font>
<div>
<table align="center">
	<tr>
		<td align="left" valign="top">

		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">HASTA BİLGİLERİ</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td colspan="2"><input class="inputTextfield" name="protokolNo"
					style="width: 204px; background-color: buttonshadow;"
					readonly="readonly" id="hastaAd" value="${hasta.protokolNo }"></td>
			</tr>

			<tr>
				<td>Ad-Soyad</td>
				<td><input class="inputTextfield"
					style="width: 394px; background-color: buttonshadow;"
					name="hastaAd" readonly="readonly" id="hastaAd"
					value="${hasta.ad} ${hasta.soyad} (${hasta.tckimlik})"></td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center; color: red">${warn}</td>
			</tr>
		</table>
		<hr>
		<c:if test="${hastaOperasyonListesi ne null } ">
			<table class="sorgulama">
				<tr>
					<td colspan="3" style="text-align: center;">OPERASYON
					BİLGİLERİ</td>
				</tr>
				<tr>
					<td>İşlem Tipi</td>
					<td colspan="2"><input class="inputTextfield"
						name="protokolNo"
						style="width: 229px; background-color: buttonshadow;"
						readonly="readonly" id="hastaAd"
						value="${hastaOperasyonListesi['0'].islemTip.ad }"></td>

				</tr>

				<tr>
					<td>Doktor</td>
					<td><input class="inputTextfield"
						style="width: 416px; background-color: buttonshadow;"
						name="hastaAd" readonly="readonly" id="hastaAd"
						value="${hastaOperasyonListesi['0'].doktor.dAd } - ${hastaOperasyonListesi['0'].doktor.dSoyad }"></td>


				</tr>
				<tr>
					<td>İşlem Tarihi</td>
					<td><input class="inputTextfield"
						style="width: 394px; background-color: buttonshadow;"
						name="hastaAd" readonly="readonly" id="hastaAd"
						value="${hastaOperasyonListesi['0'].islemTarihi }"></td>


				</tr>
				<tr>
					<td>Ücret</td>
					<td><input class="inputTextfield"
						style="width: 150px; background-color: buttonshadow;" name="ucret"
						readonly="readonly" id="ucret"
						value="${hastaOperasyonListesi['0'].miktar }"> TL</td>


				</tr>
				<tr>
					<td>Açıklama</td>
					<td><textarea
						style="width: 394px; background-color: buttonshadow;"
						readonly="readonly" id="hastaAd">${hastaOperasyonListesi['0'].aciklama } </textarea>
					</td>


				</tr>

				<tr>
					<td colspan="3" style="text-align: center;"></td>
				</tr>
			</table>
			<hr>

			<table class="sofT">
				<tr>
					<td colspan="5" class="helpHed">ÖDEME LİSTESİ</td>
				</tr>
				<tr>
					<td class="helpHed" />
					<td class="helpHed">Tarih</td>
					<td class="helpHed">Ödeme</td>
					<td class="helpHed">Miktar</td>



				</tr>
				<c:forEach items="${hastaOperasyonListesi['0'].odemeList}"
					var="odeme" varStatus="count">
					<tr>
						<td class="helpBod">${count.count}</td>
						<td class="helpBod">${odeme.odemeTarihi}</td>
						<td class="helpBod"><c:choose>
							<c:when test="${odeme.odemeTuru eq 1}">
			Toplam Miktar
			</c:when>
							<c:when test="${odeme.odemeTuru eq 2}">
			Peşinat
			</c:when>
							<c:when test="${odeme.odemeTuru eq 3}">
			Taksit
			</c:when>
							<c:when test="${odeme.odemeTuru eq 4}">
			Kredi Kartı
			</c:when>
							<c:otherwise>
	
			</c:otherwise>
						</c:choose></td>
						<td class="helpBod">${odeme.miktar}</td>



					</tr>

				</c:forEach>

			</table>
			<hr>

			<c:choose>

				<c:when test="${hastaOperasyonListesi['0'].durumu eq 'B'}">

				</c:when>
				<c:otherwise>
					<form action="OperasyonBitir.do" method="post"><input
						type="hidden" value="${hastaOperasyonListesi['0'].id}" name="id">
					<input type="submit" value="Operasyonu Bitir"></form>

				</c:otherwise>
			</c:choose>



		</c:if></td>
</table>

</div>
<br>
<hr>
</body>
</html>