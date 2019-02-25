<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>..Poliklinik..</title>

<!-- Bootstrap Core CSS -->
<link type="text/css" rel="stylesheet" href="sitil/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />


<!-- jQuery -->
 <script src="js/jquery-3.1.1.min.js"></script>
   <script src="js/jquery-ui.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.dataTables.min.js"></script>


<script type="text/javascript">

$(document).ready(function() {
	
	
	$('#example').DataTable(
			{
				select : {
					style : 'single',

				},
				"searching":     true,
				"paging":true,
				 "iDisplayLength": 25,
				 "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]],
				order : [ [ 0, "asc" ] ],
				language : {

					sSearch : "Ara:",
					sLengthMenu : "_MENU_",
					sInfo : "_TOTAL_ kayýt",
					infoEmpty: " ",
					zeroRecords: " ",

				}

			});
	
	
    $('#example').DataTable();
} );

</script>


</head>
<body>

		<div class="col-lg-6  col-md-6">
		
		<p> Tedavi Türlerine ait Fiyat Listesi</p>

			<table id="example" class="table table-striped table-bordered" >
				<thead>
					<tr>

						<td>Tedavi</td>
						<td>Fiyat</td>
						<td>Güncelle</td>

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${islemTurListesi}" var="islem">
						<tr>
							<td>${islem.ad }</td>
							<td>${islem.subeTip.fiyat}</td>
							<td>
							
							<button type="button" class="btn btn-link" data-toggle="modal" data-target="#fiyatGunceleModal"	data-id="${islem.subeTip.id}"
																						data-fiyat="${islem.subeTip.fiyat}">Güncelle</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</div>

	
	<div id="fiyatGunceleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">FÝYAT GÜNCELLE</h4>
				</div>
				<form action="SubeTedaviFiyatGuncelle.do" method="post">
					<div class="modal-body">
						
						<input type="hidden" name="id" id="fiyatId">
						<input type="hidden" name="subeId" id="subeIdGuncelle" value="${selectedSubeId}">
						<input type="text" name="fiyat" id="fiyat">

					</div>

					<div class="modal-footer">
						<input class="btn btn-default" type="submit" id="guncelleButton"
							value="Güncelle" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">


	

		$('#fiyatGunceleModal').on('show.bs.modal',
				function(event) {
					var button = $(event.relatedTarget)
					var id = button.data('id')
					var fiyat = button.data('fiyat')

					
					islemId=id;
					var modal = $(this)
					modal.find('#fiyatId').val(id)
					modal.find('#fiyat').val(fiyat)

		});
		
	</script>



</body>
</html>