<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<title>Hasta Sorgula</title>
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>

<script type="text/javascript">
 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("basTar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bitTar"));
					<%  Date dat = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
						String date = sdf.format(dat);	
						String basTar= (String)request.getAttribute("basTar");
						String bitTar= (String)request.getAttribute("bitTar");
						if(basTar==null) 
						{
						String[] str= date.split("\\.");
						
						basTar=str[0]+"."+str[1]+".01";
												
						}
						if(bitTar==null) 
						{
						
						String[] str= date.split("\\.");
						Integer gun=Integer.parseInt(str[2]);
						Integer sonrakiGun=gun+1;
						if(sonrakiGun==32) sonrakiGun=gun; 
						
						bitTar=str[0]+"."+str[1]+"."+ sonrakiGun.toString();
						
												
						}
						
				
					// document.getElementById("basTar").value="<%=date 
					//document.getElementById("bitTar").value="<%=bitTar
					%>
					
		}
</script>
<script>
	$("document").ready(
					function() {
							$('#example')
								.dataTable(
										{
											"bFilter": false,											
											sPaginationType : "full_numbers",
											"oLanguage" : {
											
												"sLengthMenu" : "Sayfada _MENU_ kay�t g�sterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kay�t aras�ndan  _START_ ile _END_ kay�t g�sterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yaz�n:",
												"sPrevious": "�nceki"
											
											}

										});

					});
					
					
					
function validation(){
	 var protokolNo= document.forms["sorgulaForm"]["protokolNo"].value;
	 var ad = document.forms["sorgulaForm"]["ad"].value;
	var soyad = document.forms["sorgulaForm"]["soyad"].value;
	var basTar = document.forms["sorgulaForm"]["basTar"].value;
	var bitTar = document.forms["sorgulaForm"]["bitTar"].value;
	
	if(ad==""&&soyad==""&&protokolNo=="" && basTar=="" && bitTar==""){
	alert("L�tfen en az bir sorgulama alani seciniz..");
	return false;
	}
	}
					
</script>
</head>
<body>

<div>
		<hr>
			<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
			
			..: Hasta Memnuniyet Anketi Girmek i�in l�tfen hasta sorgulay�n�z.
			
		 </font>
		<hr>
		<form action="hastaSorgulaForHastaAnket.do" method="post" id="hastaSorgulaForm" name="sorgulaForm" onsubmit="return validation()">
		<table  class="sorgulama">
			<tr>
				<td colspan="7" style="text-align: center;">HASTA SORGULA</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" name="protokolNo"
					id="hstProtokol" /></td>
					<td>Ad</td>
				<td><input class="inputTextfield" name="ad" id="hstProtokol" /></td>
				<td>Soyad</td>
				<td><input class="inputTextfield" name="soyad" id="hstProtokol" /></td>

			</tr>
			<tr>
				
			<td style="width: 135px;">Hasta EklenmeTarihi :</td>
				<td style="width: 164px;">
				<input class=inputTextfield
					name="basTar" id="basTar"></td>
				<td>/</td>
				<td colspan="4">
				
				<input class=inputTextfield name="bitTar" id="bitTar">
				
				</td>
			</tr>

			<tr>
				<td colspan="7" style="text-align: center;">
				<font style="color: red; font-size: 14px">   ${noContent}  ${warn}  </font>
				
				</td>
			</tr>
			<tr>
				<td colspan="7" style="text-align: center;"><input
					type="submit" value="Sorgula" name="bnt_gonder" /></td>
			</tr>
		</table>
		</form>

		<table class="sofT" id="example" >
		<thead>
		<tr>
				<th class="helpHed"></th>
				<th class="helpHed">Protokol No</th>
				<th class="helpHed">Ad-Soyad</th>
				<th class="helpHed">Tel</th>
				<th class="helpHed">Operasyonlar</th>
				<th class="helpHed">Anket Say�s�</th>
				<c:if test="${silAktif ne '0' }">
					<th class="helpHed"></th>
				</c:if>

			</tr>
		
		
		
		</thead>
			
			<c:forEach items="${hastaListesi}" var="hasta" varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${hasta.protokolNo}</td>
				
					<td class="helpBod">${hasta.ad} ${hasta.soyad}</td>
					<td class="helpBod">${hasta.tel}</td>
					<td class="helpBod" style="text-align: left;">
						
						<table align="left"  > 
						<tr> <th>Operasyon</th> <th>Biti� Tar.</th>   <th> Miktar</th>   <th>Kalan Miktar</th>  </tr>
						
						<c:forEach items="${hasta.hastaOperasyonList}" var="operasyon">
									
									<tr>
									<td>${operasyon.islemTip.ad }</td> 
									<td> ${operasyon.islemBitisTarihi } </td> 
									<td> ${operasyon.miktar } </td> 
									<td> ${operasyon.kalanMiktar } </td>
									
									</tr>
										
									  </c:forEach>
						
						
						
						</table>
					</td>
					
					
					<td class="helpBod"> ${hasta.hastaAnketSayisi} </td>
					
			
						<c:if test="${sessionScope.sessionMember[0].kuTur eq '4' }">
							<td class="helpBod">
							
							
							
							<html:link
								href="HastaAnketKaydiGir.jsp?hastaId=${hasta.id}&subeId=${subeId}"> Anket Kayd� Gir </html:link></td>

						</c:if>

				</tr>

			</c:forEach>

		</table>

</div>
</body>
</html>