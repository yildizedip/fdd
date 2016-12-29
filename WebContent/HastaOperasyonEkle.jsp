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
<title>Hasta Operasyon Ekle</title>

<!--  		
	window.onload = function() {
			var bas_tar = new Epoch('epoch_popup', 'popup', document
					.getElementById("islemTarihiStr"));
					
			var bit_tar = new Epoch('epoch_popup', 'popup', document
					.getElementById("islemTarihiImplStr"));
					
					
					
			 $(document).ready(
					function(){
						$("div.implantOperasyonEkleForImplant").hide();				
					}
				);
	}
	
-->
<script type="text/javascript">

window.onload = function() {
	var bas_tar = new Epoch('epoch_popup', 'popup', document
			.getElementById("islemTarihiStr"));
			
	var bit_tar = new Epoch('epoch_popup', 'popup', document
			.getElementById("islemTarihiImplStr"));
			
			
			
	 $(document).ready(
			function(){
				$("div.implantOperasyonEkleForImplant").hide();				
			}
		);
}
	function hesapla() {
		var miktar = document.getElementById("miktar").value;
		var implantUcret = document.getElementById("implantUcret").value;	
		
		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;
		if (regexLetter.test(miktar)) {
			document.getElementById("miktar").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
		if (regexLetter.test(implantUcret)) {
			document.getElementById("implantUcret").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
		if (regexLetter.test(implantProtezUcret)) {
			document.getElementById("implantProtezUcret").value = "";
			alert("Yalnızca rakam girilebilir.");
		}
	}
	
	function validateForm(){
	
		 var miktar= document.forms["operasyonEkleForm"]["miktar"].value;
		 var  islemTipi = document.forms["operasyonEkleForm"]["islemTipi"].value;
		 var doktorId= document.forms["operasyonEkleForm"]["doktorId"].value;
		 var disAdet= document.forms["operasyonEkleForm"]["disAdet"].value;
		 var islemTarihi= document.forms["operasyonEkleForm"]["islemTarihiStr"].value;
		 
		
		 
		  if(disAdet== "-1" || disAdet==null || disAdet=="" ){
			 alert("Lütfen Diş Adetini Giriniz..");
			 return false;
		 }
		  if(islemTarihi== "-1" || islemTarihi==null || islemTarihi=="" ){
			 alert("Lütfen Operasyon Tarihi Giriniz..");
			 return false;
		 }
		 
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
	
	function validateFormImplant(){
	
		 var miktar= document.forms["operasyonEkleImplantForm"]["implantUcret"].value;
		 var  islemTipi = document.forms["operasyonEkleImplantForm"]["islemTipi"].value;
		 var doktorId= document.forms["operasyonEkleImplantForm"]["implantCerrahId"].value;
		 var doktorIdBaglayan= document.forms["operasyonEkleImplantForm"]["implantBaglayanDoktorId"].value;
		 var disAdet= document.forms["operasyonEkleImplantForm"]["disAdet"].value;
		 var islemTarihi= document.forms["operasyonEkleImplantForm"]["islemTarihiImplStr"].value;
		 
		  if(disAdet== "-1" || disAdet==null || disAdet=="" ){
			 alert("Lütfen Diş Adetini Giriniz..");
			 return false;
		 }
		 
		   if(islemTarihi== "-1" || islemTarihi==null || islemTarihi=="" ){
			 alert("Lütfen Operasyon Tarihi Giriniz..");
			 return false;
		 }
		 
		 if(miktar==null || miktar==""){
			 alert("Lütfen Miktar Alanını Kontrol Ediniz..");
			 return false;
		 }
		 if(islemTipi==null || islemTipi==-1){
			 alert("Lütfen Operasyon Seçiniz..");
			 return false;
		 }
		 if(doktorId==null || doktorId==-1){
			 alert("Lütfen Cerrah Doktor Seçiniz..");
			 return false;
	 	}
	 	 if(doktorIdBaglayan==null || doktorIdBaglayan==-1){
			 alert("Lütfen Yardımcı Doktor Seçiniz..");
			 return false;
	 	}
	 	
	
	}
	
	function implantMenusuAc(){
	
		var x = document.getElementById("islemTipi").value;

			if(x=='24')
			{
				$(document).ready(
				function(){
					$("div.OperasyonEkle").hide("slow");
					$("div.implantOperasyonEkleForImplant").show("slow");				
				}
				);			
			}
			else 
			{
				$(document).ready(
				function(){
					$("div.OperasyonEkle").show("slow");				
				}
				);
			}
	}
</script>

</head>
<body>
<div>

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
				<td colspan="3" style="text-align: center; color: red;"> ${requestScope.warn} </td>
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
				<td class="helpHed">Adet</td>
				<td class="helpHed">Doktor</td>
				<td class="helpHed">Baş. Tar.</td>
				<td class="helpHed">Bit. Tar.</td>
				<td class="helpHed">Açıklama</td>
				<td class="helpHed">Ücret</td>
				<td class="helpHed">Durum</td>
				<td class="helpHed"></td>



			</tr>
			<c:forEach items="${hastaOperasyonListesi}" var="operasyon"
				varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${operasyon.islemTip.ad}</td>
					<td class="helpBod">${operasyon.disAdet}</td>						
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

					<td  class="helpBod">
						 <html:link action="/HastaOdemeListesiGetir?islemId=${operasyon.id}&amp;hastaId=${hasta.id}&amp;tip=2"> Ödeme Ekle</html:link>
						 </td>

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
					<td colspan="3" style="text-align: center;">OPERASYON EKLE </td>
				</tr>
	
		<tr>
					<td> Diş Hekimi :</td>
					<td colspan="2"> <select size="1" name="doktorId" class="giderTuru">
						<option label="Diş Hekimi Seçiniz.." value="-1"></option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option  label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
								value="${doktorDTO.dId }" 
								<c:if test="${doktorDTO.dId eq operasyonDoktorId }">
								selected="selected"
								</c:if>  
								>
								
								</option>
						</c:forEach>
					</select> <input type="hidden" name="hastaId" value="${hasta.id }">
					<input type="hidden" name="iliskiliIslemId" value="${iliskiliIslemId}">

					</td>

				</tr>
<tr>
					<td>Operasyon Tarihi:</td>
					<td colspan="2"><input class="inputTextfield" name="islemTarihiStr" id="islemTarihiStr" readonly="readonly" <c:if test="${operasyonEklemeTarihi ne null}">
								
							value="${operasyonEklemeTarihi}"
								
								</c:if>="" value="${tarihStr}">
					 
					</td>

				</tr>
				<tr>
					<td> Yapılacak Operasyon :</td>
					<td><select size="1" name="islemTipi" id="islemTipi" class="giderTuru" onchange="implantMenusuAc()">
						<option label="Operasyon Seçiniz.." value="-1"></option>

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id}" <c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>=""></option>
						</c:forEach>
					</select></td>


				</tr>
				<tr>
					<td> Adet : </td>
					<td style="width: 530px;">
					
					<select size="1" name="disAdet" id="disAdet" class="giderTuru">
						<option label="Adet Seçiniz.." value="-1"></option>

						<c:forEach items="${disSayisiList}" var="dis">
							<option label="${dis}" value="${dis}"></option>
						</c:forEach>
					</select>   </td>


				</tr>

				<tr>
					<td>Operasyon Ücreti :</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="miktar" id="miktar" onkeyup="hesapla()" > TL</td>
				</tr>

				<tr>
					<td>Operasyon Durumu :</td>
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

		<div id="implantOperasyonEkleForImplant"
			class="implantOperasyonEkleForImplant"><a
			href="javascript: history.go(-1)">Geri</a> <c:if
			test="${hasta.id ne null }">
			<form name="operasyonEkleImplantForm" action="HastaOperasyonEkle.do"
				method="post" onsubmit="return validateFormImplant()">
			<table class="sorgulama" border="1">
				<tr>
					<td colspan="3" style="text-align: center;">İMPLANT EKLE</td>
				</tr>
				<tr>
					<td>Operasyon Tipi</td>
					<td colspan="2"><select size="1" name="islemTipi"
						id="islemTipi" class="giderTuru" >
						<option label="Operasyon Seçiniz.." value="-1" />

						<c:forEach items="${islemTurList}" var="islem">

							<option label="${islem.ad}" value="${islem.id}"
								<c:if test="${islem.ad eq 'İMPLANT'}"> selected="selected"   </c:if> />

						</c:forEach>
					</select> <input type="hidden" name="hastaId" value="${hasta.id }">

					</td>

				</tr>




				

	<tr>
					<td>Adet</td>
					<td colspan="2">
					<select size="1" name="disAdet"
						id="disAdet" class="giderTuru">
						<option label="Adet Seçiniz.." value="-1" />

						<c:forEach items="${disSayisiList}" var="dis">
							<option label="${dis}" value="${dis}" />
						</c:forEach>
					</select> 
					</td>

				</tr>
				<tr>
					<td>Doktor Cerrahi</td>
					<td><select size="1" name="implantCerrahId" class="giderTuru">
						<option label="Doktor Seçiniz.." value="-1"></option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
								value="${doktorDTO.dId }"></option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>Doktor Protez</td>
					<td><select size="1" name="implantBaglayanDoktorId" class="giderTuru">
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
						name="islemTarihiImplStr" id="islemTarihiImplStr"
						value="${tarihStr}"  ></td>
				</tr>
				<tr>
					<td>İmplant Ücreti</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="miktar" id="implantUcret" onkeyup="hesapla()">
					TL</td>
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
						id="btn_gonder" onclick="checkOperasyon()" /></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center; color: red;"></td>
				</tr>
			</table>
			</form>
		</c:if></div>

</div>
</body>
</html>