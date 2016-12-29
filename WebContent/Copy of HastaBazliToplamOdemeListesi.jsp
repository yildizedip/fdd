<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript" src="lib/jquery.dataTables.js"></script>
<title>Hasta Sorgula</title>

<script>
	$("document").ready(
					function() {
						$('#example')
								.dataTable(
										{
											
											sPaginationType : "full_numbers",
											 "iDisplayLength": 5,
		 								     "aLengthMenu": [[5,10,25, 50, 100, -1], [5,10,25, 50, 100, "Hepsi"]],
											"oLanguage" : {
											
												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
												"sPrevious": "Önceki",
												"sEmptyTable": "Veri Bulunamadı"
											
											}

										});

					});
</script>

</head>
<body id="dt_example" >
<div id="container" >


	<table>
		<tr> 
		<td style="width: 1434px; " align="left"> 
		<h1>
		<c:choose>
		<c:when test="${raporIslemTipi eq '10' }"> Hastaların Toplam Ödeme Durumu</c:when>
		<c:when test="${raporIslemTipi eq '11' }"> Ödemesi Bitmiş Hasta Listesi </c:when>
		<c:when test="${raporIslemTipi eq '12' }"> Operasyonu Bitmiş Hasta Listesi </c:when>
		<c:when test="${raporIslemTipi eq '13' }"> Operasyonu Bitmiş Ödemesi Devam Eden Hasta Listesi </c:when>
		<c:when test="${raporIslemTipi eq '14' }"> Operasyonu ve Ödemesi Bitmiş Hasta Listesi </c:when>
		<c:when test="${raporIslemTipi eq '15' }"> Operasyonu Devam Eden Ödemesi Bitmiş Hasta Listesi </c:when>
		
		</c:choose>
		
		
		 </h1>
		 </td> 
		<td style="width: 51px; ">
		
		
				       <input type="button"  style="background-image:url('Images/printIcon2.jpg'); height: 24px; width: 32px" onclick="window.print()" >
		
		</td> </tr>
		</table>
		
	
		 
		 <div id="demo"> 
			
 <table class="display" id="example" cellpadding="0" cellspacing="0" border="0" >
	<thead> 
		<tr>
			<th></th>
			<th>Hasta</th>
			<th>İşlem</th>
			<th>Doktor</th>
			<th width="77px" >İşlem T.</th>			
			<th width="70px">Ücret</th>
			<th width="70px">Öd. Mik.</th>
			<th width="77px" >Öd. Trh</th>
			<th width="70px">Kal. Mik.</th>		
	
		</tr>
		</thead>
	   	<tbody>
		<c:forEach items="${hastaBazliToplamOdemeListesi}" var="odeme" varStatus="count">
		
		<tr class="gradeA">
		    <td style=" font-size: 9px "> ${count.count}</td>
			<td style=" font-size: 9px ">${odeme.hasta.ad} ${odeme.hasta.soyad} ${odeme.hasta.tel}</td>
			<td style=" font-size: 9px ">${odeme.islemTip.ad}</td>
			<td style=" font-size: 9px ">${odeme.doktor.dAd} ${odeme.doktor.dSoyad} </td>
			<td style=" font-size: 9px " >${odeme.islem.islemTarihiStr} ${odeme.islem.islemBitisTarihiStr} </td>
		
			<td style=" font-size: 9px ">${odeme.ucret} </td>
					
			<td style=" font-size: 9px ">${odeme.miktar} </td>
			<td style=" font-size: 9px ">${odeme.eklenmeTarihiStr} </td>
			
			<td style=" font-size: 9px ">${odeme.kalanMiktar} </td>
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
					<th> </th>
					<th> </th>
					<th> </th>
				
				</tr>
		
		</tfoot>
		
	</table>
	</div>


</div>
</body>
</html>