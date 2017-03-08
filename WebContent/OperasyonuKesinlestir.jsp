<%@page import="tr.com.fdd.dto.THastaDTO"%>
<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
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

<link rel="stylesheet" href="css/edip.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<title>Hasta Güncelle</title>
<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiStr"));

	}
</script>

<%
	String islemId = request.getParameter("islemId");
	String hastaId = request.getParameter("hastaId");
	String subeId = request.getParameter("subeId");
	SQLUtils utils = new SQLUtils();
	Connection conn = SQLUtils.getMySqlConneciton();
	TIslemDTO islem = utils.getOperasyonuKesinlesmemisHasta(Integer.parseInt(islemId), conn);
	System.out.print(subeId);
	THastaDTO hasta = utils.getHasta(Integer.parseInt(hastaId), conn, new Integer(subeId).intValue());

	request.setAttribute("operasyon", islem);
	request.setAttribute("hasta", hasta);
%>
</head>
<body style="color:black ; background-color: white;">

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
		<div class="page-header ">
			<div class="page-title" style="font-size: 20px;">Hasta
				Operasyonu Kesinleþtir</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>

	<div>
	
	<div class="col-lg-6">  

		<table class="table table-bordered">
			<tr>
				<td colspan="2" style="text-align: center;" class="bg-info">HASTA BÝLGÝLERÝ</td>
			</tr>
			<tr>
				<td>Protokol No</td>

				<td><input class="inputTextfield" name="protokolNo"
					id="protokolNo" value="${hasta.protokolNo }" /></td>
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tckimlik }" /> <input type="hidden" name="id"
					value="${hasta.id }"></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad"
					value="${hasta.ad }" /> <input class="inputTextfield" name="soyad"
					id="soyad" value="${hasta.soyad }" /></td>
			</tr>




			<tr>
				<td colspan="2" align="left"><label style="color: red;">
						${requestScope.warn}</label></td>

			</tr>

		</table>
		
		</div>
		
		<div class="clearfix"></div>

	<div class="col-lg-6">

		<c:if test="${odemeListesi eq null}">

			<form action="OperasyonuKesinlestir.do" method="post">
			
				<table class="table table-bordered">
					<tr>
						<td colspan="3" style="text-align: center;" class="bg-info">OPERASYON
							BÝLGÝLERÝ</td>
					</tr>
					<tr>
						<td>Ýþlem Tipi</td>
						<td colspan="2"><select size="1" name="islemTipi"
							class="">
								<option label="Operasyon Seçiniz.." value="-1" />

								<c:forEach items="${islemTurList}" var="islem">
									<option label="${islem.ad}" value="${islem.id }"
										<c:if test="${operasyon.islemTipi eq islem.id }">
						
						selected="selected"
						</c:if> />
								</c:forEach>

						</select> <input type="hidden" name="islemId" value="${operasyon.id}">
						</td>

					</tr>

					<tr>
						<td>Doktor</td>
						<td><select size="1" name="doktorId" >
								<option label="Doktor Seçiniz.." value="-1" />

								<c:forEach items="${doktorList}" var="doktorDTO">
									<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
										value="${doktorDTO.dId }"
										<c:if test="${operasyon.doktorId eq doktorDTO.dId }">
										
										selected="selected"
										</c:if> />
								</c:forEach>
						</select></td>


					</tr>
					<tr>
						<td>Ýþlem Tarihi</td>
						<td><input class="inputTextfield" name="islemTarihiStr"
							id="islemTarihiStr" value="${operasyon.islemTarihiStr}" /></td>


					</tr>
					<tr>
						<td>Ücret</td>
						<td><input class="inputTextfield" style="width: 150px;"
							name="miktar" id="miktar" value="${operasyon.miktar }" /> TL</td>


					</tr>
					<tr>
						<td>Açýklama</td>
						<td><textarea style="width: 394px;" name="aciklama"
								id="aciklama">${operasyon.aciklama } </textarea></td>


					</tr>

					<tr>
						<td colspan="3" style="text-align: center;"><input
							type="submit" value="Operasyonu Kesinleþtir" id="btn_gonder"
							name="bnt_gonder" /></td>

					</tr>
				</table>
			</form>
		</c:if>
</div>

	</div>
</body>
</html>