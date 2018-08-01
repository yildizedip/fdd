<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Bootstrap Core CSS -->
<link href="sitil/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link href="sitil/light-bootstrap-dashboard.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css" />


<link rel="stylesheet" type="text/css" href="css/zebra-datepicker.css" />

</head>
<body onload="myFunction()">

	<div class="container-fluid">
	<div class="row">
	<div class="col-lg-6 col-md-6"> 
	
			<div class="panel panel-default">

				<div class="panel-heading" align="center">
					 Randevuları Görüntüle 
				</div>
				<div class="panel-body">
					<form class="form-inline" action="getRandevuListesi.do"
						method="post">

						<div class="form-group">
							<input type="text" class="form-control tarih"
								placeholder="Başlangıç Tarihi" name="baslangicTarihi"
								id="baslangicTarihi">
						</div>
						<div class="form-group">
							<input type="text" class="form-control tarih" placeholder="Bitiş Tarihi" name="bitisTarihi" id="bitisTarihi">
						</div>
						
						<button type="submit" class="btn btn-default btn-sm">Randevuları
							Getir</button>
					</form>

					<hr>
					<table id="example" class="table table-bordered">
						<thead>

							<tr>
								<th>Hasta</th>
								<th>Randevu</th>
								<th>Açıklama</th>
								<th>Doktor Ad</th>


							</tr>

						</thead>
						<tbody>
							<c:forEach items="${randevuListesi}" var="randevu"
								varStatus="count">

								<tr>
									<td>${randevu.hasta.ad }${randevu.hasta.soyad }
										${randevu.hasta.protokolNo }</td>
									<td>${randevu.randevuTarihiBaslangic}-
										${randevu.randevuBitSaat}</td>
									<td>${randevu.aciklama }</td>
									<td>${randevu.doktor.dAd }${randevu.doktor.dSoyad }</td>

								</tr>

							</c:forEach>

						</tbody>



					</table>


				</div>


			</div>

		</div>
		</div>
		</div>


<form id="send" action="hastaGunlukRandevuSorgula.do"  method="post">


</form>



		<!-- jQuery -->
		<script src="scriptt/jquery.js"></script>
		<script src="scriptt/bootstrap.min.js"></script>
		<script type="text/javascript"
			src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/raphael.min.js"></script>
		<script src="js/morris.min.js"></script>


		<script src="js/zebra_datepicker.js" charset="UTF-8"></script>


		<script type="text/javascript">
		
		$(document).ready(function(){
			
			$("#send").submit();
		
			$('#example')
					.DataTable(
							{

								"iDisplayLength" : 10,
								"lengthMenu" : [ [ 10, 25, 50, -1 ],
										[ 10, 25, 50, "All" ] ],
								"order" : [ [ 1, "desc" ] ],
								"language" : {

									"sSearch" : " ",
									"sLengthMenu" : "_MENU_",
									"sInfo" : "_TOTAL_ kayıttan _START_ - _END_ arasındaki kayıtlar gösteriliyor",
									"infoEmpty" : "",
									"zeroRecords" : "Veri Bulunamadı",
									"paginate": {
								        "first":      "Başa Git",
								        "last":       "Sona Git",
								        "next":       "Sonraki",
								        "previous":   "Önceki"
								    },

								}

							});

			var date = $.datepicker.formatDate('yy.mm.dd', new Date());

			$('input.tarih').Zebra_DatePicker();

			$("#baslangicTarihi").val(date);
			$("#bitisTarihi").val(date);

			var table = $('#example').DataTable();

			var val = [];

			<c:forEach items="${getTopOperations}" var="op">

			var event = {
				oper : '${op[0]}',
				value : '${op[1]}'
			}

			val.push(event);

			</c:forEach>

			new Morris.Bar({

				// ID of the element in which to draw the chart.
				element : 'myfirstchart',
				// Chart data records -- each entry in this array corresponds to a point on
				// the chart.
				data : val,
				// The name of the data record attribute that contains x-values.
				xkey : 'oper',
				// A list of names of data record attributes that contain y-values.
				ykeys : [ 'value' ],
				// Labels for the ykeys -- will be displayed when you hover over the
				// chart.
				labels : [ 'value' ]
			});
			
			
			     
			});
		</script>

</body>
</html>