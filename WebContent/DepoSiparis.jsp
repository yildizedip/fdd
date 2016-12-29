
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags"  prefix="myTagFiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/epoch_styles.css" 	type="text/css" />
<link rel="stylesheet" href="css/edip.css" 	type="text/css" />
<link rel="stylesheet" href="css/styles.css" 	type="text/css" />
<script type="text/javascript"src="js/epoch_classes.js"></script>
<title></title>

<script type="text/javascript">
window.onload = 
function() 
{
var eklemeTarStr = new Epoch('epoch_popup','popup', document.getElementById("eklemeTarStr"));	
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
<div align="left" >
	<hr>
		<table>
				<tr> 
				<td style="width: 1434px; " align="left"> 
		 			<font style="font-size: 12px; font-family: monospace; color: graytext; ">
				..: Depo Sipariş İşlemleri
				</font>
		 
				 </td> 
				<td style="width: 51px; ">
				
				  <form>
						       <input type="button"  style="background-image:url('Images/printIcon2.jpg'); height: 24px; width: 32px" onclick="window.print()" >
				</form>
				</td> </tr>
		</table>
		<hr>
</div>
<fieldset>
	<legend>Sipariş Girişi</legend>
		<form action="siparisEkle.do" method="post">
			<table>
			
						<tr> 
							<td> <label> Şube  : </label> </td>
							<td>
								<select size="1" name="subeId" id="subeId"	class="subeList" style="width: 125px; ">

										<option label="Şube Seçiniz.." value="0"></option>
										<c:forEach items="${sessionScope.subelerList}"	var="sube">
											<option label="${sube.sAd }"
												value="${sube.sId}"></option>
										</c:forEach>
								</select>
							
							</td>
						 </tr>
						 
				
				<tr>
					<td>Sipariş No :</td>
					<td> <input type="text" value="${siparis.siparisNo}" readonly="readonly" > </td> <td> <input type="submit" value="Sipariş No Üret"> </td>
				</tr>
							
			</table>
		
		</form>


</fieldset>
<br>
<fieldset>
	<legend>Sipariş Listesi</legend>
		<form action="siparisEkle.do" method="post">
			<table>
			<tr>
					<td></td>
					<td> Siparis No </td>
					<td> Şube </td>
				</tr>
			<c:forEach items="${siparisList}" var="siparis" varStatus="count">
				<tr>
					<td>${count.count}</td>
					<td>${siparis.siparisNo}</td>
				</tr>
				</c:forEach>
				
			
			</table>
		
		</form>


</fieldset>
<br>
<fieldset title="Sipariş Girişi" style="width: 250; height: 250;"  > 
<legend>Sipariş Ürün Girişi</legend>
					<form  name="form" action="siparisUrunEkle.do" method="post"  onsubmit="return validateForm()">
					<table>
						<tr>
							<td> <label> Sipariş No :</label> </td>
							<td> <input type="text" name="siparisId" value=""> </td>
						
						</tr>		
						 
						<tr> 
							<td style="width: 122px; "> <label> Depo : </label> </td>
							<td>
								<select size="1" name="depoId" id="depoList"	class="depoList" style="width: 142px; ">

										<option label="Depo Seçiniz.." value="0"></option>
										<c:forEach items="${sessionScope.depoList}"	var="depo">
											<option label="${depo.depoAd}"
												value="${depo.id}"></option>
										</c:forEach>
								</select>
							
							</td>
							
						 </tr>
						 
						<tr>
							<td> <label> Ürün Tip : </label> </td>
							<td>
								<select size="1" name="depoUrunTipId" id="depoUrunTipList"	class="depoUrunTipList" style="width: 162px; ">

										<option label="Ürün Tip Seçiniz.." value="0"></option>
										<c:forEach items="${sessionScope.depoUrunTipList}"	var="depoUrunTip">
											<option label="${depoUrunTip.urunAd }"
												value="${depoUrunTip.id }"></option>
										</c:forEach>
								</select>
							
							</td>
						</tr> 
						<tr>
							<td> <label> Depo Fiyat : </label> </td>
							<td>
								<input type="text" id="depoFiyat" name="depoFiyat" style="width: 84px; ">							
							</td>
						</tr> 
						<tr>
							<td> <label> Şube Fiyat : </label> </td>
							<td>
								<input type="text" id="subeFiyat" name="subeFiyat" style="width: 84px; ">							
							</td>
						</tr> 
						<tr>
							<td> <label> Adet : </label> </td>
							<td>
							<select size="1" name="adet" id="adet"	 style="width: 109px; ">

										<option label="Adet Seçiniz.." value="0"></option>
										<c:forEach items="${sessionScope.adetList}"	var="var">
											<option label="${var}"
												value="${var}"></option>
										</c:forEach>
								</select>
							</td>
						</tr> 
						<tr>
								<td>Tarih</td>
								<td><input class=inputTextfield name="eklemeTarStr" id="eklemeTarStr" value="${eklemeTarStr}"> 
								
								</td>
							</tr>
						
						<tr> 
							<td >  
							<label> Açıklama: </label>
							</td>
							<td >  
							<textarea rows="3" cols="30" name="aciklama" style="height: 97px; width: 266px; "></textarea>
							</td>
							
						 </tr>
						 
						 
						<tr> 
							<td colspan="2" align="center">  
							<input type="submit" value="Ürün Ekle" >
							</td>
							
						 </tr>
						 
					
					</table>
						
					</form>	
					</fieldset>
					
					<fieldset>
					<legend>Ürün Listem</legend>
					
					
					
					
					</fieldset>
	
</body>
</html>