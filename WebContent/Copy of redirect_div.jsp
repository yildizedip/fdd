<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title></title>

<style type="text/css">
body {
	background-image: url(Images/366_6.jpg);
	font-family: "Verdana", "Times New Roman", Times, serif;
	color: #666;
	background-repeat: repeat-x;
}

#main {
	background-color: #FFF;
	width: 1050px;
	margin-right: auto;
	margin-left: auto;
}

#menu {
	text-align: left;
	width: 220px;
	margin: 5px;
	float: left;
	font-size: 86%;
}

#menu h1 {
	display: block;
	background-color: #FF9900;
	font-size: 80%;
	padding: 3px 0 5px 3px;
	border: 1px solid #000000;
	color: #333333;
	margin: 0px;
	width: 220px;
	text-align: center;
}

#menu ul {
	list-style: none;
	margin: 0px;
	padding: 0px;
	border: none;
}

#menu ul li {
	margin: 0px;
	padding: 0px;
}

#menu ul li a {
	font-size: 85%;
	display: block;
	border-bottom: 1px dashed #C39C4E;
	padding: 4px 0px 4px 3px;
	text-decoration: none;
	color: #666666;
	width: 220px;
}

#menu ul li a:hover,#menu ul li a:focus {
	color: #000000;
	background-color: #eeeeee;
}

#icerik {
	margin: 2px;
	padding: 2px;
	float: left;
}

#icerikTemizle {
	clear: left;
}

#alt {
	margin: 5px;
	text-align: right;
	font-size: 70%;
}

#banner {
	margin: 2px;
}


</style>

<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>
<script language=JavaScript>
	document.onmousedown = click;

	var times = 0;

	var times2 = 10;

	function click() {

		if ((event.button == 2) || (event.button == 3)) {

			if (times >= 1) {

			}

			alert("Sa� t�k �al��mamaktad�r!");

			times++;
		}
	}
	


</script>
</head>
<body>
<div id="main"><c:if
	test="${sessionScope.sessionMember[0] eq null}">
	<%
		session.invalidate();
	%>
	<jsp:forward page="login4.jsp"></jsp:forward>
</c:if>

<div id="banner"><c:import url="FrameUstBaslik.jsp"></c:import></div>

<div id="menu"><c:choose>
	<c:when
		test="${(sessionScope.sessionMember[0].kuTur eq '1') || (sessionScope.sessionMember[0].kuTur eq '2')
				|| (sessionScope.sessionMember[0].kuTur eq '4')  }">

		<div id="menu">
		<h1>Hasta ��lemleri</h1>

		<ul>
			<li><a href="HastaEkle.jsp" target="frame">Hasta Ekle</a>
			<li><a href="HastaIslemleri.jsp?islem=4" target="frame">
			Hastaya Operasyon Ekle</a>
			<li><a href="HastaIslemleri.jsp?islem=2" target="frame">
			Hasta �deme Ekle</a>
			<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
			Hasta Operasyon Bitir - G�ncelle</a> 
			
			<!--  
					
					<li>
					<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
					Hastan�n Bitmi� Operasyonlar�n� Getir</a>
					<a href="HastaIslemleri.jsp?islem=7" target="frame">
					Hastan�n Devam Eden Operasyonunu Bitir</a>
					
			-->
			<li><a href="HastaIslemleri.jsp?islem=6" target="frame">
			Hasta �demeleri G�r�nt�le G�ncelle</a>
			<li><html:link action="/hastaSorgula.do" target="frame"> Hasta G�ncelle Sil</html:link>
			<li><html:link action="/operasyonuKesinlesmemisHastaListesi.do"
				target="frame"> Operasyonu Kesinle�memi� Hastalar </html:link></li>


			<!--  
					<li><a href="HastaIslemleri.jsp?islem=1" target="frame">
					Randevu Ekle</a>				
					<li><a href="HastaRandevuSorgulama.jsp" target="frame">Randevu Listesi G�r�nt�le</a>
					
					
					-->
		</ul>
		<br>
		<h1>Muhasebe ��lemleri</h1>
		<ul>
			<!-- <li><a href="GelirEkle.jsp" target="frame">Gelir Ekle</a></li> -->

			<li><a href="GiderEkle.jsp" target="frame">Gider Ekle</a></li>

			<!--  
					
					<li><a href="GelirSorgulama.jsp" target="frame">Gelir
					Sorgula</a></li>
					<li><a href="GiderSorgulama.jsp" target="frame">Gider
					Sorgula</a></li>
					<li><a href="GiderTuruEkle.jsp" target="frame">Gider T�r�
					Ekle</a></li>
					
					-->


			<li><a href="GunlukDurum.jsp" target="frame"> G�n Sonu
			Raporu</a></li>
			<li><a href="GelirRaporu.jsp" target="frame"> Gelir Raporu</a></li>
			<li><a href="GiderRaporu.jsp" target="frame"> Gider Raporu</a></li>

		</ul>
		<br>
		<h1>Raporlar</h1>
		<ul>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10"
				target="frame"> Hastalar�n Toplam �deme Durumu </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11"
				target="frame"> �demesi Bitmi� Hasta Listesi</html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12"
				target="frame"> Operasyonu Bitmi� Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13"
				target="frame"> Operasyonu Bitmi� �demesi Devam Eden Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=14"
				target="frame"> Operasyonu ve �demesi Bitmi� Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=15"
				target="frame"> Operasyonu Devam Eden �demesi Bitmi� Hasta Listesi </html:link></li>


		</ul>
		</div>
	</c:when>

	<c:when test="${sessionScope.sessionMember[0].kuTur eq '1' }">

		<h1>TANIMLAMALAR</h1>
		<ul>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10"
				target="frame"> �ube Ekle G�ncelle Sil </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11"
				target="frame"> Kullan�c� Ekle G�ncelle Sil </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12"
				target="frame"> Doktor Ekle G�ncelle Sil </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13"
				target="frame"> Gider T�r� Ekle G�ncelle Sil  </html:link></li>
			
		</ul>
	</c:when>
	<c:when test="${sessionScope.sessionMember[0].kuTur eq '3' }">

		<div id="menu">
		<h1>��LEMLER</h1>
		<ul>
			<li><a href="OperasyonListForDoktor.jsp" target="frame">Hastalar�m
			</a></li>
			<li><a href="GiderSorgulamaForDoctor.jsp" target="frame">Gider
			Durumum</a></li>
			<li><a href="GelirRaporu.jsp" target="frame"> Gelir Durumum</a></li>
			<li><html:link action="/operasyonuKesinlesmemisHastaListesi.do"
				target="frame"> Operasyonu Kesinle�memi� Hastalar </html:link></li>
		</ul>
		<h1>Raporlar</h1>
		<ul>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10"
				target="frame"> Hastalar�n Toplam �deme Durumu </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11"
				target="frame"> �demesi Bitmi� Hasta Listesi</html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12"
				target="frame"> Operasyonu Bitmi� Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13"
				target="frame"> Operasyonu Bitmi� �demesi Devam Eden Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=14"
				target="frame"> Operasyonu ve �demesi Bitmi� Hasta Listesi </html:link></li>
			<li><html:link action="/hastaBazliToplamOdemeListesi?tip=15"
				target="frame"> Operasyonu Devam Eden �demesi Bitmi� Hasta Listesi </html:link></li>


		</ul>

		</div>
	</c:when>

	<c:otherwise>
	</c:otherwise>
</c:choose></div>
<div id="icerik"><iframe src="Statistics.jsp" name="frame"
	width="770" height="520" frameborder="0" scrolling="auto"></iframe></div>
<div id="icerikTemizle"></div>
<div id="alt">Dicle F�rat Di� Polikli�i &copy; 2012</div>

</div>
</body>
</html>