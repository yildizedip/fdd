<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles"%>

<%@ page import="java.util.Enumeration"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-9">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>Dicle Fırat</title>

</head>
<body>
	<tiles:insert attribute="header" />

	<div id="wrapper">

		<tiles:insert attribute="menu" />

		
		<div id="page-wrapper">


			<!--BEGIN CONTENT-->
			<div class="page-content">
				<div id="tab-general">
					<div class="row mbl">
						<div class="col-lg-12">

							<div class="col-md-12">
								<div id="area-chart-spline"
									style="width: 100%; height: 300px; display: none;"></div>
							</div>

						</div>
						
						<tiles:insert attribute="body" />

					</div>
				</div>
			</div>
			<!--END CONTENT-->
			<!--BEGIN FOOTER-->
			<tiles:insert attribute="footer" />
		</div>

		<!--END FOOTER-->
	</div>
	<!--END PAGE WRAPPER-->




	<div id="dialogInfo" title="Bilgilerimi Güncelle">

		<form action="KullaniciGuncelle.do?tip=kisiselBilgileriGuncelle"
			method="post">

			<div id="guncelle">
				BİLGİLERİM
				<hr>
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
				<div>
					<input type="submit" value="Güncelle">
				</div>
			</div>
		</form>

	</div>

	<div id="dialogSifremiDegistir" title="Şifremi Güncelle">

		<form name="SifreForm" action="SifremiGuncelle.do?" method="post"
			onsubmit="return validateSifreForm()">
			<div>
				<label> Eski Şifre..............:</label> <input type="password"
					name="password"> <input type="hidden" name="kuloginId"
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
			<hr>
			<div>
				<input type="submit" value="Güncelle">
			</div>
		</form>

	</div>

</body>
</html>