<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.dto.TLabrotuvarDTO"%>
<%@page import="java.util.List"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<title>Hasta Sorgula</title>
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>

<script type="text/javascript">
 var basTarihi;
  window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("basTar"));
		var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bitTar"));
					<%Date dat = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			String date = sdf.format(dat);
			String basTar = (String) request.getAttribute("basTar");
			String bitTar = (String) request.getAttribute("bitTar");
			if (basTar == null) {
				String[] str = date.split("\\.");

				basTar = str[0] + "." + str[1] + ".01";

			}
			if (bitTar == null) {

				String[] str = date.split("\\.");
				Integer gun = Integer.parseInt(str[2]);
				Integer sonrakiGun = gun + 1;

				bitTar = str[0] + "." + str[1] + "." + sonrakiGun.toString();

			}%>	
				
					//document.getElementById("basTar").value="<%=basTar%>";
					//document.getElementById("bitTar").value="<%=bitTar%>
	";	
	}
</script>
<script>
	$("document")
			.ready(
					function() {
						$('#example')
								.dataTable(
										{
											"bFilter" : false,
											sPaginationType : "full_numbers",
											"oLanguage" : {

												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
												"sPrevious" : "Önceki"

											}

										});

					});
</script>
</head>
<body>
	<!-- sayfa ilk acildiginda sorgulama yapsin.. -->
	<%-- 	<%
	Integer subeId= (Integer)session.getAttribute("subeId");
		SQLUtils sqlUtils = new SQLUtils();
		Connection conn = SQLUtils.getMySqlConneciton();
		List<TLabrotuvarDTO> labIslemList = sqlUtils
				.getLabratuvarIslemList(conn,subeId);
		request.setAttribute("labIslemList", labIslemList);
		conn.close();
	%> --%>

	<div>
		<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
			..: Laboratuvar işlemlerini görmek için lütfen sorgulama yapınız.. </font>
		<hr>
		<hr>
		<form action="labIslemSorgula.do" method="post" id="labrotuvarForm"
			onsubmit="">
			<table class="sorgulama">
				<tr>
					<td colspan="7" style="text-align: center;">LABORATUVAR ISLEM
						SORGULA</td>
				</tr>
				<tr>

					<td>Durum</td>
					<td><select name="durum" style="width: 126px;">
							<option label="Seçiniz" value="-1"></option>
							<c:forEach items="${labDurumList}" var="var">
								<option label="${var.toString}" value="${var.state}"
									<c:if test="${var.state eq 'B'}"> selected="selected" </c:if> />
							</c:forEach>
					</select></td>
					<td>İşlem</td>
					<td><select name="labIslemTipId" style="width: 145px;">
							<option label="Seçiniz" value="-1"></option>
							<c:forEach items="${labIslemTipList}" var="labIslem">
								<option label="${labIslem.ad}" value="${labIslem.id}" />
							</c:forEach>
					</select></td>
					<td><input type="hidden" name="sube" value="${sube.sId}">
					</td>
					<td><input type="hidden" name="requestPage" value="klinik">
					</td>
				</tr>
				<tr>
					<td>Protokol No</td>
					<td><input class="inputTextfield" name="hastaProtokolNo"
						id="hstProtokol" /></td>
					<td>Ad</td>
					<td><input class="inputTextfield" name="hastaAd"
						id="hstProtokol" /></td>
					<td>Soyad</td>
					<td><input class="inputTextfield" name="hastaSoyad"
						id="hstProtokol" /></td>

				</tr>
				<tr>
					<td style="width: 56px;">Klinik Çıkış Tarih :</td>
					<td style="width: 164px;"><input class=inputTextfield
						name="klinikCikisTarBas" id="basTar"></td>
					<td>/</td>
					<td colspan="4"><input class=inputTextfield
						name="klinikCikisTarBit" id="bitTar"></td>
				</tr>

				<tr>
					<td colspan="7" style="text-align: center;"><input
						type="submit" value="Sorgula" name="bnt_gonder" /></td>
				</tr>
			</table>

		</form>


		<hr>
		<br>


		<table class="sofT" id="example">
			<thead>
				<tr>
					<th class="helpHed"></th>
					<th class="helpHed">Protokol No</th>
					<th class="helpHed">Hasta</th>
					<th class="helpHed">Doktor</th>
					<th class="helpHed">Durum</th>
					<th class="helpHed">İşlem</th>
					<th class="helpHed">Klinik Çıkış Tarihi</th>
					<th class="helpHed">Lab Çıkış Tarihi</th>
					<th class="helpHed">Klinik Değerl. Tar.</th>
					<th class="helpHed" style="width: 150px;">Provolar</th>
					<th class="helpHed"></th>

				</tr>
			</thead>

			<c:forEach items="${labIslemList}" var="labIslem" varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${labIslem.hastaDTO.protokolNo}</td>
					<td class="helpBod">${labIslem.hastaDTO.ad}
						${labIslem.hastaDTO.soyad}</td>
					<td class="helpBod">${labIslem.doktorDTO.dAd}
						${labIslem.doktorDTO.dSoyad}</td>
					<td class="helpBod">

						${labIslem.laboratuvarIslemDurum.toString}</td>
					<td class="helpBod">${labIslem.labIslemTipAd}</td>
					<td class="helpBod">${labIslem.klinikCikisTar}</td>
					<td class="helpBod">${labIslem.labCikisTar}</td>
					<td class="helpBod">${labIslem.klinikDegerlendirmeTar}</td>
					<td class="helpBod"><c:forEach items="${labIslem.provaList}"
							var="prova">
					
					${prova.provaTipEnm}:${prova.provaTar} <br>

						</c:forEach></td>


					<td class="helpBod"><c:choose>


							<c:when test="${(labIslem.laboratuvarIslemDurum.state eq 'B') }">

								<html:link
									action="/HastaLabrotuvarIslemleri?labIslemId=${labIslem.id}&labIslemTip=14"> Lab İşlem Onayla Red</html:link>

							</c:when>

							<c:when
								test="${(labIslem.laboratuvarIslemDurum.state eq 'A') || (labIslem.laboratuvarIslemDurum.state eq 'C') || (labIslem.laboratuvarIslemDurum.state eq 'D')}">
								<html:link
									action="/HastaLabrotuvarIslemleri?labIslemId=${labIslem.id}&labIslemTip=15"> Lab İslem Detay Göster</html:link>

							</c:when>



						</c:choose></td>


				</tr>

			</c:forEach>

		</table>
	</div>
</body>
</html>