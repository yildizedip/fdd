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
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>
<title>Operasyonu Kesinleştirme</title>
<script>
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
				
					document.getElementById("basTar").value="<%=basTar%>";
					document.getElementById("bitTar").value="<%=bitTar%>";	
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

		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
			
			..: Arama Kaydı Girişsdfsd
			
		 </font>
		<hr>
		
		<form action="getHastaOperasyonListForAramaKaydi.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="7" style="text-align: center;">HASTA SORGULA</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" name="protokolNo" id="hstProtokol"/> 
				 <input type="hidden" name="tip" id="tip" value="${param.tip}"/></td>
					<td>Ad</td>
				<td><input class="inputTextfield" name="ad" id="hstProtokol"/></td>
				<td>Soyad</td>
				<td><input class="inputTextfield" name="soyad" id="hstProtokol"/></td>
			</tr>
					<tr> 
			<td>İşlem</td>
			<td colspan="5">
			
			<select size="1" name="islemTipi" class="giderTuru">
						<option label="Operasyon Seçiniz.." value="-1"/>

						<c:forEach items="${islemTurList}" var="islem">
							<option label="${islem.ad}" value="${islem.id }"/>
						</c:forEach>
					</select>
			</td>
			</tr>			
			<tr>
				<td style="width: 56px;">Tarih :</td>
				<td style="width: 164px;">
				<input class="inputTextfield" name="basTar" id="basTar"/></td>
				<td>/</td>
				<td colspan="4">
				<input class="inputTextfield" name="bitTar" id="bitTar"/>
				</td>
			</tr>
			
			<tr>
				<td colspan="7" style="text-align: center;">
		<label style="color: red;">
				${requestScope.warn}</label>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="text-align: center;">
				<input type="submit" value="Sorgula" name="bnt_gonder"/>
				</td>
			</tr>
		</table>
		</form>
	
		<hr>
		<br>
		<table class="sofT" id="example">
		<thead>
		<tr> 
		<th class="helpHed" colspan="10"> Operasyonu Kesinleşmemiş Hasta Listesi</th>
		</tr> 
			<tr>
				<th class="helpHed"></th>
				<th class="helpHed">Protokol No</th>
				<th class="helpHed">TcKimlik</th>
				<th class="helpHed">Ad-Soyad</th>
				<th class="helpHed">Tel</th>
				<th class="helpHed">Adet</th>
				<th class="helpHed">Operasyon</th>
				<th class="helpHed">Ücret</th>
				<th class="helpHed">Tarih</th>
				<th class="helpHed" > </th>	
			</tr>
			
			</thead>
			<tbody>  
			<c:forEach items="${operasyonuKesinlesmemisHastaListesi}" var="islem"
				varStatus="count">
				<tr>
					<td class="helpBod" style="font-size: 9px ">${count.count}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.hasta.protokolNo}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.hasta.tckimlik}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.hasta.ad} ${islem.hasta.soyad}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.hasta.tel}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.disAdet}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.islemTip.ad}</td>
					<td class="helpBod" style="font-size: 9px ">${islem.miktar}</td>
					<td class="helpBod" style="font-size: 9px " width="80px">${islem.islemTarihi}</td>
					
					<td class="helpBod">					
						<html:link href="OperasyonKesinlesmemisAramaKaydiGir.jsp?islemId=${islem.id}&hastaId=${islem.hastaId}&subeId=${subeId}"> Arama Kaydı Gir </html:link>  
					</td>
				</tr>

			</c:forEach>
			
			</tbody>
			
			<tfoot>
		
			<tr>
					<th> </th>
					<th> </th>
					<th> </th>
					<th> </th>
					<th> </th>
					<th> </th>
					<th style="font-size: 10px; color: Blue;" >TOPLAM </th>
					
					<th style="font-size: 10px; color: Blue;">${toplamUcret} </th>
					
					<th style="font-size:10px;  color: Blue"></th>
				
				<th> </th>
				</tr>
		
		</tfoot>

		</table>


</body>
</html>