<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet" href="styles/nestable.css">



<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css"	href="css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css"	href="css/jquery.dataTables.min.css" />

<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css"	href="css/fullcalendar.print.min.css" media="print" />


<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/moment-with-locales.js"></script>
<script src="script/bootstrap.min.js"></script>

<script src='js/locale-all.js'></script>

<script src="js/jquery.dataTables.min.js"></script>
<script src="js/fullcalendar.js"></script>
<script src="js/fullcalendar.min.js"></script>



<style type="text/css">
.fc h2 {
   font-size: 12px;
}

</style>



<script>
	$(document)
			.ready(
					function() {

						var dt_to = $.datepicker.formatDate('yy.mm.dd',	new Date());

						$('#myDate').text(dt_to);

						$('#example').DataTable({
							select : {
								style : 'single'
							}
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

									$('#hasta').val(ids[1] + " " + ids[2]);
									$('#protokol').val(ids[0]);
									$('#telefon').val(ids[3]);
									$('#hastaId').val(ids[4]);
								});

						$('#exampleModal').on(
								'show.bs.modal',
								function(event) {
									var button = $(event.relatedTarget) // Button that triggered the modal
									var recipient = button.data('whatever') // Extract info from data-* attributes

									var modal = $(this)
									modal.find('.modal-body #recipient-name')
											.val(recipient)
								});

						<c:forEach items="${doktorList4Randevu}" var="ra">

						var val = [];

						<c:forEach items="${ra.doktorRandevuList}" var="randevu">

						var event = {
							"title" : '${randevu.hasta.ad} ${randevu.hasta.soyad}',
							"start" : '${randevu.randevuTarihiBaslangic}',
							"end" : '${randevu.randevuTarihiBitis}',
							"description": 'Hasta : ${randevu.hasta.ad} ${randevu.hasta.soyad}'
								+ '<br>Tedavi: ${randevu.islemTipDto.ad}'
								+ '<br> Açýklama: ${randevu.aciklama}'
						}

						val.push(event);

						</c:forEach>

						$('#${ra.dId}').fullCalendar(
								{

									header : {
										left : 'prev,next today',
										center : '',
										right : 'title'
									},
									defaultView : 'agendaDay',
									height : 600,
									locale : 'tr',
									theme :false,
									selectable : true,
									minTime : "08:00:00",
									maxTime : "22:00:00",
									
									fixedWeekCount:false,
									weekNumbers : true,
									navLinks : true, // can click day/week names to navigate views
									businessHours : false,
						
									slotDuration : '00:30:00',
									contentHeight : 600,
									slotLabelFormat : 'H:mm',
									
									allDaySlot : false,
									selectHelper : true,
									editable : false,

									eventClick : function(calEvent, jsEvent,
											view) {

										$(this).css('border-color', 'red');
										$('#start').val(
												moment(calEvent.start).format(
														'LLL'));
										$('#end').val(
												moment(calEvent.end).format(
														'LLL'));
										$('#title').val(calEvent.title);

									},
									events : val,
									eventRender : function(event, element) {
										element.attr('href','javascript:void(0);');
										
										$(element).css('font-size', '15px');
										element.click(function() {

											$("#startTime").html(
													moment(event.start).format(
															'LLL'));
											$("#endTime").html(
													moment(event.end).format(
															'LLL'));
											
											$("#eventInfo").html(event.description);

											$("#eventContent").dialog({
												modal : true,
												title : event.title,
												width : 350
											});
										});
									}

								});

						</c:forEach>

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
						
						
						
						
						$('#btnNextDay').bind('click',function() {
							$('#randevuEkleForm').submit(); 
							
						});
						$('#btnPrevDay').bind('click',function() {
							
							
						});

					});

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

<style>
#popup {
	display: none;
}

body {
	padding: 0;
	font-size: 13px;
	color:black; 
	font-family: serif;
}
</style>

<title>Randevu</title>
</head>
<body>

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		
		<div class="page-header pull-right">
			<div class="page-title" style="font-size: 24px;">
				<span id="myDate"> </span> 
			</div>
			
			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 20px; width: 20px"
				onclick="window.print()"></button>
		</div>
		<div class="clearfix"></div>
	</div>


	<div class="row">

		<div class="col-lg-12">
			<table class="table table-hover table-bordered">

				<tr>
					<c:forEach items="${doktorList4Randevu}" var="randevu">

						<td align="center">
						
							<div class="bg-info">
							
							<span  style="font-size: 16px;"> ${randevu.dAd}
								${randevu.dSoyad} </span>
								
								</div>
								
								
							<form action="hastaRandevuSorgula.do" method="post">
								<input type="submit" value="RANDEVU VER" class="btn btn-default">
								<input type="hidden" name="doktor" value="${randevu.dId}">
								<div id="${randevu.dId}"></div>
							</form> 

							
						</td>

					</c:forEach>

				</tr>
			</table>
		</div>

	</div>

	<div id="eventContent" title="Event Details" style="display: none;">
		<p id="eventInfo"></p>
		Baþlangýç Tarihi: <span id="startTime"></span>
		<br> 
		Bitiþ Tarihi: <span id="endTime"></span><br>
		<br>
	</div>


</body>
</html>