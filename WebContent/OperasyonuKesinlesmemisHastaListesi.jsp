<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>



<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script src="script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" src="js/jquery.ui.datepicker-tr.js"></script>
<script>
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
				
					document.getElementById("basTar").value="<%=basTar%>";
					document.getElementById("bitTar").value="<%=bitTar%>";
	}

	$("document")
			.ready(
					function() {
						$('#example')
								.dataTable(
										{
											"bFilter" : false,
											sPaginationType : "full_numbers",
											"oLanguage" : {

												"sLengthMenu" : "Sayfada _MENU_ kayýt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayýt arasýndan  _START_ ile _END_ kayýt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazýn:",
												"sPrevious" : "Önceki"

											}

										});
					});
</script>

</head>
<body style="color: black; background-color: white; font-size: 11px;">

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		<div class="page-header ">
			<div class="page-title" style="font-size: 15px;">

				<c:choose>
					<c:when test="${param.tip eq '1' }">
			Tedavisi Kesinleþmemiþ Hasta Sorgulama
			</c:when>
					<c:when test="${param.tip eq '3' }">
			 Arama Kaydý Giriþ
			</c:when>
					<c:otherwise>
			 Tedavisi Kesinleþmiþ Hasta Listesi
			</c:otherwise>
				</c:choose>


			</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 22px; width: 22px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>


	<br>
	<div class="col-lg-6">


		<form action="operasyonuKesinlesmemisHastaListesi.do" method="post">
		<input type="hidden" name="tip" id="tip"						value="${param.tip}" />
			<table class="table table-bordered">
				<tr>
					<td colspan="2" class="bg-info">SORGULA</td>
				</tr>
				<tr>
					
					<td><input class="inputTextfield" name="ad" id="hstProtokol" placeholder="Ad" /></td>
					<td><input class="inputTextfield" name="soyad"	id="hstProtokol" placeholder="Soyad" /></td>
				</tr>
				
				
				<tr>
					<td> 
						
							<select size="1" name="islemTipi">
								<option label="Tedavi Seçiniz.." value="-1">Tedavi Seçiniz</option>
	
								<c:forEach items="${islemTurList}" var="islem">
									<option label="${islem.ad}" value="${islem.id }"> ${islem.ad}</option>
								</c:forEach>
						 </select>
					
					</td>
					
					<td >
						<c:choose>
							<c:when test="${sessionScope.sessionMember[0].kuTur ne '3'}">
	
								<select size="1" name="doktorId">
										<option label="Diþ Hekimi Seçiniz.." value="-1">Diþ Hekimi Seçiniz..</option>
	
										<c:forEach items="${doktorList}" var="doktorDTO">
											<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
												value="${doktorDTO.dId }"
												<c:if test="${doktorDTO.dId eq operasyonDoktorId }">
									selected="selected"
									</c:if>>
												${doktorDTO.dAd } ${doktorDTO.dSoyad }</option>
										</c:forEach>
								</select>
	
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>

						</c:choose>
					
					</td>
				</tr>
				<tr>
					
					<td style="width: 164px;"> 
					Tarih : 
					<input class="inputTextfield" name="basTar" id="basTar" />
					
					</td>
					<td><input class="inputTextfield" name="bitTar" id="bitTar" /></td>

					
				</tr>

				<tr>
					<td colspan="7" style="text-align: center;"><input
						type="submit" value="Sorgula" name="bnt_gonder" /></td>
				</tr>
			</table>
		</form>
<label
						style="color: red;"> ${requestScope.warn} </label>

	</div>

	<hr>
	<table class="table table-bordered" id="example">
		<thead>

			<tr>
				<th class="bg-success" colspan="11">
					<h4 align="center">Hasta Listesi</h4>
				</th>
			</tr>

			<tr>
				<th></th>
				<th>Protokol No</th>
				<th>Ad-Soyad</th>
				<th>Adet</th>
				<th>Operasyon</th>
				<th>Doktor</th>
				<th>Ücret</th>
				<th>Tarih</th>

				<c:if
					test="${sessionScope.sessionMember[0].kuTur ne '3'
				  && param.tip eq '1'  }">
					<th></th>
				</c:if>

				<c:if
					test="${sessionScope.sessionMember[0].kuTur ne '3'
				  && param.tip eq '3'  }">
					<th></th>
				</c:if>
			</tr>

		</thead>
		<tbody>
			<c:forEach items="${operasyonuKesinlesmemisHastaListesi}" var="islem"
				varStatus="count">
				<tr>
					<td><strong>${count.count}</strong></td>
					<td>${islem.hasta.protokolNo}</td>
					<td>${islem.hasta.ad} ${islem.hasta.soyad} - ${islem.hasta.tel}</td>
					<td>${islem.disAdet}</td>
					<td>${islem.islemTip.ad}</td>
					<td>${islem.doktor.dAd} ${islem.doktor.dSoyad}</td>
					<td>${islem.miktar}</td>
					<td width="120px">${islem.islemTarihi}</td>

					<c:if
						test="${sessionScope.sessionMember[0].kuTur ne '3' && param.tip eq '1' }">

						<td><html:link
								href="OperasyonuKesinlestir.jsp?islemId=${islem.id}&hastaId=${islem.hastaId}&subeId=${subeId}"> Kesinleþtir </html:link>
						</td>
					</c:if>

					<c:if
						test="${sessionScope.sessionMember[0].kuTur ne '3' && param.tip eq '3' }">
						<td><html:link
								href="OperasyonKesinlesmemisAramaKaydiGir.jsp?islemId=${islem.id}&hastaId=${islem.hastaId}&subeId=${subeId}"> Arama Kaydý Gir </html:link>
						</td>

					</c:if>

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
				<th style="font-size: 10px; color: Blue;">TOPLAM</th>

				<th style="font-size: 10px; color: Blue;">${toplamUcret}</th>

				<th style="font-size: 10px; color: Blue"></th>

				<th></th>
			</tr>

		</tfoot>

	</table>


</body>
</html>