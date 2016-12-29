<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" 	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

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
<body id="dt_example">

<div id="container">
		<table>
			<tr>
				<td>
					<h1>
						<c:choose>
							<c:when test="${param.tip eq '10' }"> Hastaların Toplam Ödeme Durumu</c:when>
							<c:when test="${param.tip eq '11' }"> Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${param.tip eq '12' }"> Operasyonu Bitmiş Hasta Listesi </c:when>
							<c:when test="${param.tip eq '13' }"> Operasyonu Bitmiş Ödemesi Devam Eden Hasta Listesi </c:when>
							<c:when test="${param.tip eq '14' }"> Operasyonu ve Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${param.tip eq '15' }"> Operasyonu Devam Eden Ödemesi Bitmiş Hasta Listesi </c:when>
							<c:when test="${param.tip eq '16' }"> Operasyonu Devam Eden Hasta Listesi </c:when>
							<c:when test="${param.tip eq '17' }"> Ödemesi Devam Eden Hasta Listesi </c:when>

						</c:choose>
					</h1>
				</td>
				<td style="width: 51px;"><input type="button"
					style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
					onclick="window.print()"></td>
			</tr>
		</table>


		<form
			<c:choose>
		<c:when test="${param.tip eq '10' }"> action="hastaBazliToplamOdemeListesi.do?tip=10"</c:when>
		<c:when test="${param.tip eq '11' }"> action="hastaBazliToplamOdemeListesi.do?tip=11" </c:when>
		<c:when test="${param.tip eq '12' }"> action="hastaBazliToplamOdemeListesi.do?tip=12"</c:when>
		<c:when test="${param.tip eq '13' }"> action="hastaBazliToplamOdemeListesi.do?tip=13" </c:when>
		<c:when test="${param.tip eq '14' }"> action="hastaBazliToplamOdemeListesi.do?tip=14" </c:when>
		<c:when test="${param.tip eq '15' }"> action="hastaBazliToplamOdemeListesi.do?tip=15" </c:when>
		<c:when test="${param.tip eq '16' }"> action="hastaBazliToplamOdemeListesi.do?tip=16" </c:when>
		<c:when test="${param.tip eq '17' }"> action="hastaBazliToplamOdemeListesi.do?tip=17" </c:when>
		
		</c:choose>
			method="post">
			<table class="sorgulama">
				<tr>
					<td colspan="7" style="text-align: center;">HASTA SORGULA</td>
				</tr>
				<tr>
					<td>Protokol No</td>
					<td><input class="inputTextfield" name="protokolNo"
						id="hstProtokol" /></td>
					<td>Ad</td>
					<td><input class="inputTextfield" name="ad" id="hstProtokol" /></td>
					<td>Soyad</td>
					<td><input class="inputTextfield" name="soyad"
						id="hstProtokol" /></td>
				</tr>
				<tr>
					<td style="width: 56px;">Ödeme Tarihi :</td>
					<td style="width: 164px;"><input class=inputTextfield
						name="basTar" id="basTar"></td>
					<td>/</td>
					<td colspan="4"><input class=inputTextfield name="bitTar"
						id="bitTar">  Ödeme tarihine göre arama yapıldığında sadece o tarihler arasında ki ödemeler görünür!  </td>
				</tr>

				<tr>
					<td colspan="7" style="text-align: center;"><input
						type="submit" value="Sorgula" name="bnt_gonder" /></td>
				</tr>
				<tr>
					<td colspan="7" style="text-align: center; color: red; text-shadow:aqua;">  ${warn}  </td>
				</tr>
			</table>

		</form>

		<div id="demo">

			<table class="sofT" id="example" cellpadding="0" cellspacing="0"	border="0">
				<thead>
					<tr>
						<th class="helpHed"></th>
						<th class="helpHed">Prt. No</th>
						<th class="helpHed">Hasta</th>
						<th class="helpHed">İşlem</th>
						<th class="helpHed">Adet</th>
						<th class="helpHed">Doktor</th>
						<th width="77px" class="helpHed">İşlem T.</th>


						<th width="20px" class="helpHed">Öd. Miktarları</th>
						<th width="107px" class="helpHed">Öd. Trhleri</th>
						<th width="70px" class="helpHed">Ücret</th>
						<th width="70px" class="helpHed">Öd. Mik.</th>

						<th width="70px" class="helpHed">Kal. Mik.</th>
					
						<th width="70px" class="helpHed">Ödeme Gün Ekle</th>
							<th width="1px"class="helpHed" ></th>
						<!-- 
			<th width="70px" class="helpHed">Doktor Hes.</th>	
			
			<th width="70px" class="helpHed">Sirket Hes.</th>	
			 -->


					</tr>
				</thead>
				<tbody>
					<c:forEach items="${hastaBazliToplamOdemeListesi}" var="odeme"
						varStatus="count">

						<tr>
							<td class="helpBod">${count.count}</td>
							<td class="helpBod">${odeme.hasta.protokolNo}</td>

							<td class="helpBod">${odeme.hasta.ad}
								${odeme.hasta.soyad} - ${odeme.hasta.tel}</td>
							<td class="helpBod">${odeme.islemTip.ad}</td>
							<td class="helpBod">${odeme.islem.disAdet}</td>
							<td class="helpBod">${odeme.doktor.dAd}
								${odeme.doktor.dSoyad}</td>
							<td class="helpBod">${odeme.islem.islemTarihiStr}
								${odeme.islem.islemBitisTarihiStr}</td>
							<td class="helpBod"><c:forEach
									items="${odeme.islem.odemeListStr}" var="odemeler">
											${odemeler}<br>
								</c:forEach></td>

							<td class="helpBod"><c:forEach
									items="${odeme.islem.odemeTarihListStr}" var="odemeler">
									${odemeler}<br>


								</c:forEach></td>

							<td class="helpBod">${odeme.ucret}</td>



							<td class="helpBod">${odeme.miktar}</td>


							<td class="helpBod">${odeme.kalanMiktar}</td>
							


							<!--  
		<td style=" font-size: 9px " class="helpBod">${odeme.doktorHesap} </td>
			
			<td style=" font-size: 9px " class="helpBod">${odeme.sirketHesap} </td>
		-->



				<td class="helpBod">  <a id="opener" class="gunGir"> Gün Gir</a>  </td>
				
				<td class="helpBod" width="1px"  style="font-size:1px; visibility: hidden; ">${odeme.islem.id}</td>
				
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
							<th></th>


					</tr>

				</tfoot>

			</table>
		</div>

	</div>


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