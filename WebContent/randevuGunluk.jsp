<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>

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


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="sitil/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet" href="styles/nestable.css">
<link rel="stylesheet" type="text/css" href="css/zebra-datepicker.css" />
<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.theme.css" />
<link rel="stylesheet" type="text/css"	href="css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css"	href="css/jquery.dataTables.min.css" />


<style type="text/css">
.fc h2 {
   font-size: 11px;
}

body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 12px;
	color: black;
	background-color: white;
}

.modal-header, .close {
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}
</style>


<script>

<c:if test="${not empty warn}">

alert('${warn}')
</c:if> 
	$(document)
			.ready(
					function() {
						
						 '<c:if test="${!empty randevuListesi}">' // randevu sayfasindan hasta sec ile gelen hasta

									$('#randevuListModal').modal('show');
						 
						 
						'</c:if> ' 
						
						
						$('#randevuListKapat').click(function() {
							//send form for randevu
							$('#getRandevuGunlukForm').submit();
						    
						});
						
						/**
						
					$('#nextButton').click(function() {
							
							<c:forEach items="${doktorList4Randevu}" var="ra">
							
							 $('#${ra.dId}').fullCalendar('next');
							
							</c:forEach>
						    
						});
						
						$('#previousButton').click(function() {
							
							<c:forEach items="${doktorList4Randevu}" var="ra">
							
							 $('#${ra.dId}').fullCalendar('prev');
							
							</c:forEach>
						    
						});
							
						**/
						
						var tarih=new Date();
						var gun=tarih.getDay();
						var ay=tarih.getMonth();
						var yil=tarih.getFullYear();
						var gunler= ['Pazar', 'Pazartesi', 'Salý','Çarþamba','Perþembe','Cuma','Cumartesi'];
						var aylar= ['Ocak', 'Þubat', 'Mart','Nisan','Mayýs','Haziran','Temmuz','Aðustos','Eylül','Ekim','Kasým','Aralýk'];
						$('#myDate').text(tarih.getDate()+' '+aylar[ay]+' '+yil+' '+gunler[gun]);								
						//var dt_to = $.datepicker.formatDate('dd M yy',	new Date());
						
									
						//$('#myDate').text(dt_to);

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
										left : '',
										center : '',
										right : ''
									},
									defaultView : 'agendaDay',
									height : 600 ,
									locale : 'tr',
									theme :false,
									selectable : true,
									minTime : "09:00:00",
									maxTime : "21:00:00",
									fixedWeekCount:false,
									weekNumbers : false,
									navLinks : true, // can click day/week names to navigate views
									businessHours : false,
									columnFormat : 'DD.MM dddd',
						
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
														'L'));
										$('#end').val(
												moment(calEvent.end).format(
														'L'));
										$('#title').val(calEvent.title);

									},
									events : val,
									eventRender : function(event, element) {
										element.attr('href','javascript:void(0);');
										
										$(element).css('font-size', '11px');
										element.click(function() {

											$("#startTime").html(
													moment(event.start).format('L'));
											$("#endTime").html(
													moment(event.end).format('L'));
											
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

.fc-button-prev {
	display: none;
}

</style>

<title>Randevu</title>
</head>
<body>


<form id="getRandevuGunlukForm" method="get" action="hastaGunlukRandevuSorgula.do">



  </form>
		<div class="col-lg-12">
		
		
		<div class="row"> 
		
		<div class="col-lg-6" align="left"> 
		
		<!-- 
		 <button id="previousButton"> << </button> 
		 <button id="nextButton"> >> </button> 
		
		 -->
		
		
		
		</div>
		<div class="col-lg-6" align="right"> 
		
		
		
			<form   class="form-inline" action="getRandevuListesi.do" method="post" >
							
							<div class="form-group">
								    <input type="text" class="form-control tarih" placeholder="Protokol No" name="protokolNo" id="protokolNo">
								  </div>
								  <div class="form-group">
								    <input type="text" class="form-control tarih"  placeholder="Hasta Ad" name="ad" id="ad">
								    <input type="hidden" name="page" value="fromRandevu" >
								  </div>
								  
								  <button type="submit" class="btn btn-default">Randevu Ara</button>
			
								
							</form>
		
		
		  </div>
		  
		  </div>
		
		<h4 id="myDate" align="center"> </h4>
			<table class="table table-hover table-bordered">

				
				<tr>
					<c:forEach items="${doktorList4Randevu}" var="randevu">

						<td align="center">
						
							<div class="bg-info">
							
							<span  style="font-size: 12px;">  <strong> ${randevu.dAd} ${randevu.dSoyad} </strong>  </span>
								
								</div>
								
								
							<form action="hastaRandevuSorgula.do" method="post">
								<input type="submit" value="Randevu Görüntüle /  Ver" class="btn btn-link " style="font-size: 12px; ">
								<input type="hidden" name="doktor" value="${randevu.dId}">
								<div id="${randevu.dId}"></div>
							</form> 
							
							
							
						</td>

					</c:forEach>

				</tr>
			</table>
		</div>


	<div id="eventContent" title="Event Details" style="display: none;">
		<p id="eventInfo"></p>
		Baþlangýç Tarihi: <span id="startTime"></span>
		<br> 
		Bitiþ Tarihi: <span id="endTime"></span><br>
		<br>
	</div>



	<div class="modal fade" id="randevuListModal" 
		tabindex="-1" role="dialog"	aria-labelledby="exampleModalLabel" style="color: black; font-size: 11px;" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>

						<h4 class="modal-title" id="exampleModalLabel">Randevu Listesi</h4>
					</div>

					<div class="modal-body">
		
		
		<table id="example" class="table table-bordered">
								<thead>
			
									<tr>
										<th>Hasta</th>
										<th>Randevu</th>
										<th>Açýklama</th>
										<th>Doktor Ad</th>
			
			
									</tr>
			
								</thead>
								<tbody>
									<c:forEach items="${randevuListesi}" var="randevu"
										varStatus="count">
			
										<tr>
											<td>${randevu.hasta.ad } ${randevu.hasta.soyad }   ${randevu.hasta.protokolNo }</td>
											<td>${randevu.randevuTarihiBaslangic} - ${randevu.randevuBitSaat}</td>
											<td>${randevu.aciklama }</td>
											<td>${randevu.doktor.dAd } ${randevu.doktor.dSoyad }</td>
			
			
			
										</tr>
			
			
									</c:forEach>
			
								</tbody>
			
			
			
							</table>
			

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" id="randevuListKapat" data-dismiss="modal">Kapat</button>
						
					</div>

				</div>
			</div>
		</div>
		
		
</body>
</html>