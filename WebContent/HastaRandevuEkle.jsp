<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<title>Hasta Sorgula</title>
<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("randevuTarihiStr"));

	}
</script>

</head>
<body>
<div>
<table align="center">
	<tr>
		<td align="left" valign="top" style="width: 650px">
		<hr>


		<form action="HastaRandevuEkle.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA RANDEVU EKLE</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td>
				
				
				<input class="inputTextfield" readonly="readonly" name="protokolNo"
					id="protokolNo" value="${hasta.protokolNo }" style="width: 394px; background-color: buttonshadow;"/>
					<input type="hidden" name="hastaId" value="${hasta.id }" >
					
					</td>
					
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" name="tcKimlik" id="tcKimlik"
					readonly="readonly" value="${hasta.tckimlik }" style="width: 394px; background-color: buttonshadow;" /></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad"
					style="width: 394px; background-color: buttonshadow;"
					readonly="readonly"
					value="${requestScope.hasta.ad} - ${requestScope.hasta.soyad }" />
			</tr>

			<tr>
				<td>Tarih</td>
				<td><input class="inputTextfield" name="randevuTarihiStr" id="randevuTarihiStr"
					<%if (request.getAttribute("tarihStr") == null) {%>=""
					value="${param.tarihStr}" <%} else {%>=""
					value="${tarihStr}" <%}%>="" /></td>
			</tr>
			<tr>
				<td>Saat</td>
				<td><select size="1" name="randevuSaat" style="width: 56px; font-size:12px ">
					<option value="-1" label="Saat">
					<c:forEach items="${requestScope.saatler}" var="saat" >
					<option value="${saat}" label="${saat}" ></option>				
					</c:forEach>
				</select>
				
				 : <select name="randevuDak" size="1" style="width: 52px; font-size:12px ">
				<option value="-1" label="Dk">
				<c:forEach items="${dakikalar }" var="dakika">
				<option label="${dakika }" value="${dakika }">
				
				</c:forEach>
				
				</select>
				
				</td>

			</tr>
			
			<tr>
				<td>Yapılacak İşlem</td>
				<td>
				<select name="islem" id="islem" style="width: 202px; " class="giderTuru">
				<option value="-1" label="İşlem Seçiniz..">
				<c:forEach var="islem" items="${sessionScope.islemTurList }">
				<option value="${islem.id }" label="${islem.ad }"> </option>
				
				
				</c:forEach>
				
				</select>
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
				<td>Açıklama</td>
				<td><textarea rows=5 " cols="50" name="aciklama"></textarea></td>
			</tr>
			<tr>

				<td colspan="3" style="text-align: center;"><input
					type="submit" value="Kaydet" /></td>
			</tr>


			<tr>
				<td colspan="2" align="left"><label style="color: red;">
				${requestScope.warn }</label></td>

			</tr>
		</table>
		<hr>
		</form>
		</td>
</table>

</div>
</body>
</html>