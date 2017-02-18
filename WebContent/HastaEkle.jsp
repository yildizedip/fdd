<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
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
<link rel="apple-touch-icon" sizes="72x72"	href="images/icons/favicon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114" href="images/icons/favicon-114x114.png">

<script src="js/moment-with-locales.js"></script>
<script src="js/fullcalendar.js"></script>
<script src="js/fullcalendar.min.js"></script>
<script src='js/locale-all.js'></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/jquery.form-validator.min.js"></script>
<script src="js/jquery.maskedinput.min.js"></script>


	<script src="script/bootstrap.min.js"></script>
	<script src="script/main.js"></script>
	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/epoch_classes.js"></script>
	<script type="text/javascript" src="js/jquery.form-validator.min.js"></script>
	<script type="text/javascript" src="js/jquery.maskedinput.min.js"></script>


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet" href="styles/nestable.css">

<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.theme.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />


</head>

<body>
	<div class="row col-lg-12 bg-success" >
		
			<h4> ${requestScope.warn} </h4>
	</div>
	
	<div class="container col-lg-12">
		<div class="panel panel-grey">

			<div class="panel-heading">Hasta Kartı Ekle</div>

			<div class="panel-body pan">

				<form action="hastaEkle.do" method="post" onsubmit="return validateForm()" name="hastaForm" >

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
							<div class="col-lg-4">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										<input name="ad" id="ad" type="text" placeholder="Ad"
										 class="form-control" data-validation="length" data-validation-length="min3" />

									</div>
								</div>
							</div>
							<div class="col-lg-4">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i>
										
										<input id="inputLastName" name="soyad" id="soyad" type="text" placeholder="Soyad" class="form-control" data-validation="length" data-validation-length="min2" />
									</div>
								</div>
							</div>
						</div>

						<div class="row">

							<div class="col-lg-4">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-phone"></i> <input name="tel" id="tel"	type="text" placeholder="Telefon" class="form-control" data-validation="required" data-validation-length="min11"  />
									</div>
								</div>
							</div>

							<div class="col-lg-4">
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
													class="form-control " type="text"
													placeholder="Tedavi Tarih Giriniz.">
											</div>
										</div>

									</div>
								</div>
								
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

											<div class="input-icon">
											
												<div class="btn-group" id="buttons">
													<button type="button" class="btn btn-info disno "> 18</button> 
													<button type="button" class="btn btn-info disno "> 17</button> 
													<button type="button" class="btn btn-info disno ">16</button> 
													<button type="button" class="btn btn-info disno">15</button> 
													<button type="button" class="btn btn-info disno">14</button> 
													<button type="button" class="btn btn-info disno">13</button> 
													<button type="button" class="btn btn-info disno">12</button> 
													<button type="button" class="btn btn-info disno">11</button> 
													
													<button type="button" class="btn btn-white"></button> 
													 
													<button type="button" class="btn btn-success disno">21</button> 
													<button type="button" class="btn btn-success disno">22</button> 
													<button type="button" class="btn btn-success disno">23</button> 
													<button type="button" class="btn btn-success disno">24</button> 
													<button type="button" class="btn btn-success disno">25</button> 
													<button type="button" class="btn btn-success disno">26</button> 
													<button type="button" class="btn btn-success disno">27</button> 
													<button type="button" class="btn btn-success disno">28</button> 
													<br>
													<br>
													<button type="button" class="btn btn-danger disno">48</button> 
													<button type="button" class="btn btn-danger disno">47</button> 
													<button type="button" class="btn btn-danger disno">46</button> 
													<button type="button" class="btn btn-danger disno">45</button> 
													<button type="button" class="btn btn-danger disno">44</button> 
													<button type="button" class="btn btn-danger disno">43</button> 
													<button type="button" class="btn btn-danger disno">42</button> 
													<button type="button" class="btn btn-danger disno">41</button> 
													
													<button type="button" class="btn btn-white"></button> 
													<button type="button" class="btn btn-warning disno">31</button> 
													<button type="button" class="btn btn-warning disno">32</button> 
													<button type="button" class="btn btn-warning disno">33</button> 
													<button type="button" class="btn btn-warning disno">34</button> 
													<button type="button" class="btn btn-warning disno">35</button> 
													<button type="button" class="btn btn-warning disno">36</button> 
													<button type="button" class="btn btn-warning disno">37</button> 
													<button type="button" class="btn btn-warning disno">38</button> 
												</div>
											</div>
										</div>
									</div>
								</div>
								
									<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											
											 <input
													class="form-control" placeholder="Diş Numarası"	name="disNo" id="disNo" > 
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
											
												<button type="button" id="disnosil" class="btn btn-warning">Sil</button> 
										</div>
									</div>
								</div>

								
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


								<div class="row" id="implantOk" hidden="true">
									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="implantBaglayanDoktorId" class="form-control">
												<option label="Protez Doktor Seçiniz.." value="-1"></option>
						
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
												<option label="Cerrah Doktor Seçiniz.." value="-1"></option>
						
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
								
								<!--  


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
								-->
								
								

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
												 <input
													class="form-control" placeholder="Ücret Giriniz (TL)"
													name="operasyonUcret" id="operasyonUcret" onkeyup="hesapla()" >

										</div>
									</div>
								</div>

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

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control" name="operasyonAciklama"	placeholder="Açıklama Giriniz" rows="2" 
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
									<div class="col-lg-6">
										<div class="form-group">

												<input	class="form-control" placeholder="Ödeme Miktarı Giriniz (TL)" name="odemeMiktar" id="odemeMiktar">

										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">

												<input	class="form-control" placeholder="Kalan Miktar" name="kalanMiktar" id="kalanMiktar"   >

										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control"
													placeholder="Açıklama Giriniz" rows="2" name="odemeAciklama"	id="aciklama" cols="40"></textarea>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
						
						<div class="row">
												
												<div class="form-actions text-right pal">
                                                    <button type="submit" class="btn btn-info">
                                                        Kaydet</button>
                                                </div>
						</div>
						
						
					</div>

				</form>
			</div>
		</div>
	</div>



	<script type="text/javascript">
	
		$(document).ready(function() {
			
			var myLanguage = {
			        errorTitle: 'Form submission failed!',
			        requiredFields: 'You have not answered all required fields',
			        badTime: 'You have not given a correct time',
			        badEmail: 'You have not given a correct e-mail address',
			        badTelephone: 'You have not given a correct phone number',
			        badSecurityAnswer: 'You have not given a correct answer to the security question',
			        badDate: 'You have not given a correct date',
			        lengthBadStart: 'The input value must be between ',
			        lengthBadEnd: ' karakter olmalı.',
			        lengthTooLongStart: 'The input value is longer than ',
			        lengthTooShortStart: 'Giriş en az ',
			        notConfirmed: 'Input values could not be confirmed',
			        badDomain: 'Incorrect domain value',
			        badUrl: 'The input value is not a correct URL',
			        badCustomVal: 'The input value is incorrect',
			        andSpaces: ' and spaces ',
			        badInt: 'Lütfen numara girişi yapınız',
			        badSecurityNumber: 'Your social security number was incorrect',
			        badUKVatAnswer: 'Incorrect UK VAT Number',
			        badStrength: 'The password isn\'t strong enough',
			        badNumberOfSelectedOptionsStart: 'You have to choose at least ',
			        badNumberOfSelectedOptionsEnd: ' answers',
			        badAlphaNumeric: 'The input value can only contain alphanumeric characters ',
			        badAlphaNumericExtra: ' and ',
			        wrongFileSize: 'The file you are trying to upload is too large (max %s)',
			        wrongFileType: 'Only files of type %s is allowed',
			        groupCheckedRangeStart: 'Please choose between ',
			        groupCheckedTooFewStart: 'Please choose at least ',
			        groupCheckedTooManyStart: 'Please choose a maximum of ',
			        groupCheckedEnd: ' item(s)',
			        badCreditCard: 'The credit card number is not correct',
			        badCVV: 'The CVV number was not correct',
			        wrongFileDim : 'Incorrect image dimensions,',
			        imageTooTall : 'the image can not be taller than',
			        imageTooWide : 'the image can not be wider than',
			        imageTooSmall : 'the image was too small',
			        min : 'min',
			        max : 'max',
			        imageRatioNotAccepted : 'Image ratio is not accepted'
			    };

			$.validate({
				language : myLanguage
			});
			
			$("#tel").mask("0999 9999999");
			
			$("#tel").on("blur", function() {
			    var last = $(this).val().substr( $(this).val().indexOf("-") + 1 );
			    
			    if( last.length == 3 ) {
			        var move = $(this).val().substr( $(this).val().indexOf("-") - 1, 1 );
			        var lastfour = move + last;
			        
			        var first = $(this).val().substr( 0, 9 );
			        
			        $(this).val( first + '-' + lastfour );
			    }
			});
			
			 $("#odemeMiktar").keyup(function(){
				 var opUcret= $("#operasyonUcret").val();
				 var miktar= $("#odemeMiktar").val();
				 var kalan= opUcret - miktar;
			        $("#kalanMiktar").val(kalan);
			  });
			 
			 
			 
			 $.datepicker.regional['tr'] = {
					                 closeText: 'kapat',
					 	                prevText: '&#x3C;geri',
					 	                nextText: 'ileri&#x3e',
					 	                currentText: 'bugün',
					 	                monthNames: ['Ocak','Şubat','Mart','Nisan','Mayıs','Haziran',
					 	                'Temmuz','Ağustos','Eylül','Ekim','Kasım','Aralık'],
					 	                monthNamesShort: ['Oca','Şub','Mar','Nis','May','Haz',
					 	                'Tem','Ağu','Eyl','Eki','Kas','Ara'],
					 	                dayNames: ['Pazar','Pazartesi','Salı','Çarşamba','Perşembe','Cuma','Cumartesi'],
					 	                dayNamesShort: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
					 	                dayNamesMin: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
					 	                weekHeader: 'Hf',
					 	                dateFormat: 'dd.mm.yy',
					 	                firstDay: 1,
					 	                isRTL: false,
					 	                showMonthAfterYear: false,
					 	                yearSuffix: ''};
			 $.datepicker.setDefaults($.datepicker.regional['tr'])
			
			$( "#islemTarihiStr" ).datepicker();
			 
			$( "#islemTarihiStr" ).datepicker( "option", "dateFormat", "yy.mm.dd" ); 
			 
			$( "#odemeTarihiStr" ).datepicker();
			$( "#odemeTarihiStr" ).datepicker( "option", "dateFormat", "yy.mm.dd" );

			$("#protokolNoUret").click(function(){$.datepicker.setDefaults($.datepicker.regional['tr'])

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
			
			
						 
			 
			 
			 var disno=[];
				
			    $('.disno').on('click', function (e) {
			    	
						var no=$(this).html();
						var varmi=true;
						for (i = 0; i < disno.length; i++) { 
						    text = disno[i];
						    if(text==no)
						    	varmi=false;
						}
						if(varmi)
						disno.push(no);
						
						varmi=true;
						//var txtdisno=$('#disNo').val() +no;							
						$('#disNo').val(disno);
				});
			    $('#disnosil').on('click', function (e) {
			    	
			    		
						var no=$(this).html();
						disno.pop();
						//var txtdisno=$('#disNo').val() +no;							
						$('#disNo').val(disno);
				});
		});
		
		
		function validateForm() {
			
		    var operasyonUcret = document.forms["hastaForm"]["operasyonUcret"].value;
		    var odemeMiktar = document.forms["hastaForm"]["odemeMiktar"].value;
		    var kalanMiktar = document.forms["hastaForm"]["kalanMiktar"].value;
		   
		    
		    if(operasyonUcret<0 ){
		   			alert("Tedavi Ücreti negatif olamaz.")
		    return false;
		    }
		    
		    if(odemeMiktar<0){
		   			alert("Ödeme negatif olamaz.")
		    return false;
		    }
		    
		    if(kalanMiktar<0){
		   			alert("Ödeme negatif olamaz.")
		    return false;
		    }
		   			
			var regexNum = /\d/;
			var regexLetter = /[a-zA-z]/;
			if (regexLetter.test(operasyonUcret) || regexLetter.test(odemeMiktar) || regexLetter.test(kalanMiktar)) {
				alert("Yalnızca rakam girilebilir.");
				 return false;
			}
			
		}
	</script>



</body>
</html>