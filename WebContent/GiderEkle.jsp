
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>


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


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
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
	 alert("Lütfen Miktar Alanýný Kontrol Ediniz..");
	 return false;
	 }
	 
	
	if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			
			alert("Yalnýzca rakam girilebilir.");
			return false;
		}

	
	if(giderTuru==0 || giderTuru==''){
	
		alert("Lütfen Gider Turu Seçiniz..");
			return false;
	}
	
	}
								
</script>

</head>
<body style="color:black;">


<div class="bg-success"> ${requestScope.warn} </div>
<div class="col-lg-6">  

	<form name="form" action="addGider.do" method="post"	onsubmit="return validateForm()">
		<table class="table table-bordered">
		
		<tr>
				<td colspan="4"
					style="text-align: center; font: bold; font-size: 20px;" class="bg-blue" >Gider Ekle
				</td>
			</tr>
			
			<tr>
				
				<td>Tarih</td>
				<td>
					<input name="tarihStr" id="tarihStr" value="${tarihStr}" class="form-control"  > 
					<input type="hidden" name="subeId"	value="${subeId}">
					
				</td>
			</tr>
			<tr>
				<td>Miktar</td>
				<td><input type="text" id="miktar" name="miktar" class="form-control" placeholder="TL" /></td>
			</tr>
			<tr>
				<td> Gider Türü</td>
				<td><select size="1" name="giderTuru" id="giderTuru">

						<option label="Gider Türü Seçiniz.." value="0">Gider Türü Seçiniz..</option>
						<c:forEach items="${sessionScope.giderTurKodlari}" var="turKodDTO">
							<option label="${turKodDTO.turAd }" value="${turKodDTO.turKod }">${turKodDTO.turAd }</option>
						</c:forEach>
				</select></td>
			</tr>
			
			<tr>
				<td> Ödeme Þekli </td>
				<td>
				
				<select size="1" name="odemeSekli" id="odemeSekli">

							<option label="Peþin" value="1">Peþin</option>
							<option label="Kredi Kartý" value="2">Kredi Kartý</option>
						
				</select>
				
				</td>
			</tr>
			
			<tr>
				<td>Açýklama</td>
				<td>
				<textarea class="form-control" rows="4" cols="50" name="aciklama"></textarea>
				
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<input class="btn-blue"	type="submit" value="Gönder" name="bnt_gonder"></td>
			</tr>
			
		</table>
	
	</form>
	</div>

	
	
</body>
</html>