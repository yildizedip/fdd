<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>


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
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" src="js/jquery.ui.datepicker-tr.js"></script>

<script type="text/javascript"  src="lib/jquery-1.10.2.js"></script>
<script type="text/javascript"  src="lib/jquery-ui-1.10.4.js"></script>
<script type="text/javascript"  src="lib/jquery.dataTables.js"></script>

<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/i18n/jquery-ui-i18n.min.js"></script>

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

<title></title>
</head>
<body style="color: black; background-color: white;">

	<%
			Date bugun = new Date();
			SimpleDateFormat sdff = new SimpleDateFormat("yyyy.MM.dd");
			String gunlukTarih = sdff.format(bugun);
			request.setAttribute("bugun", gunlukTarih);
		%>
		
		
		<div> <button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button> </div>
		
	<div class="col-lg-6 ">

		<div class="panel panel-default">

			<div class="panel-heading">Gün Sonu Durumu Sorgula (Gelir -
				Gider Analizi)</div>

			<div class="panel-body">

				<form action="getGelirGiderDurumu.do" method="post">

					<input type="hidden" value="10" name="islem">
					<div class="form-group">
						<div class="row">

							<c:choose>
								<c:when
									test="${(odeme_tarih_degistir eq 'off') and (sessionScope.sessionMember[0].kuTur eq '4') }">

									<div class="col-lg-3">
										<label class="form-control">Tarih :</label>
									</div>

									<div class="col-lg-4">
										<input class="form-control" name="bas_tar" id="bas_tar"
											disabled="disabled">
									</div>
									<div class="col-lg-5" align="left">
										<input class="form-control" name="bit_tar" id="bit_tar"
											disabled="disabled">
									</div>
								</c:when>

								<c:otherwise>
									<div class="col-lg-6">
										<input class="form-control" name="bas_tar" id="bas_tar">
									</div>
									<div class="col-lg-6" align="left">
										<input class="form-control" name="bit_tar" id="bit_tar">
									</div>

								</c:otherwise>

							</c:choose>

						</div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-lg-6">
								<select size="1" name="doktorId" class="form-control">
									<option label="Doktor Seçiniz.." value="-1">Doktor
										Seçiniz..</option>

									<c:forEach items="${doktorList}" var="doktorDTO">
										<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
											value="${doktorDTO.dId }">${doktorDTO.dAd }
											${doktorDTO.dSoyad }</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-6">
								<select size="1" name="islemTipi" class="form-control">
									<option label="Tedavi Seçiniz.." value="-1">Tedavi
										Seçiniz..</option>

									<c:forEach items="${islemTurList}" var="islem">
										<option label="${islem.ad}" value="${islem.id }">${islem.ad}</option>
									</c:forEach>
								</select>
							</div>
						</div>



					</div>

					<div class="form-group">
						<select size="1" name="giderTuru" class="form-control">

							<option label="Gider Türü Seçiniz.." value="-1">Gider
								Türü Seçiniz..</option>
							<c:forEach items="${sessionScope.giderTurKodlari}"
								var="turKodDTO">
								<option label="${turKodDTO.turAd }" value="${turKodDTO.turKod }">${turKodDTO.turAd }</option>
							</c:forEach>
						</select>

					</div>

					<div class="form-group">
						<br>

						<button type="submit" class="btn btn-info btn-sm">Sorgula</button>

						<input type="hidden" name="doctor"
							value="${sessionScope.sessionMember[0].kuId }" id="bas_tar">

					</div>

				</form>
			</div>

		</div>

	</div>

	<div class="clearfix"></div>



	<div class="col-lg-8">
		<myTagFiles:GelirRaporu silAktif="0">
			<c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}
									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					</myTagFiles:GelirRaporu>
	</div>

	<div class="col-lg-4">


		<myTagFiles:GiderRaporu silAktif="0">
			<c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}
									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					</myTagFiles:GiderRaporu>

	</div>

</body>
</html>