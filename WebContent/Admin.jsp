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

<script type="text/javascript">
	document.onmousedown = click;

	var times = 0;

	var times2 = 10;

	function click() {

		if ((event.button == 2) || (event.button == 3)) {

			if (times >= 1) {

			}

			alert("Sað týk çalýþmamaktadýr!");

			times++;
		}
	}
</script>

</head>
<body>
	<div>


		<c:if test="${sessionScope.sessionMember[0] eq null}">
			<%
				session.invalidate();
			%>
			<jsp:forward page="login4.jsp"></jsp:forward>


		</c:if>


		<nav id="navbar-darkblue" class="navbar navbar-inverse">


			<ul class="nav navbar-nav">
				<li><html:link page="/SubeEkleGuncelleSil.jsp" target="frame"> Þube Ekle Güncelle Sil </html:link></li>
				<li><html:link page="/KullaniciEkleGuncelleSil.jsp"
						target="frame"> Kullanýcý Ekle Güncelle Sil </html:link></li>

				<li><html:link page="/DoktorEkleGuncelleSil.jsp" target="frame"> Doktor Ýþlemleri </html:link></li>

				<li><html:link page="/GiderTuruEkle.jsp" target="frame"> Gider Türü Ekle Güncelle Sil  </html:link></li>


				<li><html:link page="/SubeOperasyonFiyatEslestir.jsp"
						target="frame">Tedavi Fiyat Tanýmla </html:link></li>


			</ul>
			
				<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
				
				
					<a class="dropdown-toggle"
						data-toggle="dropdown" href="#">
							${sessionScope.sessionMember[1].kuAd }
							${sessionScope.sessionMember[1].kuSoyad } - ${sube.sAd} <span
							class="caret"></span>
					</a>
	
					
					
					</li>
					
					<li><a href="cikis.jsp"> <i class="fa fa-sign-out" aria-hidden="true"></i>
							</a></li>

			</ul>



		</nav>

			<iframe name="frame" width="100%" height="900"
				frameborder="0" scrolling="auto"></iframe>
		<div id="alt">DF Grup &copy; 2012</div>
	</div>
</body>
</html>