<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@ page import="java.util.Enumeration"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title></title>

<style type="text/css">
#ddblueblockmenu {
	border: 1px solid black;
	border-bottom-width: 1;
	width: 185px;
	
}

#ddblueblockmenu ul {
	margin: 0;
	padding: 0;
	text-align:left;
	list-style-type:none;
	font: normal 75%  Times-New-Roman;
	
}

#ddblueblockmenu li a {
	display: block;
	padding: 1px 0;
	padding-left: 9px;
	width: 169px; 
	text-decoration: none;
	color: black;
	background-color: white;
	border-bottom: 1px solid #90bade;
	border-left: 7px solid #1958b7;
}

* html #ddblueblockmenu li a { 
	width: 169px; 
}

#ddblueblockmenu li a:hover {
	background-color: #2586d7;
	border-left-color: #1c64d1;
}

#ddblueblockmenu div.menutitle {
	color: white;
	border-bottom: 2px solid black;
	padding: 1px 20;
	padding-left: 15px;
	background-color: grey;
	font: 90% 'Times New Roman', 'Lucida Grande', Arial, sans-serif;
}

.outer a,.outer div,.outer li,.outer ul {
	margin: 0;
	padding: 0;
	font-family: Verdana, Helvetica, Arial, sans-serif;
}

div.menu {
	width: 193px;
}

div.menu ul {
	list-style: none;
	text-indent: 0px;
}

div.menu li {
	margin-top: 3px;
}

div.menu a {
	font: 11px Verdana;
	padding: 4px;
	color: #646464;
	display: block;
	padding: 6px 30px;
	height: 20px;
	text-decoration: none;
	background: url('Images/background.gif');
}

div.menu a:hover {
	background: url('Images/highlight.gif') no-repeat right;
	padding: 6px 40px;
}

#btn {
	color: #ff00;
	background: white;
	font-size: 12px;
	font-family: monospace;
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
	style="background-image: url('Images/bg2.jpg');">
<div align="center">
<table border="0" width="990">
	<tr>
		<td colspan="3">
		<br>
		<c:import url="FrameUstBaslik.jsp"></c:import></td>
	</tr>

	<tr>
		<td width="250" style="vertical-align: top;" rowspan="2">
		<c:if
			test="${sessionScope.sessionMember[0] eq null}">
			<%
				session.invalidate();
			%>
			<jsp:forward page="login4.jsp"></jsp:forward>
		</c:if>
		<hr>
		<font color='Red'> İşlemler </font>
		<hr>
		<c:choose>
			<c:when
				test="${(sessionScope.sessionMember[0].kuTur eq '1') || (sessionScope.sessionMember[0].kuTur eq '2')
				|| (sessionScope.sessionMember[0].kuTur eq '4')  }">

				<div id="ddblueblockmenu">
				<div class="menutitle">Hasta</div>

				<ul>
					<li><a href="HastaEkle.jsp" target="frame">Hasta Ekle</a>
					<li><a href="HastaIslemleri.jsp?islem=4" target="frame">
					Hastaya Operasyon Ekle</a>
					<li><a href="HastaIslemleri.jsp?islem=2" target="frame">
					Hasta Ödeme Ekle</a>
					
					<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
					Hastanın Devam Eden Operasyonunu Getir</a>	
					
					<li><a href="HastaIslemleri.jsp?islem=7" target="frame">
					Hastanın Devam Eden Operasyonunu Bitir</a>					
					
					<li><a href="HastaIslemleri.jsp?islem=5" target="frame">
					Hastanın Bitmiş Operasyonlarını Getir</a>
					
					<li><a href="HastaIslemleri.jsp?islem=6" target="frame">
					Hasta Ödemeleri Görüntüle</a>	
					
					<li><a href="HastaSorgula.jsp" target="frame">Hasta
					Güncelle Sil</a>
					<!--  
					<li><a href="HastaIslemleri.jsp?islem=1" target="frame">
					Randevu Ekle</a>				
					<li><a href="HastaRandevuSorgulama.jsp" target="frame">Randevu Listesi Görüntüle</a>
					
					
					-->
					
									</ul>
				<div class="menutitle">Muhasebe İşlemleri</div>
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
					
					
					<li><a href="GunlukDurum.jsp" target="frame"> Gün Sonu Raporu</a></li>
					<li><a href="GelirRaporu.jsp" target="frame"> Gelir Raporu</a></li>
					<li><a href="GiderRaporu.jsp" target="frame"> Gider Raporu</a></li>
				</ul>
				<div class="menutitle">Raporlamalar</div>
					<ul>					
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=10" target="frame"> Hastaların Toplam Ödeme Durumu </html:link></li>					
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=11" target="frame"> Ödemesi Bitmiş Hasta Listesi</html:link></li>					
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=12" target="frame"> Operasyonu Bitmiş Hasta Listesi </html:link></li>					
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=13" target="frame"> Operasyonu Bitmiş Ödemesi Devam Eden Hasta Listesi </html:link></li>
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=14" target="frame"> Operasyonu ve Ödemesi Bitmiş Hasta Listesi </html:link></li>	
						<li><html:link action="/hastaBazliToplamOdemeListesi?tip=15" target="frame"> Operasyonu Devam Eden Ödemesi Bitmiş Hasta Listesi </html:link></li>																			
				   </ul>
				</div>
			</c:when>

			<c:when test="${sessionScope.sessionMember[0].kuTur eq '3' }">

				<div class="outer">
				<div class="menu">
				<ul>
					<li><a href="OperasyonListForDoktor.jsp" target="frame">Hastalarım	</a></li>
					<li><a href="GiderSorgulamaForDoctor.jsp" target="frame">Gider Durumum</a></li>
				</ul>
				</div>
				</div>
			</c:when>
			
			<c:otherwise>
			</c:otherwise>
		</c:choose></td>
		<td width="790"><iframe src="IframeMain.html" name="frame"
			width="790" height="550" frameborder="0" scrolling="auto"></iframe></td>
	</tr>


</table>
</div>
</body>
</html>