<%@page import="tr.com.fdd.dto.TLabrotuvarProvaDTO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<title>Laboratuvar Randevu</title>
<script type="text/javascript">
	$(document).keydown(
			function(e) {
				if (e.keyCode === 8 || e.keyCode === 16) {
					var element = e.target.nodeName.toLowerCase();
					if ((element != 'input' && element != 'textarea')
							|| $(e.target).attr("readonly")) {
						return false;
					}
				}
			});

	function checkProva() {

		var provaOn = document.getElementById("metalProva").value;
		alert(provaOn);
		if (provaOn == "on") {
			document.getElementById("metalProvaTar").disabled = false;
			alert(document.getElementById("metalProvaTar").disabled);
		}
		

	}

	window.onload = function() {
	
	new Epoch('epoch_popup', 'popup', document
				.getElementById("degerlendirmeTar"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("labCikisTarStr"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("disliTarihiStr"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("metalTarihiStr"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("iskeletTarihiStr"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("zirkonTarihiStr"));

		new Epoch('epoch_popup', 'popup', document
				.getElementById("dentinTarihiStr"));

	}

	function validateForm() {

		var puan = document.getElementById("puan").value;
		var islemOnay = document.getElementById("islemOnay").value;
		var aciklama = document.getElementById("aciklama").value;

	if(puan==-1)
	{
	alert("Lütfen Labratuvar işlemine puan veriniz.");
	return false;
	}
	if(islemOnay==-1)
	{
	alert("Lütfen Labratuvar işlemini Onayla veya Reddediniz.");
	return false;
	}
	
	if(islemOnay==2 && aciklama=="")
	{
	alert("Lütfen işlemin neden red edildiği hakkında açıklama girin.");
	return false;
	}
	}
</script>
</head>
<body>
	<div>

		<input type="hidden" onkeyup="return onkeyup()" />
		<form action="LaboratuvarIslemOnaylaRed.do" method="post"
			name="labForm" onsubmit="return validateForm()">

			<table class="sorgulama" style="width: 967px;">
				<tr>
					<th colspan="2" style="text-align: center; font-size: 14px">
						LABORATUVAR İŞLEM DETAY  <BR>
					</th>
				</tr>
				<tr>
					<td rowspan="2" style="height: 126px;"><img
						src="Images/labDis.jpg" style="height: 109px; width: 435px"></td>
					<td style="height: 52px;">Diş Hekimi: <br> <br> <input
						class="inputTextfield"
						style="width: 416px; background-color: threedlightshadow;"
						name="hastaAd" readonly="readonly" id="hastaAd"
						value="${labIslem.doktorDTO.dAd } - ${labIslem.doktorDTO.dSoyad }">
						<input type="hidden" name="id" id="id" value="${labIslem.id}">

					</td>
				</tr>
				<tr>
					<td style="height: 51px;">Hasta Adı - Protokol No : <br>
						<br> <input readonly="readonly" class="inputTextfield"
						name="ad" id="ad"
						style="background-color: threedlightshadow; width: 239px"
						value="${labIslem.hastaDTO.ad } ${labIslem.hastaDTO.soyad}">
						- <input readonly="readonly" class="inputTextfield"
						name="protokolNo" style="background-color: threedlightshadow;"
						id="protokolNo" value="${labIslem.hastaDTO.protokolNo }"></td>

				</tr>
				<tr>
					<td valign="top">
						<table>
							<tr>
								<td style="width: 78px;">Operasyon :</td>
								<td><input class="inputTextfield" name="protokolNo"
									style="width: 324px; background-color: threedlightshadow;"
									readonly="readonly" id="islemTipi"
									value="${labIslem.islemTipDTO.ad}"></td>
							</tr>
							<tr>
								<td style="width: 78px;">Adet :</td>
								<td><input class="inputTextfield" name="disAdet"
									style="width: 324px; background-color: threedlightshadow;"
									readonly="readonly" id="islemTipi" value="${labIslem.disSay}">

								</td>
							</tr>
							<tr>
								<td>Klinik Açıklama :</td>
								<td><textarea name="aciklama" 
										style=" width: 326px; height: 138px"
										 id="aciklama"> ${labIslem.aciklama}</textarea></td>
							</tr>
						</table> 
					</td>
					<td align="left" style="width: 554px;"><c:forEach
							items="${labIslem.provaList}" var="prova">
							<c:if test="${prova.provaTip == 1}">
								<jsp:scriptlet>request.setAttribute("metal", true);</jsp:scriptlet>
								<c:set var="metalTar" value="${prova.provaTar }" ></c:set>
								
							</c:if>
							<c:if test="${prova.provaTip == 2}">
								<jsp:scriptlet>request.setAttribute("iskelet", true);</jsp:scriptlet>
								<c:set var="iskeletTar" value="${prova.provaTar }" ></c:set>
							</c:if>
							<c:if test="${prova.provaTip == 3}">
								<jsp:scriptlet>request.setAttribute("zirkon", true);</jsp:scriptlet>
								<c:set var="zirkonTar" value="${prova.provaTar }"/>
							</c:if>
							<c:if test="${prova.provaTip == 4}">
								<jsp:scriptlet>request.setAttribute("disli", true);</jsp:scriptlet>
								<c:set var="disliTar" value="${prova.provaTar }" ></c:set>
							</c:if>
							<c:if test="${prova.provaTip == 5}">
								<jsp:scriptlet>request.setAttribute("dentin", true);</jsp:scriptlet>
								<c:set var="dentinTar" value="${prova.provaTar }" ></c:set>
							</c:if>

						</c:forEach>
						<table>

							<tr>
								<th colspan="4" align="center">LABORATUVAR PROVA RANDEVU</th>
							</tr>
							<tr>
								<td>İŞLEM:</td>
								<td >${labIslem.labIslemTipAd}</td>
								<td>DURUM :</td>
								<td>${labIslem.laboratuvarIslemDurum.toString}</td>
							</tr>
						
							<tr>
								<td>Değerlendirme Tarihi :</td>
								<td colspan="3">
								
								<input name="klinikDegerlendirmeTar" disabled="disabled" id="degerlendirmeTar" value="${labIslem.klinikDegerlendirmeTar}">
								</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="metalProva"
									id="metalProva" disabled="disabled"
									<c:if test="${metal eq true}"> checked="checked" </c:if>>
									Metal</td>
								<td><input class="inputTextfield" name="metalProvaTar" value="${metalTar }"									
								style="background-color: threedlightshadow;"  disabled="disabled"
								
									id="metalTarihiStr" /></td>

								<td style="width: 75px;"><input type="checkbox"
									name="iskeletProva" id="iskeletProva" disabled="disabled"
									onclick="checkProva()" readonly="readonly"
									<c:if test="${iskelet eq true}"> checked="checked" </c:if>>
									Iskelet</td>
								<td><input class="inputTextfield" name="iskeletProvaTar"
									id="iskeletTarihiStr" value="${iskeletTar}"
									
								style="background-color: threedlightshadow;"  disabled="disabled"
								 />

								</td>
							</tr>
							<tr>
								<td><input type="checkbox" name="zirkonProva"
									id="zirkonProva" disabled="disabled"
									<c:if test="${zirkon eq true}"> checked="checked" </c:if>>
									Zirkon</td>
								<td><input class="inputTextfield" name="zirkonProvaTar" value="${zirkonTar}"
									id="zirkonTarihiStr" readonly="readonly"									
								style="background-color: threedlightshadow;"  disabled="disabled"
								/>

								</td>

								<td><input type="checkbox" name="disliProva"
									id="disliProva" disabled="disabled"
									<c:if test="${disli eq true}"> checked="checked" </c:if>>
									Dişli</td>
								<td><input class="inputTextfield" name="disliProvaTar" value="${disliTar}"
									id="disliTarihiStr" readonly="readonly"									
								style="background-color: threedlightshadow;"  disabled="disabled"
								 />

								</td>
							</tr>
							<tr>
								<td style="width: 66px;"><input type="checkbox"
									name="dentinProva" id="dentinProva" disabled="disabled"
									<c:if test="${dentin eq true}"> checked="checked" </c:if>>
									Dentin</td>
								<td><input class="inputTextfield" name="dentinProvaTar"
									id="dentinTarihiStr" value="${dentinTar}"								
								style="background-color: threedlightshadow;"  disabled="disabled"
								 />

								</td>
								<td></td>
								<td></td>
							</tr>

							<tr>
								<td style="width: 68px;">Klinik Çıkış Tarihi :</td>
								<td><input class="inputTextfield" name="klinikCikisTarStr" disabled="disabled"
									id="klinikCikisTarStr" value="${labIslem.klinikCikisTar }"
									readonly="readonly"
									style="background-color: threedlightshadow;" /></td>

								<td style="width: 49px;">Laboratuvar Çıkış Tarihi :</td>
								<td><input class="inputTextfield" disabled="disabled" readonly="readonly"
									style="background-color: threedlightshadow;"
									name="labCikisTarStr" value="${labIslem.labCikisTar}"
									id="labCikisTarStr" /></td>
							</tr>
							<tr>
								<td>Lab. Açıklama :</td>
								<td colspan="4" style="text-align: left;"><textarea
										rows="5" style="background-color: threedlightshadow;"
										cols="45" name="labAciklama">${labIslem.labAciklama}</textarea>
								</td>
							</tr>
							<tr>
								<td>Not :</td>
								<td colspan="3" style="text-align: left;">
								<input type="text" value="${labIslem.puan }" disabled="disabled">
								
								 </td>
							</tr>

						</table>
				
				</tr>
				<tr>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"></td>
				</tr>
			</table>

		</form>

	</div>
</body>
</html>