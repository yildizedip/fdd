
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
	 alert("L�tfen Miktar Alan�n� Kontrol Ediniz..");
	 return false;
	 }
	 
	
	if (!regexNum.test(miktar) && regexLetter.test(miktar)) {
			
			alert("Yaln�zca rakam girilebilir.");
			return false;
		}


	
	}
								
</script>

</head>
<body style="color:black;">



<div class="col-lg-6">  

	<div class=" bg-success"> <strong> ${requestScope.warn} </strong>  </div>

	<form name="form" action="addGelir2.do" method="post"	onsubmit="return validateForm()">
		<table class="table table-bordered">
		
		<tr>
				<td colspan="4"
					style="text-align: center; font: bold; font-size: 20px;" class="bg-blue" >Gelir Ekle
				</td>
			</tr>
			
			<tr>
				
				<td>Tarih</td>
				<td>
				
				<c:choose>
					
					<c:when test="${(odeme_tarih_degistir eq 'off') and (sessionScope.sessionMember[0].kuTur eq '4') }">
						<input name="tarihStr" id="tarihStr" value="${tarihStr}" class="form-control" disabled="disabled"> 
					 </c:when>
					 
					 <c:otherwise>
					 	<input name="tarihStr" id="tarihStr" value="${tarihStr}" class="form-control" > 
					 
					 </c:otherwise>
				
				</c:choose>
					
					
					<input type="hidden" name="subeId"	value="${subeId}">
					
					
					
					
				</td>
			</tr>
			<tr>
				<td>Miktar</td>
				<td><input type="text" id="miktar" name="miktar" class="form-control" placeholder="TL" /></td>
			</tr>
			
			<tr>
				<td> �deme �ekli </td>
				<td>
				
				<select size="1" name="odemeSekli" id="odemeSekli">

							<option label="Pe�in" value="1">Pe�in</option>
							<option label="Kredi Kart�" value="2">Kredi Kart�</option>
							<option label="Havale / EFT" value="3">Havale / EFT</option>
						
				</select>
				
				</td>
			</tr>
			
			<tr>
				<td>A��klama</td>
				<td>
				<textarea class="form-control" rows="4" cols="50" name="aciklama"></textarea>
				
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<input class="btn-blue"	type="submit" value="G�nder" name="bnt_gonder"></td>
			</tr>
			
		</table>
	
	</form>
	</div>

	
	
</body>
</html>