<%@page import="tr.com.fdd.dto.THastaDTO"%>
<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
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
<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiStr"));

	}
	
	
	function validation(){
	 var tar =	document.getElementById("islemTarihiStr").value;
	 var saat =	document.getElementById("saat").value;
	 var dakika =	document.getElementById("dakika").value;
	 var aciklama =	document.getElementById("aciklama").value;
	 
	
	 if(saat=="-1" || dakika=="-1"){
		 alert("Lütfen saat dakika seçiniz.");
		 return false;
	 }
	 if(tar==""){
		 alert("Lütfen tarih seçiniz.");
		 return false;
	 }
	 
	 if(aciklama==""){
		 alert("Lütfen açıklama seçiniz.");
		 return false;
	 }
	 
	 return true;
	}
	
</script>

<%
String islemId= request.getParameter("islemId");
String hastaId= request.getParameter("hastaId");
String subeId= request.getParameter("subeId");
if(islemId != null && hastaId!=null &&  subeId!=null){
SQLUtils utils= new SQLUtils();
Connection conn =SQLUtils.getMySqlConneciton();

TIslemDTO islem=  utils.getOperasyonuKesinlesmemisHasta(Integer.parseInt(islemId),conn);
System.out.print(subeId);
THastaDTO hasta= utils.getHasta(Integer.parseInt(hastaId),conn,new Integer(subeId).intValue());

request.setAttribute("operasyon",islem);
request.setAttribute("hasta",hasta);
}
 %>
</head>
<body>
<div>

			<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Hasta Arama Kaydı Gir </font>
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
				<td>TEl</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tel}" /> </td>
			</tr>

		

			<tr>
				<td colspan="2" align="left">
				
				<label style="color: red;">
				${requestScope.warn}</label>
				
				</td>

			</tr>

		</table>
		
		<hr>
		<c:if test="${odemeListesi eq null}">
		
		<form action="aramaKaydiEkle.do" method="post" onsubmit="return validation()">
		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">ARAMA KAYDI BİLGİLERİ GİRİŞ</td>
			</tr>
			<tr>
				<td>Operasyon	 Tipi-Tarihi</td>
				<td colspan="2">
				<select size="1" name="islemTipi" class="giderTuru"  disabled="disabled"  >
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
					
					
					
					<input class="inputTextfield" name="islemTarihi" disabled="disabled" id="islemTarihi" value="${operasyon.islemTarihiStr}">
				</td> 

			</tr>

			<tr>
				<td>Doktor</td>
				<td>
				<select size="1" name="doktorId" class="giderTuru" disabled="disabled">
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
				<td>Ücret</td>
				<td><input class="inputTextfield" style="width: 150px; " name="miktar" 
				id="miktar" value="${operasyon.miktar }"  disabled="disabled" /> TL</td>


			</tr>
			<tr>
				<td>Arama Tarihi</td>
				<td>
				
				<input class="inputTextfield" name="aramaTarihiStr" 
				id="islemTarihiStr" value="${operasyon.islemTarihiStr}"/>
				</td>
			
			<tr>
				<td>Saat</td>
				<td><select size="1" name="saat" id="saat" style="width: 56px; font-size:12px ">
					<option value="-1" label="Saat">
					<c:forEach items="${saatler}" var="saat" >
					<option value="${saat}" label="${saat}" ></option>				
					</c:forEach>
				</select>
				
				 : <select name="dakika" id="dakika" size="1" style="width: 52px; font-size:12px ">
				<option value="-1" label="Dk">
				<c:forEach items="${dakikalar}" var="dakika">
				<option label="${dakika }" value="${dakika }">
				
				</c:forEach>
				
				</select>
				
				</td>

			</tr>
			
				
			<tr>
				<td>Arama Açıklama</td>
				<td>
				<textarea style="width: 394px; height: 83px"  name="aciklama" id="aciklama"></textarea>				 
					</td>
 

			</tr>

			<tr>
				<td colspan="3" style="text-align: center;">
				<input type="submit" value="Arama Kaydı Gir" 
				id="btn_gonder" name="bnt_gonder"/>
				
				</td>
				
			</tr>
		</table>
		</form>
		</c:if>
	
</div>
</body>
</html>