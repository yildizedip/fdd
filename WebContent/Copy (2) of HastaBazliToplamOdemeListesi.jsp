<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
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

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>
<title></title>

<style type="text/css">

/* CSS bilgilerim - sifre gunceller */

#close{
font-size: 10px;
}

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}

#boxes .window {
	position: fixed;
	left: 0;
	top: 0;
	width: 440px;
	height: 200px;
	display: none;
	z-index: 9999;
	padding: 20px;
}

#boxes #dialogBilgilerimiGuncelle {
	width: 390px;
	height: 280px;
	padding: 10px;	
	background-image: url("Images/untitled.png");
	background-repeat:repeat-x;
}

#boxes #dialogGunGir {
	width: 420px;
	height: 220px;
	padding: 10px;	
	background-color: white;
}

/*......................*/

/* CSS DROPDOWN LIST MENU BASLA */

</style>



<script type="text/javascript">
 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("basTar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bitTar"));
					<%Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);
			System.out.println("EDİP" + date);

			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			if (basTar == null) {
				String[] str = date.split("\\.");

				basTar = str[0] + "." + str[1] + ".01";

				//basTar="2010"+"."+"01"+".01";

			}
			if (bitTar == null)
				bitTar = date;%>	
				
					document.getElementById("basTar").value="<%=basTar%>";
					document.getElementById("bitTar").value="<%=bitTar%>";
	}

	function mainmenu() {
		$(" #nav ul ").css({
			display : "none"
		});
		$(" #nav li").hover(function() {
			$(this).find('ul:first').css({
				visibility : "visible",
				display : "none"
			}).show(400);
		}, function() {
			$(this).find('ul:first').css({
				visibility : "hidden"
			});
		});
	}

	$(document).ready(function() {
		mainmenu();

		//select all the a tag with name equal to modal
		$('a[name=modal]').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			//Get the A tag
			var id = $(this).attr('href');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set heigth and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//transition effect		
			$('#mask').fadeIn(1000);
			$('#mask').fadeTo("slow", 0.8);

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			$(id).css('top', winH / 2 - $(id).height() / 2);
			$(id).css('left', winW / 2 - $(id).width() / 2);

			//transition effect
			$(id).fadeIn(2000);

		});

		//if close button is clicked
		$('.window .close').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			$('#mask').hide();
			$('.window').hide();
		});

		//if mask is clicked
		$('#mask').click(function() {
			$(this).hide();
			$('.window').hide();
		});

		$(window).resize(function() {

			var box = $('#boxes .window');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set height and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			box.css('top', winH / 2 - box.height() / 2);
			box.css('left', winW / 2 - box.width() / 2);

		});

	});

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
						id="bitTar"></td>
				</tr>

				<tr>
					<td colspan="7" style="text-align: center;"><input
						type="submit" value="Sorgula" name="bnt_gonder" /></td>
				</tr>
			</table>

		</form>

		<div id="demo">

			<table class="sofT" id="example" cellpadding="0" cellspacing="0"
				border="0">
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
							<td class="helpBodSmall">${count.count}</td>
							<td class="helpBodSmall">${odeme.hasta.protokolNo}</td>

							<td class="helpBodSmall">${odeme.hasta.ad}
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



							<td class="helpBod">  <a name="modal" href="#dialogGunGir" target="frame">	Gün Gir</a>   </td>
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


					</tr>

				</tfoot>

			</table>
		</div>




	</div>

	<!-- BOXESSSSS -->

	<div id="boxes">

		<div id="dialogGunGir" class="window">

			<form name="SifreForm" action="SifremiGuncelle.do?" method="post"
				onsubmit="return validateSifreForm()">
				<div id="guncelle">
					ŞİFREMİ GÜNCELLE
					<hr>
					<div>
						<label> Deneme Şifre..............:</label> 
						
						<input type="text" value=" ${tempOdeme.ucret} aaa"	name="password"> 
							
							
							<input type="hidden" name="kuloginId"
							value="${sessionScope.sessionMember[1].kuLoginId}">

					</div>
					<div>
						<label> Yeni Şifre..............:</label> <input type="password"
							name="newPassword">
					</div>
					<div>
						<label> Yeni Şifre Tekrar...:</label> <input type="password"
							name="reNewPassword">
					</div>
					<br>
					<hr>
					<div>
						<input type="submit" value="Güncelle">
					</div>
				</div>
			</form>

			<div>
				<a id="close" href="#" class="close"> Kapat </a>
			</div>

		</div>
		<!-- SIFREMI GUNCELLE DIV -->

		<!-- Do not remove div#mask, because you'll need it to fill the whole screen -->
		<div id="mask"></div>

	</div>

</body>
</html>