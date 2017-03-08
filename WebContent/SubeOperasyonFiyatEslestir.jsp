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


		<form action="getOperasyonTur.do" method="post">
		
		
			<div class="col-lg-3 col-md-6">

				<div class="form-group">
					<div class="input-icon">

						<select size="1" name="subeId" id="subeId"
							class="form-control">
							<option label="Þube Seçiniz.." value="-1">Þube
								Seçiniz..</option>

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
						<td>Tedavi</td>
						<td>Fiyat</td>
						<td>Güncelle</td>

					</tr>
				</thead>
				<tbody>
					<c:forEach items="${islemTurListesi}" var="islem">

						<tr>
							<td>${islem.ad }</td>
							<td>${islem.subeTip.subeAd }</td>
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
	
		$('#islemTipi').on('change', function() {

			var value = this.value;

			'<c:forEach items="${islemTurListesi}" var="islem">'

			if (value == '${islem.id}') {

				var fiyat = '${islem.subeTip.fiyat}';

				$('#operasyonUcret').val(fiyat);

			}

			'</c:forEach>'

		});

		
		/* $('#subeId').on('change', function() {

			var subeId = this.value;

			alert(subeId)
			$('#subeIdGuncelle').val(subeId);

			alert()


		});
 */
		
		var islemId=-1;

		$('#guncelleButton').click(function() {

			
			
			'<c:forEach items="${islemTurListesi}" var="islem">'
			
			if (islemId == '${islem.id}') {

				var fiyat=	$('#fiyat').val();

				

			}

			'</c:forEach>'
			
			
		});

	

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