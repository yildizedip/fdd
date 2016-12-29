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
#menu {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 79%;
	width: 245px;
	padding: 0px;
	margin: 0px;
	text-align:left;	
	background-color: white;
}

#menu h1 {
	display: block;
	background-color: #FF9900;
	font-size: 80%;
	padding: 3px 0 5px 3px;
	border: 1px solid #000000;
	color: #333333;
	margin: 0px;
	width: 245px;
	text-align:center;
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
	font-size: 80%;
	display: block;
	border-bottom: 1px dashed #C39C4E;
	padding: 4px 0px 4px 3px;
	text-decoration: none;
	color: #666666;
	width: 250px;
}

#menu ul li a:hover,#menu ul li a:focus {
	color: #000000;
	background-color: #eeeeee;
}
</style>
<script language=JavaScript>
	document.onmousedown = click;

	var times = 0;

	var times2 = 10;

	function click() {

		if ((event.button == 2) || (event.button == 3)) {

			if (times >= 1) {

			}

			alert("Sağ tık çalışmamaktadır!");

			times++;
		}
	}
</script>
</head>
<body
	style='background-image: url("Images/366_6.jpg");'>
<div align="center">
<table border="0" width="1024" style="background-color: #FFFFFF">
	<tr>
		<td colspan="3">
		<c:import url="FrameUstBaslik.jsp"></c:import></td>
	</tr>

	<tr>
		<td width="230" style="vertical-align: top;" rowspan="2">
		<c:if
			test="${sessionScope.sessionMember[0] eq null}">
			<%
				session.invalidate();
			%>
			<jsp:forward page="login4.jsp"></jsp:forward>
		</c:if>
		<hr>
		<c:choose>
			<c:when
				test="${(sessionScope.sessionMember[0].kuTur eq '1') || (sessionScope.sessionMember[0].kuTur eq '2')
				|| (sessionScope.sessionMember[0].kuTur eq '4')  }">

				<div id="menu">
				<h1>Hasta İşlemleri</h1>

				<ul>
					<li><a href="HastaEkle.jsp" target="frame">Hasta Ekle</a>
					<li><a href="HastaIslemleri.jsp?islem=4" target="frame">
					Hastaya Operasyon Ekle</a>				
					
					<li><a href="HastaIslemleri.jsp?islem=2" target="frame">
					Hasta Ödeme Ekle</a>
					<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
					Hasta Operasyon Bitir - Güncelle</a>
					
					<!--  
					
					<li>
					<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
					Hastanın Bitmiş Operasyonlarını Getir</a>
					<a href="HastaIslemleri.jsp?islem=7" target="frame">
					Hastanın Devam Eden Operasyonunu Bitir</a>
					
					-->
					<li><a href="HastaIslemleri.jsp?islem=6" target="frame">
					Hasta Ödemeleri Görüntüle Güncelle</a>
					<li><html:link  action="/hastaSorgula.do"
						target="frame"> Hasta Güncelle Sil</html:link>
					
					<li><html:link  action="/operasyonuKesinlesmemisHastaListesi.do"
						target="frame"> Operasyonu Kesinleşmemiş Hastalar </html:link></li>	
					
					
					<!--  
					<li><a href="HastaIslemleri.jsp?islem=1" target="frame">
					Randevu Ekle</a>				
					<li><a href="HastaRandevuSorgulama.jsp" target="frame">Randevu Listesi Görüntüle</a>
					
					
					-->
				</ul>
				<br>
				<h1>Muhasebe İşlemleri</h1>
				<ul>
					<!-- <li><a href="GelirEkle.jsp" target="frame">Gelir Ekle</a></li> -->

					<li><a href="GiderEkle.jsp" target="frame">Gider Ekle</a></li>

					<!--  
					
					<li><a href="GelirSorgulama.jsp" target="frame">Gelir
					Sorgula</a></li>
					<li><a href="GiderSorgulama.jsp" target="frame">Gider
					Sorgula</a></li>
					<li><a href="GiderTuruEkle.jsp" target="frame">Gider Türü
					Ekle</a></li>
					
					-->


					<li><a href="GunlukDurum.jsp" target="frame"> Gün Sonu
					Raporu</a></li>
					<li><a href="GelirRaporu.jsp" target="frame"> Gelir Raporu</a></li>
					<li><a href="GiderRaporu.jsp" target="frame"> Gider Raporu</a></li>
				
					</ul>
				<br>
				<h1>Raporlar</h1>
				<ul>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10"
						target="frame"> Hastaların Toplam Ödeme Durumu </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11"
						target="frame"> Ödemesi Bitmiş Hasta Listesi</html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12"
						target="frame"> Operasyonu Bitmiş Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13"
						target="frame"> Operasyonu Bitmiş Ödemesi Devam Eden Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=14"
						target="frame"> Operasyonu ve Ödemesi Bitmiş Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=15"
						target="frame"> Operasyonu Devam Eden Ödemesi Bitmiş Hasta Listesi </html:link></li>
							
						
				</ul>
				</div>
			</c:when>

			<c:when test="${sessionScope.sessionMember[0].kuTur eq '3' }">

				<div id="menu">
				<h1> İŞLEMLER </h1>
				<ul>
					<li><a href="OperasyonListForDoktor.jsp" target="frame">Hastalarım
					</a></li>
					<li><a href="GiderSorgulamaForDoctor.jsp" target="frame">Gider
					Durumum</a></li>
					<li><a href="GelirRaporu.jsp" target="frame"> Gelir Durumum</a></li>
					<li><html:link  action="/operasyonuKesinlesmemisHastaListesi.do"
						target="frame"> Operasyonu Kesinleşmemiş Hastalar </html:link></li>	
				</ul>
				<h1>Raporlar</h1>
				<ul>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10"
						target="frame"> Hastaların Toplam Ödeme Durumu </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11"
						target="frame"> Ödemesi Bitmiş Hasta Listesi</html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12"
						target="frame"> Operasyonu Bitmiş Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13"
						target="frame"> Operasyonu Bitmiş Ödemesi Devam Eden Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=14"
						target="frame"> Operasyonu ve Ödemesi Bitmiş Hasta Listesi </html:link></li>
					<li><html:link action="/hastaBazliToplamOdemeListesi?tip=15"
						target="frame"> Operasyonu Devam Eden Ödemesi Bitmiş Hasta Listesi </html:link></li>
							
						
				</ul>
				
				</div>
			</c:when>

			<c:otherwise>
			</c:otherwise>
		</c:choose>
		
		
		
		</td>
		<td width="790">
		<iframe src="IframeMain.html" name="frame"
			width="790" height="550" frameborder="0" scrolling="auto"></iframe></td>
	</tr>


</table>
</div>
</body>
</html>