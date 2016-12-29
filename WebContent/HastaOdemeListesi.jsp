<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
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
<script type="text/javascript">

function dogrula(){

}

</script>
</head>
<body>
<div>

		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Hasta �deme Listesi </font>
		<hr>
		
		
		<form action="hastaRandevuSorgula.do" method="post" >
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA B�LG�LER�</td>
			</tr>
			<tr>
			<td>Protokol No</td>
				<td><input readonly="readonly" class=inputTextfield name="protokolNo" id="protokolNo" value="${requestScope.hasta.protokolNo }"></td>
			</tr>
			<tr>
			<td>Ad-Soyad</td>
				<td><input readonly="readonly" class=inputTextfield name="ad" id="ad"	value="${requestScope.hasta.ad } ${requestScope.hasta.soyad}"></td>
			</tr>
			<tr>
				<td>Tc Kimlik</td>
				<td><input readonly="readonly" class=inputTextfield name="tc" id="tc" value="${requestScope.hasta.tckimlik }"
					></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;" >
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<label id="lbl_error" style="color: red;">${requestScope.warn} ${requestScope.noContent}
								</label> 
				</td>
			</tr>
		</table>

		</form>

		<hr>
		<table class="sorgulama">
				<tr>
					<td colspan="3" style="text-align: center;">OPERASYON
					B�LG�LER�</td>
				</tr>
				<tr>
					<td>��lem Tipi</td>
					<td colspan="2">
					<input class="inputTextfield" name="protokolNo" 
					style="width: 229px; background-color: buttonshadow;" 
					readonly="readonly" id="islemTipi"  
						value="${hastaOperasyonListesi[0].islemTip.ad}"
					></td>

				</tr>
				<tr>
					<td>Di� Say�s�</td>
					<td><input class="inputTextfield" style="width: 106px; 
					background-color: buttonshadow;" name="hastaAd" readonly="readonly" id="hastaAd" value="${hastaOperasyonListesi[0].disAdet}"></td>


				</tr>
				
				<tr>
					<td>Doktor</td>
					<td><input class="inputTextfield" style="width: 416px; 
					background-color: buttonshadow;" name="hastaAd" readonly="readonly" id="hastaAd" value="${hastaOperasyonListesi['0'].doktor.dAd } - ${hastaOperasyonListesi['0'].doktor.dSoyad }"></td>


				</tr>
				
				<tr>
					<td>��lem Tarihi</td>
					<td><input class="inputTextfield" style="width: 394px; background-color: buttonshadow;" name="hastaAd" readonly="readonly" id="hastaAd" value="${hastaOperasyonListesi['0'].islemTarihi }"></td>

				</tr>
				<tr>
					<td>�cret</td>
					<td><input class="inputTextfield" style="width: 150px; background-color: buttonshadow;" name="ucret" readonly="readonly" id="ucret" value="${hastaOperasyonListesi['0'].miktar }"> TL</td>
				</tr>
				
				<tr>
					<td>A��klama</td>
					<td>
					<textarea style="background-color: buttonshadow; width: 333px" readonly="readonly" id="hastaAd">${hastaOperasyonListesi['0'].aciklama } </textarea>
					</td>
				</tr>
			</table>
		
		<hr>
		<table class="sofT" >
		<tr> <td class="helpHed"  colspan="8"> �DEME L�STES�</td> </tr>	
		<tr>
			<td class="helpHed" ></td>
			<td class="helpHed">Tarih</td>
			<td class="helpHed" >�deme T�r�</td>
			<td class="helpHed" >�denen Miktar</td>
			<td class="helpHed">Kalan Miktar</td>
			<td class="helpHed">A��klama</td>
		
			<c:if test="${silAktif ne '0' }">
						<td class="helpHed" > </td>
						<td class="helpHed" > </td>
						
			</c:if>
	
		</tr>
		<c:forEach items="${requestScope.hastaOdemeListesi}" var="odeme" varStatus="count">
		<tr>
		    <td class="helpBod" > ${count.count}</td>
			<td class="helpBod">${odeme.odemeTarihi}</td>
			<td class="helpBod">
			<c:choose>
			<c:when test="${odeme.odemeTuru eq 2}" >
			Pe�inat
			</c:when>
			<c:when test="${odeme.odemeTuru eq 3}" >
			Taksit
			</c:when>
			<c:when test="${odeme.odemeTuru eq 4}" >
			Kredi Kart�
			</c:when>
			</c:choose>
			
			</td>
			<td class="helpBod">${odeme.miktar} </td>
			<td class="helpBod">${operasyon.miktar -odeme.miktar} 
			<c:set target="${operasyon}" property="miktar" 
			value="${operasyon.miktar -odeme.miktar}"></c:set> </td>
			
			<td class="helpBod">${odeme.aciklama} </td>
		
			<c:if test="${silAktif ne '0' }">
					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
					<td class="helpBod" >
					
					<html:link action="/OdemeSil?id=${odeme.id}"> Sil </html:link>  </td>
						<td class="helpBod" >
					
					<html:link action="/OdemeGetir?id=${odeme.id}"> G�ncelle </html:link>  </td>
					
					</c:if>			
			
			</c:if>			
		</tr>
	
		</c:forEach>
		
	</table>
	

</div>
</body>
</html>