<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<title>Hasta Sorgula</title>

<script type="text/javascript">
				
	window.onload = function() {
			var bas_tar = new Epoch('epoch_popup', 'popup', document
					.getElementById("islemTarihiStr"));
					
								var bit_tar = new Epoch('epoch_popup', 'popup', document
					.getElementById("islemTarihiImplStr"));
			
	}

	function hesapla() {
		var miktar = document.getElementById("miktar").value;
		var implantUcret = document.getElementById("implantUcret").value;
		var implantProtezUcret = document.getElementById("implantProtezUcret").value;
		
		
		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;
		if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			document.getElementById("miktar").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
		if (!regexNum.test(implantUcret) && regexLetter.test(implantUcret)) {
			document.getElementById("implantUcret").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
		if (!regexNum.test(implantProtezUcret) && regexLetter.test(implantProtezUcret)) {
			document.getElementById("implantProtezUcret").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
	}
	
	function validateForm(){
	
		 var miktar= document.forms["operasyonEkleForm"]["miktar"].value;
		 var  islemTipi = document.forms["operasyonEkleForm"]["islemTipi"].value;
		 var doktorId= document.forms["operasyonEkleForm"]["doktorId"].value;
		 
		 
		 if(miktar==null || miktar==""){
			 alert("Lütfen Miktar Alanını Kontrol Ediniz..");
			 return false;
		 }
		 if(islemTipi==null || islemTipi==-1){
			 alert("Lütfen Operasyon Seçiniz..");
			 return false;
		 }
		 if(doktorId==null || doktorId==-1){
			 alert("Lütfen Doktor Seçiniz..");
			 return false;
	 	}
	 	
	
	}

	
function checkOperasyon(){
	
}
	
	
</script>

</head>
<body>
<div>
<table align="center">
	<tr>
		<td align="left" valign="top" style="width: 650px">
		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Operasyon Ekle </font>
		<hr>
		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">HASTA BİLGİLERİ</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td colspan="2"><input class="inputTextfield"
					readonly="readonly" name="protokolNo" id="hstProtokol"
					value="${hasta.protokolNo }" /></td>

			</tr>

			<tr>
				<td>Ad</td>
				<td><input class="inputTextfield" name="ad"
					value="${hasta.ad }" id="hstProtokol" /></td>
				<td><input class="inputTextfield" name="soyad"
					readonly="readonly" value="${hasta.soyad }" id="hstProtokol" /></td>

			</tr>

			<tr>
				<td colspan="3" style="text-align: center; color: red;"></td>
			</tr>
		</table>

		<hr>
		<table class="sofT">
			<tr>
				<td colspan="11" class="helpHed">VAR OLAN OPERASYON LİSTESİ</td>
			</tr>
			<tr>

				<td class="helpHed" />
				<td class="helpHed">Operasyon</td>
				<td class="helpHed">Doktor</td>
				<td class="helpHed">Baş. Tar.</td>
				<td class="helpHed">Bit. Tar.</td>
				<td class="helpHed">Açıklama</td>
				<td class="helpHed">Ücret</td>
				<td class="helpHed">Durum</td>



			</tr>
			<c:forEach items="${hastaOperasyonListesi}" var="operasyon"
				varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${operasyon.islemTip.ad}</td>
					<td class="helpBod">${operasyon.doktor.dAd} -
					${operasyon.doktor.dSoyad}</td>
					<td class="helpBod">${operasyon.islemTarihi}</td>
					<td class="helpBod">${operasyon.islemBitisTarihi}</td>
					<td class="helpBod">${operasyon.aciklama}</td>
					<td class="helpBod">${operasyon.miktar}</td>


					<td class="helpBod"><c:choose>
						<c:when test="${operasyon.durumu eq 'A'}">D. Ediyor</c:when>
						<c:when test="${operasyon.durumu eq 'B'}">Bitmiş</c:when>


					</c:choose></td>


				</tr>

			</c:forEach>

		</table>

		<hr>
		<div id="OperasyonEkle" class="OperasyonEkle"><c:if
			test="${hasta.id ne null }">

			<form name="operasyonEkleForm" action="HastaOperasyonEkle.do"
				method="post" onsubmit="return validateForm()">
			<table class="sorgulama" border="1">
				<tr>
					<td colspan="3" style="text-align: center;">OPERASYON EKLE</td>
				</tr>
				<tr>
					<td>Operasyon Tipi</td>
					<td colspan="2"><select size="1" name="islemTipi" 
					
						id="islemTipi" class="giderTuru"
						
						>
						<option label="Operasyon Seçiniz.." value="-1" />

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id}"  
							<c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>
							
							/>
						</c:forEach>
					</select> <input type="hidden" name="hastaId" value="${hasta.id }">
					<input type="hidden" name="iliskiliIslemId" value="${iliskiliIslemId}">

					</td>

				</tr>

				<tr>
					<td>Doktor</td>
					<td><select size="1" name="doktorId" class="giderTuru">
						<option label="Doktor Seçiniz.." value="-1"></option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
								value="${doktorDTO.dId }"></option>
						</c:forEach>
					</select></td>


				</tr>
				<tr>
					<td>Tarih</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="islemTarihiStr" id="islemTarihiStr"
						value="${tarihStr}"></td>


				</tr>

				<tr>
					<td>Ücret</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="miktar" id="miktar" onkeyup="hesapla()"> TL</td>
				</tr>

				<tr>
					<td>Durum</td>
					<td style="width: 530px;"><input type="checkbox" name="durumu">
					Kesinleşmedi</td>
				</tr>
				<tr>
					<td>Açıklama</td>
					<td><textarea rows="4" name="aciklama" id="aciklama" cols="50"></textarea></td>

				</tr>

				<tr>
					<td colspan="3" style="text-align: center;"><input
						type="submit" value="Operasyon Ekle" name="bnt_gonder"
						id="btn_gonder" /></td>
				</tr>

				<tr>
					<td colspan="3" style="text-align: center; color: red;"></td>
				</tr>
			</table>

			</form>
		</c:if></div>

	

		</td>
</table>
</div>
</body>
</html>