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

<!-- 	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("odemeTarihiStr"));

	} -->

<script type="text/javascript">

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

<hr>
Hastaya ait seçilen ödemeyi aşağıdaki form ile güncelleyebilirsiniz.<div>
<table align="center">

	<tr>
		<td align="left" valign="top">		
		
				<form action="OdemeGuncelle.do" method="post">
				<table class="sorgulama">
					<tr>
						<td colspan="2" style="text-align: center;">ÖDEME GÜNCELLE</td>
					</tr>

					<tr>
						<td>Tarih</td>
						<td><input class=inputTextfield name="odemeTarihiStr"
							id="odemeTarihiStr"
							value="${odeme.odemeTarihiStr }" readonly="readonly"	 /> 
							<input type="hidden" name="id" value="${odeme.id }">
							
							
							</td>
					</tr>
					<tr>
						<td>Ödeme Türü</td>

						<td><select size="1" name="odemeTuru" style="width: 169px;"
							class="giderTuru">
						
							<option label="Peşinat" value="2" 
								<c:if test="${odeme.odemeTuru eq 2 }">
								selected="selected"
								</c:if>
							/>
							<option label="Taksit" value="3"
							<c:if test="${odeme.odemeTuru eq 3 }">
								selected="selected"
								</c:if>
							
							 />
							 	<option label="Kredi Kartı" value="4"
							<c:if test="${odeme.odemeTuru eq 4 }">
								selected="selected"
								</c:if>
							
							 />
						</select></td>
					</tr>
					
				
					<tr>
						<td>Miktar</td>

						<td><input type="text" name="miktar" id="miktar"
							value="${odeme.miktar }"  /> TL</td>
					</tr>

					
					<tr>
						<td>Açıklama</td>
						<td><textarea rows=5 " cols="50" name="aciklama">${odeme.aciklama}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input
							type="submit" value="Ödeme Güncelle" id="btn_gonder" 
							name="bnt_gonder"></td>
					</tr>
					<tr>
						<td colspan="2" align="left"><label style="color: red;">
						${requestScope.warn }</label></td>

					</tr>
				</table>

				</form>


		</td>
</table>

</div>
<br>
<hr>
</body>
</html>