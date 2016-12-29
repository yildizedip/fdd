
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
<script type="text/javascript" src="js/epoch_classes.js"></script>
<title></title>

<!-- window.onload = 
function() 
{


var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("tarihStr"));	
												
}
 -->

<script type="text/javascript">

window.onload = 
function() 
{


var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("tarihStr"));	
												
}

function validateForm(){
	 var miktar= document.forms["form"]["miktar"].value;
	 var giderTuru = document.forms["form"]["giderTuru"].value;
	var odemeSekli = document.forms["form"]["odemeSekli"].value;
	 
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
	if(giderTuru==0 || giderTuru==''){
	
		alert("Lütfen Gider Turu Seçiniz..");
			return false;
	}
	
			if(odemeSekli==0 || odemeSekli==''){
	
		alert("Lütfen Odeme Şekli Seçiniz..");
			return false;
	}
	}
								
</script>

</head>
<body>
	<div align="left">
		<hr>
		<table>
			<tr>
				<td style="width: 1434px;" align="left"><font
					style="font-size: 12px; font-family: monospace; color: graytext;">
						..: Gider Ekle </font></td>
				<td style="width: 51px;">

					<form>
						<input type="button"
							style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
							onclick="window.print()">
					</form>
				</td>
			</tr>
		</table>

		<hr>
	</div>
	<form name="form" action="addGider.do" method="post"
		onsubmit="return validateForm()">
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">GİDER EKLE</td>
			</tr>
			<tr>
				<td>Tarih</td>
				<td><input class=inputTextfield name="tarihStr" id="tarihStr"
					value="${tarihStr}"> <input type="hidden" name="subeId"
					value="${subeId}"></td>
			</tr>
			<tr>
				<td>Miktar</td>
				<td><input type="text" id="miktar" name="miktar"
					style="height: 21px" /> TL</td>
			</tr>
			<tr>
				<td><label style="width: 100px">Gider Türü</label></td>
				<td><select size="1" name="giderTuru" id="giderTuru"
					class="giderTuru">

						<option label="Gider Türü Seçiniz.." value="0"></option>
						<c:forEach items="${sessionScope.giderTurKodlari}" var="turKodDTO">
							<option label="${turKodDTO.turAd }" value="${turKodDTO.turKod }"></option>
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>Ödeme Şekli</td>
				<td><myTagFiles:OdemeSekli></myTagFiles:OdemeSekli></td>
			</tr>
			<tr>
				<td>Açıklama</td>
				<td><textarea rows="5" cols="50" name="aciklama">
								</textarea></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><input
					type="submit" value="Gönder" name="bnt_gonder"></td>
			</tr>
			<tr>
				<td colspan="2"><label id="lbl_error" style="color: red;">${requestScope.warn}
				</label></td>
			</tr>
		</table>
	</form>
	</td>
	</tr>
	</table>
	</div>
</body>
</html>