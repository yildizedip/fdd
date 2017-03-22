<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true"%>
<%@ attribute name="implantSayfasimi" required="false"
	rtexprvalue="true"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script src="/js/jquery-3.1.1.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/epoch_classes.js"></script>
<script src="/script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"
	href="/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="/styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/styles/main.css">
<link rel="stylesheet" href="/css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="/css/edip.css" type="text/css" />

</head>
<body>
	<c:if test="${not empty gelirList}">

		<table class="table table-bordered">
			<tr>
				<td colspan="11" align="center" class="bg-warning">Gelir
					Listesi</td>
			</tr>
			<tr>
				<td></td>
				<td>Tarih</td>
				<td>Ptk. No</td>
				<td>Ad Soyad</td>
				<td>Tedavi</td>
				<td>Adet</td>
				<td>Doktor</td>
				<td>Ödeme</td>
				<c:if test="${implantSayfasimi ne 'evet' }">

					<td>Miktar</td>

				</c:if>

				<td>Aciklama</td>
				<c:if test="${silAktif ne '0' }">
					<td></td>
				</c:if>

				<c:if test="${implantSayfasimi eq 'evet' }">

					<td></td>

				</c:if>

			</tr>
			<c:forEach items="${gelirList}" var="gelir" varStatus="count">
				<tr>
					<td>${count.count}</td>
					<td>${gelir.odemeTarihiStr}</td>
					<td>${gelir.hasta.protokolNo}</td>
					<td>${gelir.hasta.ad} ${gelir.hasta.soyad}</td>

					<td>${gelir.islemTip.ad}</td>
					<td>${gelir.islem.disAdet}</td>
					<td>${gelir.doktor.dAd} ${gelir.doktor.dSoyad}</td>

					<td><c:choose>
							<c:when test="${gelir.odemeTuru eq 2}">
			Pesin
			</c:when>
							<c:when test="${gelir.odemeTuru eq 3}">
			Taksit
			</c:when>
			
			<c:when test="${gelir.odemeTuru eq 4}">
																								Kredi Karti
																								</c:when>
																				<c:when test="${gelir.odemeTuru eq 5}">
																								EFT / Havale
																								</c:when>
						</c:choose></td>

					<c:if test="${implantSayfasimi ne 'evet' }">

						<td>${gelir.miktar}</td>

					</c:if>
					<td>${gelir.aciklama}</td>
					<c:if test="${silAktif ne '0' }">
						<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
							<td><html:link action="/SilGelir?id=${gelir.id}"> Sil </html:link></td>
						</c:if>

					</c:if>

					<c:if test="${implantSayfasimi eq 'evet' }">

						<td></td>

					</c:if>
				</tr>

			</c:forEach>

			<c:if test="${implantSayfasimi ne 'evet' }">

				<tr>
					<td colspan="8" style="font-size: 13px; color: blue;">TOPLAM
						MIKTAR</td>
					<td style="font-size: 13px; color: blue;">${toplamGelir}</td>
					<td></td>
				</tr>


			</c:if>


		</table>
	</c:if>



</body>
</html>