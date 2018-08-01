<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>

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


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
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


<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />

<script type="text/javascript" src="lib/jquery.dataTables.js"></script>
<title></title>
<script>
var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("basTar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bitTar"));
					<%Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);
			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			if (basTar == null) {
				String[] str = date.split("\\.");

				basTar = str[0] + "." + str[1] + ".01";

			}
			if (bitTar == null) {

				String[] str = date.split("\\.");
				Integer gun = Integer.parseInt(str[2]);
				Integer sonrakiGun = gun + 1;

				bitTar = str[0] + "." + str[1] + "." + sonrakiGun.toString();

			}%>	
				
					document.getElementById("basTar").value="<%=basTar%>";
					document.getElementById("bitTar").value="<%=bitTar%>";
	
	}

	$("document")
			.ready(
					function() {
						$('#example')
								.dataTable(
										{
											"bFilter" : false,
											sPaginationType : "full_numbers",
											"oLanguage" : {

												"sLengthMenu" : "Sayfada _MENU_ kayýt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayýt arasýndan  _START_ ile _END_ kayýt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazýn:",
												"sPrevious" : "Önceki"

											}

										});

					});
</script>

</head>
<body style="color:black ; background-color: white;">

	<div class="row">

		<div class="col-lg-6"></div>
		<div class="col-lg-6">

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 22px; width: 22px"
				onclick="window.print()"></button>

		</div>

	</div>

	<br>


 
	<form action="hastaAramaKaydiListGetir.do" method="post">
	
			<div class="col-lg-8 ">

				<div class="panel panel-default">  
				<div class="panel-heading"> 
				
						Sorgula
				</div>
				
				<div class="panel-body">  
			
						<div class="form-group">
							
							<div class="row"> 
								
								<div class="col-lg-6">
										<input class="form-control" name="protokolNo"	id="hstProtokol"  placeholder="Protokol No" /> 
										<input type="hidden" name="tip" id="tip"	value="${param.tip}" /> 
								</div>
								
							</div>
							
						</div>
						
						<div class="form-group">
							
							<div class="row"> 
								
								<div class="col-lg-6">	<input class="form-control" name="ad" id="hstProtokol" placeholder="Ad" /> </div>
								<div class="col-lg-6">  <input class="form-control" name="soyad" id="hstProtokol" placeholder="Soyad" /> </div>
								
							</div>
							
						</div>
						
						<div class="form-group">
							
							<div class="row"> 
								
								<div class="col-lg-6">
										<select size="1" name="islemTipi" class="form-control" >
												<option label="Operasyon Seçiniz.." value="-1" />
						
												<c:forEach items="${islemTurList}" var="islem">
													<option label="${islem.ad}" value="${islem.id }" />
												</c:forEach>
										</select>
								</div>
								
							</div>
							
						</div>
						
						
						<div class="form-group">
							
							<div class="row"> 
								
								<div class="col-lg-6">	<input class="form-control" name="basTar" id="basTar"  placeholder="Baþlangýç Tarihi"/> </div>
								<div class="col-lg-6">  <input class="form-control" name="bitTar" id="bitTar" placeholder="Bitiþ Tarihi" /> </div>
								
							</div>
							
						</div>
						<button type="submit" class="btn btn-info btn-sm">Sorgula</button>
					</div>
				</div>
			</div>
	</form>
	

	<div class="clearfix"></div>
	
	
	<a href="OperasyonuKesinlesmemisHastaListesi.jsp?tip=3" class="btn btn-info btn-sm">Arama Kaydý Ekle</a>
	<br>
	<br>
	<table class="table table-bordered" id="example">
		<thead>
			<tr>
				<th class="bg-success" colspan="13"> <h4 align="center">Tedavisi Kesinleþmemiþ Hastalarýn Arama Kayýt Listesi </h4></th>
			</tr>
			<tr>
				<th class=""></th>
				<th class="">Protokol No</th>
				<th class="">Ad-Soyad</th>
				<th class="">Tel</th>
				<th class="">Arama Tarihi</th>
				<th class="">Arama Saat</th>
				<th class="">Açýklama</th>
				<th class="">Operasyon</th>
				<th class="">Op.Tarih</th>
				<th class="">Adet</th>
				<th class="">Ücret</th>


				<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'
				   }">
					<th class=""></th>

				</c:if>
			</tr>

		</thead>
		<tbody>
			<c:forEach items="${aramaKayitListesi}" var="arama" varStatus="count">
				<tr>
					<td class="" >${count.count}</td>
					<td class="" >${arama.islem.hasta.protokolNo}</td>
					<td class="" >${arama.islem.hasta.ad}	${arama.islem.hasta.soyad}</td>
					<td class="" >${arama.islem.hasta.tel}</td>
					<td class=""  width="77px">${arama.aramaTarih}</td>
					<td class="" >${arama.aramaSaat}</td>
					<td class="" >${arama.aciklama}</td>
					<td class="" >${arama.islem.islemTip.ad}</td>
					<td class=""  width="77px">${arama.islem.islemTarihi}</td>
					<td class="" >${arama.islem.disAdet}</td>
					<td class="" >${arama.islem.miktar}</td>

					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'  }">

						<td class=""><html:link
								action="/AramaKaydiSil?id=${arama.id}"> Sil </html:link></td>
						

					</c:if>
				</tr>

			</c:forEach>

		</tbody>

		<tfoot>

			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>

				<th ></th>
				<th style="font-size: 10px; color: Blue;">TOPLAM</th>

				<th style="font-size: 10px; color: Blue;">${toplamUcret}</th>

				<th></th>
				<th></th>

			</tr>

		</tfoot>

	</table>


</body>
</html>