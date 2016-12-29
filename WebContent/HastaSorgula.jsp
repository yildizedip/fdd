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
						
						bitTar=str[0]+"."+str[1]+"."+ sonrakiGun.toString();
						
												
						}
						
					%>	
				
					//document.getElementById("basTar").value="<%=basTar%>";
					//document.getElementById("bitTar").value="<%=bitTar%>";	
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
											
												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
												"sPrevious": "Önceki"
											
											}

										});

					});
					
					
					
</script>
</head>
<body>

<div>

		<hr>
		<table>
			<tr>
				<td><a href="HastaEkle.jsp">Hasta Ekle</a></td>


			</tr>

		</table>
		<hr>
		<form action="hastaSorgula.do" method="post" id="hastaSorgulaForm" onsubmit="">
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
				
			<td style="width: 56px;">Tarih :</td>
				<td style="width: 164px;">
				<input class=inputTextfield
					name="basTar" id="basTar"></td>
				<td>/</td>
				<td>
				
				<input class=inputTextfield name="bitTar" id="bitTar">
				
				</td>
				<td> Telefon </td>
				<td> <input type="text" name="tel" ></td>
			</tr>

			<tr>
				<td colspan="7" style="text-align: center;"><input
					type="submit" value="Sorgula" name="bnt_gonder" /></td>
			</tr>
		</table>

		</form>

		<hr>
		<br>


		<table class="sofT" id="example" >
		<thead>
		<tr>
				<th class="helpHed"></th>
				<th class="helpHed">Protokol No</th>
				<th class="helpHed">TcKimlik</th>
				<th class="helpHed">Ad-Soyad</th>
				<th class="helpHed">Tel</th>
				<th class="helpHed">Eklenme Trh</th>

				<c:if test="${silAktif ne '0' }">
					<th class="helpHed"></th>
					<th class="helpHed"></th>
				</c:if>

			</tr>
		
		
		
		</thead>
			
			<c:forEach items="${hastaListesi}" var="hasta" varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${hasta.protokolNo}</td>
					<td class="helpBod">${hasta.tckimlik}</td>
					<td class="helpBod">${hasta.ad} ${hasta.soyad}</td>
					<td class="helpBod">${hasta.tel}</td>
					<td class="helpBod">${hasta.eklenmeTarihiStr}</td>

					<c:if test="${silAktif ne '0' }">
						<c:if test="${sessionScope.sessionMember[0].kuTur eq '4' }">
							<td class="helpBod"><html:link
								action="/HastaSil?id=${hasta.id}"> Sil </html:link></td>

							<td class="helpBod"><html:link
								action="/HastaGetir?id=${hasta.id}&type=3"> Güncelle </html:link>
							</td>
						</c:if>

					</c:if>
				</tr>

			</c:forEach>

		</table>

</div>
</body>
</html>