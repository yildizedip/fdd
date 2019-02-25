<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>

<html lang="en">
<head>
<title>Hasta</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

    
<link type="text/css" rel="stylesheet" href="styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet" href="sitil/bootstrap.min.css">
<link rel="stylesheet" type="text/css"	href="css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="css/zebra-datepicker.css" />

<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">

<style type="text/css">

.modal-header, .close {
	background-color: #567FAB;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}

.disno {
	font-size: 15px;
	font-weight: bold;
	font-family: cursive;
	color: blue;
	height: 75px;
	width: 54px;
	border: 0px;
	
}

.toothdown > span {
	display: block;
    height: 0%;
    float:left;
}

.toothgroup {
background-color: #2A3141;

}

.toothup > span {
	display: block;
    height: 100%;
    float:left;
}


th {
	font-size: 11px;
}

td {
	font-size: 11px;
}
</style>

</head>

<body style="color: black; background-color:menu; ">

	<c:forEach items="${ayarlar}" var="ayar">

		<c:if test="${ayar.name eq 'odeme_tarih_degistir' }">

			<c:set var="odeme_tarih_degistir" value="${ayar.value}">
			</c:set>
		</c:if>
	</c:forEach>
	
			


	<div class="container" style="background-color: white;">


		<div class="row">
		
		<div class="col-lg-5 col-md-5 col-sm-5">
		
			<input type="button" class="btn btn-primary" value="Hasta Sorgula" data-toggle="modal" data-target="#hastaSorgulaModal" >
		
		</div>
		
		
		<div class="col-lg-7 col-md-7 col-sm-7" >
		
			<div class="pull-right">  	
			<form class="form-inline" action="hastaSorgulaForRandevu.do" method="post" >   
				
				<input type="hidden" id="hastaId4Seacrh" name="hastaId">
				
				
				<div class="form-group">
					<input class="form-control" type="text" id="SorguInput" placeholder="Hasta Ara (Ad Soyad)">
				
				</div>
				
				<div class="form-group">
				<input class="form-control"  type="text" id="SorguInputPrtk" placeholder="Hasta Ara (Protokol No)">
				
				
				</div>
				<div class="form-group">
					<input class="btn btn-primary" type="submit" value="Hasta Getir" id="btnHastaGetir" disabled="disabled">
				</div>
				
			</form>
			
			</div>
			
		</div>
		</div>
		


<hr>

		<div class="row">
			<div class="col-lg-12" id="hastaPanel">
				<div class="panel panel-default">

					<div class="panel-heading">

						<div class="row">

							<div class="col-lg-9" >
							 	<span style="font-size: 18px;" > <strong> ${lastHasta.ad} ${lastHasta.soyad} </strong>   </span>	 
							</div>
							
							
							<div class="col-lg-3" >
							
								<input type="button" class="btn btn-primary pull-right" value="Yeni Hasta" data-toggle="modal"data-target="#hastaEkleModal" >
							 	
							</div>
							
						</div>
					</div>

					<div class="panel-body">

						<div class="col-lg-12">

							<div id="tab-general">
								<div class="row mbl">
									<ul id="generalTab" class="nav nav-pills responsive">
										<li >
										<a href="#hasta-info-tab" data-toggle="tab">Hasta Kartý</a>
										</li>
										
										<li class="active">
										<a href="#tedavi-tab" data-toggle="tab">Tedavi</a>
										</li>
										
										<li >
										<a href="#hasta-randevu-tab" data-toggle="tab" >Randevular</a>
										</li>
										
										<li><a href="#anket-tab" data-toggle="tab">Memnuniyet</a>
										</li>
										

									</ul>
									<div id="generalTabContent" class="tab-content responsive">
									
										<div id="hasta-info-tab" class="tab-pane">
										<hr>
											<jsp:include page="HastaKarti.jsp"></jsp:include>
										</div>

										<div id="tedavi-tab" class="tab-pane fade in active">
										<hr>
											<jsp:include page="HastaOperasyonList.jsp"></jsp:include>

										</div>
										<div id="hasta-randevu-tab" class="tab-pane">
										<hr>
											<jsp:include page="HastaRandevuList.jsp"></jsp:include>
										</div>
										
										
										<div id="anket-tab" class="tab-pane">
										<hr>
											<div class="panel panel-white">
												
												<div class="panel-body">
												
												
													<button type="button" class="btn btn-link" data-toggle="modal"
													data-target="#anketEkleModal"
													data-whatever="${lastHasta.id}">Memnuniyet Formu Oluþtur</button>

													<table class="table table-hover table-bordered">
														<thead>

															<tr>
																<th></th>

																<th>Tarihi</th>
																<th> Saat</th>
																<th>Memnuniyet Derecesi</th>
																<th>Açýklama</th>


																<c:if
																	test="${sessionScope.sessionMember[0].kuTur ne '3'  }">
																	<th></th>
																</c:if>
															</tr>


														</thead>
														<tbody>

															<c:forEach items="${lastHasta.hastaAnketList}"
																var="anket" varStatus="count">

																<tr>
																	<td>${count.count}</td>
																	<td>${anket.tarih}</td>
																	<td>${anket.saat}</td>
																	<td>${anket.memnuniyetDerecesi}</td>
																	<td>${anket.aciklama}</td>

																	<c:if
																		test="${sessionScope.sessionMember[0].kuTur eq '4'  }">

																		<td class="helpBod"><html:link
																				action="//hastaAnketSil?id=${anket.id}"> Sil </html:link></td>
																	</c:if>
																</tr>


															</c:forEach>

														</tbody>


													</table>



												</div>


											</div>
										</div>
										
										


									</div>
								</div>
							</div>


						</div>
					</div>

<br>
<br>
<br>
<hr>

				</div>


			</div>
	
		</div>




	</div>


	<form id="send" action="hastaSorgulaForRandevu.do" method="post">
		<input type="hidden" name="hastaId" id="hasta_idSorgulama">
	</form>

	<form id="randevuEkleForm" action="hastaSorgulaForRandevu.do"
		method="post">
		<input type="hidden" name="hastaId" id="hasta_id_randevuForm"
			value="${lastHasta.id}"> <input type="hidden"
			name="islem" id="pageAction"> <input type="hidden"
			name="doktorId" id="doktorIdForm"> <input type="hidden"
			name="islemId" id="operasyonIdForm">
	</form>


	<!--DIALOG START................................................................................................................................................................ -->
	<!--DIALOG START................................................................................................................................................................ -->
	<!--DIALOG START................................................................................................................................................................ -->
	<!--DIALOG START................................................................................................................................................................ -->
	<!--DIALOG START................................................................................................................................................................ -->
	<!--DIALOG START................................................................................................................................................................ -->

	<!-- HASTA EKLE ... -->

	<div class="modal fade" id="hastaEkleModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">HASTA EKLE</h4>
				</div>
				<form action="hastaEkle.do" method="post"
					onsubmit="return validateForm()" name="hastaForm">
					<div class="panel-body">

						<div class="row">
							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<input name="ad" id="ad" type="text" placeholder="Ad"
											class="form-control" data-validation="length"
											data-validation-length="min3" />

									</div>
								</div>
							</div>
							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<input id="inputLastName" name="soyad" id="soyad" type="text"
											placeholder="Soyad" class="form-control"
											data-validation="length" data-validation-length="min2" />
									</div>
								</div>
							</div>
						</div>

						<div class="row">

							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<input name="tel" id="tel" type="text" placeholder="Telefon"
											class="form-control" data-validation="required"
											data-validation-length="min11" />
									</div>
								</div>
							</div>

							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<input id="tckimlik" onkeyup="kontrol()" name="tckimlik"
											type="text" placeholder="Tc Kimlik No" class="form-control" />
									</div>
								</div>
							</div>

						</div>

					</div>

					<div class="modal-footer">
						<input id="bntHastaKaydet" type="submit" value="Hasta Ekle"
							class="btn btn-default btn-sm" />

						<button type="button" class="btn btn-default btn-sm"
							data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<!-- HASTA LISTESI ... 
		<div class="modal fade" id="hastaSecModal">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">HASTA LÝSTESÝ</h4>
					</div>
					<div class="panel-body">
					
						<table id="example" class="table" style="font-size: 13px;">
							<thead>
								<tr>
									<th>Protokol No</th>
									<th>Ad</th>
									<th>Soyad</th>
									<th>Telefon</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="hasta" items="${hastaList}">
									<tr>
										<td> <strong> ${hasta.protokolNo} </strong> </td>
										<td> <strong> ${hasta.ad} </strong> </td>
										<td> <strong> ${hasta.soyad} </strong> </td>
										<td> <strong> ${hasta.tel} </strong> </td>
										<td hidden="true">${hasta.id }</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"	id="buttonSec">Seç</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>
				</div>
			</div>
		</div>
		
		-->


	<!-- HASTA GUNCELLE ... -->

	<div id="hastaGuncelleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">HASTA GÜNCELLE</h4>
				</div>

				<form action="HastaGuncelle.do" method="post">
					<div class="panel-body">

						<table class="table table.table-lg">
							<tr>
								<td>Protokol No</td>

								<td><input class="inputTextfield" name="protokolNo"
									id="protokolNo" value="${lastHasta.protokolNo }" /> <input
									type="hidden" name="id" value="${lastHasta.id}"></td>
							</tr>

							<tr>
								<td>TC Kimlik</td>
								<td><input class="inputTextfield" name="tckimlik"
									id="tckimlik" value="${lastHasta.tckimlik }" />
							</tr>
							<tr>
								<td>Ad-Soyad</td>

								<td><input class="inputTextfield" name="ad" id="ad"
									value="${lastHasta.ad }" /> <input
									class="inputTextfield" name="soyad" id="soyad"
									value="${lastHasta.soyad }" /></td>
							</tr>


							<tr>
								<td>Tel</td>
								<td><input class="inputTextfield" name="tel" id="tel"
									value="${lastHasta.tel }" /></td>
							</tr>

						</table>


					</div>

					<div class="modal-footer">
						<input id="bntKaydet" type="submit" value="Güncelle"
							class="btn btn-primary" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>



	<!--- HASTA SIL . -->
	<div id="hastasSilModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">HASTA SÝL</h4>
				</div>
				<form action="HastaSil.do" method="post">
					<div class="modal-body">
						<h4>
							<span> ${lastHasta.ad} ${lastHasta.soyad}
								isimli hasta silinecektir. Emin misiniz? </span>
						</h4>
						<input type="hidden" name="id" value="${lastHasta.id}">


					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<!--- HASTA SIL . -->


	<!--- OPERASYON EKLE. -->

	<div id="operasyonEkleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ EKLE (
						${lastHasta.ad} ${lastHasta.soyad} )</h4>
				</div>


		

			</div>
		</div>
	</div>

	<!--- operasyon sil. -->

	<div id="operasyonSilModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ SÝL</h4>
				</div>
				<form action="OperasyonSil.do" method="post">
					<div class="modal-body">
						<h5>
							<span id="operasyonAd"> </span> <span> isimli tedavi
								silinecektir.. Emin misiniz? </span>
						</h5>
						<input type="hidden" name="id" id="operasyonId">

					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>


	<!--- operasyon bitir. -->
	<div id="operasyonBitirModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ BÝTÝR</h4>
				</div>
				<form action="OperasyonBitir.do" method="post">
					<div class="modal-body">

						<input type="text" class="tarih" name="tarihStr"
							id="operasyonBitirTrhStr" placeholder="Bitirme Tarihi Giriniz.">
						<h5>
							<span id="operasyonAd"> </span> <span> isimli tedavi
								tamamlanacaktýr. Emin misiniz? </span>
						</h5>

						<input type="hidden" name="id" id="operasyonId">

					</div>
					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Bitir" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>
					

				</form>
			</div>
		</div>
	</div>
	<!--- operasyon kesinleþtir. -->
	<div id="operasyonKesinlestirModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ
						KESÝNLEÞTÝR</h4>
				</div>
				<form action="OperasyonuKesinlestir.do" method="post">
					<div class="modal-body">

						<input type="text" name="islemTarihiStr" class="tarih"
							id="operasyonKesinlestirTrhStr"
							placeholder="Kesinleþtirme Tarihi Giriniz.">
						<h5>
							<span id="operasyonAd"> </span> <span> isimli tedavi
								kesinleþtirilecektir. Emin misiniz? </span>
						</h5>
						<input type="hidden" name="islemId" id="operasyonId">

					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Tedavi Kesinleþtir" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>







	<!--- OPERASYON GUNCELLE . -->

	<div id="operasyonGuncelleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ GÜNCELLE</h4>
				</div>

				<form action="OperasyonGuncelle.do" method="post">

					<div class="modal-body">

						<table class="table">
							<tr>
								<td>Doktor</td>
								<td><select size="1" name="doktorId" class="form-control"
									id="doktorId">
										<option label="Diþ Hekimi Seçiniz.." value="-1">
											Hekim Seçiniz</option>

										<c:forEach items="${doktorList}" var="doktorDTO">
											<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
												value="${doktorDTO.dId}">${doktorDTO.dAd }
												${doktorDTO.dSoyad }</option>
										</c:forEach>
								</select></td>

							</tr>
							<tr>
								<td>Tedavi</td>
								<td colspan="2"><select size="1" name="islemTipi"
									id="islemTipi">
										<option label="Tedavi Seçiniz.." value="-1">Tedavi
											Seçiniz..</option>

										<c:forEach items="${islemTurList}" var="islem">
											<option label="${islem.ad}" value="${islem.id }">
												${islem.ad}</option>
										</c:forEach>

								</select> <input type="hidden" name="islemId" id="islemId"></td>

							</tr>

							<tr>
								<td>Tedavi Baþlama - Bitiþ tarihi</td>
								<td><input name="islemTarihiStr" id="islemTarihiStrModal"
									class="tarih" /> - <input name="islemBitisTarihiStr"
									id="islemBitisTarihiStrModal" class="tarih" /></td>

							</tr>
							<tr>
								<td>Ücret :</td>
								<td><input name="miktar" id="tedaviMiktar" /></td>

							</tr>
							<tr>
								<td>Diþ No :</td>
								<td><input name="disNo" id="disNo" /></td>

							</tr>


							<tr>
								<td>Açýklama</td>
								<td><textarea style="width: 394px;" name="aciklama"
										id="opaciklama"></textarea></td>

							</tr>


						</table>



					</div>


					<div class="modal-footer">
						<input type="submit" class="btn btn-primary"
							value="Tedavi Güncelle" id="btn_gonder" name="bnt_gonder" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<!--- ODEME EKLE . -->


	<div id="odemeEkleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">ÖDEME EKLE</h4>
				</div>

				<form action="hastaOdemeEkle.do" method="post">

					<div class="modal-body">
						<input type="hidden" name="islemId" id="islemIdOdemeModal" /> <input
							type="hidden" name="hastaId" id="hastaIdOdemeModal" /> <input
							type="hidden" name="doktorId" id="doktorIdOdemeModal" />



						<table class="table">
							<tr>
								<td>Tarih</td>
								<td><c:choose>
										<c:when test="${odeme_tarih_degistir eq 'on'}">

											<input type="text" name="odemeTarihiStr" class="tarih"
												id="odemeTarihiStrModal" />


										</c:when>
										<c:otherwise>

											<input type="text" name="odemeTarihiStr" class="tarih"
												disabled="disabled" id="odemeTarihiStrModal" />

										</c:otherwise>
									</c:choose></td>
							</tr>

							<tr>
								<td>Kalan Miktar</td>

								<td><input type="text" name="kalanMiktari"
									readonly="readonly" id="kalanOdemeMiktariModal" /></td>
							</tr>


							<tr>
								<td>Ödeme Miktarý</td>

								<td><input type="text" name="miktar" id="odemeMiktarModal" />
									TL</td>
							</tr>

							<tr>
								<td>Kalan Miktar</td>
								<td><input type="text" id="kalanMiktarModal"
									data-validation="required" name="kalanMiktar"
									style="width: 204px; background-color: buttonshadow;">
									TL</td>

							</tr>
							<tr>
								<td>Ödeme Türü</td>
								<td><select size="1" class="form-control" name="odemeTuru">
										<option label="Peþinat" value="2">Peþinat</option>
										<option label="Taksit" value="3">Taksit</option>
										<option label="Kredi Kartý" value="4">Kredi Kartý</option>
										<option label="EFT / Havale" value="5">EFT / Havale</option>

								</select></td>

							</tr>



							<tr>
								<td>Açýklama</td>
								<td><textarea rows="3" cols="50" name="aciklamaOdemeModal"></textarea></td>
							</tr>


						</table>

					</div>

					<div class="modal-footer">
						<input type="submit" class="btn btn-primary" value="Ödeme Ekle"
							id="btn_gonder" name="bnt_gonder">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>

			</div>
		</div>
	</div>




	<!-- odeme guncelle -->

	<div id="odemeGuncelleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">ÖDEME GÜNCELLE</h4>
				</div>


				<form action="OdemeGuncelle.do" method="post">

					<div class="modal-body">

						<input type="hidden" name="id" id="odemeGuncelleId">
						<table class="table">

							<tr>
								<td>Tarih</td>
								<td><input name="odemeTarihiStr" class="tarih"
									id="odemeTarihiStrOdemeGuncelleModal" /></td>
							</tr>

							<tr>
								<td>Miktar</td>

								<td><input type="text" name="miktar"
									id="odememiktarguncellemeModal" /> TL</td>
							</tr>
							<tr>
								<td>Odeme Türü</td>

								<td><select size="1" class="form-control" name="odemeTuru">
										<option label="Peþinat" value="2" />
										<option label="Taksit" value="3" />
										<option label="Kredi Kartý" value="4" />

								</select></td>
							</tr>




							<tr>
								<td>Açýklama</td>
								<td><textarea rows="3" cols="50" name="aciklama"
										id="odemeaciklamaguncellemeModal"> </textarea></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;"></td>
							</tr>

						</table>

					</div>


					<div class="modal-footer">
						<input type="submit" class="btn btn-primary"
							value="Ödeme Güncelle" id="btn_gonder" name="bnt_gonder">
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>


				</form>


			</div>
		</div>
	</div>

	<!-- odeme sil -->

	<div id="odemeSilModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">ÖDEME SÝL</h4>
				</div>
				<form action="OdemeSil.do" method="post">
					<div class="modal-body">
						<h5>
							<span id="odemeMiktar"> </span> <span> TL miktarýnda ödeme
								silinecektir.. Emin misiniz? </span>
						</h5>
						<input type="hidden" name="id" id="odemeId">

					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>


	<!--- operasyon odeme gunu ekle -->
	<div id="operasyonOdemeGunuGirModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">BORÇ TARÝHÝ
						EKLE</h4>
				</div>
				<form action="borcOdemeTarihEkle.do" method="post">

					<div class="modal-body">

						<input type="hidden" name="islemId" id="islemId" /> <input
							type="hidden" name="hastaId" value="${lastHasta.id}" />

						<table class="table">
							<tr>
								<td>Kalan Ödeme Miktarý:</td>
								<td><input type="text" id="kalan" name="kalan"></td>

							</tr>
							<tr>
								<td>Borcun Ödeneceði Tarih:</td>
								<td><input type="text" id="borcOdemeTarihiStr"
									name="borcOdemeTarihiStr" class="tarih"
									data-validation="required"></td>

							</tr>
							<tr>
								<td>Borcun Ödeneceði Miktar:</td>
								<td><input type="text" name="miktar" id="borcOdemeMiktar"
									data-validation="required"> TL</td>

							</tr>
							<tr>
								<td>Açýklama :</td>
								<td><textarea id="borcOdemeaciklama" name="aciklama"
										cols="40" rows="3"></textarea></td>

							</tr>

						</table>


					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>


	<div id="anketEkleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">
						HASTA MEMNUNÝYET FORMU <br>
						${lastHasta.ad} ${lastHasta.soyad}
					</h4>
				</div>

				<form action="anketEkle.do" method="post"
					onsubmit="return validation()">
					<div class="modal-body">



						<table class="table">

							<tr>
								<td>Tarihi</td>
								<td><input name="tarihStr" class="tarih"
									id="anketAramaTArihi" data-validation="required" /> <input
									type="hidden" name="hastaId" value="${lastHasta.id}"
									id="hastaId"></td>


							</tr>

							<tr>
								<td>Saat</td>
								<td><select size="1" name="saat" id="saat"
									style="width: 86px; font-size: 12px" data-validation="required">
										<option value="-1" label="Saat">
											<c:forEach items="${saatler}" var="saat">
												<option value="${saat}" label="${saat}"></option>
											</c:forEach>
								</select> : <select name="dakika" size="1" id="dakika"
									style="width: 86px; font-size: 12px">
										<option value="-1" label="Dk">
											<c:forEach items="${dakikalar}" var="dakika">
												<option label="${dakika }" value="${dakika }">
											</c:forEach>
								</select></td>

							</tr>
							<tr>
								<td>Memnuniyet Derecesi</td>
								<td><select size="1" name="memnuniyetDerecesi"
									id="memnuniyetDerecesi" data-validation="required">
										<option value="-1" label="Memnuniyet Derecesi">
										<option value="4" label="Çok iyi">
										<option value="3" label="Ýyi">
										<option value="2" label="Kötü">
										<option value="1" label="Çok Kötü">
								</select></td>
							</tr>


							<tr>
								<td>Not </td>
								<td><textarea name="aciklama" id="aciklama"></textarea></td>


							</tr>

						</table>



					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- ARAMA KAYDI EKLEEE.. -->

	<div id="aramaKaydiEkleModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">
						HASTA ARAMA KAYDI GÝRÝÞÝ (KESINLEÞMEMÝÞ OPERASYONLAR) <br>
						${lastHasta.ad} ${lastHasta.soyad}
					</h4>
				</div>

				<form action="aramaKaydiEkle.do" method="post"
					onsubmit="return validation()">

					<input type="hidden" name="islemId" id="islemId"> <input
						type="hidden" name="hastaId" value="${lastHasta.id}"
						id="hastaId">
					<div class="modal-body">
						<span id="operasyonAd"> </span>
						<table class="table">

							<tr>
								<td>Arama Tarihi</td>
								<td><input class="tarih" name="aramaTarihiStr"
									id="aramaTarihiEkleStr" /></td>
							<tr>
								<td>Saat</td>
								<td><select size="1" name="saat" id="saat"
									style="width: 86px; font-size: 12px">
										<option value="-1" label="Saat">
											<c:forEach items="${saatler}" var="saat">
												<option value="${saat}" label="${saat}"></option>
											</c:forEach>
								</select> : <select name="dakika" id="dakika" size="1"
									style="width: 86px; font-size: 12px">
										<option value="-1" label="Dk">
											<c:forEach items="${dakikalar}" var="dakika">
												<option label="${dakika }" value="${dakika }">
											</c:forEach>
								</select></td>

							</tr>


							<tr>
								<td>Arama Açýklama</td>
								<td><textarea name="aciklama" id="aciklama"></textarea></td>


							</tr>


						</table>
					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-primary" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
					</div>
				</form>
			</div>
		</div>
	</div>




	<div id="randevuEkleModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">RANDEVU EKLE</h4>
				</div>



				<div class="modal-body">

					<div class="row">
						<div class="col-lg-12 col-md-12">
							<div id="calendar"></div>
						</div>

					</div>

				</div>
				<div class="modal-footer" >
					<input type="submit" class="btn btn-primary" value="Randevu Ekle"
						id="btn_gonder" name="bnt_gonder" />
					<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
				</div>




			</div>
		</div>
	</div>
	
	
	
	<div id="odemeListModal" class="modal fade" >
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">ÖDEME LÝSTESÝ</h4>
				</div>



				<div class="modal-body">

					<div class="row">
						
						<p id="odemeList" > </p>

					</div>

				</div>
				<div class="modal-footer">
					<input type="submit" class="btn btn-primary" value="Randevu Ekle"
						id="btn_gonder" name="bnt_gonder" />
					<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
				</div>




			</div>
		</div>
	</div>
	
	
	<div id="hastaSorgulaModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">


				<div class="modal-body">

								<div class="panel panel-default" >
								
			
			<div class="panel-heading" >
				 Hasta Arama
				</div>
				
				<div class="panel-body" >  
				
						
						<div class="row" >
						
							<div class="col-lg-3 col-md-3 col-sm-3">
								<input class="form-control" name="protokolNo" id="hstPrt" placeholder="P. No"    />
							</div>
							<div class="col-lg-3 col-md-3 col-sm-3">
								<input class="form-control" name="ad" id="hstAdi" placeholder="Ad"   />
							</div>

							<div class="col-lg-2 col-md-2 col-sm-2">
								<input class="form-control" name="soyad" id="hstSoyadi"	placeholder="Soyad"   />
							</div>
							
							<div class="col-lg-2 col-md-2 col-sm-2">
								<input class="form-control" name="tel" id="hastaTeli"	placeholder="Telefon"   />
							</div>
					
							<div class="col-lg-2 col-md-2 col-sm-2">
								<input type="submit" class=" btn btn-sm btn-primary" value="Ara" name="bnt_gonder" id="hastaListele" />
							</div>
					
								
						</div>
								
						
								
						
					<hr>
						<div id="hastaTable" >


						</div>
						
						

		</div>
						
				</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Vazgeç</button>
				</div>




			</div>
		</div>
	</div>

	<!-- button actions dialogsss  END .. -->
	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/jquery-ui.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/zebra_datepicker.js" charset="UTF-8"></script>
  


	<script type="text/javascript">
		
	
	function checkTedavi() {
			
			
				var miktar = $("#operasyonUcret").val();
				var disNo = $("#disNo").val();
				var tedavi = $("#islemTipi option:selected").html();
	
				var message = $.trim(tedavi) + ' tedavisi ve ' + disNo
						+ ' numaralarý için tedavi fiyatý:' + miktar
						+ ' olarak belirlenmiþtir. Kaydetmek için emin misiniz?';
	
				if (confirm(message)) {
	
					return true;
				} else {
	
					return false;
	
				}

		}

		function validateFormOperasyonEkle() {
			
			var doktorId = document.forms["operasyonEkleForm"]["doktorId"].value;

			var tedaviId = document.forms["operasyonEkleForm"]["islemTipi"].value;
			
			var disNo = document.forms["operasyonEkleForm"]["disNo"].value;
			
			var kalanMiktar = document.forms["operasyonEkleForm"]["kalanMiktar"].value;
			
			


			if (disNo == null || disNo == "" ) {
				alert("Lütfen Tedavi Uygulanacak Diþ Numarasý Seçiniz.");
				return false;
			}
			if (doktorId == null || doktorId == -1) {
				alert("Lütfen Doktor Seçiniz.");
				return false;
			}
			if (tedaviId == null || tedaviId == -1) {
				alert("Lütfen Tedavi Seçiniz.");
				return false;
			}
			
			if (kalanMiktar <0) {
				alert("Lütfen Ödeme Miktarýný Kontrol ediniz.");
				return false;
			}
			
			var miktar = $("#operasyonUcret").val();
			var disNo = $("#disNo").val();
			var tedavi = $("#islemTipi option:selected").html();

			var message = $.trim(tedavi) + ' tedavisi ve ' + disNo
					+ ' numaralarý için tedavi fiyatý:' + miktar
					+ ' olarak belirlenmiþtir. Kaydetmek için emin misiniz?';

			if (confirm(message)) {

				return true;
			} else {

				return false;

			}

		}
		
		function validateFormHastaSorgulama() {

			var protokol = document.forms["hastaSorgulaForm"]["hstProtokol"].value;

			var ad = document.forms["hastaSorgulaForm"]["hstAd"].value;

			var soyad = document.forms["hastaSorgulaForm"]["hstSoyad"].value;

			if (protokol == "" && ad == "" && soyad == "") {

				alert("Lütfen sorgulama alaný seçiniz..");

				return false;
			}
		}

		<c:if test="${not empty warn}">
		alert('${warn}')
		</c:if>

		$(document)
				.ready(
						function() {
							
							var date = $.datepicker.formatDate(
									'yy.mm.dd', new Date());

							$("#islemTarihiStr").val(date);
							$("#odemeTarihiStr").val(date);
							

							var myLanguage = {
								errorTitle : 'Form submission failed!',
								requiredFields : 'You have not answered all required fields',
								badTime : 'You have not given a correct time',
								badEmail : 'You have not given a correct e-mail address',
								badTelephone : 'You have not given a correct phone number',
								badSecurityAnswer : 'You have not given a correct answer to the security question',
								badDate : 'You have not given a correct date',
								lengthBadStart : 'The input value must be between ',
								lengthBadEnd : ' karakter olmalý.',
								lengthTooLongStart : 'The input value is longer than ',
								lengthTooShortStart : 'Giriþ en az ',
								notConfirmed : 'Input values could not be confirmed',
								badDomain : 'Incorrect domain value',
								badUrl : 'The input value is not a correct URL',
								badCustomVal : 'The input value is incorrect',
								andSpaces : ' and spaces ',
								badInt : 'Lütfen numara giriþi yapýnýz',
								badSecurityNumber : 'Your social security number was incorrect',
								badUKVatAnswer : 'Incorrect UK VAT Number',
								badStrength : 'The password isn\'t strong enough',
								badNumberOfSelectedOptionsStart : 'You have to choose at least ',
								badNumberOfSelectedOptionsEnd : ' answers',
								badAlphaNumeric : 'The input value can only contain alphanumeric characters ',
								badAlphaNumericExtra : ' and ',
								wrongFileSize : 'The file you are trying to upload is too large (max %s)',
								wrongFileType : 'Only files of type %s is allowed',
								groupCheckedRangeStart : 'Please choose between ',
								groupCheckedTooFewStart : 'Please choose at least ',
								groupCheckedTooManyStart : 'Please choose a maximum of ',
								groupCheckedEnd : ' item(s)',
								badCreditCard : 'The credit card number is not correct',
								badCVV : 'The CVV number was not correct',
								wrongFileDim : 'Incorrect image dimensions,',
								imageTooTall : 'the image can not be taller than',
								imageTooWide : 'the image can not be wider than',
								imageTooSmall : 'the image was too small',
								min : 'min',
								max : 'max',
								imageRatioNotAccepted : 'Image ratio is not accepted'
							};


							$('#implantAktif').bind('change', function() {

								if ($(this).is(':checked')) {

									$("#islemTipi").val(24);
									$("#implantOk").show();
								} else {
									$("#islemTipi").show();
									$("#implantOk").hide();
								}
							});

							$("#odemeMiktarModal")
									.keyup(
											function() {
												var opUcret = $(
														"#kalanOdemeMiktariModal")
														.val();
												var miktar = $(
														"#odemeMiktarModal")
														.val();
												var kalan = opUcret - miktar;
												if (kalan < 0) {
													alert("Kalan Miktar negatif olamaz..")
													$("#kalanMiktarModal").val(
															null);
												} else {
													$("#kalanMiktarModal").val(
															kalan);

												}
											});

							$("#odemeMiktar").keyup(function() {

								var opUcret = $("#operasyonUcret").val();
								var miktar = $("#odemeMiktar").val();
								var kalan = opUcret - miktar;
								$("#kalanMiktar").val(kalan);
							});

							$('input.tarih').Zebra_DatePicker({
								show_icon	: false
								
							});
							
							

							var disno = [];
							var disAdet = 0;

							$('.disno').on('click', function(e) {

								var button = $(this);
								var no= button.children("span").text();

								var varmi = true;
								for (i = 0; i < disno.length; i++) {
									text = disno[i];
									if (text == no)
										varmi = false;
								}
								if (varmi) {
									disno.push(no);
									disAdet++;

								}

								varmi = true;
								//var txtdisno=$('#disNo').val() +no;							
								$('#disNo').val(disno);

								$('#disAdet').val(disAdet);
								
								var adet = $('#disAdet').val();
								var value = $('#islemTipi').val();
								
								'<c:forEach items="${islemTurList}" var="islem">'

								if (value == '${islem.id}') {

									var fiyat = '${islem.subeTip.fiyat}';

									$('#operasyonUcret').val(fiyat * adet);

								}

								'</c:forEach>'

							});

							$('#disnosil').on('click', function(e) {

								var no = $(this).html();
								disno.pop();
								//var txtdisno=$('#disNo').val() +no;							
								$('#disNo').val(disno);

								if (disAdet > 0)
									disAdet--;

								$('#disAdet').val(disAdet);
								
								var adet = $('#disAdet').val();
								var value = $('#islemTipi').val();
								
								'<c:forEach items="${islemTurList}" var="islem">'

								if (value == '${islem.id}') {

									var fiyat = '${islem.subeTip.fiyat}';

									$('#operasyonUcret').val(fiyat * adet);

								}

								'</c:forEach>'

							});

							//OPERASYON SIL

							$('#operasyonSilModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button that triggered the modal
										var recipient = button.data('opid') // Extract info from data-* attributes
										var opads = button.data('opad') // Extract info from data-* attributes

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)
										modal.find('#operasyonId').val(
												recipient)
										modal.find('#operasyonAd').html(opads)
									});

							//OPERASYON BITIR
							$('#operasyonBitirModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button that triggered the modal
										var opid = button.data('opid') // Extract info from data-* attributes
										var opads = button.data('opad')

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)
										modal.find('#operasyonId').val(opid)
										modal.find('#operasyonAd').html(opads)

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										$("#operasyonBitirTrhStr").val(date)

									});

							//OPERASYON KESINLESTIR
							$('#operasyonKesinlestirModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button that triggered the modal
										var opid = button.data('opid') // Extract info from data-* attributes
										var opads = button.data('opad')

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)
										modal.find('#operasyonId').val(opid)
										modal.find('#operasyonAd').html(opads)

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										$("#operasyonKesinlestirTrhStr").val(
												date)

									});

							//OPERASYON EKLE
							$('#operasyonEkleModal').on(
									'show.bs.modal',
									function() {
										$(this).find('.modal-dialog').css({
											width : '100%', //probably not needed
											height : '100%', //probably not needed 
										});

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										$("#islemTarihiStr").val(date);
										$("#odemeTarihiStr").val(date);

									});

							//OPERASYON GUNCELLE
							$('#operasyonGuncelleModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var opid = button.data('opid')
										var opad = button.data('opad')
										var opislem = button.data('opislem')
										var opbastar = button.data('opbastar')
										var opbittar = button.data('opbittar')
										var opucret = button.data('opmiktar')
										var opaciklama = button
												.data('opaciklama')
										var opdisno = button.data('opdisno')
										var opdurum = button.data('opdurum')
										var opdoktor = button.data('opdoktor')

										var arr = opbastar.split('-');

										var opbasTarFormat = arr[0] + "."
												+ arr[1] + "." + arr[2];
										var opbitTarFormat = opbittar;
										if (opbittar != "") {
											var arrBit = opbittar.split('-');

											var opbitTarFormat = arrBit[0]
													+ "." + arrBit[1] + "."
													+ arrBit[2];
										}

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)
										modal.find('#islemId').val(opid)
										modal.find('#islemTipi').val(opislem)
										modal.find('#opaciklama').val(
												opaciklama)
										modal.find('#islemTarihiStrModal').val(
												opbasTarFormat)
										modal.find('#islemBitisTarihiStrModal')
												.val(opbitTarFormat)
										modal.find('#tedaviMiktar')
												.val(opucret)
										modal.find('#disNo').val(opdisno)
										modal.find('#doktorId').val(opdoktor)
									});

							// ODEME EKLE
							$('#odemeEkleModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget) // Button that triggered the modal
										var opid = button.data('opid') // Extract info from data-* attributes
										var doktorId = button.data('doktorid') // Extract info from data-* attributes
										var hastaId = button.data('hastaid') // Extract info from data-* attributes
										var kalanMiktar = button
												.data('odkalanmiktar') // Extract info from data-* attributes

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)

										modal.find('#odemeTarihiStrModal').val(
												date)

										modal.find('#kalanOdemeMiktariModal')
												.val(kalanMiktar)
										modal.find('#islemIdOdemeModal').val(
												opid)
										modal.find('#hastaIdOdemeModal').val(
												hastaId)
										modal.find('#doktorIdOdemeModal').val(
												doktorId)

									});

							$('#odemeGuncelleModal')
									.on(
											'show.bs.modal',
											function(event) {
												var button = $(event.relatedTarget) // Button that triggered the modal
												var odemeId = button
														.data('odemeid') // Extract info from data-* attributes
												var odememiktar = button
														.data('odememiktar') // Extract info from data-* attributes
												var odemeaciklama = button
														.data('odemeaciklama') // Extract info from data-* attributes

												var date = $.datepicker
														.formatDate('yy.mm.dd',
																new Date());

												// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
												// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
												var modal = $(this)
												modal.find('#odemeGuncelleId')
														.val(odemeId)
												modal
														.find(
																'#odememiktarguncellemeModal')
														.val(odememiktar)
												modal
														.find(
																'#odemeaciklamaguncellemeModal')
														.val(odemeaciklama)

												modal
														.find(
																'#odemeTarihiStrOdemeGuncelleModal')
														.val(date)

											});

							$('#odemeSilModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var odemeId = button.data('odemeid')
										var odememiktar = button
												.data('odememiktar')

										var modal = $(this)
										modal.find('#odemeId').val(odemeId)
										modal.find('#odemeMiktar').html(
												odememiktar)

									});

							$('#operasyonOdemeGunuGirModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var opid = button.data('opid')
										var kalanMiktar = button
												.data('kalanmiktar')

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										var modal = $(this)
										modal.find('#islemId').val(opid)
										modal.find('#kalan').val(kalanMiktar)
										modal.find('#borcOdemeTarihiStr').val(
												date)

									});

							$('#aramaKaydiEkleModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var opid = button.data('opid')
										var opad = button.data('opad')

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());

										var modal = $(this)
										modal.find('#islemId').val(opid)
										modal.find('#operasyonAd').html(opad)
										modal.find('#aramaTarihiEkleStr').val(
												date)
									});
							$('#odemeListModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var odemeList = button.data('data-odemeList')
										var modal = $(this)
										modal.find('#odemeList').val(odemeList)
									});

							$('#randevuEkleModal').on(
									'show.bs.modal',
									function(event) {
										$(this).find('.modal-dialog').css({
											width : '100%',
											height : '700',
										});
										var button = $(event.relatedTarget)
										var opid = button.data('opid')
										var opad = button.data('opad')
										var opislem = button.data('opislem')
										var opbastar = button.data('opbastar')
										var opbittar = button.data('opbittar')
										var opucret = button.data('opmiktar')
										var opaciklama = button
												.data('opaciklama')
										var opdisno = button.data('opdisno')
										var opdurum = button.data('opdurum')

										var doktorAd = '${doktorAd}'
										alert(doktorAd)
										var arr = opbastar.split('-');

										var opbasTarFormat = arr[0] + "."
												+ arr[1] + "." + arr[2];
										var opbitTarFormat = opbittar;
										if (opbittar != "") {
											var arrBit = opbittar.split('-');

											var opbitTarFormat = arrBit[0]
													+ "." + arrBit[1] + "."
													+ arrBit[2];
										}

										// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
										// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
										var modal = $(this)
										modal.find('#islemId').val(opid)
										modal.find('#islemTipi').val(opislem)
										modal.find('#opaciklama').val(
												opaciklama)
										modal.find('#islemTarihiStrModal').val(
												opbasTarFormat)
										modal.find('#islemBitisTarihiStrModal')
												.val(opbitTarFormat)
										modal.find('#miktar').val(opucret)
										modal.find('#disNo').val(opdisno)

									});

							

							$('#islemTipi').on('change', function() {

								var adet = $('#disAdet').val()
								var value = this.value;
								'<c:forEach items="${islemTurList}" var="islem">'

								if (value == '${islem.id}') {

									var fiyat = '${islem.subeTip.fiyat}';

									$('#operasyonUcret').val(fiyat * adet);

								}

								'</c:forEach>'

							});

							$('.randevuEkleButton')
									.click(
											function(event) {

												var doktorId = $(this).val();

												var opid = $(this).attr(
														'data-opId');

												$('#pageAction')
														.val(
																'randevu-getir-hasta-islemleri');
												$('#doktorIdForm')
														.val(doktorId);
												$('#operasyonIdForm').val(opid);
												$('#randevuEkleForm').submit();
											});

							'<c:if test="${!empty hastaListesi}">' // randevu sayfasindan hasta sec ile gelen hasta

							$('#hastaPanel').prop("hidden", false);

							'</c:if>'
							
							
							$("#SorguInput").autocomplete({
					            source:'hastaBasicSorgula.do',
					            minLenght:3,
					            
					            focus:function(event,ui){
					                
					                $("#SorguInput").val(ui.item.value);
					                return false;
					            },
					            select:function(event,ui){
					            	  $("#hastaId4Seacrh").val(ui.item.id);
					            	  
					            	  $("#btnHastaGetir").prop('disabled', false);
					            	 
					            },
					            close: function( event, ui ) {
					            }
					            
					        });

							$("#SorguInputPrtk").autocomplete({
					            source:'hastaSorgula4Protokol.do',
					            minLenght:3,
					            
					            focus:function(event,ui){
					                
					                $("#SorguInputPrtk").val(ui.item.value);
					                return false;
					            },
					            select:function(event,ui){
					            	  $("#hastaId4Seacrh").val(ui.item.id);
					            	  
					            	  $("#btnHastaGetir").prop('disabled', false);
					            	 
					            },
					            close: function( event, ui ) {
					            }
					            
					        });
							
												
							
							$('#hastaListele').click(function() {
								
								$.ajax({
									type : 'POST',
									url : 'hastaBasicSorgula.do',
									data : 'protokolNo=' + $('#hstPrt').val()+'&ad='+$('#hstAdi').val()+'&soyad='+$('#hstSoyadi').val()+'&tel='+$('#hastaTeli').val(),
									dataType : 'text',
									success : function(data) {
										
										aa = jQuery.parseJSON(data)
				                        var options = [];
										
										$('#hastaTable').empty();
										
										var table= '<table id="example" class="table table-border" >';
										
										table += '<thead >';
										table += '<tr>';
										table += '<th>Protokol</th>';
										table += '<th>Ad</th>';
										table += '<th>Soyad</th>';
										table += '<th>Telefon</th>';
										table += '<th style="visibility: hidden; width: 1px;"></th>';
										table += '</tr>';
										table += '</thead>';
										table += '<tbody>';
										
										
				                        for (var i = 0; i < aa.length; i++) {
				                        	
				                        	var row ='<tr>';
				                        	
				                            var id= aa[i]['id'];
				                            var protokolNo= aa[i]['protokolNo'];
				                            var ad= aa[i]['ad'];
				                            var soyad= aa[i]['soyad'];
				                            var tel= aa[i]['tel'];
				                        	
				                           
				                            row +='<td>' ; 	row += protokolNo;  row +="</td>";
				                            row +='<td>'  ;	row += ad;  row +="</td>";
				                            row +="<td>"  ; row += soyad;  row +="</td>";
				                            row +="<td>"  ; row += tel;  row +="</td>";
				                            row +='<td>  <button type="button" class="btn btn-primary btn-sm sec" value="Seç"> Seç </button> </td></td> ';
				                            row +='<td class="nr" style="visibility: hidden; width: 1px;">';   row += id;  row +="</td>";
				                            
				                            row += '</tr>';
				                        	
				                        	table += row;
				                        }
				                        
				                        table += '</tbody>';
										table += '</table>';
										
										$('#hastaTable').append(table);
										
										
										
										$('.sec').click(
												function() {
													
													var item = $(this).closest("tr")   // Finds the closest row <tr> 
								                       .find(".nr")     // Gets a descendent with class="nr"
								                       .text(); 
								                       
													$('#hasta_idSorgulama')
													.val(item);
													$('#send').submit();
													
												});
									    
									}
								})
							})
							

						});
	</script>

</body>
</html>