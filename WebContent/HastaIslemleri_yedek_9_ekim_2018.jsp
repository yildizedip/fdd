<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>
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


<link type="text/css" rel="stylesheet" href="sitil/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="css/zebra-datepicker.css" />
<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">

<style type="text/css">
.modal-header, .close {
	background-color: #5cb85c;
	color: white !important;
	text-align: center;
	font-size: 30px;
}

.modal-footer {
	background-color: #f9f9f9;
}

.disno {
 font-size: 10px;

}

th { font-size: 11px; }
td { font-size: 11px; }

</style>

</head>

<body style="color: black; background-color: white;">

							<c:forEach items="${ayarlar}" var="ayar" >
							
								<c:if test="${ayar.name eq 'odeme_tarih_degistir' }">
									
									<c:set var="odeme_tarih_degistir" value="${ayar.value}"> </c:set>
								</c:if> 
							
							</c:forEach>
							
							

	<div class="container col-lg-12 col-md-12" style="font-size: 13px;">

		<div class="row">
		

		<div class="collapse in " id="hastaAra">
			
			<div class="col-lg-4">
			
			
			<button type="button" class="btn btn-link btn-sm pull-right " data-toggle="modal"
						data-target="#hastaEkleModal">Hasta Ekle</button>
						
			<div class="panel panel-default" >
			
			<div class="panel-heading" >
				 Hasta Listesi
				</div>
				
				<div class="panel-body" >  
				
						<form class="form-inline" action="hastaBasicSorgula.do" method="post"
						id="hastaSorgulaForm">
						
						 
						
							<div class="form-group">
								<input class="form-control" name="protokolNo" id="hstPrt" placeholder="P. No"    />
							</div>
							<div class="form-group">
								<input class="form-control" name="ad" id="hstAd" placeholder="Ad"   />
							</div>

							<div class="form-group">
								<input class="form-control" name="soyad" id="hstSoyad"	placeholder="Soyad"   />
							</div>
							
							<div class="form-group">
								<input class="form-control" name="tel" id="tel"	placeholder="Telefon"   />
							</div>
						
							<div class="form-group">
								<input type="submit" class="btn btn-sm btn-default" value="Ara" name="bnt_gonder" />
								
								</div>
						</form>
					<hr>
				<c:if test="${!empty hastaList}">
						<div id="hastaTable" >

							<table id="example" class="table table-default"  >
								<thead >
									<tr>
										<th>Prt.No</th>
										<th>Ad</th>
										<th>Soyad</th>
										<th>Telefon</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="hasta" items="${hastaList}">
										<tr>
											<td>${hasta.protokolNo}</td>
											<td>${hasta.ad}</td>
											<td >${hasta.soyad}</td>
											<td >${hasta.tel}</td>
											<td hidden="true" width="1px;" style="size: 2px; font-size: 1px;">${hasta.id}</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>

						</div>
						
							<button type="button" class="btn btn-default"  id="buttonSec"> Seç </button>
						
						</c:if>

		</div>
						
				</div>
		</div>
	</div>
		
<c:if test="${!empty hastaListesi}">

			<div class="col-lg-8" id="hastaPanel" >
			
				<div class="panel panel-default">

					<div class="panel-heading" >
					
					
					<div class="row">
						  
						 	 <div class="col-lg-7" style="font-size: 12px;"> 
						  			${hastaListesi[0].ad}
										${hastaListesi[0].soyad} (${hastaListesi[0].tel}) &nbsp;&nbsp;
										Protokol No : ${hastaListesi[0].protokolNo}
										
							</div>
							
							<div class="col-lg-5"> 
										<c:if test="${silAktif ne '0' }">
											<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
				
												<button type="button" class="btn btn-link btn-xs " data-toggle="modal"
													data-target="#hastaGuncelleModal"
													data-whatever="${hastaListesi[0].id}">Güncelle</button>
												<button type="button" class="btn btn-link btn-xs" data-toggle="modal"
													data-target="#operasyonEkleModal"
													data-whatever="${hastaListesi[0].id}">Tedavi Ekle</button>
												<button type="button" class="btn btn-link btn-xs" data-toggle="modal"
													data-target="#anketEkleModal"
													data-whatever="${hastaListesi[0].id}">Anket Ekle</button>
												<button type="button" class="btn btn-link btn-xs " style="color: red;"
													data-toggle="modal" data-target="#hastasSilModal"
													data-whatever="${hastaListesi[0].id}">Sil</button>
											</c:if>
				
										</c:if>
							</div>
						
						</div>
						
						
						</div>
						
						<div class="panel-body">
						
				<div class="col-lg-12"> 

				<div id="tab-general">
					<div class="row mbl">
						<ul id="generalTab" class="nav nav-tabs responsive">
							<li class="active"><a href="#tedavi-tab" data-toggle="tab">Tedavi
									Ve Ödemeler</a></li>
							<li><a href="#anket-tab" data-toggle="tab">Anket</a></li>
							
						</ul>
						<div id="generalTabContent" class="tab-content responsive">

							<div id="tedavi-tab" class="tab-pane fade in active">
								
								<div style="font-size: 11px;">

								<c:forEach items="${hastaListesi[0].hastaOperasyonList}"
									var="operasyon" varStatus="count">

									<div class="panel"
										 >


										<div class="panel-heading"
										
										<c:choose>
																	<c:when test="${operasyon.durumu eq 'A'}">style="background-color: #ECF8E0"</c:when>
																	<c:when test="${operasyon.durumu eq 'B'}">style="background-color: #EFF8FB"</c:when>		
																	<c:when test="${operasyon.durumu eq 'K'}">style="background-color: #FBEFF2"</c:when>		
										</c:choose> 
										
										 >
											<div class="row">
												<div>
													Tedavi: ${operasyon.islemTip.ad} (${operasyon.disNo})
													&nbsp; &nbsp; &nbsp; Hekim: ${operasyon.doktor.dAd}
													${operasyon.doktor.dSoyad} &nbsp; &nbsp; &nbsp; Durum :

													<c:choose>
														<c:when test="${operasyon.durumu eq 'A'}">Devam Ediyor</c:when>
														<c:when test="${operasyon.durumu eq 'B'}">Bitmiþ</c:when>
														<c:when test="${operasyon.durumu eq 'K'}">Kesinleþmedi</c:when>
													</c:choose>
													  
													  &nbsp; &nbsp; &nbsp; Tarih:${operasyon.islemTarihi}  &nbsp; &nbsp; &nbsp; Fiyat: ${operasyon.miktar}
													  
														 &nbsp; &nbsp; &nbsp;  <c:if test="${operasyon.aciklama ne ''}"> Açýklama:${operasyon.aciklama}  </c:if>

													<button type="button" class="btn btn-success btn-xs pull-right"
														data-toggle="collapse" data-target="#${operasyon.id}">
														Detay</button>

												</div>


											</div>
										</div>

										<div class="collapse" id="${operasyon.id}" >
											<div class="panel-body ">
											

												<div class="col-lg-5 col-md-5">

													

														<div>
														<strong>Tedavi Tarihi :  </strong>
														${operasyon.islemTarihi} 
															${operasyon.islemBitisTarihi}
															
															</div>

														<div> <strong>Diþ Sayýsý :  </strong>    ${operasyon.disAdet}</div>

														<div> <strong>Diþ No'lar :  </strong>  ${operasyon.disNo}</div>

														<div>
															<c:if test="${!empty operasyon.implantCerrahDoktor}">
																						           ( Cerrah Hekim: 
																								${operasyon.implantCerrahDoktor.dAd} 
																								${operasyon.implantCerrahDoktor.dSoyad} 
																						</c:if>
															<c:if test="${!empty operasyon.implantDestekDoktor}">
																									Yardýmcý Hekim : 
																								${operasyon.implantDestekDoktor.dAd} 
																								${operasyon.implantDestekDoktor.dSoyad} )
																						</c:if>
														</div>
													


														<div>  <strong> Tedavi Fiyat : </strong>  ${operasyon.miktar}</div>
														<div>  <strong> Kalan Ödeme Miktarý : </strong>   ${operasyon.kalanMiktar} </div>
														<div> <strong> Açýklama : </strong>   ${operasyon.aciklama}</div>

												</div>


												<div class="col-lg-7 col-md-7">

													<c:if test="${!empty operasyon.odemeList}">
														<table class="table table-hover table-bordered">
															<thead>
																<tr>
																	<td class="helpHed">Ödeme Tarih</td>
																	<td class="helpHed">Miktar</td>
																	<td class="helpHed">Tür</td>
																	<td class="helpHed">Açýklama</td>

																	<c:if test="${silAktif ne '0' }">
																		<td class="helpHed"></td>
																		<td class="helpHed"></td>
																	</c:if>
																</tr>

															</thead>
															<tbody>

																<c:forEach items="${operasyon.odemeList}" var="odeme"
																	varStatus="count">

																	<tr>
																		<td class="helpBod">${odeme.odemeTarihi}</td>
																		<td class="helpBod">${odeme.miktar}</td>
																		
																		
																	

																		<td><c:choose>
																				<c:when test="${odeme.odemeTuru eq 1}">
																								Toplam Miktar
																								</c:when>
																				<c:when test="${odeme.odemeTuru eq 2}">
																								Peþinat
																								</c:when>

																				<c:when test="${odeme.odemeTuru eq 3}">
																								Taksit
																								</c:when>
																				<c:when test="${odeme.odemeTuru eq 4}">
																								Kredi Kartý
																								</c:when>
																				<c:when test="${odeme.odemeTuru eq 5}">
																								EFT / Havale
																								</c:when>

																			</c:choose></td>

																		<td class="helpBod">${odeme.aciklama}</td>

																		<c:if test="${silAktif ne '0' }">
																			<c:if
																				test="${sessionScope.sessionMember[0].kuTur ne '3' }">
																				<td class="helpBod">
																					<button type="button" class="btn btn-link btn-xs"
																						data-toggle="modal"
																						data-target="#odemeGuncelleModal"
																						data-odemeid="${odeme.id}"
																						data-odememiktar="${odeme.miktar}"
																						data-odemeaciklama="${odeme.aciklama}">
																						Güncelle</button>

																				</td>
																				<td class="helpBod">
																					<button type="button" class="btn btn-link btn-xs"
																						data-toggle="modal" data-target="#odemeSilModal"
																						data-odemeid="${odeme.id}"
																						data-odememiktar="${odeme.miktar}">Sil</button>
																				</td>

																			</c:if>


																		</c:if>
																	</tr>


																</c:forEach>

															</tbody>


														</table>
													</c:if>

												</div>

											</div>

											<div class="panel-footer">


												<button type="button" class="btn btn-link btn-sm randevuEkleButton"
													id="randevuEkle" value="${operasyon.doktorId}"
													data-opId="${operasyon.id}">Randevu Ekle</button>
												<!--  
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#randevuEkleModal" data-opid="${operasyon.id}"  data-opbastar="${operasyon.islemTarihi}" data-opbittar="${operasyon.islemBitisTarihi}" data-opislem="${operasyon.islemTipi}" data-opaciklama="${operasyon.aciklama}" data-opdisno="${operasyon.disNo}" data-opmiktar="${operasyon.miktar}"> Randevu Ekle</button>

-->
												
												<c:if test="${silAktif ne '0' }">
																			<c:if
																				test="${sessionScope.sessionMember[0].kuTur ne '3' }">
												<button type="button" class="btn btn-link btn-sm"
													data-toggle="modal" data-target="#operasyonGuncelleModal"
													data-opid="${operasyon.id}"
													data-opdoktor="${operasyon.doktorId}"
													data-opbastar="${operasyon.islemTarihi}"
													data-opbittar="${operasyon.islemBitisTarihi}"
													data-opislem="${operasyon.islemTipi}"
													data-opaciklama="${operasyon.aciklama}"
													data-opdisno="${operasyon.disNo}"
													data-opmiktar="${operasyon.miktar}">Güncelle</button>


												<c:if test="${operasyon.kalanMiktar >0}">
													<button type="button" class="btn btn-link btn-sm"
														data-toggle="modal" data-target="#odemeEkleModal"
														data-opid="${operasyon.id}"
														data-odkalanmiktar="${operasyon.kalanMiktar}"
														data-doktorid="${operasyon.doktorId}"
														data-hastaid="${hastaListesi[0].id}">Ödeme Ekle</button>
												</c:if>

												<c:if test="${operasyon.durumu eq 'A'}">
													<button type="button" class="btn btn-link btn-sm"
														data-toggle="modal" data-target="#operasyonBitirModal"
														data-opid="${operasyon.id}"
														data-opad="${operasyon.islemTip.ad}">Bitir</button>
												</c:if>

												<c:if test="${operasyon.durumu eq 'K'}">
													<button type="button" class="btn btn-link btn-sm"
														data-toggle="modal"
														data-target="#operasyonKesinlestirModal"
														data-opid="${operasyon.id}"
														data-opad="${operasyon.islemTip.ad}">Kesinleþtir</button>
													<button type="button" class="btn btn-link btn-sm"
														data-toggle="modal" data-target="#aramaKaydiEkleModal"
														data-opid="${operasyon.id}"
														data-opad="${operasyon.islemTip.ad}">Arama Kaydý
														Ekle</button>
												</c:if>


												<button type="button" class="btn btn-link btn-sm"
													data-toggle="modal"
													data-target="#operasyonOdemeGunuGirModal"
													data-opid="${operasyon.id}"
													data-kalanmiktar="${operasyon.kalanMiktar}">Ödeme
													Günü Gir</button>
												<button type="button" class="btn btn-danger pull-right btn-sm"
													data-toggle="modal" data-target="#operasyonSilModal"
													data-opid="${operasyon.id}"
													data-opad="${operasyon.islemTip.ad}">Sil</button>

														</c:if>
			

												</c:if>
											</div>


										</div>
									</div>

								</c:forEach>
								
								</div>

							</div>
							<div id="anket-tab" class="tab-pane">
								<div class="panel panel-white">
									<div class="panel-heading">
										<div class="row">
											<div class="col-lg-6 col-md-6">${hastaListesi[0].ad}
												${hastaListesi[0].soyad}</div>
										</div>
									</div>
									<div class="panel-body">

										<table class="table table-hover table-bordered">
											<thead>

												<tr>
													<th></th>

													<th>Anket Tarihi</th>
													<th>Anket Saat</th>
													<th>Mem. Derecesi</th>
													<th>Açýklama</th>


													<c:if
														test="${sessionScope.sessionMember[0].kuTur ne '3'  }">
														<th></th>
													</c:if>
												</tr>


											</thead>
											<tbody>

												<c:forEach items="${hastaListesi[0].hastaAnketList}"
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

				
				</div>
				
				
			</div>

			</c:if>
			<div>

				<h4>${requestScope.warn}</h4>

			</div>
		</div>



	
	</div>


	<form id="send" action="hastaSorgulaForRandevu.do" method="post">
		<input type="hidden" name="hastaId" id="hasta_idSorgulama">
	</form>

	<form id="randevuEkleForm" action="hastaSorgulaForRandevu.do"
		method="post">
		<input type="hidden" name="hastaId" id="hasta_id_randevuForm"
			value="${hastaListesi[0].id}"> <input type="hidden"
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
										<input name="ad" id="ad"
											type="text" placeholder="Ad" class="form-control"
											data-validation="length" data-validation-length="min3" />

									</div>
								</div>
							</div>
							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<input id="inputLastName"
											name="soyad" id="soyad" type="text" placeholder="Soyad"
											class="form-control" data-validation="length"
											data-validation-length="min2" />
									</div>
								</div>
							</div>
						</div>

						<div class="row">

							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										 <input name="tel" id="tel"
											type="text" placeholder="Telefon" class="form-control"
											data-validation="required" data-validation-length="min11" />
									</div>
								</div>
							</div>

							<div class="col-lg-6 col-md-6">
								<div class="form-group">
									<div class="input-icon">
										 <input id="tckimlik"
											onkeyup="kontrol()" name="tckimlik" type="text"
											placeholder="Tc Kimlik No" class="form-control" />
									</div>
								</div>
							</div>

						</div>

					</div>

					<div class="modal-footer">
						<input id="bntHastaKaydet" type="submit" value="Hasta Ekle"
							class="btn btn-default btn-sm" />

						<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Vazgeç</button>
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
					<button type="button" class="btn btn-default" data-dismiss="modal"	id="buttonSec">Seç</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>
				</div>
			</div>
		</div>
		
		-->

	<div class="modal fade" id="hastaSecModal" style="color: black; font-size: 11px;">
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

					<form action="hastaBasicSorgula.do" method="post"
						id="hastaSorgulaForm"
						>
						<div class="form-group col-lg-3 col-md-3">
							<input class="form-control " name="protokolNo" id="hstProtokol"
								placeholder="Protokol No" />
						</div>


						<div class="form-group col-lg-4 col-md-4">
							<input class="form-control " name="ad" id="hstAd"
								placeholder="Ad" />
						</div>

						<div class="form-group col-lg-3 col-md-3">
							<input class="form-control " name="soyad" id="hstSoyad"
								placeholder="Soyad" />

						</div>
						<div class="form-group col-lg-2 col-md-2">
							<input type="submit" class="btn btn-default" value="Sorgula"
								name="bnt_gonder" />

						</div>


					</form>

					<div id="hastaTable" hidden="true">

						<table id="example" class="table" style="font-size: 11px;">
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
										<td>${hasta.protokolNo}</td>
										<td>${hasta.ad}</td>
										<td>${hasta.soyad}</td>
										<td>${hasta.tel}</td>
										<td hidden="true">${hasta.id }</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

					</div>

				</div>
				<div class="modal-footer">

				
					<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
				</div>


			</div>
		</div>
	</div>


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
									id="protokolNo" value="${hastaListesi[0].protokolNo }" /> <input
									type="hidden" name="id" value="${hastaListesi[0].id}"></td>
							</tr>

							<tr>
								<td>TC Kimlik</td>
								<td><input class="inputTextfield" name="tckimlik"
									id="tckimlik" value="${hastaListesi[0].tckimlik }" />
							</tr>
							<tr>
								<td>Ad-Soyad</td>

								<td><input class="inputTextfield" name="ad" id="ad"
									value="${hastaListesi[0].ad }" /> <input
									class="inputTextfield" name="soyad" id="soyad"
									value="${hastaListesi[0].soyad }" /></td>
							</tr>


							<tr>
								<td>Tel</td>
								<td><input class="inputTextfield" name="tel" id="tel"
									value="${hastaListesi[0].tel }" /></td>
							</tr>

						</table>


					</div>

					<div class="modal-footer">
						<input id="bntKaydet" type="submit" value="Güncelle"
							class="btn btn-default" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
							<span> ${hastaListesi[0].ad} ${hastaListesi[0].soyad}
								isimli hasta silinecektir. Emin misiniz? </span>
						</h4>
						<input type="hidden" name="id" value="${hastaListesi[0].id}">


					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
					<h4 class="modal-title" id="exampleModalLabel">
						TEDAVÝ EKLE  ( ${hastaListesi[0].ad}	${hastaListesi[0].soyad} )
					</h4>
				</div>


				<form action="HastaOperasyonEkle.do" method="post"
					onsubmit="return validateFormOperasyonEkle()"
					name="operasyonEkleForm">


					<div class="modal-body">

						<div class="col-lg-6 col-md-6">

							<input type="hidden" name="hastaId" value="${hastaListesi[0].id}">

							<h4>Tedavi Bilgileri</h4>
							<!-- TEDAVi BILGILERI -->

							<div class="row ">

								<div class="col-lg-6 col-md-6">
									<div class="form-group ">
										<select size="1" name="doktorId" class="form-control">
											<option label="Diþ Hekimi Seçiniz.." value="-1">
												Hekim Seçiniz</option>

											<c:forEach items="${doktorList}" var="doktorDTO">
												<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
													value="${doktorDTO.dId }">${doktorDTO.dAd }
													${doktorDTO.dSoyad }</option>
											</c:forEach>
										</select>
										
									</div>
								</div>
								
								
								<div class="col-lg-6 col-md-6">
									<div class="form-group">
									
									<strong> Tedavi Tarihi :  </strong>
										<input name="islemTarihiStr" id="islemTarihiStr"
											class="tarih " type="text"
											placeholder="Tedavi Tarih Giriniz."
											data-validation="required"
											data-validation-error-msg="Zorunlu Alan">
									</div>
								</div>
								
								
							</div>
							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">

										<div class="input-icon">

											<div class="btn-group btn-group-xs" >
												<button type="button"
													class="col-lg-12 col-md-12 btn btn-default disno">Üst Çene</button>
												
												</div>
											<div class="btn-group btn-group-xs" id="buttons">

												<button type="button" class="btn btn-info disno">18</button>
												<button type="button" class="btn btn-info disno">17</button>
												<button  type="button" class="btn btn-info disno">16</button>
												<button type="button" class="btn btn-info disno">15</button>
												<button type="button" class="btn btn-info disno">14</button>
												<button type="button" class="btn btn-info disno">13</button>
												<button type="button" class="btn btn-info disno">12</button>
												<button type="button" class="btn btn-info disno">11</button>

												<button type="button" class="btn btn-white"></button>

												<button type="button" class="btn btn-success disno">21</button>
												<button type="button" class="btn btn-success disno">22</button>
												<button type="button" class="btn btn-success disno">23</button>
												<button type="button" class="btn btn-success disno">24</button>
												<button type="button" class="btn btn-success disno">25</button>
												<button type="button" class="btn btn-success disno">26</button>
												<button type="button" class="btn btn-success disno">27</button>
												<button type="button" class="btn btn-success disno">28</button>
												<br> <br>
												<button type="button" class="btn btn-danger disno">48</button>
												<button type="button" class="btn btn-danger disno">47</button>
												<button type="button" class="btn btn-danger disno">46</button>
												<button type="button" class="btn btn-danger disno">45</button>
												<button type="button" class="btn btn-danger disno">44</button>
												<button type="button" class="btn btn-danger disno">43</button>
												<button type="button" class="btn btn-danger disno">42</button>
												<button type="button" class="btn btn-danger disno">41</button>

												<button type="button" class="btn btn-white"></button>
												<button type="button" class="btn btn-warning disno">31</button>
												<button type="button" class="btn btn-warning disno">32</button>
												<button type="button" class="btn btn-warning disno">33</button>
												<button type="button" class="btn btn-warning disno">34</button>
												<button type="button" class="btn btn-warning disno">35</button>
												<button type="button" class="btn btn-warning disno">36</button>
												<button type="button" class="btn btn-warning disno">37</button>
												<button type="button" class="btn btn-warning disno">38</button>
											</div>
											
											
											<div class="btn-group btn-group-xs" >
											
											
														<button type="button"
												class="col-lg-12 col-md-12 btn btn-default disno">Alt Çene</button>
												
												</div>

											

										</div>
									</div>
								</div>
							</div>

							<br>

							<div class="row">
								<div class="col-lg-5 col-md-5">
									<div class="form-group">

										<input class="form-control" placeholder="Diþ Numarasý"
											name="disNo" id="disNo" data-validation="required"
											data-validation-error-msg="Zorunlu Alan"> 
											
											


									</div>
								</div>
								<div class="col-lg-5 col-md-5">
									<div class="form-group">
											<input
											class="form-control" placeholder="Adet" name="disAdet"
											id="disAdet" data-validation="required"
											data-validation-error-msg="Zorunlu Alan">
									</div>
								</div>
								<div class="col-lg-2 col-md-2">
									<div class="form-group">

										<button type="button" id="disnosil" class="btn btn-warning">Sil</button>
									</div>
								</div>
							</div>

							<div class="row">

								<div class="col-lg-6 col-md-6">
									<div class="form-group">
										<div class="input-icon">

											<select size="1" name="islemTipi" id="islemTipi"
												class="form-control tedaviTipi">
												<option label="Tedavi Seçiniz.." value="-1">Tedavi
													Seçiniz..</option>

												<c:forEach items="${islemTurList}" var="islem">
													<option label="${islem.ad}" value="${islem.id}"
														<c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>="">
														${islem.ad}</option>
												</c:forEach>
											</select>

										</div>
									</div>
								</div>


								<div class="col-lg-6 col-md-6">
									<div class="form-group">

										<div class="checkbox">
											<label> <input type="checkbox" name="implantAktif"
												id="implantAktif" /> &nbsp; Implant
											</label>
										</div>

									</div>
								</div>
							</div>

							<div class="row" id="implantOk" hidden="true">
								<div class="col-lg-12 col-md-12">
									<div class="form-group ">
										<select size="1" name="implantBaglayanDoktorId"
											class="form-control">
											<option label="Protez Doktor Seçiniz.." value="-1"></option>

											<c:forEach items="${doktorList}" var="doktorDTO">
												<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
													value="${doktorDTO.dId }">${doktorDTO.dAd }
													${doktorDTO.dSoyad }</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-lg-12 col-md-12">
									<div class="form-group ">
										<select size="1" name="implantCerrahId" class="form-control">
											<option label="Cerrah Doktor Seçiniz.." value="-1"></option>

											<c:forEach items="${doktorList}" var="doktorDTO">
												<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
													value="${doktorDTO.dId }">${doktorDTO.dAd }
													${doktorDTO.dSoyad }</option>
											</c:forEach>
										</select>
									</div>
								</div>



							</div>


							<!--  
								<div class="row">
									<div class="col-lg-12 col-md-12">
										<div class="form-group">
											<div class="input-icon">
												<select size="1" name="disAdet" id="disAdet"
													class="form-control">
													<option label="Adet Seçiniz.." value="-1">Adet
														Seçiniz..</option>

													<c:forEach items="${disSayisiList}" var="dis">
														<option label="${dis}" value="${dis}">${dis}</option>
													</c:forEach>
												</select>

											</div>
										</div>
									</div>
								</div>

								-->


							<div class="row">
								<div class="col-lg-6 col-md-6">
									<div class="form-group">
										<input class="form-control" placeholder="Ücret Giriniz (TL)"
											name="operasyonUcret" id="operasyonUcret" onkeyup="hesapla()"
											data-validation="required"
											data-validation-error-msg="Zorunlu Alan">

									</div>
								</div>
								
								
								<div class="col-lg-6 col-md-6">
									<div class="form-group">

										<div class="input-icon">
											<div class="checkbox">
												<label> <input type="checkbox" id="durumu"
													name="operasyonDurum" /> &nbsp; Kesinleþmedi
												</label>
											</div>

										</div>
									</div>
								</div>
								
								
							</div>


						
							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">
										<div class="input-icon">
											<textarea class="form-control" name="operasyonAciklama"
												placeholder="Açýklama Giriniz" rows="1" id="aciklama"
												cols="30"></textarea>
										</div>
									</div>

								</div>
							</div>
						</div>


						<div class="col-lg-6 col-md-6">

							<h4>Ücret Bilgileri</h4>
							<!-- UCRET BILGILERI BASLA-->
							<div class="row">
								<div class="col-lg-6 ">
									<div class="form-group">
										<div class="hero-unit">
											<input type="text" name="odemeTarihiStr" class="tarih"
												id="odemeTarihiStr" placeholder="Tarih Giriniz.">
										</div>

									</div>

								</div>
							</div>

							<div class="row">
							
								<div class="col-lg-4">
									<div class="form-group">

										<input class="form-control"
											placeholder="Ödeme Miktarý Giriniz (TL)" name="odemeMiktar"
											id="odemeMiktar"> 
											
											
											

									</div>
								</div>
								
								
								<div class="col-lg-4">
									<div class="form-group">

									
											 <input class="form-control"
											placeholder="Kalan Miktar" name="kalanMiktar"
											id="kalanMiktar" readonly="readonly">

									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">

										<select size="1" class="form-control" name="odemeTuru">
											<option label="Peþinat" value="2" >Peþinat</option>
											<option label="Taksit" value="3" >Taksit</option>
											<option label="Kredi Kartý" value="4" >Kredi Kartý</option>
											<option label="EFT / Havale" value="5" >EFT / Havale</option>

										</select>

									</div>
								</div>
							</div>




							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">
										<div class="input-icon">
											<textarea class="form-control" placeholder="Açýklama Giriniz"
												rows="4" name="odemeAciklama" id="aciklama" cols="50"></textarea>
										</div>
									</div>

								</div>
							</div>
							
							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">
										<div class="input-icon">
												
										<input id="bntKaydetTedavi" class="btn btn-default pull-right" type="submit" value="Ekle" onclick="return checkTedavi();" />
										
										</div>
									</div>

								</div>
							</div>
							
							
							
						</div>
					</div>

					<div class="clearfix"></div>

					<div class="modal-footer">
						
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>

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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Bitir" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>checkTedavi

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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Tedavi Kesinleþtir" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
						<input type="submit" class="btn btn-default"
							value="Tedavi Güncelle" id="btn_gonder" name="bnt_gonder" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
								<td>
								
								
								<c:choose>
								    <c:when test="${odeme_tarih_degistir eq 'on'}">
								    
								    <input type="text" name="odemeTarihiStr" class="tarih"
									id="odemeTarihiStrModal"/>
								                      
								
								         </c:when>
								         <c:otherwise>
								         
								                   <input type="text" name="odemeTarihiStr" class="tarih" disabled="disabled"
									id="odemeTarihiStrModal"/>
								
								         </c:otherwise>
								</c:choose>
								
									
									</td>
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
								<td>
											<select size="1" class="form-control" name="odemeTuru">
												<option label="Peþinat" value="2" >Peþinat</option>
												<option label="Taksit" value="3" >Taksit</option>
												<option label="Kredi Kartý" value="4" >Kredi Kartý</option>
												<option label="EFT / Havale" value="5" >EFT / Havale</option>
	
											</select>
										
										</td>

							</tr>



							<tr>
								<td>Açýklama</td>
								<td><textarea rows="3" cols="50" name="aciklamaOdemeModal"></textarea></td>
							</tr>


						</table>

					</div>

					<div class="modal-footer">
						<input type="submit" class="btn btn-default" value="Ödeme Ekle"
							id="btn_gonder" name="bnt_gonder">
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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

								<td>
								<select size="1" class="form-control" name="odemeTuru"
									>
										<option label="Peþinat" value="2" />
										<option label="Taksit" value="3" />
										<option label="Kredi Kartý" value="4" />

								</select>
								
								</td>
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
						<input type="submit" class="btn btn-default"
							value="Ödeme Güncelle" id="btn_gonder" name="bnt_gonder">
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
							type="hidden" name="hastaId" value="${hastaListesi[0].id}" />

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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
						HASTA MEMNUNÝYET ANKETÝ BÝLGÝLERÝ FORMU <br>
						${hastaListesi[0].ad} ${hastaListesi[0].soyad}
					</h4>
				</div>

				<form action="anketEkle.do" method="post"
					onsubmit="return validation()">
					<div class="modal-body">



						<table class="table">

							<tr>
								<td>Anket Arama Tarihi</td>
								<td><input name="tarihStr" class="tarih"
									id="anketAramaTArihi" data-validation="required" /> <input
									type="hidden" name="hastaId" value="${hastaListesi[0].id}"
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
								<td>Açýklama</td>
								<td><textarea name="aciklama" id="aciklama"></textarea></td>


							</tr>

						</table>



					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
						${hastaListesi[0].ad} ${hastaListesi[0].soyad}
					</h4>
				</div>

				<form action="aramaKaydiEkle.do" method="post"
					onsubmit="return validation()">

					<input type="hidden" name="islemId" id="islemId"> <input
						type="hidden" name="hastaId" value="${hastaListesi[0].id}"
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
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Kaydet" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
				<div class="modal-footer">
					<input type="submit" class="btn btn-default" value="Randevu Ekle"
						id="btn_gonder" name="bnt_gonder" />
					<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
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
		
		
		
		
		var message= $.trim(tedavi) + ' tedavisi ve '+ disNo+' numaralarý için tedavi fiyatý:' + miktar + ' olarak belirlenmiþtir. Kaydetmek için emin misiniz?'  ;
		
		if (confirm(message)) {
		    
		    return true;
		} else {
		   
		    return false;
		    
		}
			
	}
	
	
		function validateFormOperasyonEkle() {

			var doktorId = document.forms["operasyonEkleForm"]["doktorId"].value;

			var tedaviId = document.forms["operasyonEkleForm"]["islemTipi"].value;
			
			
			var kalanMiktar = document.forms["operasyonEkleForm"]["kalanMiktar"].value;

			if (doktorId == null || doktorId == -1) {
				alert("Lütfen Doktor Seçiniz..");
				return false;
			}
			if (tedaviId == null || tedaviId == -1) {
				alert("Lütfen Tedavi Seçiniz..");
				return false;
			}
			if (kalanMiktar <0) {
				alert("Lütfen Ödeme Miktarýný Kontrol ediniz.");
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


							$('#example')
									.DataTable(
											{
												select : {
													style : 'single',

												},
												"searching":     false,
												"paging":false,
												 "iDisplayLength": 5,
												 "lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]],
												order : [ [ 4, "desc" ] ],
												language : {

													sSearch : "Ara:",
													sLengthMenu : "_MENU_",
													sInfo : "_TOTAL_ kayýt",
													infoEmpty: " ",
													zeroRecords: " ",

												}

											});

							var table = $('#example').DataTable();

							$('#example tbody').on('click', 'tr', function() {
								$('#example tbody tr').removeClass('selected');
								$(this).toggleClass('selected');
							});

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

							$('input.tarih').Zebra_DatePicker();

							var disno = [];
							var disAdet=0;
							
							
							
							

							$('.disno').on('click', function(e) {

								var no = $(this).html();
								
								var varmi = true;
								for (i = 0; i < disno.length; i++) {
									text = disno[i];
									if (text == no)
										varmi = false;
								}
								if (varmi){
									disno.push(no);
									disAdet++;
									
								}

								varmi = true;
								//var txtdisno=$('#disNo').val() +no;							
								$('#disNo').val(disno);
								
								
								
								
								$('#disAdet').val(disAdet);
								
							});
							
							$('#disnosil').on('click', function(e) {

								var no = $(this).html();
								disno.pop();
								//var txtdisno=$('#disNo').val() +no;							
								$('#disNo').val(disno);
								
							if(disAdet>0)
								  disAdet--;
								
								
								$('#disAdet').val(disAdet);
								
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
							$('#operasyonBitirModal').on('show.bs.modal',
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
							$('#operasyonKesinlestirModal').on('show.bs.modal',
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
										
										$("#operasyonKesinlestirTrhStr").val(date)
										
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
										var opaciklama = button.data('opaciklama')
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
										modal.find('#tedaviMiktar').val(opucret)
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
										var kalanMiktar = button.data('odkalanmiktar') // Extract info from data-* attributes

										
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

												var date = $.datepicker.formatDate('yy.mm.dd',new Date());

												// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
												// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
												var modal = $(this)
												modal.find('#odemeGuncelleId').val(odemeId)
												modal.find('#odememiktarguncellemeModal').val(odememiktar)
												modal.find('#odemeaciklamaguncellemeModal').val(odemeaciklama)
												
												modal.find('#odemeTarihiStrOdemeGuncelleModal').val(date)

											});

							$('#odemeSilModal').on(
									'show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var odemeId = button.data('odemeid')
										var odememiktar = button.data('odememiktar')

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
										modal.find('#borcOdemeTarihiStr').val(date)

									});

							$('#aramaKaydiEkleModal').on('show.bs.modal',
									function(event) {
										var button = $(event.relatedTarget)
										var opid = button.data('opid')
										var opad = button.data('opad')

										var date = $.datepicker.formatDate(
												'yy.mm.dd', new Date());
										
										var modal = $(this)
										modal.find('#islemId').val(opid)
										modal.find('#operasyonAd').html(opad)
										modal.find('#aramaTarihiEkleStr').val(date)
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

							$('#buttonSec')
									.click(
											function() {
												var ids = $.map(table.rows(
														'.selected').data(),
														function(item) {
															return item
														});

												if (ids.length) {
													$('#hasta_idSorgulama')
															.val(ids[4]);
													$('#send').submit();
												} else {
													alert("Lütfen Hasta Seçiniz.");
												}
											});
							
							
							$('#islemTipi').on('change', function () {
								
								
								var adet= $('#disAdet').val()
								var  value= this.value;
								'<c:forEach items="${islemTurList}" var="islem">'
								

								if(value == '${islem.id}')
								{
									
									 var fiyat=	'${islem.subeTip.fiyat}';
									 
									 
								 
									 $('#operasyonUcret').val(fiyat*adet);
								 
								 
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

						});
	</script>

</body>
</html>