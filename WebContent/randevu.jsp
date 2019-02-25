<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/moment-with-locales.js"></script>
<script src="js/fullcalendar.js"></script>
<script src='js/locale-all.js'></script>
<script src="script/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery.form-validator.min.js"></script>
<script type="text/javascript" src="js/jquery.maskedinput.min.js"></script>
<script src="js/zebra_datepicker.js" charset="UTF-8"></script>


<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="sitil/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/nestable.css">
<link rel="stylesheet" type="text/css" href="css/zebra-datepicker.css" />
<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.theme.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />

<style type="text/css">
.fc-future {
	background-color: white;
}

.fc h2 {
	font-size: 16px;
	font-family: sans-serif;
}

.fc h3 {
	font-size: 16px;
	font-family: sans-serif;
}

.fc h4 {
	font-size: 16px;
	font-family: sans-serif;
}

.fc h5 {
	font-size: 16px;
	font-family: sans-serif;
}

.modal-header, .close {
	background-color: #567FAB;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}

#popup {
	display: none;
}

body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 12px;
	color: black;
}
</style>

<script>
	var val = [];

	<c:forEach items="${selectedDoctor.doktorRandevuList}" var="randevu">

	var event = {
		"title" : '${randevu.hasta.ad} ${randevu.hasta.soyad} ${randevu.hasta.protokolNo} ${randevu.aciklama}',
		"start" : '${randevu.randevuTarihiBaslangic}',
		"end" : '${randevu.randevuTarihiBitis}',
		"description" : '${randevu.aciklama}',
		"id" : '${randevu.id}',
		"dId" : '${selectedDoctor.dId}',
		"hastaTel" : "${randevu.hasta.tel}",
		"hastaProtokol" : "${randevu.hasta.protokolNo}",
		"tedavi" : "${randevu.islemTipDto.ad}",
		"islem" : "${randevu.islemDto.id}",
		"tedaviDisNo" : "${randevu.islemDto.disNo}",
		"islemTipId" : "${randevu.islemTipDto.id}",
		"geldimi" : "${randevu.randevuyaGelinmedi}"

	}
	val.push(event);
	</c:forEach>

	/* <c:if test="${not empty warn }">

	 alert('${warn}')
	 </c:if> */

	$(document)
			.ready(
					function() {

						$('#tedaviVar').hide();
						$('#tedaviYok').hide();
						$('#hastaTable').hide();

						/* 	'<c:if test="${hastaListesi[0].hastaSelectedDoktorOperasyonList.size()>0}">'
								
								$('#tedaviYok').hide();
								$('#tedaviVar').show();
							
						
							'</c:if>' */

						/* 		$('#yeniTedaviEkle').on('click', function(e) {

									$('#tedaviYok').show();
									$('#tedaviVar').hide();
								}); */

						var disno = [];
						var disAdet = 0;

						$('.disno').on('click', function(e) {

							var no = $(this).html();

							var varmi = true;
							for (i = 0; i < disno.length; i++) {
								text = disno[i];
								if (text == no)
									varmi = false;
							}
							if (varmi) {
								disno.push(no);
								disAdet++;

							}

							varmi = true;
							//var txtdisno=$('#disNo').val() +no;							
							$('#disNoYeni').val(disno);
							$('#disAdetYeni').val(disAdet);

						});

						$('#disnosil').on('click', function(e) {

							var no = $(this).html();
							disno.pop();
							//var txtdisno=$('#disNo').val() +no;							
							$('#disNoYeni').val(disno);

							if (disAdet > 0)
								disAdet--;

							$('#disAdetYeni').val(disAdet);

						});

						$('#tedaviTarihYeni').Zebra_DatePicker();

						$('#implantAktif').bind('change', function() {

							if ($(this).is(':checked')) {

								$("#islemTipi").val(24);
								$("#implantOk").show();
							} else {
								$("#islemTipi").show();
								$("#implantOk").hide();
							}
						});
						$('#randevuBosSaat').bind('change', function() {

							if ($(this).is(':checked')) {

								$("#hastaBilgileri").hide();
								$("#randevuBilgileri").hide();
								//		$("#tedaviYok").hide();
							} else {

								$("#hastaBilgileri").show();
								$("#randevuBilgileri").show();
								//		$("#tedaviYok").show();
							}
						});

						//$('#exampleModal').modal('show');

						var myLanguage = {
							errorTitle : 'Form submission failed!',
							requiredFields : 'You have not answered all required fields',
							badTime : 'You have not given a correct time',
							badEmail : 'You have not given a correct e-mail address',
							badTelephone : 'You have not given a correct phone number',
							badSecurityAnswer : 'You have not given a correct answer to the security question',
							badDate : 'Lütfen tarih giriniz.',
							lengthBadStart : 'The input value must be between ',
							lengthBadEnd : ' karakter olmalý.',
							lengthTooLongStart : 'The input value is longer than ',
							lengthTooShortStart : 'Giriþ en az ',
							notConfirmed : 'Input values could not be confirmed',
							badDomain : 'Incorrect domain value',
							badUrl : 'The input value is not a correct URL',
							badCustomVal : 'The input value is incorrect',
							andSpaces : ' and spaces ',
							badInt : 'Lütfen numara giriþi yapýnýz',
							badSecurityNumber : 'Your social security number was incorrect',
							badUKVatAnswer : 'Incorrect UK VAT Number',
							badStrength : 'The password isn\'t strong enough',
							badNumberOfSelectedOptionsStart : 'You have to choose at least ',
							badNumberOfSelectedOptionsEnd : ' answers',
							badAlphaNumeric : 'The input value can only contain alphanumeric characters ',
							badAlphaNumericExtra : ' and ',
							wrongFileSize : 'The file you are trying to upload is too large (max %s)',
							wrongFileType : 'Only files of type %s is allowed',
							groupCheckedRangeStart : 'Please choose between ',
							groupCheckedTooFewStart : 'Please choose at least ',
							groupCheckedTooManyStart : 'Please choose a maximum of ',
							groupCheckedEnd : ' item(s)',
							badCreditCard : 'The credit card number is not correct',
							badCVV : 'The CVV number was not correct',
							wrongFileDim : 'Incorrect image dimensions,',
							imageTooTall : 'the image can not be taller than',
							imageTooWide : 'the image can not be wider than',
							imageTooSmall : 'the image was too small',
							min : 'min',
							max : 'max',
							imageRatioNotAccepted : 'Image ratio is not accepted',

						};

						$.validate({
							language : myLanguage
						});

						$('#example')
								.DataTable(
										{
											 "info":     false,
											 "searching":false,
											 "lengthChange": false,
											 
											select : {
												style : 'single',

											},
											"iDisplayLength" : 5,
											"lengthMenu" : [ [ 5, 25, 50, -1 ],
													[ 5, 25, 50, "All" ] ],
											order : [ [ 1, "desc" ] ],
											language : {

												sSearch : "Ara:",
												sLengthMenu : "_MENU_",
												sInfo : "_TOTAL_ kayýttan _START_ - _END_ arasýndaki kayýtlar gösteriliyor",

											},
											
											 "columnDefs": [
										            {
										                "targets": [ 4 ],
										                "visible": false
										            },
										           
										        ]

										});

						var table = $('#example').DataTable();

						$('#example tbody').on('click', 'tr', function() {
							$('#example tbody tr').removeClass('selected');
							$(this).toggleClass('selected');
						});

						$('#buttonSec').click(
								function() {

									var ids = $.map(table.rows('.selected')
											.data(), function(item) {
										return item
									});

									$('#hastaad').val(ids[1]);
									$('#hastasoyad').val(ids[2]);
									$('#protokol').val(ids[0]);
									$('#telefon').val(ids[3]);
									$('#hastaId').val(ids[4]);

									var start = $('#start').val();
									var end = $('#end').val();
									var title = $('#title').val();

									$('#randevuBasTar').val(start);
									$('#randevuBitTar').val(end);
									$('#randevuAciklama').val(title);

									$('#hasta_id').val(ids[4]);
									$('#randevuDoktorId').val("${doktorId}");
									//$('#pageAction').val('randevu-getir');
									//$('#send').submit();

								});

						$('#hastaEkleDialog').on(
								'show.bs.modal',
								function() {
									$(this).find('.modal-dialog').css({
										width : '80%', //probably not needed
										height : '80%', //probably not needed 
									});

									var date = $.datepicker.formatDate(
											'yy.mm.dd', new Date());

									$("#start").val('${randevuBasTar}')
									$("#end").val('${randevuBitTar}')

								});

						$('#calendar')
								.fullCalendar(
										{
											header : {
												left : 'prev,next today',
												center : 'title',
												right : 'month,agendaWeek,agendaDay'
											},
											defaultView : 'agendaWeek',
											locale : "tr",
											theme : false,
											fixedWeekCount : false,
											weekNumbers : true,
											columnFormat : 'DD/MM dddd',
											navLinks : true, // can click day/week names to navigate views
											selectable : true,
											businessHours : false,
											minTime : "08:00:00",
											maxTime : "21:00:00",
											allDaySlot : false,
											selectHelper : true,
											editable : true,
											slotDuration : '00:30:00',
											contentHeight : 600,
											slotLabelFormat : 'H:mm',
											select : function(start, end) {

												if (start.isBefore(moment())) {
													$('#calendar')
															.fullCalendar(
																	'unselect');
													return false;
												}

												//var title = prompt('Aciklama Gir:');
												var eventData;
												//if (title) {
												eventData = {
													title : title,
													start : start,
													end : end
												};

												//	$('#calendar').fullCalendar('renderEvent',	eventData, true); // stick? = true
												//}
												$('#calendar').fullCalendar(
														'unselect');

												$('#start')
														.val(
																moment(
																		eventData['start'])
																		.format(
																				"YYYY-MM-DD HH:mm"));
												$('#end')
														.val(
																moment(
																		eventData['end'])
																		.format(
																				"YYYY-MM-DD HH:mm"));

												$('#randevuBasTarHastaSec')
														.val(
																moment(
																		eventData['start'])
																		.format(
																				"YYYY-MM-DD HH:mm"));
												$('#randevuBitTarHastaSec')
														.val(
																moment(
																		eventData['end'])
																		.format(
																				"YYYY-MM-DD HH:mm"));

												//$("#islemTipi").val(9);
												//$('#title').text(eventData['title']);
												$('#hastaEkleDialog').modal(
														'show');

												$('#start')
														.val(
																moment(
																		eventData['start'])
																		.format(
																				"YYYY-MM-DD HH:mm"));
												$('#end')
														.val(
																moment(
																		eventData['end'])
																		.format(
																				"YYYY-MM-DD HH:mm"));

												/* dialog=$("#hastaEkleDialog").dialog({
													modal : true,
													title : event.title,
													width : 750,
													buttons: {
												        Kapat: function() {
												          dialog.dialog( "close" );
												        }
												      },
												}); */

											},
											eventClick : function(calEvent,
													jsEvent, view) {

												$(this).css('border-color',
														'red');
												$(this)
														.css('font-size',
																'10px');

												// $('#start').val(moment(calEvent.start).format('YYYY-MM-DD HH:mm'));
												//	$('#end').val(moment(calEvent.end).format('YYYY-MM-DD HH:mm'));
												//	$('#title').html(calEvent.title);

											},

											eventResize : function(event) {

												$("#startTime")
														.val(
																moment(
																		event.start)
																		.format(
																				'YYYY-MM-DD HH:mm'));
												$("#endTime")
														.val(
																moment(
																		event.end)
																		.format(
																				'YYYY-MM-DD HH:mm'));

												$("#eventInfo").html(
														event.description);

												$("#ranId").val(event.id);
												$("#dId").val(event.dId);
												$("#hastaTel").html(
														event.hastaTel);
												$("#hastaProtokolNo").html(
														event.hastaProtokol);

												$("#tedavi").html(event.tedavi);
												$("#tedaviDisNo").html(
														event.tedaviDisNo);

												if (event.geldimi == 'on') {
													$("#randevuyaGelinmedi")
															.attr("checked",
																	"checked");
													$("#ranGelmedi").css(
															"background-color",
															"#F78181");

												} else {
													$('#randevuyaGelinmedi')
															.removeAttr(
																	'checked');
													$("#ranGelmedi").css(
															"background-color",
															"white");
												}

												dialog = $("#eventContent")
														.dialog(
																{
																	modal : true,
																	title : event.title,
																	width : 450,
																	buttons : {
																		Kapat : function() {
																			dialog
																					.dialog("close");
																		}
																	},

																});

											},
											eventDrop : function(event) {

												$("#startTime")
														.val(
																moment(
																		event.start)
																		.format(
																				'YYYY-MM-DD HH:mm'));
												$("#endTime")
														.val(
																moment(
																		event.end)
																		.format(
																				'YYYY-MM-DD HH:mm'));

												$("#eventInfo").html(
														event.description);

												$("#ranId").val(event.id);
												$("#dId").val(event.dId);
												$("#hastaTel").html(
														event.hastaTel);
												$("#hastaProtokolNo").html(
														event.hastaProtokol);

												$("#tedavi").html(event.tedavi);
												$("#tedaviDisNo").html(
														event.tedaviDisNo);

												if (event.geldimi == 'on') {
													$("#randevuyaGelinmedi")
															.attr("checked",
																	"checked");
													$("#ranGelmedi").css(
															"background-color",
															"#F78181");

												} else {
													$('#randevuyaGelinmedi')
															.removeAttr(
																	'checked');
													$("#ranGelmedi").css(
															"background-color",
															"white");
												}

												dialog = $("#eventContent")
														.dialog(
																{
																	modal : true,
																	title : event.title,
																	width : 450,
																	buttons : {
																		Kapat : function() {
																			dialog
																					.dialog("close");
																		}
																	},

																});

											},
											eventRender : function(event,
													element) {
												$(element).css(
														'background-color',
														'#6D998C');
												element.attr('href',
														'javascript:void(0);');
												$(element).css('font-size',
														'10px');
												if (event.geldimi == 'on')
													$(element).css(
															'background-color',
															'#F2B3B3');

												element
														.click(function() {

															$("#startTime")
																	.val(
																			moment(
																					event.start)
																					.format(
																							'YYYY-MM-DD HH:mm'));
															$("#endTime")
																	.val(
																			moment(
																					event.end)
																					.format(
																							'YYYY-MM-DD HH:mm'));

															$("#eventInfo")
																	.html(
																			event.description);

															$("#ranId").val(
																	event.id);
															$("#dId").val(
																	event.dId);
															$("#hastaTel")
																	.html(
																			event.hastaTel);
															$(
																	"#hastaProtokolNo")
																	.html(
																			event.hastaProtokol);

															$("#tedavi")
																	.html(
																			event.tedavi);
															$("#tedaviDisNo")
																	.html(
																			event.tedaviDisNo);

															if (event.geldimi == 'on') {
																$(
																		"#randevuyaGelinmedi")
																		.attr(
																				"checked",
																				"checked");
																$("#ranGelmedi")
																		.css(
																				"background-color",
																				"#F78181");

															} else {
																$(
																		'#randevuyaGelinmedi')
																		.removeAttr(
																				'checked');
																$("#ranGelmedi")
																		.css(
																				"background-color",
																				"white");
															}
															//$("#randevuyaGelinmedi").checked=false;
															//$("#randevuyaGelinmedi").attr("unchecked", "checked");

															dialog = $(
																	"#eventContent")
																	.dialog(
																			{
																				modal : true,
																				title : event.title,
																				width : 450,
																				buttons : {
																					Kapat : function() {
																						dialog
																								.dialog("close");
																					}
																				},

																			});
														});
											},
											events : val

										});

						$(function() {
							$('#btnAdd')
									.bind(
											'click',
											function() {
												var start = $('#start').val();
												var end = $('#end').val();
												var title = $('#title').val();

												$('#myTable')
														.append(
																'<tr>'
																		+ '<td> '
																		+ title
																		+ ' </td>'
																		+ '<td> '
																		+ start
																		+ ' </td>'
																		+ '<td>'
																		+ end
																		+ '</td>'
																		+ '<td> <button type="button" class="remove">Sil</button> </td>'
																		+ '</tr>');
											});
							$('#myTable').on('click', '.remove', function() {
								$(this).closest('tr').remove();
							});
						});

						'<c:if test="${requestScope.actionTip eq 1}">' // hasta islemlerinden secilen hasta

						$('#hastaInfo')
								.html(
										"Lütfen ${hastaListesi[0].ad} ${hastaListesi[0].soyad} hastanýn ${randevuTedavi.islemTip.ad}  tedavisi için randevu tarih ve saati seçiniz.");

						$('#hastaId').val('${hastaListesi[0].id}');
						$('#hastaad').attr('readonly', true);
						$('#hastaad').val('${hastaListesi[0].ad}');
						$('#hastasoyad').val('${hastaListesi[0].soyad}');
						$('#hastasoyad').attr('readonly', true);
						$('#telefon').val('${hastaListesi[0].tel}');
						$('#telefon').attr('readonly', true);
						$('#protokol').val('${hastaListesi[0].protokolNo}');
						$('#islemId').val('${randevuTedavi.id}');
						$('#islemTipi').val('${randevuTedavi.islemTip.id}');
						$('#disNo').val('${randevuTedavi.disNo}');

						$('#tedaviTarih').val('${randevuTedavi.islemTarihi}');
						$('#tedaviUcret').val('${randevuTedavi.miktar}');
						$('#tedaviDisNo').val('${randevuTedavi.disNo}');
						$('#tedaviAciklama').val('${randevuTedavi.aciklama}');

						$('#hastaSecButton').prop("disabled", true);

						' </c:if> '

						'<c:if test="${!empty hastaList}">' // randevu sayfasindan hasta sec ile gelen hasta

						$('#hastaEkleDialog').modal('show');
						$('#hastaTable').show();
						'</c:if> '

						'<c:if test="${requestScope.actionTip eq 2}">' // randevu sayfasindan hasta sec ile gelen hasta

						$('#hastaId').val('${hastaListesi[0].id}');
						$('#hastaad').attr('readonly', true);
						$('#hastaad').val('${hastaListesi[0].ad}');
						$('#hastasoyad').val('${hastaListesi[0].soyad}');
						$('#hastasoyad').attr('readonly', true);
						$('#telefon').val('${hastaListesi[0].tel}');
						$('#telefon').attr('readonly', true);
						$('#protokol').val('${hastaListesi[0].protokolNo}');
						$('#islemId').val('${randevuTedavi.id}');
						//$('#islemTipi').val('${hastaListesi[0].hastaOperasyonList}');

						$('#start').val('${randevuBasTar}');
						$('#end').val('${randevuBitTar}');
						$('#title').val('${randevuAciklama}');

						$('#hastaSecButton').prop("disabled", false);
						$('#hastaEkleDialog').modal('show');

						' </c:if> '

						$('#islemTipi')
								.on(
										'change',
										function() {

											'<c:forEach items="${hastaListesi[0].hastaSelectedDoktorOperasyonList}" var="islem">'

											if (this.value == '${islem.islemTip.id}') {
												$('#tedaviTarih').val(
														'${islem.islemTarihi}');
												$('#tedaviUcret').val(
														'${islem.miktar}');
												$('#tedaviDisNo').val(
														'${islem.disNo}');
												$('#tedaviAciklama').val(
														'${islem.aciklama}');
												$('#islemId')
														.val('${islem.id}');
											}

											'</c:forEach>'
										});

						$('#islemTipiYeni').on('change', function() {

							var value = this.value;

							'<c:forEach items="${islemTurList}" var="islem">'

							if (value == '${islem.id}') {

								var fiyat = '${islem.subeTip.fiyat}';

								$('#tedaviUcretYeni').val(fiyat);

							}

							'</c:forEach>'

						});

					});

	function validate() {

		return true;

		/* var islemTipiYeni = $('#islemTipiYeni').val();
		var islemTipiVarolan = $('#islemTipi').val();

		if (islemTipiYeni == -1 && ${empty hastaListesi[0].hastaSelectedDoktorOperasyonList} ) {
			alert("Lütfen tedavi seçiniz.");
			return false;
		}
		
		if (islemTipiVarolan == -1 && ${hastaListesi[0].hastaSelectedDoktorOperasyonList.size()>0} ) {
			alert("Lütfen tedavi seçiniz.");
			return false;
		} */

	}

	function send() {

		var events = $('#calendar').fullCalendar('clientEvents');

		var text = "";
		var i;
		for (i = 0; i < events.length; i++) {
			text += events[i]['title'] + " - " + events[i]['start'] + " - "
					+ events[i]['end'];
		}

		alert("text : " + text)

	}
</script>


<title>Randevu Ekle</title>
</head>
<body>

<div class="container">

	<div class="row">
		<div>
			<div style="text-align: center; font-size: 18px; font-weight: bold;">
				<span> ${selectedDoctor.dAd} ${selectedDoctor.dSoyad}</span>
			</div>
		</div>
		<div class="pull-right">
			<button class="btn"
				style="background-image: url('Images/printIcon2.jpg'); height: 20px; width: 20px"
				onclick="window.print()"></button>
		</div>
	</div>
	<div class="row">

		<!-- 	RANDEVU EKLE  -->

		<div class="row">

			<div class="col-lg-12">
				<h4 id="hastaInfo"
					style="color: black; font-size: 14px; font-style: italic;"></h4>
			</div>

		</div>
		<div class="col-lg-12">
			<div id="calendar"></div>
		</div>
	</div>

	<div id="eventContent" title="Event Details" style="display: none;">

		<form action="hastaRandevuGuncelle.do" method="post">
			<input name="id" type="hidden" id="ranId"> <input
				name="doktorId" type="hidden" id="dId">

			<div class="form-body pal">
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-icon" class="bg-info">

								Telefon : <span id="hastaTel"></span> <br> Protokol No :<span
									id="hastaProtokolNo"></span> <br> Tedavi :<span
									id="tedavi"></span> <br>

							</div>

						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-icon">
								<input class="form-control" name="randevuTarihiBaslangic"
									id="startTime">

							</div>

						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-icon">
								<i class="fa fa-calendar" aria-hidden="true"></i> <input
									class="form-control" name="randevuTarihiBitis" id="endTime">

							</div>

						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-icon">

								<textarea class="form-control" name="aciklama" id="eventInfo"
									placeholder="Açýklama Giriniz" rows="2" cols="50"></textarea>


							</div>

						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="form-group">
							<div class="input-icon">

								<div class="checkbox" id="ranGelmedi">
									<label> <input type="checkbox" id="randevuyaGelinmedi"
										name="randevuyaGelinmedi" /> &nbsp; Randevuya Gelinmedi
									</label>
								</div>

							</div>

						</div>
					</div>
				</div>


				<div class="col-md-12">

					<div class="form-actions text-center pal">

						<input type="submit" value="Guncelle" name="action"
							class="btn btn-primary" id="buttonsave"> <input
							type="submit" value="Sil" name="action" class="btn btn-primary"
							id="buttondelete" />

					</div>
				</div>

			</div>

		</form>

	</div>


	<form id="send" action="hastaSorgulaForRandevu.do" method="post">
		<input type="hidden" name="hastaId" id="hasta_id"> <input
			type="hidden" name="islem" id="pageAction"> <input
			type="hidden" name="doktorId" value="${doktorId}"> <input
			type="hidden" name="randevuBasTar" value="${randevuBasTar}">
		<input type="hidden" name="randevuBitTar" value="${randevuBitTar}">
		<input type="hidden" name="randevuAciklama" id="randevuAciklama">
	</form>


	<div class="modal fade " id="hastaEkleDialog" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel"
		style="color: black;">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg-success">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">RANDEVU EKLE</h4>
				</div>

				<div class="modal-body">

					<div class="row">

						<div class="col-lg-5">
							<fieldset>
								<legend style=" font-weight: bold; font-size: 13px;">Hasta
									Ara</legend>


								<div>
									<form action="hastaBasicSorgula.do" method="post"
										id="hastaSorgulaForm"
										onsubmit="return validateFormHastaSorgulama()">
										<input type="hidden" class="form-control " name="randevuAktif" />

											<div class="col-lg-5">
												<input class="form-control input-sm" name="protokolNo"
													id="hstProtokol" placeholder="Protokol No" /> <input
													type="hidden" name="islem" value="randevu" /> <input
													type="hidden" name="doktorId" value="${selectedDoctor.dId}"
													id="randevuDoktorId"> <input type="hidden"
													id="randevuBasTarHastaSec" name="randevuBasTar"
													value="${randevuBasTar }"> <input type="hidden"
													id="randevuBitTarHastaSec" name="randevuBitTar"
													value="${randevuBitTar }">
											</div>

											<div class=" col-lg-5">
												<input class="form-control input-sm" name="ad" id="hstAd"
													placeholder="Ad" />
											</div>
											
											<div class="col-lg-2 ">
												<input type="submit" class="btn btn-sm btn-info" value="Sorgula"
													name="bnt_gonder" />
											</div>
									</form>
								</div>


								<div id="hastaTable">

									<table id="example" class="table table-striped" style="font-size: 11px;">
										<thead>
											<tr>
												<th>Protokol No</th>
												<th>Ad</th>
												<th>Soyad</th>
												<th>Telefon</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="hasta" items="${hastaList}">
												<tr>
													<td>${hasta.protokolNo}</td>
													<td>${hasta.ad}</td>
													<td>${hasta.soyad}</td>
													<td>${hasta.tel}</td>
													<td hidden="true">${hasta.id }</td>
												</tr>
											</c:forEach>

										</tbody>
									</table>



									<button type="button" class="btn btn-sm btn-info" id="buttonSec">Seç</button>
								</div>
							</fieldset>
						</div>

						<div class="col-lg-7">
							<fieldset>
								<legend style=" font-weight: bold; font-size: 13px;">Randevu
									Bilgileri</legend>

								<form action="HastaRandevuEkle.do" method="post"
									onsubmit="return validate()">
									

									<input name="hastaId" id="hastaId" hidden="true"> <input
										name="islemId" id="islemId" hidden="true"> <input
										name="hastaId" id="hastaId" hidden="true"> <input
										name="islemId" id="islemId" hidden="true"> <input
										type="hidden" name="doktorId" id="doktorId"
										value="${selectedDoctor.dId}">

									<div class="col-lg-12" id="hastaBilgileri">

										<div class="col-lg-4">
											<div class="form-group">
												<div class="input-icon">
													<input class="form-control" name="hastaAd" type="text"
														placeholder="Hasta Ad" id="hastaad" data-validation="required" data-validation-error-msg="Hasta Seçiniz..">

												</div>

											</div>
										</div>

										<div class="col-lg-4">
											<div class="form-group">
												<div class="input-icon">
													<input class="form-control" name="hastaSoyad"
														placeholder="Hasta Soyad" id="hastasoyad" data-validation="required" data-validation-error-msg="Hasta Seçiniz..">

												</div>
											</div>
										</div>


										<div class="col-lg-4">
											<div class="form-group">
												<div class="input-icon">
													<input class="form-control" name="telefon"
														placeholder="Tel" id="telefon" >

												</div>
											</div>
										</div>


										<div class="col-lg-6">
											<div class="form-group">
												<div class="input-icon">
													<input class="form-control bg-info" type="text"
														name="randevuTarihiBaslangic" placeholder="Baþlangýç "
														id="start" data-validation="required"
														style="color: black;">
												</div>
											</div>
										</div>



										<div class="col-lg-6">
											<div class="form-group">
												<div class="input-icon">
													<input class="form-control bg-info" type="text"
														name="randevuTarihiBitis" placeholder="Bitiþ" id="end"
														data-validation="required" style="color: black;">
												</div>
											</div>
										</div>

										<div class="col-lg-12">
											<div class="form-group">

												<textarea class="form-control" name="aciklama"
													placeholder="Açýklama Giriniz" rows="1" id="title"
													cols="20" data-validation="required"
													data-validation-error-msg="Lütfen Açýklama Giriniz."></textarea>

											</div>
										</div>

										<div class="col-lg-12">
											<div class="form-group">

												<input class="form-control" name="beklenenOdeme"
													placeholder="Beklenen Ödeme Miktarý (TL)"
													id="beklenenOdeme" />

											</div>
										</div>

									</div>
									<div class="pull-right">
										<label> <input type="checkbox" id="randevuBosSaat"
											name="randevuBosSaatAktif" /> &nbsp; Reserve
										</label>
									</div>
									<div class="clearfix"></div>

									<div class="pull-right">
										<input id="bntKaydet" class="btn btn-sm btn-info" type="submit"
											value="Randevu Ekle" />
										<button type="button" class="btn btn-sm btn-default"
											data-dismiss="modal">Vazgeç</button>

									</div>

								</form>
							</fieldset>

						</div>

					</div>

				</div>

			</div>
		</div>

	</div>
	
	</div>

</body>