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
						
	}

	function hesapla() {
		var miktar = document.getElementById("miktar").value;
		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;
		if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			document.getElementById("miktar").value = "";
			alert("Yaln�zca rakam girilebilir.");
		}
	}
	
	function validateForm(){
		 var miktar= document.forms["operasyonEkleForm"]["miktar"].value;
		 var  islemTipi = document.forms["operasyonEkleForm"]["islemTipi"].value;
		 var doktorId= document.forms["operasyonEkleForm"]["doktorId"].value;
		 
		 if(miktar==null || miktar==""){
			 alert("L�tfen Miktar Alan�n� Kontrol Ediniz..");
			 return false;
		 }
		 if(islemTipi==null || islemTipi==-1){
			 alert("L�tfen Operasyon Se�iniz..");
			 return false;
		 }
		 if(doktorId==null || doktorId==-1){
			 alert("L�tfen Doktor Se�iniz..");
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

		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Operasyon Ekle </font>
		<hr>
		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">HASTA B�LG�LER�</td>
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
					<td colspan="2">
					<select size="1" name="islemTipi"
						id="islemTipi" class="giderTuru">
						
						<option label="Operasyon Se�iniz.." value="-1" />

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id }" />
						</c:forEach>
					</select> 
					
					<input type="hidden" name="hastaId" value="${hasta.id }">

					</td>

				</tr>

				<tr>
					<td>Doktor</td>
					<td>
					
					<select size="1" name="doktorId" class="giderTuru">
					
						<option label="Doktor Se�iniz.." value="-1"></option>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
								value="${doktorDTO.dId }"></option>
						</c:forEach>
					</select>
					
					</td>


				</tr>
				<tr>
					<td>Tarih</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="islemTarihiStr" id="islemTarihiStr"
						value="${tarihStr}"></td>


				</tr>

				<tr>
					<td>�cret</td>
					<td style="width: 530px;"><input class="inputTextfield"
						name="miktar" id="miktar" onkeyup="hesapla()"> TL</td>
				</tr>

				<tr>
					<td>Durum</td>
					<td style="width: 530px;"><input type="checkbox" name="durumu">
					Kesinle�medi</td>
				</tr>
				<tr>
					<td>A��klama</td>
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
		</c:if>
		</div>

		
</body>
</html>