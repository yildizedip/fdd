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
<title>Laboratuvar Gönder</title>
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

	window.onload = function() {

		new Epoch('epoch_popup', 'popup', document
				.getElementById("metalTarihiStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("iskeletTarihiStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("zirkonTarihiStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("disliTarihiStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("dentinTarihiStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("klinikCikisTarStr"));
		new Epoch('epoch_popup', 'popup', document
				.getElementById("labCikisTarStr"));

	}

	function validate() {

		var tip = document.getElementById("labIslemId").value;

		if (tip == "-1") {
			alert("Lütfen Labratuvar İşlem Tipi Seçiniz..");
			return false;
		}
	}
</script>
</head>
<body>
	<div>

		<c:if test="${operasyon eq null}">
			<c:redirect url="exception.jsp">
			</c:redirect>

		</c:if>
		<input type="hidden" onkeyup="return onkeyup()" />
		<form action="LabrotuvaraGonder.do" method="post" name="labForm"
			onsubmit="return validate()">

			<table class="sorgulama" style="width: 980px;">
				<tr>
					<th colspan="2" style="text-align: center; font-size: 14px">
						LABORATUVAR GÖNDERME FORMU <BR>
					</th>
				</tr>
				<tr>
					<td rowspan="2" style="height: 126px;"><img
						src="Images/labDis.jpg" style="height: 109px; width: 435px"></td>
					<td style="height: 52px;">Diş Hekimi: <br> <br> <input
						class="inputTextfield"
						style="width: 416px; background-color: threedlightshadow;"
						name="hastaAd" readonly="readonly" id="hastaAd"
						value="${operasyon.doktor.dAd } - ${operasyon.doktor.dSoyad }"></td>
				</tr>
				<tr>
					<td style="height: 51px;">Hasta Adı - Protokol No : <br>
						<br> <input readonly="readonly" class="inputTextfield"
						name="ad" id="ad"
						style="background-color: threedlightshadow; width: 239px"
						value="${hasta.ad } ${hasta.soyad}"> - <input
						readonly="readonly" class="inputTextfield" name="protokolNo"
						style="background-color: threedlightshadow;" id="protokolNo"
						value="${hasta.protokolNo }">
						
						<input type="hidden" name="id" value="${hasta.id}">
						</td>

				</tr>
				<tr>
					<td valign="top">
						<table>
							<tr>
								<td style="width: 78px;">Operasyon :</td>
								<td><input class="inputTextfield" name="protokolNo"
									style="width: 324px; background-color: threedlightshadow;"
									readonly="readonly" id="islemTipi"
									value="${operasyon.islemTip.ad}"> <input type="hidden"
									name="islemId" value="${operasyon.id}"></td>
							</tr>
							<tr>
								<td style="width: 88px;">İşlem Tarihi :</td>
								<td><input class="inputTextfield"
									style="width: 198px; background-color: threedlightshadow;"
									name="hastaAd" readonly="readonly" id="hastaAd"
									value="${operasyon.islemTarihi }"></td>
							</tr>
							<tr>
								<td>Sayı :</td>
								<td><input class="inputTextfield"
									style="width: 106px; background-color: threedlightshadow;"
									name="hastaAd" readonly="readonly" id="hastaAd"
									value="${operasyon.disAdet}"></td>
							</tr>
							<tr>
								<td>Ücret :</td>
								<td><input class="inputTextfield"
									style="width: 150px; background-color: threedlightshadow;"
									name="ucret" readonly="readonly" id="ucret"
									value="${operasyon.miktar }"></td>
							</tr>
							<tr>
								<td>Açıklama :</td>
								<td><textarea
										style="background-color: threedlightshadow; width: 280px; height: 75px"
										readonly="readonly" id="hastaAd">${operasyon.aciklama } </textarea></td>
							</tr>
						</table> 
					</td>
					<td align="left" style="width: 554px;">


						<table>

							<tr>
								<th colspan="4" align="center">LABORATUVAR İŞLEM FORMU</th>
							</tr>
							<tr>
								<td>İŞLEM:</td>
								<td colspan="3"><select size="1" style="width: 142px;"
									id="labIslemId" name="labIslemTipId">

										<option label="Seçiniz.." value="-1">
											<c:forEach items="${labIslemTipList}" var="tip">

												<option label="${tip.ad} " value="${tip.id}">
												</option>

											</c:forEach>
								</select></td>
							</tr>
							<tr>
								<td><input type="checkbox" name="metalProva"
									id="metalProva" onselect="checkProva()"> Metal</td>
								<td><input class="inputTextfield" name="metalProvaTar"
									id="metalTarihiStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>

								<td style="width: 75px;"><input type="checkbox"
									name="iskeletProva" id="iskeletProva" onclick="checkProva()">
									Iskelet</td>
								<td><input class="inputTextfield" name="iskeletProvaTar"
									id="iskeletTarihiStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>
							</tr>
							<tr>
								<td><input type="checkbox" name="zirkonProva"
									id="zirkonProva"> Zirkon</td>
								<td><input class="inputTextfield" name="zirkonProvaTar"
									id="zirkonTarihiStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>

								<td><input type="checkbox" name="disliProva"> Dişli</td>
								<td><input class="inputTextfield" name="disliProvaTar"
									id="disliTarihiStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>
							</tr>
							<tr>
								<td style="width: 66px;"><input type="checkbox"
									name="dentinProva"> Dentin</td>
								<td><input class="inputTextfield" name="dentinProvaTar"
									id="dentinTarihiStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>
								<td></td>
								<td></td>
							</tr>

							<tr>
								<td style="width: 68px;">Klinik Çıkış Tarihi :</td>
								<td><input class="inputTextfield" name="klinikCikisTarStr"
									id="klinikCikisTarStr" value="${tarihStr}" /></td>

								<td style="width: 49px;">Laboratuvar Çıkış Tarihi :</td>
								<td><input class="inputTextfield" name="labCikisTarStr"
									id="labCikisTarStr"
									style="background-color: threedlightshadow;"
									disabled="disabled" /></td>
							</tr>
							<tr>
								<td>Açıklama :</td>
								<td colspan="4" style="text-align: left"><textarea
										name="aciklama" rows="4" cols="50" style="width: 410px;"></textarea>
								</td>
							</tr>

							<tr>
								<td></td>
								<td colspan="3" style="text-align: center;"><input
									type="submit" name="Gonder" value="Gönder"></td>
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