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
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>
<title>Hasta Sorgula</title>
<script type="text/javascript">
	$("document")
			.ready(
					function() {
						$('#example')
								.dataTable(
										{

											sPaginationType : "full_numbers",
											"iDisplayLength" : 5,
											"aLengthMenu" : [
													[ 5, 10, 25, 50, 100, -1 ],
													[ 5, 10, 25, 50, 100,
															"Hepsi" ] ],
											"oLanguage" : {

												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
												"sPrevious" : "Önceki",
												"sEmptyTable" : "Veri Bulunamadı"

											}

										});

					});
</script>

</head>
<body id="dt_example">
<div id="container">

<div>
<h1>..: Operasyonu Kesinleşmemiş Hasta Listesi</h1>
<input type="button"
	style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
	onclick="window.print()"></div>

<table class="display" id="example" cellpadding="0" cellspacing="0"
	border="0">
	<thead>
		<tr>
			<th ></th>
			<th>Protokol No</th>
			<th>Ad-Soyad</th>
			<th>Tel</th>
			<th>Operasyon</th>
			<th>Ücret</th>
			<th>Tarih</th>
			<c:if
				test="${sessionScope.sessionMember[0].kuTur ne '3'   }">
				<th></th>
			</c:if>
					</tr>
	</thead>
	<tbody>
		<c:forEach items="${operasyonuKesinlesmemisHastaListesi}" var="islem"
			varStatus="count">
			<tr class="gradeA">
				<td  >${count.count}</td>
				<td  >${islem.hasta.protokolNo}</td>
				<td  >${islem.hasta.ad} ${islem.hasta.soyad} ${islem.hasta.tckimlik}</td>
				<td  >${islem.hasta.tel}</td>
				<td  >${islem.islemTip.ad}</td>
				<td  >${islem.miktar}</td>
				<td  >${islem.islemTarihiStr}</td>
				<c:if
					test="${sessionScope.sessionMember[0].kuTur ne '3'  }">

					<td ><html:link
						href="OperasyonuKesinlestir.jsp?islemId=${islem.id}&hastaId=${islem.hastaId}&subeId=${subeId}"> Kesinleştir </html:link>
					</td>

				</c:if>
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
					<th></th>
				
				</tr>
		
		</tfoot>
</table>
</div>
</body>
</html>