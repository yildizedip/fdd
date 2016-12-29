<%@page import="tr.com.fdd.mysql.MysqlUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@page import="tr.com.fdd.dto.TTurKodDTO"%>
<%@page import="tr.com.fdd.struts.actions.GenericAction"%>
<%@page import="net.sf.hibernate.Session"%>
<%@page import="net.sf.hibernate.Query"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">

<title></title>

<link rel="stylesheet" href="css/edip.css" type="text/css">
<style type="text/css">
#ekle {
	background-color: #CECEFF;
	margin: 5px;
	padding: 5px;
	width: 300px;
	float: left;
}

#main {
	font-size: 11px;
	font-family: Verdana, Geneva, sans-serif;
}

#sonuclist {
	background-color: #CECEFF;
	margin: 5px;
	padding: 5px;
	width: 600px;
	float: left;
}

#aciklama {
	margin: 5px;
	padding: 5px;
	float: left;
}

#aciklamaTemizle {
	clear: left;
}

#guncelle {
	margin: 5px;
	padding: 5px;
	float: left;
	background-color: #CECEFF;
}
#subeEkle {
	background-color: #DFDFFF;
	margin: 10px;
	padding: 5px;
	width: 300px;
	float: left;
}
#subeList {
	background-color: #DFDFFF;
	margin: 10px;
	padding: 5px;
	width: 300px;
	border: 1px solid #060;
	float: left;
}
#subeler {
	margin: 5px;
	padding: 5px;
	border: 1px solid #030;
}
#clear {
	clear: left;
}
</style>
</head>
<body>

<%
	Connection connection = MysqlUtil.instance.getConnection();
	SQLUtils utils = new SQLUtils();

	List<TTurKodDTO> result = utils.getGiderTurList(connection);
	if (result.size() > 0) {
		request.setAttribute("giderTurList", result);

	} else {
		request.setAttribute("noContent", "Kayýt Bulunamadý");
	}
%>
<br>
<hr>
<div id="main">
<div id="ekle">
<form action="GiderTuruEkle.do" method="post">
<table class="table">
	<tr>
		<td colspan="2" align="center">Gider Türü Ekle</td>
	</tr>
	<tr>
		<td>Tür Ad</td>
		<td><input type="text" name="turAd"></td>
	</tr>
	<tr>
		<td>Tür Kod</td>
		<td><input type="text" name="turKod"></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit"
			value="Tür Ekle"></td>
	</tr>
</table>
</form>
<label style="background-color: red;">${requestScope.warn}</label></div>
<div id="aciklama">
<p>A&Ccedil;IKLAMALAR:</p>
<p>1-Doktorlarýn kendilerine ait gider turlerini g&ouml;rmeleri
icin,</p>
<p>gider t&uuml;rleri listesinde bulunan Tur Id kolonu ile kullanici
</p>
<p>listesinde bulunan gider tur kodu ayný olmalýdýr.</p>
</div>
<div id="aciklamaTemizle"></div>
<div id="sonuclist">
<table class="table">
	<tr>
		<td colspan="4" align="center">GIDER TURLERI</td>
	</tr>
	<tr>
		<td></td>
		<td>Tur Id</td>
		<td>Tur Ad</td>
		<td>Tür Kod</td>
		<td>Aktif Sube</td>
		<td></td>
	</tr>
	<c:forEach var="giderTur" items="${giderTurList}" varStatus="count">
		<tr>
			<td>${count.count}-</td>
			<td>${giderTur.turId}</td>
			<td>${giderTur.turAd}</td>
			<td>${giderTur.turKod}</td>
			<td><c:forEach items="${giderTur.turSubeList}" var="sube">
               ${sube.sAd},
               </c:forEach></td>
			<td><html:link action="/SilGiderTuru?turId=${giderTur.turId}"> Sil </html:link>
			/ <html:link action="/GiderTuruGetir?turId=${giderTur.turId}"> Güncelle </html:link>

			</td>

			<td>/ <html:link
				action="/GiderTuruSubeGetir?turId=${giderTur.turId}"> Sube Sil </html:link>
			/ <html:link action="/GiderTuruSubeGetir?turId=${giderTur.turId}"> Sube Ekle </html:link>

			</td>
		</tr>
	</c:forEach>
</table>
</div>
<c:if test="${giderTur ne null}">
	<div id="guncelle">
	<form action="GiderTuruGuncelle.do" method="post">
	<table class="table">
		<tr>
			<td colspan="2" align="center">Gider Türü Güncelle</td>
		</tr>
		<tr>
			<td>Tür Id</td>
			<td><input type="text" name="turId" value="${giderTur.turId}"></td>
		</tr>
		<tr>
			<td>Tür Ad</td>
			<td><input type="text" name="turAd" value="${giderTur.turAd}"></td>
		</tr>
		<tr>
			<td>Tür Kod</td>
			<td><input type="text" name="turKod" value="${giderTur.turKod}"></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit"
				value="Güncelle"></td>
		</tr>
	</table>
	</form>
	</div>
</c:if> <br>

<!-- SUBE ISLEMLERI SUBE LISTESI -->
<c:if test="${giderTurDto ne null}">
<div id="subeList">

${giderTurDto.turAd}
için þubeler:
<hr>
<table class="sofTSmall">
	<tr>
		
		<td class="helpHed">Þube</td>
		<td class="helpHed"></td>
	</tr>
	<c:forEach items="${giderTurDto.turSubeList}" var="sube"
		varStatus="count">
		<tr>
		
			<td class="helpHed">${sube.sAd}</td>
			<td class="helpBod"><html:link
				action="/GiderTuruSubeSil?giderTuruSubeId=${sube.giderTuruSubeId}">Sil</html:link></td>
		</tr>
	</c:forEach>
</table>
</div>






<!-- SUBE ISLEMLERI SUBE EKLEME -->

<div id="subeEkle">
${giderTurDto.turAd} için þube ekleme;

<form action="GiderTuruSubeEkle.do" method="post">

<hr>
<input type="hidden" value="${giderTurDto.turId}"
	name="turId">
<div id="subeler"><select size="1" name="subeId" class="subeler">
	<option label="Þube Seçiniz.." value="-1"></option>
	<c:forEach items="${subelerList}" var="sube">
		<option label="${sube.sAd }" value="${sube.sId}"></option>
	</c:forEach>
</select></div>
<div><input type="submit" value="Þube Yetkilendir"></div>
</form>
</div>
</c:if>
<div id="clear"></div>

</div>

</body>
</html>