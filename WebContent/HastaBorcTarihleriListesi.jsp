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
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>
<title></title>
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

	<hr>
	<font style="font-size: 12px; font-family: monospace; color: graytext;">


		..: BORÇ TARİHİ LİSTESİ </font>
	<hr>

	<form action="borcOdemeListesi.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="7" style="text-align: center;">SORGULA</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input class="inputTextfield" name="protokolNo"
					id="hstProtokol" /> <input type="hidden" name="tip" id="tip"
					value="${param.tip}" /></td>
				<td>Ad</td>
				<td><input class="inputTextfield" name="ad" id="hstProtokol" /></td>
				<td>Soyad</td>
				<td><input class="inputTextfield" name="soyad" id="hstProtokol" /></td>
			</tr>
		
			<tr>
				<td style="width: 56px;"> Tarih :</td>
				<td style="width: 164px;"><input class="inputTextfield"
					name="borcOdemeTarihiBaslamaStr" id="basTar" /></td>
				<td>/</td>
				<td colspan="4"><input class="inputTextfield" name="borcOdemeTarihiBitisStr"
					id="bitTar" /></td>
			</tr>

			<tr>
				<td colspan="7" style="text-align: center;">
				<label id="lbl_error" style="color: red;">${requestScope.warn}
				${requestScope.noContent} </label>
				</td>
			</tr>
			<tr>
				<td colspan="7" style="text-align: center;"><input
					type="submit" value="Sorgula" name="bnt_gonder" /></td>
			</tr>
		</table>
	</form>

	<hr>
	
	<a href="HastaBazliToplamOdemeListesi.jsp?tip=13">Borç Tarihi Ekle</a>
	<br>
	<table class="sofT" id="example">
		<thead>
			<tr>
				<th class="helpHed" colspan="12">Hasta Borç Tarihleri Listesi</th>
			</tr>
			<tr>
				<th class="helpHed"></th>
				<th class="helpHed">Protokol No</th>
				<th class="helpHed">Ad-Soyad</th>
				<th class="helpHed">Tel</th>
				<th class="helpHed">Operasyon</th>
				<th class="helpHed">Toplam Ücret</th>
				<th class="helpHed">Toplam Ödenen</th>
				<th class="helpHed">Kalan Miktar</th>
				<th class="helpHed">Borcun Ödeme Tarihi</th>
				<th class="helpHed">Ödenecek Miktar</th>
				<th class="helpHed">Açıklama</th>
				


				<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'
				   }">
					<th class="helpHed"></th>

				</c:if>
			</tr>

		</thead>
		<tbody>
			<c:forEach items="${borcListesi}" var="borc" varStatus="count">
				<tr>
					<td class="helpBod" >${count.count}</td>
					<td class="helpBod" >${borc.islemDTO.hasta.protokolNo}</td>
					<td class="helpBod" >${borc.islemDTO.hasta.ad}	${borc.islemDTO.hasta.soyad}</td>
					<td class="helpBod" >${borc.islemDTO.hasta.tel}</td>
					<td class="helpBod" >${borc.islemDTO.islemTip.ad}</td>
					<td class="helpBod" >${borc.islemDTO.miktar}</td>

					<td class="helpBod" >${borc.islemDTO.toplamOdenenMiktar}</td>
										<td class="helpBod" >${borc.islemDTO.kalanMiktar}</td>
					<td class="helpBod"  width="77px">${borc.borcOdemeTarihi}</td>
					
					<td class="helpBod" >${borc.miktar}</td>
					<td class="helpBod"  width="77px">${borc.aciklama}</td>



					<c:if test="${sessionScope.sessionMember[0].kuTur ne '3'  }">

						<td class="helpBod"><html:link
								action="/borcTarihBilgisiSil?id=${borc.id}"> Sil </html:link></td>
						

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
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>

			</tr>

		</tfoot>

	</table>


</body>
</html>