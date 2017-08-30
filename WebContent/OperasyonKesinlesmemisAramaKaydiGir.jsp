<%@page import="tr.com.fdd.dto.THastaDTO"%>
<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@page import="tr.com.fdd.mysql.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
	
	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script src="script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" src="js/jquery.ui.datepicker-tr.js"></script>
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
		 alert("Lütfen açýklama seçiniz.");
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
	Connection conn =DbConnection.getMySqlConneciton();;

	TIslemDTO islem=  utils.getOperasyonuKesinlesmemisHasta(Integer.parseInt(islemId),conn);
	System.out.print(subeId);
	THastaDTO hasta= utils.getHasta(Integer.parseInt(hastaId),conn,new Integer(subeId).intValue());

	request.setAttribute("operasyon",islem);
	request.setAttribute("hasta",hasta);
}
 %>
</head>
<body style="color: black; background-color: white; font-size: 11px;">
<div>

<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		<div class="page-header ">
			<div class="page-title" style="font-size: 15px;">

			Hasta Arama Kaydý Gir - {  ${hasta.ad} - ${hasta.soyad} (${hasta.tel}) }


			</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 22px; width: 22px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>


		<div class="col-lg-6">
		
		<c:if test="${odemeListesi eq null}">
		
		<form action="aramaKaydiEkle.do" method="post" onsubmit="return validation()">
		<table  class="table table-bordered">
			<tr>
				<td colspan="3" class="bg-info" style="text-align: center;">ARAMA KAYDI BÝLGÝLERÝ GÝRÝÞ</td>
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
				<td><select size="1" name="saat" id="saat" style="width: 90px; font-size:12px ">
					<option value="-1" label="Saat">
					<c:forEach items="${saatler}" var="saat" >
					<option value="${saat}" label="${saat}" ></option>				
					</c:forEach>
				</select>
				
				 : <select name="dakika" id="dakika" size="1" style="width: 90px; font-size:12px ">
				<option value="-1" label="Dk">
				<c:forEach items="${dakikalar}" var="dakika">
				<option label="${dakika }" value="${dakika }">
				
				</c:forEach>
				
				</select>
				
				</td>

			</tr>
			
				
			<tr>
				<td>Arama Açýklama</td>
				<td>
				<textarea style="width: 394px; height: 83px"  name="aciklama" id="aciklama"></textarea>				 
					</td>
 

			</tr>

			<tr>
				<td colspan="3" style="text-align: center;">
				<input type="submit" value="Arama Kaydý Gir" 
				id="btn_gonder" name="bnt_gonder"/>
				
				</td>
				
			</tr>
		</table>
		</form>
		</c:if>
		
		</div>
	
</div>
</body>
</html>