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
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
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
						$('#example')
								.dataTable(
										{

											sPaginationType : "full_numbers",
											"iDisplayLength" : -1,
											"aLengthMenu" : [
													[ 25, 50, 100, -1 ],
													[ 25, 50, 100, "Hepsi" ] ],
											"oLanguage" : {

												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
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
	    	 var operasyon=   $(row.children().get(3)).text();
	    	 var ucret=   $(row.children().get(9)).text();
	    	 var kalan=   $(row.children().get(11)).text();
	    	 var islemId=   $(row.children().get(13)).text();
	   
	    	 
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
			
			<div class="col-lg-6"> 

<div class="panel panel-blue" >
                                            <div class="panel-heading">
                                                Sorgulama</div>
                                            <div class="panel-body pan">
                                                <div class="form-body pal">
                                                
                                                 <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <label for="inputName" class="control-label">
                                                                    Rapor Tipi </label>
                                                                   
                                                                    
                                                                    <select size="1" name="tip" class="form-control">
																			<option label="Hastaların Toplam Ödeme Durumu" value="10"></option>
																			<option label="Tedavisi Bitmiş Hasta Listesi" value="12"></option>
																			<option label="Tedavisi Devam Eden Hasta Listesi" value="16"></option>
																			<option label="Ödemesi Bitmiş Hasta Listesi" value="11"></option>
																			<option label="Ödemesi Devam Eden Hasta Listesi" value="17"></option>
																			<option label="Tedavisi Bitmiş Ödemesi Devam Eden Hasta Listesi" value="13"></option>
																			<option label="Tedavisi ve Ödemesi Bitmiş Hasta Listesi" value="14"></option>
																			<option label="Tedavsi Devam Eden Ödemesi Bitmiş Hasta Listesi" value="15"></option>
												
																	</select>
                                                                   
                                                                    
                                                            </div>
                                                        </div>
                                                      
                                                    </div>
                                                
                                                
                                                
                                                 <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="inputName" class="control-label">
                                                                    Ödeme Başlangıç Tarihi </label>
                                                                <div class="input-icon right">
                                                                    <i class="fa fa-calendar"></i>
                                                                   <input class="form-control"	name="basTar" id="basTar">
                                                                    
                                                                 </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="inputEmail" class="control-label">
                                                                    Ödeme Bitiş Tarihi</label>
                                                                <div class="input-icon right">
                                                                    <i class="fa fa-calendar"></i>
                                                                    <input  class="form-control" name="bitTar" id="bitTar"> 
                                                                    </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                
                                                 
                                                </div>
                                                <div class="form-actions text-right pal">
                                                    <button type="submit" class="btn btn-primary">
                                                        Sorgula</button>
                                                </div>
                                            </div>
                                        </div>
 </div>

		</form>
		
		<div class="clearfix"></div>
		<h4>
		
		
		
		 </h4>

			<table class="table table-bordered" id="example" style="font-size: 15px;" >
				<thead>
				<tr class="bg-warning" >
				<td colspan="13" align="center">
					<c:choose>
							<c:when test="${requestScope.raporIslemTipi eq '10' }"> Hastaların Toplam Ödeme Durumu</c:when>
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
				
					<tr  >
						<th class=""></th>
						<th class="">Prt. No</th>
						<th class="">Hasta</th>
						<th class="">İşlem</th>
						<th class="">Adet</th>
						<th class="">Doktor</th>
						<th width="77px" class="">İşlem T.</th>


						<th width="20px" class="">Öd. Miktarları</th>
						<th width="107px" class="">Öd. Trhleri</th>
						<th width="70px" class="">Ücret</th>
						<th width="70px" class="">Öd. Mik.</th>

						<th width="70px" class="">Kal. Mik.</th>
					
						<th width="70px" class=""></th>
						<th width="0px" style="border-color: white;" ></th>
						<!-- 
			<th width="70px" class="">Doktor Hes.</th>	
			
			<th width="70px" class="">Sirket Hes.</th>	
			 -->


					</tr>
				</thead>
				<tbody>
					<c:forEach items="${hastaBazliToplamOdemeListesi}" var="odeme"			varStatus="count">

						<tr>
							<td class="">${count.count}</td>
							<td class="">${odeme.hasta.protokolNo}</td>

							<td class="">${odeme.hasta.ad}
								${odeme.hasta.soyad} - ${odeme.hasta.tel}</td>
							<td class="">${odeme.islemTip.ad}</td>
							<td class="">${odeme.islem.disAdet}</td>
							<td class="">${odeme.doktor.dAd}
								${odeme.doktor.dSoyad}</td>
							<td class="">${odeme.islem.islemTarihiStr}
								${odeme.islem.islemBitisTarihiStr}</td>
							<td class=""><c:forEach
									items="${odeme.islem.odemeListStr}" var="odemeler">
											${odemeler}<br>
								</c:forEach></td>

							<td class=""><c:forEach
									items="${odeme.islem.odemeTarihListStr}" var="odemeler">
									${odemeler}<br>


								</c:forEach></td>

							<td class="">${odeme.ucret}</td>



							<td class="">${odeme.miktar}</td>


							<td class="">${odeme.kalanMiktar}</td>

							<!--  
								<td style=" font-size: 9px " class="">${odeme.doktorHesap} </td>
								<td style=" font-size: 9px " class="">${odeme.sirketHesap} </td>
							-->

						<td class="">  <a id="opener" class="gunGir"> Gün Gir</a>  </td>
				
						<td width="1px"  style="font-size:1px; visibility: hidden; border-color: white;">${odeme.islem.id}</td>
				
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
						<th></th>
						<th></th>
						<th></th>
						<th>TOPLAM</th>

						<th style="font-size: 10px; color: Blue;">${toplamUcret}</th>
						<th style="font-size: 10px; color: Blue">${toplamMiktar}</th>
						<th style="font-size: 10px; color: Blue">
							${toplamKalanMiktar}</th>
							<th></th>
							<th style="border-color: white;"></th>


					</tr>

				</tfoot>

			</table>



<div id="dialog" title="Hasta Borç Tarihi Ekleme">

		<form name="borcForm" id="borcForm" action="borcOdemeTarihEkle.do" method="post" onsubmit="return validateForm()">
        <table>
            <tr>
                <td> Protokol No : </td>
                <td><input type="text" name="protokol" id="protokol" disabled="disabled" /></td>
                <td><input type="hidden" name="islemId" id="islemId" /></td>
                
            </tr>
            <tr>
                <td> Ad-Soyad </td>
                <td><input type="text" name="adSoyad" id="adSoyad" disabled="disabled" /></td>
                
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
                <td> <textarea id="aciklama" name="aciklama"  cols="60" rows="10"></textarea> </td>
                
            </tr>
           
            <tr>
                <td>Kaydet </td>
                <td> <input type="submit"  value="Kaydet"> </td>
                
            </tr>
        </table>
    </form>

	</div>
 

</body>
</html>