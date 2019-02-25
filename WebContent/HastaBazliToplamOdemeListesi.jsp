<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" 	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

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


<title></title>

<script type="text/javascript">



 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("basTar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bitTar"));
		
					
					<%  Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);

			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			
			if (basTar == null) {
				String[] str = date.split("\\.");

				basTar = str[0] + "." + str[1] + ".01";

				//basTar="2010"+"."+"01"+".01";

			}
			if (bitTar == null)
				bitTar = date; 
				%>	
				
			
					
	}


	$("document")
			.ready(
					function() {
						$('#tablo')
								.dataTable(
										{

											sPaginationType : "full_numbers",
											"iDisplayLength" : -1,
											"aLengthMenu" : [
													[ 25, 50, 100, -1 ],
													[ 25, 50, 100, "Hepsi" ] ],
											"oLanguage" : {

												"sLengthMenu" : "_MENU_ ",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Ara",
												"sPrevious" : "Önceki",
												"sEmptyTable" : "Veri Bulunamadı"

											}
										});

					});
	
	
	$(function() {

		$("#dialog").dialog({
			autoOpen : false,
			width: 600,
			
			show : {
				effect : "blind",
				duration : 1000
			},
			hide : {
				effect : "explode",
				duration : 1000
			}
			,
			open: function( event, ui ) {
			      $("#borcForm").validate();
		    }


		});

		$('.gunGir').click(function(){
	         var row = $(this).parents('tr');
	      
	    	 var sira=   $(row.children().get(0)).text();
	    	 var protokol=   $(row.children().get(1)).text();
	    	 var adSoyad=   $(row.children().get(2)).text();
	    	 
	    	 var operasyon=   $(row.children().get(4)).text();
	    	 
	    	 var ucret=   $(row.children().get(6)).text();
	    	 var kalan=   $(row.children().get(8)).text();
	    	 var islemId=   $(row.children().get(11)).text();
	   
	    	 
	    	   $('#protokol').val(protokol);
	    	   $('#islemId').val(islemId);
	           $('#adSoyad').val(adSoyad);
	           $('#operasyon').val(operasyon);
	           $('#ucret').val(ucret);
	           $('#kalan').val(kalan);
	           $('#kalan2').val(kalan);
	    	 
	    	 
	    	 
	        $('#dialog').dialog('open');
	        return false;
	    });
	});
	
	
	$(function() {

	    $.datepicker.setDefaults($.datepicker.regional['tr']);
	    $( "#datepicker" ).datepicker( 
	    		{ dateFormat: 'yy.mm.dd'}
		
	    
	    );
	 });


	$("#borcForm").validate({

	    rules: {
	    	miktar: {
	            required: true	           
	        }
	      
	    },

	    messages: {
	    	miktar: "Please enter a valid email address",
	      },


	    submitHandler: function(form) {
	        form.submit();
	    }
	});
	
</script>



</head>
<body style="background-color: white; color: black;">


		<form action="hastaBazliToplamOdemeListesi.do"	method="post">
		
		
				<div class="col-lg-4 ">
			
				<div class="panel panel-default">  
				<div class="panel-heading"> Sorgula </div>
				
				<div class="panel-body">  
				
				
						
						<div class="form-group">
							
							<div class="row"> 
							
								<div class="col-lg-6" > <input class="form-control"	name="protokol" id="protokol" placeholder="Protokol No"> </div>
							
							</div>
						</div>
			
						<div class="form-group">
								<!--  
																	 <select size="1" name="tip" class="form-control">
																			<option label="Hastaların Toplam Ödeme Durumu" value="10">Hastaların Toplam Ödeme Durumu</option>
																			<option label="Tedavisi Bitmiş Hasta Listesi" value="12">Tedavisi Bitmiş Hasta Listesi</option>
																			<option label="Tedavisi Devam Eden Hasta Listesi" value="16">Tedavisi Devam Eden Hasta Listesi</option>
																			<option label="Ödemesi Bitmiş Hasta Listesi" value="11">Ödemesi Bitmiş Hasta Listesi</option>
																			<option label="Ödemesi Devam Eden Hasta Listesi" value="17">Ödemesi Devam Eden Hasta Listesi</option>
																			<option label="Tedavisi Bitmiş Ödemesi Devam Eden Hasta Listesi" value="13">Tedavisi Bitmiş Ödemesi Devam Eden Hasta Listesi</option>
																			<option label="Tedavisi ve Ödemesi Bitmiş Hasta Listesi" value="14">Tedavisi ve Ödemesi Bitmiş Hasta Listesi</option>
																			<option label="Tedavsi Devam Eden Ödemesi Bitmiş Hasta Listesi" value="15">Tedavsi Devam Eden Ödemesi Bitmiş Hasta Listesi</option>
												
																	</select>
																	
																	-->
							
							 <select size="1" name="tip" class="form-control">
																			<option label="Hastaların Ödeme Durumu" value="10">Hastaların Ödeme Durumu</option>
																			<option label="Tedavisi Bitmiş Hastalar" value="12">Tedavisi Bitmiş Hastalar</option>
																			<option label="Tedavisi Devam Eden Hastalar" value="16">Tedavisi Devam Eden Hastalar</option>
																			<option label="Tedavisi Devam Eden Hastalar (Ödemesi Bitmiş)" value="15">Tedavisi Devam Eden Hastalar (Ödemesi Bitmiş)</option>
																			<option label="Borçlu Hastalar (Tedavisi Biten)" value="13" >Borçlu Hastalar (Tedavisi Biten)</option>
																			<option label="Borçlu Hastalar (Tedavisi Devam Eden)" value="17" >Borçlu Hastalar (Tedavisi Devam Eden)</option>
							</select>
						</div>
						<div class="form-group">
							
							<div class="row"> 
							
							<div class="col-lg-6" > <input class="form-control"	name="basTar" id="basTar" placeholder="Ödeme Baş. Tarihi"> </div>
							<div class="col-lg-6" align="left">  <input  class="form-control" name="bitTar" id="bitTar" placeholder="Ödeme Bitiş Tarihi">  </div>
						</div>
					
					<div class="form-group">
						<br>
						<button type="submit" class="btn btn-info btn-sm">Gönder</button>
					
					</div>
					</div>
				</div>
				</div>
				</div>
		
		</form>
		
		<div class="clearfix"></div>
		
		<c:if test="${!empty hastaBazliToplamOdemeListesi}">
		
			<table class="table table-bordered table-striped" id="tablo" style="font-size:small;">
				<thead>
				<tr class="bg-info" >
				<td colspan="12" align="center">
					<c:choose>
							<c:when test="${requestScope.raporIslemTipi eq '10' }"> Hasta Tedavi Ödeme Listesi</c:when>
							<c:when test="${requestScope.raporIslemTipi eq '11' }"> Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '12' }"> Tedavisi Bitmiş Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '13' }"> Tedavisi Bitmiş Ödemesi Devam Eden Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '14' }"> Tedavisi ve Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '15' }"> Tedavisi Devam Eden Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '16' }"> Tedavisi Devam Eden Hasta Listesi </c:when>
							<c:when test="${requestScope.raporIslemTipi eq '17' }"> Ödemesi Devam Eden Hasta Listesi </c:when>

						</c:choose>
				 </td>
				</tr>
				
					<tr >
						<th></th>
						<th> Prt. No</th>
						<th class="">Hasta</th>
						<th class="">Doktor</th>
						<th class="">Tedavi</th>
						<th class="">Tedavi Tarihi</th>
						<th  class="">Tedavi Ücret</th>
						<th  class="">Ödemeler</th>
						<th  class="">Kalan Miktar</th>
						<th class="">Ödeme  Tarihleri</th>
					
						<th class=""> </th>
						<th width="0px" style="border-color: white;" ></th>
						<!-- 
			<th width="70px" class="">Doktor Hes.</th>	
			
			<th width="70px" class="">Sirket Hes.</th>	
			 -->


					</tr>
				</thead>
				<tbody>
					<c:forEach items="${hastaBazliToplamOdemeListesi}" var="odeme"	varStatus="count">

						<tr>
							<td>${count.count}</td>
							<td>${odeme.hasta.protokolNo}</td>
							<td>${odeme.hasta.ad}	${odeme.hasta.soyad} - ${odeme.hasta.tel}</td>
							<td>${odeme.doktor.dAd} 	${odeme.doktor.dSoyad}</td>
							<td>${odeme.islemTip.ad} (${odeme.islem.disAdet}) - ${odeme.islem.durumuStr} </td>
							<td class="">${odeme.islem.islemTarihiStr}	${odeme.islem.islemBitisTarihiStr}</td>
							<td class="">${odeme.ucret}</td>
							
							
							<td class=""><c:forEach
									items="${odeme.islem.odemeListStr}" var="odemeler">
											${odemeler}<br>
								</c:forEach>
							</td>
								
							<td class="">${odeme.kalanMiktar}</td>
							<td class=""><c:forEach
									items="${odeme.islem.odemeTarihListStr}" var="odemeler">
									${odemeler}<br>


								</c:forEach></td>

							<!--  
								<td style=" font-size: 9px " class="">${odeme.doktorHesap} </td>
								<td style=" font-size: 9px " class="">${odeme.sirketHesap} </td>
							-->

						<td class="">  <a id="opener" class="gunGir"> Gün Gir</a>  </td>
				
						<td width="1px"  style="font-size:1px; visibility: hidden;">${odeme.islem.id}</td>
				
						</tr>

					</c:forEach>
				</tbody>

				<tfoot>

					<tr>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th>TOPLAM</th>

						<th style="font-size: 10px; color: Blue;">${toplamUcret}</th>
						<th style="font-size: 10px; color: Blue">${toplamMiktar}</th>
						<th style="font-size: 10px; color: Blue"> ${toplamKalanMiktar}</th>
							<th></th>
							<th style="border-color: white;"></th>
					</tr>

				</tfoot>

			</table>
			
			</c:if>



<div class="dialog" id="dialog" title="Hasta Borç Tarihi Ekleme">

		<form name="borcForm" id="borcForm" action="borcOdemeTarihEkle.do" method="post" onsubmit="return validateForm()">
        <table>
           
            <tr>
                <td> Ad-Soyad </td>
                <td>
                <input type="text" name="adSoyad" id="adSoyad" disabled="disabled" />
                <input type="hidden" name="islemId" id="islemId" />
                
                </td>
                
            </tr>
            <tr>
                <td>Operasyon </td>
                <td><input type="text" name="operasyon" id="operasyon" disabled="disabled" /></td>
                
            </tr>
            <tr>
                <td>Toplam Ücret </td>
                <td><input type="text" name="ucret" id="ucret" disabled="disabled" /></td>
                
            </tr>
            <tr>
                <td>Kalan Miktar </td>
                <td>
                <input type="hidden" name="kalan" id="kalan"  />
                <input type="text" name="kalan2" id="kalan2" disabled="disabled" />
                </td>
                
            </tr>
            <tr>
                <td>Borcun Ödeneceği Tarih:  </td>
                <td> <input type="text" id="datepicker" name="borcOdemeTarihiStr" tabindex="-1"> </td>
                
            </tr>
            <tr>
                <td>Borcun Ödeneceği Miktar:  </td>
                <td> <input type="text" name="miktar" id="miktar" > TL </td>
                
            </tr>
            <tr>
                <td>Açıklama :  </td>
                <td> <textarea id="aciklama" name="aciklama"  cols="30" rows="3"></textarea> </td>
                
            </tr>
           
            <tr>
                <td> </td>
                <td> <input type="submit"  value="Kaydet"> </td>
                
            </tr>
        </table>
    </form>

	</div>
 

</body>
</html>