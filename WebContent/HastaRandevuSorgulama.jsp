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
<table align="center">
	<tr>
		<td align="left" valign="top" style="width: 650px">
		<hr>
		<form action="hastaRandevuSorgula.do" method="post" >
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">RANDEVU SORGULA</td>
			</tr>
			<tr>
			<td>Tarih</td>
				<td><input class=inputTextfield name="randevuTarihiStr" id="randevuTarihiStr"
					<%if (request.getSession().getAttribute("tarihStr") == null) {%>
					value="${param.tarihStr}" <%} else {%>
					value="${tarihStr}" <%}%>></td>
			</tr>

			
			<tr>
				<td colspan="2" style="text-align: center;" ><input type="submit" value="Sorgula" name="bnt_gonder" />
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

		<hr><br>


		<table class="sofT" >	
		<tr>
			<td class="helpHed" ></td>
			<td class="helpHed">Tarih</td>
			<td class="helpHed" >Saat</td>
			<td class="helpHed" >Protokol No</td>
			<td class="helpHed">Ad Soyad</td>
			<td class="helpHed">Doktor</td>
			<td class="helpHed">İşlem</td>
			
			<c:if test="${silAktif ne '0' }">
						<td class="helpHed" > </td>
			</c:if>
	
		</tr>
		<c:forEach items="${randevuList}" var="randevu" varStatus="count">
		<tr>
		    <td class="helpBod" > ${count.count}</td>
			<td class="helpBod">${randevu.randevuTarihi}</td>
			<td class="helpBod">${randevu.randevuSaat} : ${randevu.randevuDak} </td>
			<td class="helpBod">${randevu.hasta.protokolNo} </td>
			<td class="helpBod">${randevu.hasta.ad}  ${randevu.hasta.soyad}  </td>
			<td class="helpBod">${randevu.doktorAd} ${randevu.doktorSoyad}</td>
			<td class="helpBod">${randevu.islemAd} </td>
			<c:if test="${silAktif ne '0' }">
					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
					<td class="helpBod" >
					
					<html:link action="/HastaSil?id=${hasta.id}"> Sil </html:link>  </td>
					
			</c:if>			
			
			</c:if>			
		</tr>
	
		</c:forEach>
		
	</table>
	
		</td>
</table>




</div>
</body>
</html>