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
<script src="js/fullcalendar.min.js"></script>
<script src='js/locale-all.js'></script>
<script src="script/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery.form-validator.min.js"></script>
<script type="text/javascript" src="js/jquery.maskedinput.min.js"></script>

<link type="text/css" rel="stylesheet" href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet" href="styles/nestable.css">


<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css"  />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.theme.css"  />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.structure.css"  />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css"  />


<script>

var val = [];


<c:forEach items="${selectedDoctor.doktorRandevuList}" var="randevu">

var event = {
	    "title":'${randevu.hasta.ad} ${randevu.hasta.soyad}',
	    "start": '${randevu.randevuTarihiBaslangic}',
	    "end": '${randevu.randevuTarihiBitis}' ,
		"description":'${randevu.aciklama}',
		"id" : '${randevu.id}',
		"dId" : '${selectedDoctor.dId}',
		"hastaTel"	: "${randevu.hasta.tel}",
		"hastaProtokol"	: "${randevu.hasta.protokolNo}",
		"tedavi"	: "${randevu.islemTipDto.ad}",
		"islem"	: "${randevu.islemDto.id}",
		"tedaviDisNo"	: "${randevu.islemDto.disNo}",
		"islemTipId"	: "${randevu.islemTipDto.id}",
		"geldimi"	: "${randevu.randevuyaGelinmedi}"
			
	}
       val.push(event);
</c:forEach>


<c:if test="${not empty warn }">

alert('${warn}')
</c:if>

	$(document).ready(
			function() {
				//$('#exampleModal').modal('show');

				var myLanguage = {
				        errorTitle: 'Form submission failed!',
				        requiredFields: 'You have not answered all required fields',
				        badTime: 'You have not given a correct time',
				        badEmail: 'You have not given a correct e-mail address',
				        badTelephone: 'You have not given a correct phone number',
				        badSecurityAnswer: 'You have not given a correct answer to the security question',
				        badDate: 'Lütfen tarih giriniz.',
				        lengthBadStart: 'The input value must be between ',
				        lengthBadEnd: ' karakter olmalý.',
				        lengthTooLongStart: 'The input value is longer than ',
				        lengthTooShortStart: 'Giriþ en az ',
				        notConfirmed: 'Input values could not be confirmed',
				        badDomain: 'Incorrect domain value',
				        badUrl: 'The input value is not a correct URL',
				        badCustomVal: 'The input value is incorrect',
				        andSpaces: ' and spaces ',
				        badInt: 'Lütfen numara giriþi yapýnýz',
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
				        imageRatioNotAccepted : 'Image ratio is not accepted',
					    
				};

				$.validate({
					language : myLanguage
				});
				

				 $('#example').DataTable( {
				        select: {
				            style: 'single'
				        }
				    } );

				 var table = $('#example').DataTable();

				    $('#example tbody').on('click', 'tr', function () {
				    	$('#example tbody tr').removeClass('selected');
				        $(this).toggleClass('selected');
				    });

				$('#buttonSec').click(function () {
				        var ids = $.map(table.rows('.selected').data(), function (item) {
				            return item
				        });
						
				    /*     $('#hastaad').val(ids[1]);
				        $('#hastasoyad').val(ids[2]);
				        $('#protokol').val(ids[0]);
				        $('#telefon').val(ids[3]);
				        $('#hastaId').val(ids[4]); */

				        var start= $('#start').val();
				        var end= $('#end').val();
				        var title= $('#title').val();

				        $('#randevuBasTar').val(start);
				        $('#randevuBitTar').val(end);
				        $('#randevuAciklama').val(title);
		        
				        $('#hasta_id').val(ids[4]);
				        $('#pageAction').val('randevu-getir');
				        $('#send').submit();
				 });



				$('#exampleModal').on('show.bs.modal', function (event) {
					  var button = $(event.relatedTarget) // Button that triggered the modal
					  var recipient = button.data('whatever') // Extract info from data-* attributes

					  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
					  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
					  var modal = $(this)
					  modal.find('.modal-body #recipient-name').val(recipient)
				});


				
				$('#calendar').fullCalendar(
						{
							header : {
								left : 'prev,next today',
								center : '',
								right : 'month,agendaWeek,agendaDay'
							},
							defaultView : 'agendaWeek',
							locale :"tr",
							theme :false,
							height: 900,
							fixedWeekCount:false,
							weekNumbers : true,
							navLinks : true, // can click day/week names to navigate views
							selectable : true,
							businessHours : false,
							minTime : "08:00:00",
							maxTime : "22:00:00",
							allDaySlot :  false,
							selectHelper : true,
							editable : true,
							slotEventOverlap : false,
							slotDuration : '00:30:00',
							contentHeight: 600,
							slotLabelFormat : 'H:mm',
							select : function(start, end) {
									
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
									$('#calendar').fullCalendar('unselect');

									
									$('#start').val(moment(eventData['start']).format("YYYY-MM-DD HH:mm"));
									$('#end').val(moment(eventData['end']).format("YYYY-MM-DD HH:mm"));

									//$("#islemTipi").val(9);
									//$('#title').text(eventData['title']);
									 $('#hastaEkleDialog').modal('show');

									 
										 

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
							 eventClick: function(calEvent, jsEvent, view) {

							        $(this).css('border-color', 'red');
							        $(this).css('font-size', '16px');
							        
							       // $('#start').val(moment(calEvent.start).format('YYYY-MM-DD HH:mm'));
								//	$('#end').val(moment(calEvent.end).format('YYYY-MM-DD HH:mm'));
								//	$('#title').html(calEvent.title);

							    },

							    eventResize :function(event) {

							    	$("#startTime").val(moment(event.start).format('YYYY-MM-DD HH:mm'));
									$("#endTime").val(moment(event.end).format('YYYY-MM-DD HH:mm'));
									
									$("#eventInfo").html(event.description);
									
									$("#ranId").val(event.id);
									$("#dId").val(event.dId);
									$("#hastaTel").html(event.hastaTel);
									$("#hastaProtokolNo").html(event.hastaProtokol);

									$("#tedavi").html(event.tedavi);
									$("#tedaviDisNo").html(event.tedaviDisNo);
									
									if(event.geldimi =='on')
										{
										$("#randevuyaGelinmedi").attr("checked", "checked");
										$("#ranGelmedi").css("background-color", "#F78181");
										
										}
									else 
										{
										$('#randevuyaGelinmedi').removeAttr('checked');
										$("#ranGelmedi").css("background-color", "white");
										}

									dialog=$("#eventContent").dialog({
										modal : true,
										title : event.title,
										width : 450,
										buttons: {
									        Kapat: function() {
									          dialog.dialog( "close" );
									        }
									      },
									    
									     
									});
								  
							    },
							    eventDrop :function(event) {

							    	$("#startTime").val(moment(event.start).format('YYYY-MM-DD HH:mm'));
									$("#endTime").val(moment(event.end).format('YYYY-MM-DD HH:mm'));
									
									$("#eventInfo").html(event.description);
									
									$("#ranId").val(event.id);
									$("#dId").val(event.dId);
									$("#hastaTel").html(event.hastaTel);
									$("#hastaProtokolNo").html(event.hastaProtokol);

									$("#tedavi").html(event.tedavi);
									$("#tedaviDisNo").html(event.tedaviDisNo);
									
									if(event.geldimi =='on')
										{
										$("#randevuyaGelinmedi").attr("checked", "checked");
										$("#ranGelmedi").css("background-color", "#F78181");
										
										}
									else 
										{
										$('#randevuyaGelinmedi').removeAttr('checked');
										$("#ranGelmedi").css("background-color", "white");
										}

									dialog=$("#eventContent").dialog({
										modal : true,
										title : event.title,
										width : 450,
										buttons: {
									        Kapat: function() {
									          dialog.dialog( "close" );
									        }
									      },
									    
									     
									});
								  
							    },
								eventRender : function(event, element) {
									$(element).css('background-color', '#0B6138');
									element.attr('href','javascript:void(0);');
									$(element).css('font-size', '16px');
									if(event.geldimi =='on')
									$(element).css('background-color', '#F78181');


									element.click(function() {

										$("#startTime").val(moment(event.start).format('YYYY-MM-DD HH:mm'));
										$("#endTime").val(moment(event.end).format('YYYY-MM-DD HH:mm'));
										
										$("#eventInfo").html(event.description);
										
										$("#ranId").val(event.id);
										$("#dId").val(event.dId);
										$("#hastaTel").html(event.hastaTel);
										$("#hastaProtokolNo").html(event.hastaProtokol);

										$("#tedavi").html(event.tedavi);
										$("#tedaviDisNo").html(event.tedaviDisNo);
										
										if(event.geldimi =='on')
											{
											$("#randevuyaGelinmedi").attr("checked", "checked");
											$("#ranGelmedi").css("background-color", "#F78181");
											
											}
										else 
											{
											$('#randevuyaGelinmedi').removeAttr('checked');
											$("#ranGelmedi").css("background-color", "white");
											}
											//$("#randevuyaGelinmedi").checked=false;
											//$("#randevuyaGelinmedi").attr("unchecked", "checked");

										dialog=$("#eventContent").dialog({
											modal : true,
											title : event.title,
											width : 450,
											buttons: {
										        Kapat: function() {
										          dialog.dialog( "close" );
										        }
										      },
										    
										     
										});
									});
								},
							events: val

						});


			    $(function () {
			        $('#btnAdd').bind('click', function () {
			        	var start = $('#start').val();
						var end = $('#end').val();
						var title= $('#title').val();

				        
			            $('#myTable').append(
					            '<tr>'+
					            '<td> '+ title +' </td>'+
					            '<td> '+ start +' </td>'+
					            '<td>'+ end +'</td>'+
			                    '<td> <button type="button" class="remove">Sil</button> </td>'+
			                                 '</tr>');
			        });
			        $('#myTable').on('click', '.remove', function() {
			            $(this).closest('tr').remove();
			        });
			    });

			    '<c:if test="${requestScope.actionTip eq 1}">' // hasta islemlerinden secilen hasta
 
				      $('#hastaInfo').html("Lütfen ${hastaListesi[0].ad} ${hastaListesi[0].soyad} hastanýn ${randevuTedavi.islemTip.ad}  tedavisi için randevu tarih ve saati seçiniz.");
	
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
				      $('#hastaSecButton').prop( "disabled", true );

			   ' </c:if> '
			    
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
				     
				      	$('#hastaSecButton').prop( "disabled", false );
				      	$('#hastaEkleDialog').modal('show');

			   ' </c:if> '


				 $('#islemTipi').on('change', function() {

					 '<c:forEach items="${hastaListesi[0].hastaSelectedDoktorOperasyonList}" var="islem">'
					 			
					 		if(this.value =='${islem.islemTip.id}')
						 		{
						 			 $('#tedaviTarih').val('${islem.islemTarihi}');
						 			 $('#tedaviUcret').val('${islem.miktar}');
						 			 $('#tedaviDisNo').val('${islem.disNo}');
						 			 $('#tedaviAciklama').val('${islem.aciklama}');
						 		}				 	
								
					 '</c:forEach>'

					 
				})

			
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
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 12px;
}

</style>

<title>Randevu Ekle</title>
</head>
<body>

	<form id="send" action="hastaSorgulaForRandevu.do" method="post">
		<input type="hidden" name="hastaId" id="hasta_id">
		<input type="hidden" name="islem" id="pageAction">
		<input type="hidden" name="doktorId" value="${selectedDoctor.dId}">
		<input type="hidden" name="randevuBasTar" id="randevuBasTar" >
		<input type="hidden" name="randevuBitTar" id="randevuBitTar" >
		<input type="hidden" name="randevuAciklama" id="randevuAciklama" >
		</form>

   	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb bg-success">
   	
                    <div class="page-header pull-left">
                        <div class="page-title" style="font-size: 18px;">
                            <span id="myDate"> </span> Hekim :  ${selectedDoctor.dAd} ${selectedDoctor.dSoyad} </div>
                    </div>
                   
                    <div class="clearfix">
                    </div>
    </div>
    
<div class="row">


<div class="modal fade " id="hastaEkleDialog" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" style="color: black;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
     				<div class="modal-header bg-success">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">RANDEVU EKLE</h4>
					</div>
				
				
					<form action="HastaRandevuEkle.do" method="post">
					<div class="modal-body">
					
					<input name="hastaId" id="hastaId" hidden="true"  >
					<input name="islemId" id="islemId" hidden="true"  >
					<input name="doktorId" id="doktorId" value="${selectedDoctor.dId}" hidden="true" >
					
												
							<div class="row">
								<div class="col-lg-5">
									<div class="form-group">
									
									<label for="inputName" class="control-label">Ad </label>
										<div class="input-icon">
										<i class="fa fa-user" aria-hidden="true"></i>
										
										<input class="form-control"  name="hastaAd"  placeholder="Hasta Ad"	id="hastaad" data-validation="required"  >
										
										</div>
										
									</div>
								</div>
								
									<div class="col-lg-5">
								<div class="form-group">
								<label for="inputName" class="control-label">Soyad </label>
									<div class="input-icon">
									<i class="fa fa-user" aria-hidden="true"></i>
									
										<input class="form-control"  name="hastaSoyad"  placeholder="Hasta Soyad "	id="hastasoyad" data-validation="required" >
												
									</div>
								</div>
								</div>
								
								<div class="col-lg-2">
									<div class="form-group">
									<label for="inputName" class="control-label"> </label>
									<div class="input-icon">
												<button type="button" class="btn btn-primary" id="hastaSecButton" data-toggle="modal" data-target="#exampleModal"  data-whatever="${hastaListesi[0].id}"> Seç</button>
									</div>
									</div>
								</div>
								
							</div>
							
							<div class="row">
								<div class="col-lg-5">
									<div class="form-group">
									<label for="inputName" class="control-label">Telefon </label>
									<div class="input-icon">
										<i class="fa fa-phone"></i>
											<input class="form-control"  name="telefon"  placeholder="Telefon Orn. 05051119922"	id="telefon" data-validation="required">
											
									</div>
									</div>
								</div>
								
								<div class="col-lg-3">
										<div class="form-group">
										<label for="inputName" class="control-label">Protokol No </label>
										<div class="input-icon">
										<i class="fa fa-pencil" aria-hidden="true"></i>
										
											<input class="form-control"  name="protokol"  placeholder="Protokol no"	id="protokol" readonly="readonly">
													
										</div>
										</div>
								</div>
								
							</div>
						
							<h4>Tedavi Bilgileri</h4>							  
							<div class="row">
								<div class="col-lg-12">
								<div class="form-group">
								<div class="input-icon">
								
										<select size="1" name="islem" id="islemTipi"
													class="form-control">
													<option label="Tedavi Seçiniz.." value="-1">
														Tedavi Seçiniz..</option>
														
													<c:forEach items="${hastaListesi[0].hastaSelectedDoktorOperasyonList}" var="islem">
														<option label="${islem.islemTip.ad}" value="${islem.islemTip.id}" >
															${islem.islemTip.ad}</option>
													</c:forEach>

										</select>
										
								</div>
								</div>
								</div>
							</div>
							<div class="row">
									<div class="col-lg-4">
										<div class="form-group">
										<label for="inputName" class="control-label">Tarih </label>
										<div class="input-icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
										
											<input class="form-control"  name="tedaviTarih"  placeholder="Tarih"	id="tedaviTarih" readonly="readonly">
													
										</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
										<label for="inputName" class="control-label">Ücret </label>
										<div class="input-icon">
										<i class="fa fa-try" aria-hidden="true"></i>
										
											<input class="form-control"  name="tedaviUcret"  placeholder="Ücret"	id="tedaviUcret" readonly="readonly">
													
										</div>
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
										<label for="inputName" class="control-label">Diþ No </label>
										<div class="input-icon">
										<i class="fa fa-pencil" aria-hidden="true"></i>
										
											<input class="form-control"  name="tedaviDisNo"  placeholder="Diþ No"	id="tedaviDisNo" readonly="readonly">
													
										</div>
										</div>
									</div>
							</div>
							<div class="row">
									<div class="col-lg-4">
										<div class="form-group">
										<label for="inputName" class="control-label">Açýklama</label>
										<div class="input-icon">
										<i class="fa fa-info" aria-hidden="true"></i>
										
											<input class="form-control"  name="tedaviAciklama"  placeholder="Açýklama"	id="tedaviAciklama" readonly="readonly">
													
										</div>
										</div>
							</div>
								
							<div class="clearfix"></div> 	
							<h4>Randevu Bilgileri</h4>
							 
								<div class="col-lg-6">
									<div class="form-group">
										<div class="input-icon">
										<i class="fa fa-calendar "></i>
											<input class="form-control" type="text" name="randevuTarihiBaslangic"  placeholder="Baþlangýç "	id="start" data-validation="required" >
										</div>
									</div>
								</div>
								
							
								
								<div class="col-lg-6">
									<div class="form-group">
										<div class="input-icon">
										<i class="fa fa-calendar "></i>
											<input class="form-control" type="text" name="randevuTarihiBitis" placeholder="Bitiþ" id="end" data-validation="required" >
										</div>
									</div>
								</div>
								
								
							
								
								<div class="col-lg-12">
									<div class="form-group">
												
												<textarea class="form-control" name="aciklama" 
													placeholder="Açýklama Giriniz" rows="2" 
													id="title" cols="40"></textarea>

									</div>
								</div>
								
								</div>
						</div>
							
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Kaydet" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>

				</div>
				</div>
				
</div>
		


		<div class="col-lg-12">
			<h4 id="hastaInfo" style="color: black">   </h4>
		</div>
		<div class="col-lg-12">
			<div id="calendar"></div>
		</div>
		


<!-- hasta sec modal -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        
        
        
        <h4 class="modal-title" id="exampleModalLabel">HASTA LÝSTESÝ</h4>
      </div>
      
      
      <div class="modal-body">
      			    <div class="panel-body">
                             <table id="example">
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
							        <c:forEach var="hasta" items="${hastaList}" >
							            <tr>
							                <td>${hasta.protokolNo }</td>
							                <td>${hasta.ad }</td>
							                <td>${hasta.soyad }</td>
							                <td>${hasta.tel }</td>
							                <td hidden="true">${hasta.id }</td>
							            </tr>
							            </c:forEach>
            
				            	</tbody> 
				            </table>

                      </div>
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" id="buttonSec" >Seç</button>
      </div>
      
    </div>
  </div>
</div>
	</div>
	
	
	
<div id="eventContent" title="Event Details" style="display: none;">
	
		<form action="hastaRandevuGuncelle.do" method="post" >
		<input  name="id"  type="hidden"	id="ranId" >
		<input  name="doktorId"  type="hidden"	id="dId" >
		
		<div class="form-body pal">
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<div class="input-icon" class="bg-info">
										
										Telefon : <span id="hastaTel" ></span>
										<br>
										Protokol No :<span id="hastaProtokolNo" ></span>
										<br>
										Tedavi :<span id="tedavi" ></span>
										<br>
										Diþ No :<span id="tedaviDisNo" ></span>
										
										</div>
										
									</div>
								</div>
							</div>
					
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<div class="input-icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
										
										<input class="form-control"  name="randevuTarihiBaslangic"  	id="startTime" >
										
										</div>
										
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<div class="input-icon">
										<i class="fa fa-calendar" aria-hidden="true"></i>
										
										<input class="form-control"  name="randevuTarihiBitis" 	id="endTime" >
										
										</div>
										
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<div class="input-icon">
										
										<textarea class="form-control" name="aciklama" id="eventInfo"
													placeholder="Açýklama Giriniz" rows="2" 
													 cols="50"></textarea>
										
										
										</div>
										
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<div class="input-icon">
										
											<div class="checkbox" id="ranGelmedi">
													<label> <input type="checkbox" id="randevuyaGelinmedi" name="randevuyaGelinmedi" />
														&nbsp; Randevuya Gelinmedi
													</label>
												</div>
										
										</div>
										
									</div>
								</div>
							</div>
							
							
							<div class="col-md-12">
							
										<div class="form-actions text-center pal">
										
										<input	type="submit" value="Guncelle" name="action" class="btn btn-primary" id="buttonsave" > 
										<input	type="submit" value="Sil" name="action" class="btn btn-primary" id="buttondelete" />
										
										</div>
							</div>
		
		</div>
				
		</form>
		
</div>


</body>
</html>