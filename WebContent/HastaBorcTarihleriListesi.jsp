<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</script>
<script>
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

<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		<div class="page-header ">
			<div class="page-title" style="font-size: 20px;">HASTA BORÇ LÝSTESÝ</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>
	
	<div class="col-lg-6">  

	<form action="borcOdemeListesi.do" method="post">
		<table class="table table-bordered">
			<tr>
				<td colspan="7" style="text-align: center;" class="bg-blue">SORGULA</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" name="protokolNo"
					id="hstProtokol" /> <input type="hidden" name="tip" id="tip"
					value="${param.tip}" /></td>
				<td>Ad</td>
				<td><input class="inputTextfield" name="ad" id="hstProtokol" /></td>
				<td>Soyad</td>
				<td><input class="inputTextfield" name="soyad" id="hstProtokol" /></td>
			</tr>
		
			<tr>
				<td style="width: 56px;"> Tarih :</td>
				<td style="width: 164px;"><input class="inputTextfield"
					name="borcOdemeTarihiBaslamaStr" id="basTar" /></td>
				<td>/</td>
				<td colspan="4"><input class="inputTextfield" name="borcOdemeTarihiBitisStr"
					id="bitTar" /></td>
			</tr>

			<tr>
				<td colspan="7" style="text-align: center;">
				<label id="lbl_error" style="color: red;">${requestScope.warn}
				${requestScope.noContent} </label>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="text-align: center;"><input
					type="submit" value="Sorgula" name="bnt_gonder" /></td>
			</tr>
		</table>
	</form>
	
	</div>
	<div class="clearfix"></div>

	<hr>
	
	<a href="HastaBazliToplamOdemeListesi.jsp?tip=13" class="btn btn-info">Borç Tarihi Ekle</a>
	
	<br>
	<table class="table table-bordered" id="example">
		<thead>
			<tr >
				<th class="bg-success" colspan="12" > <h4 align="center"> Hasta Borç Tarihleri Listesi </h4> </th>
			</tr>
			<tr>
				<th class="bg-success"></th>
				<th class="bg-success">Protokol No</th>
				<th class="bg-success">Ad-Soyad</th>
				<th class="bg-success">Tel</th>
				<th class="bg-success">Operasyon</th>
				<th class="bg-success">Toplam Ücret</th>
				<th class="bg-success">Toplam Ödenen</th>
				<th class="bg-success">Kalan Miktar</th>
				<th class="bg-success">Borcun Ödeme Tarihi</th>
				<th class="bg-success">Ödenecek Miktar</th>
				<th class="bg-success">Açýklama</th>
				


				<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'
				   }">
					<th class="bg-success"></th>

				</c:if>
			</tr>

		</thead>
		<tbody>
			<c:forEach items="${borcListesi}" var="borc" varStatus="count">
				<tr>
					<td class="" >${count.count}</td>
					<td class="" >${borc.islemDTO.hasta.protokolNo}</td>
					<td class="" >${borc.islemDTO.hasta.ad}	${borc.islemDTO.hasta.soyad}</td>
					<td class="" >${borc.islemDTO.hasta.tel}</td>
					<td class="" >${borc.islemDTO.islemTip.ad}</td>
					<td class="" >${borc.islemDTO.miktar}</td>
					<td class="" >${borc.islemDTO.toplamOdenenMiktar}</td>
					<td class="" >${borc.islemDTO.kalanMiktar}</td>
					<td class=""  width="140px">${borc.borcOdemeTarihi}</td>
					<td class="" >${borc.miktar}</td>
					<td class=""  width="277px">${borc.aciklama}</td>

					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'  }">

					<td class="">
					<html:link	action="/borcTarihBilgisiSil?id=${borc.id}"> Sil </html:link></td>
						

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
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>

			</tr>

		</tfoot>

	</table>


</body>
</html>