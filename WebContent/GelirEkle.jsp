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
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<title></title>

<!--
 window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("odemeTarihiStr"));

	}  
	
	-->

<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("odemeTarihiStr"));
				}
	
	function hesapla() {
		var toplamMiktar = document.getElementById("toplamMiktar").value;

		var miktar = document.getElementById("miktar").value;
		var odenenMiktar = document.getElementById("odenmisMiktar").value;

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
	
	
function validateForm(){
	 var miktar= document.forms["odemeEkleForm"]["miktar"].value;
	 var toplamMiktar = document.forms["odemeEkleForm"]["toplamMiktar"].value;
	var odenenMiktar = document.forms["odemeEkleForm"]["odenmisMiktar"].value;
	var kalanMiktar= document.forms["odemeEkleForm"]["kalanMiktar"].value;
	 
	 var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;
	 
	 if(miktar==null || miktar=="" ||  miktar <0){
	 alert("Lütfen Miktar Alanını Kontrol Ediniz..");
	 return false;
	 }
	 
	
	if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			
			alert("Yalnızca rakam girilebilir.");
			return false;

		}
		if(kalanMiktar<0){ 
		alert("Lütfen miktarı kontrol ediniz..");
		return false;
		}
		
	
	}
</script>

</head>
<body>
<br>
<hr>
<font style="font-size: 12px; font-family: monospace; color: graytext;">
..: Hasta Ödeme Ekle </font>
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

		</table>
		<hr>
		
		<table class="sorgulama">
				<tr>
					<td colspan="3" style="text-align: center;">OPERASYON
					BİLGİLERİ</td>
				</tr>
				<tr>
					<td>İşlem Tipi</td>
					<td colspan="2"><input class="inputTextfield" name="protokolNo" 
style="width: 229px; background-color: buttonshadow;" readonly="readonly" id="hastaAd" 
value="${hastaOperasyonListesi['0'].islemTip.ad }"/></td>

				</tr>

				<tr>
					<td>Doktor</td>
					<td><input class="inputTextfield" style="width: 416px; 
					background-color: buttonshadow;" name="hastaAd" readonly="readonly" 
					id="hastaAd" value="${hastaOperasyonListesi['0'].doktor.dAd } - ${hastaOperasyonListesi['0'].doktor.dSoyad }"/></td>


				</tr>
				<tr>
					<td>İşlem Tarihi</td>
					<td><input class="inputTextfield" style="width: 394px; background-color: buttonshadow;" name="hastaAd" readonly="readonly" id="hastaAd" value="${hastaOperasyonListesi['0'].islemTarihi }"/></td>

				</tr>
				<tr>
					<td>Ücret</td>
					<td><input class="inputTextfield" style="width: 150px; background-color: buttonshadow;" name="ucret" readonly="readonly" id="ucret" value="${hastaOperasyonListesi['0'].miktar }"/> TL</td>
				</tr>
				
				<tr>
					<td>Açıklama</td>
					<td>
					<textarea style="background-color: buttonshadow; width: 333px" readonly="readonly" id="hastaAd">${hastaOperasyonListesi['0'].aciklama } </textarea>
					</td>
				</tr>
			</table>
		
		
		<c:if test="${hastaOperasyonListesi ne null }">
			
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
							<c:otherwise>
			Taksit
			</c:otherwise>
						</c:choose></td>
						<td class="helpBod">${odeme.miktar}</td>



					</tr>

				</c:forEach>

			</table>
			<hr>
			<c:if test="${param.tip ne '3'  }">



				<form name="odemeEkleForm" action="hastaOdemeEkle.do" method="post"
					onsubmit="return validateForm()">
				<table class="sorgulama">
					<tr>
						<td colspan="2" style="text-align: center;">ÖDEME EKLE</td>
					</tr>

					<tr>
						<td>Tarih</td>
						<td><input class=inputTextfield name="odemeTarihiStr"
							id="odemeTarihiStr" 
							<%if (request.getSession().getAttribute("tarihStr") == null) {%>
							value="${param.tarihStr}" <%} else {%>
							value="${tarihStr}" <%}%>><input
							type="hidden" name="islemId"
							value="${hastaOperasyonListesi['0'].id}"> <input
							type="hidden" name="hastaId" value="${hasta.id }" /> <input
							type="hidden" name="doktorId"
							value="${hastaOperasyonListesi['0'].doktorId}" />
							
							
							</td>
					</tr>
					<tr>
						<td>Ödeme Türü</td>

						<td><select size="1" name="odemeTuru" style="width: 169px;"
							class="giderTuru">
							<option label="Peşinat" value="2" />
							<option label="Taksit" value="3" />
							<option label="Kredi Kartı" value="4" />

						</select></td>
					</tr>
					<tr>
						<td>Ücret</td>

						<td><input type="text" name="toplamMiktar"
							style="width: 204px; background-color: buttonshadow;"
							readonly="readonly" id="toplamMiktar"
							value="${hastaOperasyonListesi['0'].miktar }" /></td>
					</tr>

					<tr>
						<td>Ödenen Miktar</td>

						<td><input type="text" name="odenmisMiktar"
							style="width: 204px; background-color: buttonshadow;"
							readonly="readonly" id="odenmisMiktar"
							value="${requestScope.odenenMiktar }" />= <input type="text"
							name="odenmisMiktar"
							style="width: 204px; background-color: buttonshadow;"
							readonly="readonly" id="odenmisMiktar"
							value="${hastaOperasyonListesi['0'].miktar - requestScope.odenenMiktar }"></td>
					</tr>
					<tr>
						<td>Ödenecek Miktar</td>

						<td><input type="text" name="miktar" id="miktar"
							onkeyup="hesapla()" style="height: 21px" /> TL</td>
					</tr>

					<tr>
						<td>Kalan Miktar</td>
						<td><input type="text" readonly="readonly" id="kalanMiktar"
							name="kalanMiktar"
							style="width: 204px; background-color: buttonshadow;"> TL</td>

					</tr>
					<tr>
						<td>Açıklama</td>
						<td><textarea rows="5" cols="50" name="aciklama"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input
							type="submit" value="Ödeme Ekle" id="btn_gonder"
							name="bnt_gonder"></td>
					</tr>
					<tr>
						<td colspan="2" align="left"></td>

					</tr>
				</table>

				</form>

			</c:if>

		</c:if></td>
</table>

</div>
<br>
<hr>
</body>
</html>