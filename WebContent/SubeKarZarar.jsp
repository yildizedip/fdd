<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>

	
<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>..Poliklinik..</title>

<!-- Bootstrap Core CSS -->
<link href="sitil/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link href="sitil/light-bootstrap-dashboard.css" rel="stylesheet">

<!-- jQuery -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script src="script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<script type="text/javascript"> 
		 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("bas_tar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bit_tar"));
					<%Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);
			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			if (basTar == null)
				basTar = date;
			if (bitTar == null)
				bitTar = date;%>	
				
					document.getElementById("bas_tar").value="<%=basTar%>";
					document.getElementById("bit_tar").value="<%=bitTar%>";
	}
</script>
</head>
<body style="background-color: white;" >


	<div class="col-lg-4 ">

	<div class="panel panel-default">  
	<div class="panel-heading"> Sorgula </div>
	
	<div class="panel-body">  

		<form action="getSubeKarZararDurum.do" method="post">
			<div class="form-group">
				
				
				<input
					type="text" class="form-control" name="baslangicTarihi" id="bas_tar"
					placeholder="Baþlangic Tarihi">
			</div>
			<div class="form-group">
				
				
				<input
					type="text" class="form-control" id="bit_tar" name="bitisTarihi"
					placeholder="Bitiþ Tarihi">
			</div>
			
			<button type="submit" class="btn btn-info btn-sm">Gönder</button>
		</form>
		
		</div>
	
	</div>

	</div>

<div class="clearfix"></div>
	<div class="col-lg-12 ">

			<table class="table table-bordered table-striped" style="font-size: 11px">
				<thead> 
					<tr>
						<td class="info" > <strong>  Þube </strong> </td>
						<td class="info" > <strong> Gelir (TL) </strong> </td>
						<td class="info"> <strong> Gider (TL) </strong> </td>
						<td class="info"> <strong> Kar </strong> </td>
						<td class="info">  <strong> Implant Say.</strong> </td>
						<td class="info">  <strong> Kesinleþmemiþ Implant </strong> </td>
						<td class="info">  <strong> Tedavi Ücret </strong> </td>
						<td class="info">  <strong> Tedavi Ücret Kesinleþmeyen </strong> </td>
						<td class="info">  <strong> Fark </strong> </td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${subeKarZararList}" var="islem">
						<tr>
							<td>${islem.subeAd }</td>
							<td>${islem.gelirStr } TL</td>
							<td>${islem.giderStr} TL</td>
							<td>${islem.karStr} TL </td>
							<td>${islem.implantSay}</td>
							<td>${islem.implantSayKesinlesmemis}</td>
							<td>${islem.tedaviMiktarStr} TL</td>
							<td>${islem.tedaviMiktarKesinlesmemisStr} TL</td>
							<td>${islem.miktarFarkStr} TL</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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