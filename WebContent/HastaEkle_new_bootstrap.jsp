<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Hasta Kartı Ekle</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link rel="apple-touch-icon" href="images/icons/favicon.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="images/icons/favicon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="images/icons/favicon-114x114.png">
<!--Loading bootstrap css-->

<link type="text/css" rel="stylesheet"
	href="styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/animate.css">
<link type="text/css" rel="stylesheet" href="styles/all.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet"
	href="styles/style-responsive.css">
<link type="text/css" rel="stylesheet"
	href="styles/zabuto_calendar.min.css">
<link type="text/css" rel="stylesheet" href="styles/pace.css">
<link type="text/css" rel="stylesheet"
	href="styles/jquery.news-ticker.css">
<link type="text/css" rel="stylesheet" href="styles/jplist-custom.css">

<link rel="stylesheet" href="css/datepicker.css">
<link rel="stylesheet" href="css/bootstrap.css">

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />


<script type="text/javascript">
	function kontrol() {

		var protokolNo = document.getElementById("protokolNo").value;
		var tckimlik = document.getElementById("tckimlik").value;
		var tel = document.getElementById("tel").value;

		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;

		if (!regexNum.test(protokolNo)
				&& regexLetter.test(protokolNnav - second - levelo)) {
			document.getElementById("protokolNo").value = "";
			alert("Yalnızca rakam girilebilir.");

		}

		if (!regexNum.test(tckimlik) && regexLetter.test(tckimlik)) {
			document.getElementById("tckimlik").value = "";
			alert("Yalnızca rakam girilebilir.");

		}
		if (!regexNum.test(tel) && regexLetter.test(tel)) {
			document.getElementById("tel").value = "";
			alert("Yalnızca rakam girilebilir.");

		}
	}

	
</script>

</head>

<body>

	<div class="container col-lg-8">
		<div class="panel panel-grey">

			<div class="panel-heading">Hasta Kartı Ekle</div>

			<div class="panel-body pan">

				<form action="hastaEkle.do" method="post">

					<input type="hidden" name="subeId" value="${subeId}">
					<input type="hidden" name="hastaId" value="${hasta.id }">
					<input type="hidden" name="iliskiliIslemId" value="${iliskiliIslemId}">
					
					
					<input
							type="hidden" name="islemId"
							value="${hastaOperasyonListesi['0'].id}"> <input
							type="hidden" name="hastaId" value="${hasta.id }" /> 
							
					

					<div class="form-body pal">

						<h4>Hasta Bilgileri</h4>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										<input name="ad" id="ad" type="text" placeholder="Ad" class="form-control" />

									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i>
										
										<input id="inputLastName" name="soyad" id="soyad" type="text" placeholder="Soyad" class="form-control" />
									</div>
								</div>
							</div>
						</div>

						<div class="row">

							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-phone"></i> <input name="tel" id="tel"	type="text" placeholder="Telefon" class="form-control" />
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										<input id="tckimlik" onkeyup="kontrol()" name="tckimlik" 	type="text" placeholder="Tc Kimlik No" class="form-control" />
									</div>
								</div>
							</div>

						</div>
			<!--  
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">

							
							<div class="input-group">
								<span class="input-group-btn ">										
										</span>
										<span class="input-group-addon">@</span>
								<input type="text" id="protokolNo"  name="protokolNo"
									class="form-control" placeholder="Protokol No " />  <span class="input-group-btn">
									<button id="protokolNoUret" type="button" class="btn btn-default">Üret</button></span>
							</div>

						</div>
							</div>

						</div>
					-->

						<hr />


						<div class="row ">


							<div class="col-lg-6">
								<h4>Tedavi Bilgileri</h4>
								<!-- TEDAVi BILGILERI -->

								<div class="row ">

									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="doktorId" class="form-control">
												<option label="Diş Hekimi Seçiniz.." value="-1">
													Hekim Seçiniz</option>

												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }"
														<c:if test="${doktorDTO.dId eq operasyonDoktorId }"> 
														selected="selected"
																		</c:if>>
														${doktorDTO.dAd } ${doktorDTO.dSoyad }</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon ">
												<i class="fa fa-calendar"></i> 
												
												<input name="islemTarihiStr" id="islemTarihiStr"
													class="form-control ornek " type="text"
													placeholder="Tedavi Tarih Giriniz.">
											</div>
										</div>

									</div>
								</div>

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

											<div class="input-icon">
												<div class="checkbox">
													<label> <input type="checkbox" name="implantAktif" id="implantAktif" />
														&nbsp; Implant
													</label>
												</div>

											</div>
										</div>
									</div>
								</div>


								<div class="row" id="implantOk" hidden="true">
									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="implantBaglayanDoktorId" class="form-control">
												<option label="Doktor Seçiniz.." value="-1"></option>
						
												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }">  ${doktorDTO.dAd } ${doktorDTO.dSoyad } </option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="implantCerrahId" class="form-control">
												<option label="Doktor Seçiniz.." value="-1"></option>
						
												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }"> ${doktorDTO.dAd } ${doktorDTO.dSoyad }   </option>
												</c:forEach>
											</select>
										</div>
									</div>
									
									
									
								</div>



								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">

												<select size="1" name="islemTipi" id="islemTipi"
													class="form-control">
													<option label="Tedavi Seçiniz.." value="-1">
														Tedavi Seçiniz..</option>

													<c:forEach items="${islemTurList}" var="islem">
														<option label="${islem.ad}" value="${islem.id}"
															<c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>="">
															${islem.ad}</option>
													</c:forEach>
												</select>

											</div>
										</div>
									</div>
								</div>


								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<select size="1" name="disAdet" id="disAdet"
													class="form-control">
													<option label="Adet Seçiniz.." value="-1">Adet
														Seçiniz..</option>

													<c:forEach items="${disSayisiList}" var="dis">
														<option label="${dis}" value="${dis}">${dis}</option>
													</c:forEach>
												</select>

											</div>
										</div>
									</div>
								</div>




								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
												 <input
													class="form-control" placeholder="Ücret Giriniz (TL)"
													name="operasyonUcret" id="operasyonUcret" onkeyup="hesapla()">

										</div>
									</div>
								</div>


								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

											<div class="input-icon">
												<div class="checkbox">
													<label> <input type="checkbox" id="durumu" name="operasyonDurum" />
														&nbsp; Kesinleşmedi
													</label>
												</div>

											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control" name="operasyonAciklama"	placeholder="Açıklama Giriniz" rows="4" 
													id="aciklama" cols="50"></textarea>
											</div>
										</div>

									</div>
								</div>
							</div>


							<div class="col-lg-6">

								<h4>Ücret Bilgileri</h4>
								<!-- UCRET BILGILERI BASLA-->
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<div class="hero-unit">
												<i class="fa fa-calendar"></i>
													<input class="form-control ornek " type="text" name="odemeTarihiStr" id="odemeTarihiStr" 
														placeholder="Tarih Giriniz.">
												</div>
											</div>

										</div>

									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

												<input	class="form-control" placeholder="Ödeme Miktarı Giriniz (TL)" name="odemeMiktar" id="odemeMiktar" >
												<input	class="form-control" placeholder="Kalan Miktarı" name="kalanMiktar" id="kalanMiktar" >

										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control"
													placeholder="Açıklama Giriniz" rows="4" name="odemeAciklama"	id="aciklama" cols="50"></textarea>
											</div>
										</div>

									</div>
								</div>
								
								
							</div>


						</div>
						
						<div class="row">
						<div class="form-actions text-right pal">
                                                    <button type="submit" class="btn btn-primary">
                                                        Kaydet</button>
                                                </div>
						</div>
						
						
					</div>

				</form>
			</div>
		</div>
	</div>

	<script src="script/jquery-1.10.2.min.js"></script>
	<script src="script/jquery-migrate-1.2.1.min.js"></script>
	<script src="script/jquery-ui.js"></script>
	<script src="script/bootstrap.min.js"></script>
	<script src="script/bootstrap-hover-dropdown.js"></script>
	<script src="script/html5shiv.js"></script>
	<script src="script/respond.min.js"></script>
	<script src="script/jquery.metisMenu.js"></script>
	<script src="script/jquery.slimscroll.js"></script>
	<script src="script/jquery.cookie.js"></script>
	<script src="script/icheck.min.js"></script>
	<script src="script/custom.min.js"></script>
	<script src="script/jquery.news-ticker.js"></script>
	<script src="script/jquery.menu.js"></script>
	<script src="script/pace.min.js"></script>
	<script src="script/holder.js"></script>
	<script src="script/responsive-tabs.js"></script>
	<script src="script/jquery.flot.js"></script>
	<script src="script/jquery.flot.categories.js"></script>
	<script src="script/jquery.flot.pie.js"></script>
	<script src="script/jquery.flot.tooltip.js"></script>
	<script src="script/jquery.flot.resize.js"></script>
	<script src="script/jquery.flot.fillbetween.js"></script>
	<script src="script/jquery.flot.stack.js"></script>
	<script src="script/jquery.flot.spline.js"></script>
	<script src="script/zabuto_calendar.min.js"></script>
	<script src="script/index.js"></script>
	<script src="script/highcharts.js"></script>
	<script src="script/data.js"></script>
	<script src="script/drilldown.js"></script>
	<script src="script/exporting.js"></script>
	<script src="script/highcharts-more.js"></script>
	<script src="script/charts-highchart-pie.js"></script>
	<script src="script/charts-highchart-more.js"></script>
	<script src="script/modernizr.min.js"></script>
	<script src="script/jplist.min.js"></script>
	<script src="script/jplist.js"></script>


	<!--CORE JAVASCRIPT
	var ageCheckbox = document.getElementById('implantAktif');
			var islemTipi = document.getElementById('islemTipi');

			ageCheckbox.onchange = function() {
			    islemTipi.hidden = this.checked ? false : true;
			};
	
	-->
	<script src="script/main.js"></script>

	<script src="script/jquery.js"></script>

	<script src="script/datepicker.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {

			 $("#odemeMiktar").keydown(function(){
			        $("#odemeMiktar").css("background-color", "yellow");
			    });

			$('.ornek').datepicker({ //# ile id üzerinden yaparsanız yanlızca bir input çalışır 
				format : "dd/mm/yyyy" //dd-mm-yyyy
			});

			$("#protokolNoUret").click(function(){

		        $('#protokolNo').val(Math.floor(Math.random() * 1000000000000));
		    }); 

			$('#implantAktif').bind('change', function() {

				if ($(this).is(':checked')) {
					$("#islemTipi").hide();
					$("#implantOk").show();
				} else {
					$("#islemTipi").show();
					$("#implantOk").hide();
				}
			});
		});
	</script>



</body>
</html>