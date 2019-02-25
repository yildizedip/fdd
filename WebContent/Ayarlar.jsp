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
<link href="sitil/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link href="sitil/light-bootstrap-dashboard.css" rel="stylesheet">

<!-- jQuery -->
<script src="scriptt/jquery.js"></script>
<script src="scriptt/bootstrap.min.js"></script>
</head>
<body>


	<form action="getAyarlar.do" method="post">

		<div class="col-lg-3 col-md-6">

			<div class="form-group">
				<div class="input-icon">

					<select size="1" name="subeId" id="subeId" class="form-control">
						<option label="Þube Seçiniz.." value="-1">Þube Seçiniz..</option>

						<c:forEach items="${subelerList}" var="sube">
							<option label="${sube.sAd}" value="${sube.sId}">
								${sube.sAd}</option>
						</c:forEach>
					</select>

				</div>
			</div>
		</div>

		<div class="col-lg-2">

			<input type="submit" value="getir">



		</div>

	</form>



	<div class="col-lg-6 ">

		<table class="table table-bordered">

			<thead>

				<tr>

					<td>Sube</td>
					<td>Ayar Adý</td>
					<td>Durum</td>   
					<td></td>   

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${subeAyarList}" var="islem">

					<tr>
						<td>${islem.subeAd}</td>
						<td>${islem.name}</td>
						<td>${islem.value}</td>
						<td>

							<button type="button" class="btn btn-link" data-toggle="modal"
								data-target="#AyarGunceleModal" 
								data-id="${islem.id}"
								data-subeId="${islem.subeId}"
								data-name="${islem.name}"
								data-value="${islem.value}"
								>Güncelle</button>
						</td>
					</tr>
				</c:forEach>


			</tbody>

		</table>
	</div>


	<div id="AyarGunceleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">AYAR GÜNCELLE</h4>
				</div>
				<form action="AyarTarihDegistirilsinGuncelle.do" method="post">
					<div class="modal-body">

						<input type="hidden" name="id" id="id"> 
						<input type="hidden" name="subeId" id="subeId"> 
						<span id="name"> </span>
						<input type="text" name="value" id="value">
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
		

		$('#AyarGunceleModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget)
			var id = button.data('id')
			var subeId = button.data('subeId')
			var name = button.data('name')
			var value = button.data('value')
			
			var modal = $(this)
			modal.find('#id').val(id)
			modal.find('#subeId').val(subeId)
			modal.find('#name').html(name)
			modal.find('#value').val(value)

		});
	</script>



</body>
</html>