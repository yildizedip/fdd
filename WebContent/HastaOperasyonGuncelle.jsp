<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<title>Hasta Güncelle</title>

<!-- 	var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiStr")); -->
<script type="text/javascript">
	window.onload = function() {

	
		var bit_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemBitisTarihiStr"));
		

	}
</script>


</head>
<body>
<div>
<table align="center">
	<tr>
		<td align="left" valign="top" style="width: 650px">
		<hr>
 <font style="font-size: 12px; font-family: monospace; color: graytext; ">
		..: Operasyon Güncelle</font>
		
		<hr>
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA BİLGİLERİ</td>
			</tr>
			<tr>
				<td>Protokol No</td>

				<td><input class="inputTextfield" name="protokolNo" id="protokolNo"
					value="${hasta.protokolNo }" /> </td>
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tckimlik }" /> <input type="hidden" name="id"
					value="${hasta.id }"></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad"
					value="${hasta.ad }" /> <input class="inputTextfield" name="soyad"
					id="soyad" value="${hasta.soyad }" /></td>
			</tr>


		

			<tr>
				<td colspan="2" align="left"><label style="color: red;">
				${warn}</label></td>

			</tr>

		</table>
		
		<hr>
		
		<form action="OperasyonGuncelle.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">OPERASYON BİLGİLERİ</td>
			</tr>
			<tr>
				<td>İşlem Tipi</td>
				<td colspan="2">
				<select size="1" name="islemTipi" class="giderTuru"   >
						<option label="Operasyon Seçiniz.." value="-1" />

						<c:forEach items="${islemTurList}" var="islem">
						<option label="${islem.ad}" value="${islem.id }" 
						<c:if test="${operasyon.islemTipi eq islem.id }">
						
						selected="selected"
						</c:if>
						
						
						/>
						</c:forEach>
						
					</select>
					<input type="hidden" name="islemId" value="${operasyon.id}">
				</td> 

			</tr>

			<tr>
				<td>Doktor</td>
				<td>
				<select size="1" name="doktorId" class="giderTuru">
						<option label="Doktor Seçiniz.." value="-1"/>

						<c:forEach items="${doktorList}" var="doktorDTO">
							<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } " value="${doktorDTO.dId }"
								<c:if test="${operasyon.doktorId eq doktorDTO.dId }">
										
										selected="selected"
										</c:if>
							
							
							/>
						</c:forEach>
					</select>
				</td>


			</tr>
			<tr>
				<td>Operasyon Başlama Tarihi</td>
				<td>
				
				<input class="inputTextfield" name="islemTarihiStr" readonly="readonly" 
				id="islemTarihiStr" value="${operasyon.islemTarihiStr}"/>
				</td>


			</tr>
			
			<tr>
				<td>Operasyon Bitiş Tarihi</td>
				<td>
				
				<input class="inputTextfield" name="islemBitisTarihiStr" 
				id="islemBitisTarihiStr" value="${operasyon.islemBitisTarihiStr}"/>
				</td>


			</tr>
				<tr>
				<td>Ücret</td>
				<td><input  class="inputTextfield"  
				
				<c:choose>
						<c:when test="${odemeListesi ne null}">
					readonly="readonly"
						</c:when>
						<c:otherwise>
							
						</c:otherwise>	</c:choose>
				 style="width: 150px;" name="miktar" 
				id="miktar" value="${operasyon.miktar }"/> TL</td>


			</tr>
			<tr>
				<td>Açıklama</td>
				<td>
				<textarea style="width: 394px;"  name="aciklama" id="aciklama">${operasyon.aciklama } </textarea>				 
					</td>
 

			</tr>

			<tr>
				<td colspan="3" style="text-align: center;">
				<input type="submit" value="Operasyon Güncelle" 
				id="btn_gonder" name="bnt_gonder"/>
				
				</td>
				
			</tr>
		</table>
		</form>
		
		</td>
</table>
</div>
</body>
</html>