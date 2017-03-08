<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>..Poliklinik..</title>

<!-- Bootstrap Core CSS -->
<link href="sitil/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link href="sitil/light-bootstrap-dashboard.css" rel="stylesheet">

<!-- jQuery -->
<script src="scriptt/jquery.js"></script>
<script src="scriptt/bootstrap.min.js"></script>


<style type="text/css">



</style>

</head>
<body>

	<div class="wrapper">

		<nav id="navbar-darkblue" class="navbar navbar-inverse">


			<ul class="nav navbar-nav">



				<li class="active"><a target="" href="redirect_div.jsp"> <i
						class="fa fa-home" aria-hidden="true"></i>
				</a></li>
				<li class="active"><a target="frame"
					href="hastaGunlukRandevuSorgula.do"> <i class="fa fa-calendar "
						aria-hidden="true"></i> Randevu
				</a></li>
				<li class="active"><a target="frame"
					href="HastaIslemleri.jsp?islem=4"><i class="fa fa-user"></i>
						Hasta</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Muhasebe <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a target="frame" href="GiderEkle.jsp">Gider Ekle</a></li>
						<li><a target="frame" href="GunlukDurum.jsp">Gün Sonu
								Raporu</a></li>
						<li><a target="frame" href="GelirRaporu.jsp">Gelir Raporu</a></li>
						<li><a target="frame" href="GiderRaporu.jsp">Gider Raporu</a></li>
					</ul></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Rapor <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a target="frame"
							href="HastaBazliToplamOdemeListesi.jsp?tip=10">Hasta Detay
								Raporlarý</a></li>
						<li><a target="frame" href="HastaAramaKayitListesi.jsp">Arama
								Kaydý iþlemleri</a></li>
						<li><a target="frame" href="HastaAnketListesi.jsp">Anketler</a></li>
						<li><a target="frame"
							href="OperasyonuKesinlesmemisHastaListesi.jsp?tip=1">Tedavisi
								Kesinleþmemiþ Hastalar</a></li>
						<li><a target="frame" href="HastaBorcTarihleriListesi.jsp">Borçlu
								Tarihi Listesi</a></li>
					</ul></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
				
				
					<a class="dropdown-toggle"
						data-toggle="dropdown" href="#">
							${sessionScope.sessionMember[1].kuAd }
							${sessionScope.sessionMember[1].kuSoyad } - ${sube.sAd} <span
							class="caret"></span>
					</a>
	
						<ul class="dropdown-menu">
							<li>
								<button type="button" class="btn btn-info" data-toggle="modal"
									data-target="#myModal">Bilgilerim</button>
	
	
							</li>
							<li>
	
								<button type="button" class="btn btn-info" data-toggle="modal"
									data-target="#modalSifre">Þifremi Deðiþtir</button>
	
	
							</li>
							<li class="divider"></li>
							
						</ul>
					
					</li>
					
					<li><a href="cikis.jsp"> <i class="fa fa-sign-out" aria-hidden="true"></i>
							</a></li>

			</ul>

		</nav>

		<iframe src="main.jsp" name="frame" width="100%" height="900"
			frameborder="0" scrolling="auto"></iframe>

	</div>



	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg-success">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title " id="myModalLabel">Bilgilerimi
						Güncelle</h4>
				</div>

				<form action="KullaniciGuncelle.do?tip=kisiselBilgileriGuncelle"
					method="post">

					<div class="modal-body">


						<div>
							<label> Ad...........:</label> <input readonly="readonly"
								class="inputTextfield" name="ad"
								value="${sessionScope.sessionMember[1].kuAd}"> <input
								readonly="readonly" type="hidden" name="kuloginId"
								value="${sessionScope.sessionMember[1].kuLoginId}"> <input
								readonly="readonly" type="hidden" name="kuTur"
								value="${sessionScope.sessionMember[0].kuTur}">

						</div>
						<div>
							<label> Soyad......:</label> <input class="inputTextfield"
								readonly="readonly" name="soyad"
								value="${sessionScope.sessionMember[1].kuSoyad}">
						</div>
						<div>
							<label> Tel...........:</label> <input class="inputTextfield"
								name="tel" value="${sessionScope.sessionMember[1].kuTel}">
							*
						</div>
						<div>
							<label> Adres.......:</label>
							<textarea name="adres" rows="3" cols="20">${sessionScope.sessionMember[1].kuAdres}</textarea>
							*

						</div>
						<br> * : Güncellenebilir alan. <br>
						<div></div>



					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">Kapat</button>
						<input type="submit" class="btn btn-info" value="Güncelle">
					</div>

				</form>
			</div>
		</div>
	</div>



	<div class="modal fade" id="modalSifre" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg-success">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title " id="myModalLabel">Bilgilerimi
						Güncelle</h4>
				</div>


				<form name="SifreForm" action="SifremiGuncelle.do?" method="post"
					onsubmit="return validateSifreForm()">

					<div class="modal-body">


						<div>
							<label> Eski Þifre..............:</label> <input type="password"
								name="password"> <input type="hidden" name="kuloginId"
								value="${sessionScope.sessionMember[1].kuLoginId}">

						</div>
						<div>
							<label> Yeni Þifre..............:</label> <input type="password"
								name="newPassword">
						</div>
						<div>
							<label> Yeni Þifre Tekrar...:</label> <input type="password"
								name="reNewPassword">
						</div>


					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">Kapat</button>
						<input type="submit" class="btn btn-info" value="Güncelle">
					</div>

				</form>
			</div>
		</div>
	</div>



</body>
</html>