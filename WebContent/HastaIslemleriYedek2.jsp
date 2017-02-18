<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Hasta Kartý Ekle</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!--Loading bootstrap css-->

<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/moment-with-locales.js"></script>
<script src='js/locale-all.js'></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/jquery.form-validator.min.js"></script>
<script src="js/jquery.maskedinput.min.js"></script>


	
	<script src="script/bootstrap-hover-dropdown.js"></script>
	
	
	
	
	<script src="script/html5shiv.js"></script>
	<script src="script/respond.min.js"></script>
	<script src="script/jquery.metisMenu.js"></script>
	
	
	
	
	
	
	<script src="script/jquery.slimscroll.js"></script>
	<script src="script/jquery.cookie.js"></script>
	<script src="script/icheck.min.js"></script>
	<script src="script/custom.min.js"></script>
	<script src="script/jquery.news-ticker.js"></script>
	<script src="script/pace.min.js"></script>
	<script src="script/responsive-tabs.js"></script>
	<script src="script/jquery.flot.js"></script>
	
	
	
	
	
	<script src="script/jquery.flot.categories.js"></script>
	<script src="script/jquery.flot.pie.js"></script>
	<script src="script/jquery.flot.tooltip.js"></script>
	<script src="script/jquery.flot.resize.js"></script>
	<script src="script/jquery.flot.fillbetween.js"></script>
	<script src="script/jquery.flot.stack.js"></script>
	<script src="script/jquery.flot.spline.js"></script>
	<script src="script/zabuto_calendar.min.js"></script>
	<script src="script/index.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="script/main.js"></script>


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.structure.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.dataTables.min.css" />


<link type="text/css" rel="stylesheet" href="styles/nestable.css">

<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.ui.theme.css" />


<!-- jquery dialog gibi componentlerin gorunumu -->
<link type="text/css" rel="stylesheet"	href="styles/jquery-ui-1.10.4.custom.min.css"> 

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

</style>

</head>

<body style="color: black;">

	<div class="container col-lg-12">

		<!-- hasta sorgulama 
		<div class="container col-lg-6">
	
		<div class="panel panel-grey">
		

			<div class="panel-heading">Hasta Sorgula</div>
			
			<div class="panel-body pan">
			
			<form action="hastaSorgulaForRandevu.do" method="post" 
		name="sorgulaForm" onsubmit="return validation()">

				<input type="hidden" name="islem"	value="${param.islem}" id="islem">
		
				<div class="form-body pal">
		
						<div class="row">

							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-phone"></i> 
										<input class="form-control" name="ad" id="ad" placeholder="Ad" />
									</div>
								</div>
							</div>
							
					
							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										
										<input class="form-control" name="soyad" id="soyad"  placeholder="Soyad">
										
									</div>
								</div>
							</div>

						</div>
						
						
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										<input class="form-control" name="protokolNo" placeholder="Protokol No" id="hstProtokol" />
										
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> 
										<input class="form-control" type="text" name="tel" id="tel"  placeholder="Telefon" > 
										
										
										
									</div>
								</div>
							</div>

						</div>
						
						<div class="row">
							<div class="col-md-12">
							
							<div> ${requestScope.warn} </div>
							
							
										<div class="form-actions text-center pal">
										
										<input
										type="submit" value="Sorgula" class="btn btn-primary" id="button" />

										</div>
						</div>
						</div>
						
		
				</div>
			</form>
</div>
</div>

</div>

<div class="clearfix"></div>
 		
-->
		<!-- TABLE START -->



	<div class="row">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModal" data-whatever="">Lütfen Hasta
			Seçiniz.</button>
	</div>
	<div class="row col-lg-3 bg-warning">
		
			${requestScope.warn}
	</div>
	
	<c:if test="${!empty hastaListesi }">
		
		<div class="page-content">
		
					<div id="tab-general">
                        <div class="row mbl">
	                        	<ul id="generalTab" class="nav nav-tabs responsive">
	                            <li class="active">  <a href="#hasta-tab" data-toggle="tab">Hasta Bilgileri</a></li>
	                            <li >  <a href="#tedavi-tab" data-toggle="tab">Tedavi Ve Ödemeler</a></li>
	                            <li><a href="#anket-tab" data-toggle="tab">Anket</a></li>
	                            <li><a href="#label-badge-tab" data-toggle="tab">Arama</a></li>
	                            <li><a href="#pagination-tab" data-toggle="tab">Randevular</a></li>
		                        </ul>
		                        <div id="generalTabContent" class="tab-content responsive">
		                        
		                        	 <div id="hasta-tab" class="tab-pane fade in active">
		                        	 
		                        	 		<h4 class="box-heading">${hastaListesi[0].ad} ${hastaListesi[0].soyad}</h4>
											<p>TELEFON : ${hastaListesi[0].tel}</p>
											<p>PROTOKOL NO: ${hastaListesi[0].protokolNo}</p>
			
									 		<c:if test="${silAktif ne '0' }">
												<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
				
													
				
															<button type="button" class="btn btn-success" data-toggle="modal" data-target="#hastaGuncelleModal" data-whatever="${hastaListesi[0].id}">Güncelle</button>
															<button type="button" class="btn btn-success" data-toggle="modal" data-target="#hastasSilModal"	data-whatever="${hastaListesi[0].id}">Sil</button>
															<button type="button" class="btn btn-success"	data-toggle="modal" data-target="#operasyonEkleModal"	 data-whatever="${hastaListesi[0].id}">Tedavi Ekle</button>
															<button type="button" class="btn btn-success"	data-toggle="modal" data-target="#anketEkleModal"	 data-whatever="${hastaListesi[0].id}">Anket Ekle</button>
															<button type="button" class="btn btn-success"	data-toggle="modal" data-target="#aramaKaydiEkleModal"	 data-whatever="${hastaListesi[0].id}">Arama Kaydý Ekle</button>
				
				
												</c:if>
				
											</c:if>
		                        	
									</div>
		                        
		                        	
		                            <div id="tedavi-tab" class="tab-pane fade">
								               	<c:forEach items="${hastaListesi[0].hastaOperasyonList}"
														var="operasyon" varStatus="count">
						
																<div class="panel panel-white">
																	<div class="panel-heading">
																		<div class="row">
																			<div class="col-lg-6">${operasyon.islemTip.ad}</div>
																		</div>
																	</div>
																	<div class="panel-body">
						
																		<div class="col-lg-6">
																		
																			<div class="col-lg-6">  
																			
																				<div>
																					DURUM :
																					<c:choose>
																							<c:when test="${operasyon.durumu eq 'A'}">Devam Ediyor</c:when>
																							<c:when test="${operasyon.durumu eq 'B'}">Bitmiþ</c:when>		
																							<c:when test="${operasyon.durumu eq 'K'}">Kesinleþmedi</c:when>		
																						</c:choose>
																				</div>
																				<div>
																					DÝÞ ADET : ${operasyon.disAdet} 
																					
																				</div>
							
																				<div>
																					DÝÞ NO : ${operasyon.disNo} 
																					
																				</div>
							
																				<div>DOKTOR : ${operasyon.doktor.dAd} ${operasyon.doktor.dSoyad} 
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
																			</div>
																			
																			
																			<div class="col-lg-6"> 
																				
																				<div>OPERASYON TARÝHÝ : ${operasyon.islemTarihi} -
																					${operasyon.islemBitisTarihi}</div>
																					
																					
																				<div> FÝYAT : ${operasyon.miktar}  </div>
																				<div> KALAN ÖDEME MÝKTARI : ${operasyon.kalanMiktar}  </div>
																				<div>AÇIKLAMA : ${operasyon.aciklama}</div>
																			
																			</div>
																		</div>
						
						
																		<div class="col-md-6">
																		
																		<c:if test="${!empty operasyon.odemeList}">
																			<!-- odeme tablosu -->
																			<table class="table table-hover table-bordered">
																				<thead>
																					<tr>
																						<td class="helpHed"></td>
																						<td class="helpHed">Ödeme Tarih</td>
																						<td class="helpHed">Ödenen Miktar</td>
																						<td class="helpHed">Kalan Miktar</td>
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
																							<td class="helpBod">${count.count}</td>
																							<td class="helpBod">${odeme.odemeTarihi}</td>
																							<td class="helpBod">${odeme.miktar}</td>
																							<td class="helpBod">${operasyon.miktar - odeme.miktar}
																							<c:set target="${operasyon}" property="miktar" value="${operasyon.miktar -odeme.miktar}"></c:set>
																							
																							</td>
						
																							<td class="helpBod">${odeme.aciklama}</td>
						
																							<c:if test="${silAktif ne '0' }">
																								<c:if
																									test="${sessionScope.sessionMember[0].kuTur ne '3' }">
																									<td class="helpBod">
																									
																									<button type="button"  class="btn btn-success" data-toggle="modal" data-target="#odemeSilModal" data-odemeid="${odeme.id}" data-odememiktar="${odeme.miktar}" > Sil</button>
																									</td>
																									<td class="helpBod">
																									
																									<button type="button"  class="btn btn-success" data-toggle="modal" data-target="#odemeGuncelleModal" data-odemeid="${odeme.id}" data-odememiktar="${odeme.miktar}" data-odemeaciklama="${odeme.aciklama}"> Güncelle</button>

						
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
																	
																	<div class="panel-footer" style="font-size: 18px; font-family: fantasy;">
																	
																	
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#operasyonSilModal" data-opid="${operasyon.id}"  data-opad="${operasyon.islemTip.ad}">Sil</button>
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#operasyonGuncelleModal" data-opid="${operasyon.id}"  data-opbastar="${operasyon.islemTarihi}" data-opbittar="${operasyon.islemBitisTarihi}" data-opislem="${operasyon.islemTipi}" data-opaciklama="${operasyon.aciklama}" data-opdisno="${operasyon.disNo}" data-opmiktar="${operasyon.miktar}"> Güncelle</button>
<c:if test="${operasyon.kalanMiktar >0}">
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#odemeEkleModal" data-opid="${operasyon.id}"  data-odkalanmiktar="${operasyon.kalanMiktar}"    data-doktorid="${operasyon.doktorId}" data-hastaid="${hastaListesi[0].id}" >Ödeme Ekle</button>
</c:if>

<c:if test="${operasyon.durumu eq 'A'}">																	
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#operasyonBitirModal" data-opid="${operasyon.id}" data-opad="${operasyon.islemTip.ad}" >Bitir</button>
</c:if>

<c:if test="${operasyon.durumu eq 'K'}"> 
<button type="button" class="btn btn-success" data-toggle="modal" data-target="#operasyonKesinlestirModal" data-opid="${operasyon.id}" data-opad="${operasyon.islemTip.ad}" >Kesinleþtir</button>
</c:if>																	
	

<button type="button" class="btn btn-success" data-toggle="modal" data-target="#operasyonOdemeGunuGirModal" data-opid="${operasyon.id}" data-kalanmiktar="${operasyon.kalanMiktar}"  >Ödeme Günü Gir</button>


																	</div>
						
																</div>
						
													</c:forEach>
		                        		
									</div>
		                            <div id="anket-tab" class="tab-pane">
		                        		ANKET BILGILERI
									</div>
								</div>
						</div>
					</div>
					</div>
		</c:if>
	</div>


	<form id="send" action="hastaSorgulaForRandevu.do" method="post">

		<input type="hidden" name="hastaId" id="hasta_id">
	</form>

	


<!--DIALOG START................................................................................................................................................................ -->
<!--DIALOG START................................................................................................................................................................ -->
<!--DIALOG START................................................................................................................................................................ -->
<!--DIALOG START................................................................................................................................................................ -->
<!--DIALOG START................................................................................................................................................................ -->
<!--DIALOG START................................................................................................................................................................ -->
	
		<!-- HASTA LISTESI ... -->
	
			<div class="modal fade" id="exampleModal">
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
						<table id="example">
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
										<td>${hasta.protokolNo }</td>
										<td>${hasta.ad }</td>
										<td>${hasta.soyad }</td>
										<td>${hasta.tel }</td>
										<td hidden="true">${hasta.id }</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

					</div>

					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
							id="buttonSec">Seç</button>
					
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>
				</div>
			</div>
		</div>
	
	<!-- HASTA GUNCELLE ... -->
	
	<div id="hastaGuncelleModal" class="modal fade" >
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
					
									<td><input class="inputTextfield" name="protokolNo" id="protokolNo"
										value="${hastaListesi[0].protokolNo }" />  
										
										
									<input type="hidden"  name="id" value="${hastaListesi[0].id}"></td>	
								</tr>
					
								<tr>
									<td>TC Kimlik</td>
									<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
										value="${hastaListesi[0].tckimlik }" /> 
									
								</tr>
								<tr>
									<td>Ad-Soyad</td>
					
									<td><input class="inputTextfield" name="ad" id="ad"
										value="${hastaListesi[0].ad }" /> <input class="inputTextfield" name="soyad"
										id="soyad" value="${hastaListesi[0].soyad }" /></td>
								</tr>
					
					
								<tr>
									<td>Tel</td>
									<td><input class="inputTextfield" name="tel" id="tel"
										value="${hastaListesi[0].tel }" /></td>
								</tr>
										
							</table>
						
						
							</div>
			
						<div class="modal-footer">
						<input id="bntKaydet" type="submit" value="Güncelle" class="btn btn-default" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
						
						</form>
					</div>
			</div>
	</div>
	
	
	
	<!--- HASTA SIL . -->
	<div id="hastasSilModal" class="modal fade" >
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
					<span >  ${hastaListesi[0].ad} ${hastaListesi[0].soyad} isimli hasta silinecektir. Emin misiniz?	</span>
						</h4>
							<input type="hidden"  name="id" value="${hastaListesi[0].id}">
							
							
						</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Sil" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	
	<!--- HASTA SIL . -->
	
	
	<!--- OPERASYON EKLE. -->
	
	<div id="operasyonEkleModal" class="modal fade"  >
			<div class="modal-dialog" role="document" >
				<div class="modal-content">
				
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ EKLE <br> ${hastaListesi[0].ad} ${hastaListesi[0].soyad} </h4>
					</div>
					
					
			<form action="HastaOperasyonEkle.do" method="post">
	
				
					<div class="modal-body">
					
							<div class="col-lg-6">
							
							<input type="hidden" name="hastaId" value="${hastaListesi[0].id}" >
							
								<h4>Tedavi Bilgileri</h4>
								<!-- TEDAVi BILGILERI -->

								<div class="row ">

									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="doktorId" class="form-control" >
												<option label="Diþ Hekimi Seçiniz.." value="-1">
													Hekim Seçiniz</option>

												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }"
														>
														${doktorDTO.dAd } ${doktorDTO.dSoyad }</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon ">
												<i class="fa fa-calendar"></i> 
												
												<input name="islemTarihiStr" id="islemTarihiStr"
													class="form-control tarih " type="text"
													placeholder="Tedavi Tarih Giriniz." data-validation="required" data-validation-error-msg="Zorunlu Alan" >
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

											<div class="input-icon">
											
												<div class="btn-group btn-group-sm" id="buttons">
													<button type="button" class="btn btn-info disno"> 18</button> 
													<button type="button" class="btn btn-info disno"> 17</button> 
													<button type="button" class="btn btn-info disno">16</button> 
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
													<br>
													<br>
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
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											
											 <input
													class="form-control" placeholder="Diþ Numarasý"	name="disNo" id="disNo" data-validation="required" data-validation-error-msg="Zorunlu Alan" > 
										</div>
									</div>
									<div class="col-lg-4">
										<div class="form-group">
											
												<button type="button" id="disnosil" class="btn btn-warning">Sil</button> 
										</div>
									</div>
								</div>

								<div class="row">
								
								 	<div class="col-lg-6">
										<div class="form-group">
											<div class="input-icon">

												<select size="1" name="islemTipi" id="islemTipi"
													class="form-control">
													<option label="Tedavi Seçiniz.." value="-1">
														Tedavi Seçiniz..</option>

													<c:forEach items="${islemTurList}" var="islem">
														<option label="${islem.ad}" value="${islem.id}"
															<c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>="">
															${islem.ad}</option>
													</c:forEach>
												</select>

											</div>
										</div>
									</div>
								 	
								 	
									<div class="col-lg-6">
										<div class="form-group">

												<div class="checkbox">
													<label >  	<input type="checkbox" name="implantAktif" id="implantAktif" />
														&nbsp; Implant </label>
												</div>

										</div>
									</div>
								</div>

								<div class="row" id="implantOk" hidden="true">
									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="implantBaglayanDoktorId" class="form-control">
												<option label="Protez Doktor Seçiniz.." value="-1" ></option>
						
												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }">  ${doktorDTO.dAd } ${doktorDTO.dSoyad } </option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="col-lg-12">
										<div class="form-group ">
											<select size="1" name="implantCerrahId" class="form-control">
												<option label="Cerrah Doktor Seçiniz.." value="-1"></option>
						
												<c:forEach items="${doktorList}" var="doktorDTO">
													<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
														value="${doktorDTO.dId }"> ${doktorDTO.dAd } ${doktorDTO.dSoyad }   </option>
												</c:forEach>
											</select>
										</div>
									</div>
									
									
									
								</div>


								<!--  
								<div class="row">
									<div class="col-lg-12">
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
									<div class="col-lg-12">
										<div class="form-group">
												 <input
													class="form-control" placeholder="Ücret Giriniz (TL)"
													name="operasyonUcret" id="operasyonUcret" onkeyup="hesapla()" data-validation="required"  data-validation-error-msg="Zorunlu Alan">

										</div>
									</div>
								</div>


								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

											<div class="input-icon">
												<div class="checkbox">
													<label> <input type="checkbox" id="durumu" name="operasyonDurum" />
														&nbsp; Kesinleþmedi
													</label>
												</div>

											</div>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control" name="operasyonAciklama"	placeholder="Açýklama Giriniz" rows="2" 
													id="aciklama" cols="50"></textarea>
											</div>
										</div>

									</div>
								</div>
							</div>


							<div class="col-lg-6">

								<h4>Ücret Bilgileri</h4>
								<!-- UCRET BILGILERI BASLA-->
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<div class="hero-unit">
												<i class="fa fa-calendar"></i>
													<input class="form-control ornek " type="text" name="odemeTarihiStr" id="odemeTarihiStr" 
														placeholder="Tarih Giriniz.">
												</div>
											</div>

										</div>

									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">

												<input	class="form-control" placeholder="Ödeme Miktarý Giriniz (TL)" name="odemeMiktar" id="odemeMiktar" >
												<input	class="form-control" placeholder="Kalan Miktar" name="kalanMiktar" id="kalanMiktar" >

										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<div class="input-icon">
												<textarea class="form-control"
													placeholder="Açýklama Giriniz" rows="4" name="odemeAciklama"	id="aciklama" cols="50"></textarea>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
	
					<div class="clearfix"></div>
			
						
							<div class="modal-footer">
								<input id="bntKaydet" class="btn btn-default" type="submit" value="Ekle" />
								<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
							</div>
					
					</form>
						
			</div>
			</div>
	</div>
	
	<!--- operasyon sil. -->
	
	<div id="operasyonSilModal" class="modal fade" >
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
					<span id="operasyonAd" > </span>
					<span > isimli tedavi silinecektir.. Emin misiniz?	</span>
						</h5>
							<input type="hidden"  name="id" id="operasyonId" >
							
						</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Sil" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	
	
	<!--- operasyon bitir. -->
	<div id="operasyonBitirModal" class="modal fade" >
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
				
				<input type="text" class="tarih" name="tarihStr" id="operasyonBitirTrhStr" placeholder="Bitirme Tarihi Giriniz." >
					<h5>  	
					<span id="operasyonAd" > </span>
					<span > isimli tedavi tamamlanacaktýr. Emin misiniz?	</span>
						</h5>
						
							<input type="hidden"  name="id" id="operasyonId" >
						
						</div>
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Bitir" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	<!--- operasyon kesinleþtir. -->
	<div id="operasyonKesinlestirModal" class="modal fade" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				
				<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">TEDAVÝ KESÝNLEÞTÝR</h4>
					</div>
				<form action="OperasyonuKesinlestir.do" method="post">
				<div class="modal-body">
				
				<input type="text"  name="islemTarihiStr" class="tarih" id="operasyonKesinlestirTrhStr" placeholder="Kesinleþtirme Tarihi Giriniz." >
					<h5>  	
					<span id="operasyonAd" > </span>
					<span > isimli tedavi kesinleþtirilecektir. Emin misiniz?	</span>
						</h5>
							<input type="hidden"  name="islemId" id="operasyonId" >
							
						</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Tedavi Kesinleþtir" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	
	
	
	
	<!--- OPERASYON GUNCELLE . -->
	
	<div id="operasyonGuncelleModal" class="modal fade" >
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
											<td>Ýþlem Tipi</td>
											<td colspan="2">
											<select size="1" name="islemTipi" id="islemTipi"  >
													<option label="Operasyon Seçiniz.." value="-1" />
							
													<c:forEach items="${islemTurList}" var="islem">
													<option label="${islem.ad}" value="${islem.id }" 
													
													/>
													</c:forEach>
													
												</select>
												<input type="hidden" name="islemId" id="islemId">
											</td> 
							
										</tr>
							
										<tr>
											<td>Tedavi Baþlama - Bitiþ tarihi</td>
											<td>
											
											<input  name="islemTarihiStr"  id="islemTarihiStrModal" class="tarih"/>
											- <input  name="islemBitisTarihiStr" class="tarih"	id="islemBitisTarihiStrModal" />
											
											
											</td>
											
										</tr>
										<tr>
											<td>Diþ No : </td>
											<td>
											
											<input  name="disNo"	id="disNo" />
											</td>
											
										</tr>
										
										
										<tr>
											<td>Açýklama</td>
											<td>
											<textarea style="width: 394px;"  name="aciklama" id="opaciklama"></textarea>				 
												</td>
							 
										</tr>
							
								
									</table>
									
									
						
						</div>
						
						
						<div class="modal-footer">
							<input type="submit" value="Tedavi Güncelle" id="btn_gonder" name="bnt_gonder"/>
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
						
						</form>
				</div>
			</div>
	</div>
	
	<!--- ODEME EKLE . -->
	
	
	<div id="odemeEkleModal" class="modal fade" >
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
				<input	type="hidden" name="islemId" id="islemIdOdemeModal" /> 
				<input	type="hidden" name="hastaId" id="hastaIdOdemeModal"/> 
				<input	type="hidden" name="doktorId" id="doktorIdOdemeModal" />
				
				<table class="table">
					<tr>
						<td>Tarih</td>
						<td>
						 	<input type="text" name="odemeTarihiStr" id="odemeTarihiStrModal" class="tarih" />
							
							</td>
					</tr>
				
					<tr>
						<td>Kalan Miktar</td>

						<td><input type="text" name="kalanMiktari"	readonly="readonly" id="kalanOdemeMiktariModal"
							 /></td>
					</tr>

			
					<tr>
						<td>Ödeme Miktarý</td>

						<td><input type="text" name="miktar" id="odemeMiktarModal" /> TL</td>
					</tr>

					<tr>
						<td>Kalan Miktar</td>
						<td><input type="text"  id="kalanMiktarModal" data-validation="required"
							name="kalanMiktar"
							style="width: 204px; background-color: buttonshadow;"> TL</td>

					</tr>
					<tr>
						<td>Açýklama</td>
						<td><textarea rows="3" cols="50" name="aciklamaOdemeModal"></textarea></td>
					</tr>
					
					
				</table>

				</div>

				<div class="modal-footer">
							<input	type="submit" class="btn btn-default" value="Ödeme Ekle" id="btn_gonder" name="bnt_gonder">
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>

				</form>
					
				</div>
			</div>
	</div>
	
	
	

	<!-- odeme guncelle -->
	
	<div id="odemeGuncelleModal" class="modal fade" >
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
								<td>
									<input name="odemeTarihiStr" class="tarih" id="odemeTarihiStrOdemeGuncelleModal" /> 
									
									
									</td>
							</tr>
				
							<tr>
								<td>Miktar</td>
		
								<td>
								<input type="text" name="miktar" id="odememiktarguncellemeModal" /> TL</td>
							</tr>

					
							<tr>
								<td>Açýklama</td>
								<td><textarea rows="3" cols="50" name="aciklama" id="odemeaciklamaguncellemeModal"> </textarea></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;"></td>
							</tr>
					
					</table>
					
					</div>
					
					
					<div class="modal-footer">
							<input	type="submit" class="btn btn-default" value="Ödeme Güncelle" id="btn_gonder" name="bnt_gonder">
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					

					</form>
					
				
				</div>
			</div>
	</div>
	
	<!-- odeme sil -->
	
	<div id="odemeSilModal" class="modal fade" >
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
					<span id="odemeMiktar" > </span>
					<span > TL miktarýnda ödeme silinecektir.. Emin misiniz?	</span>
						</h5>
							<input type="hidden"  name="id" id="odemeId" >
							
						</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Sil" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	
	
	<!--- operasyon odeme gunu ekle -->
	<div id="operasyonOdemeGunuGirModal" class="modal fade" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				
				<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">BORÇ TARÝHÝ EKLE</h4>
					</div>
				<form action="borcOdemeTarihEkle.do" method="post">
				
					<div class="modal-body">
				
								<input type="hidden" name="islemId" id="islemId" />
				
							 <table class="table">
							            <tr>
							                <td>Kalan Ödeme Miktarý:  </td>
							                <td> <input type="text" id="kalan" name="borcOdemeTarihiStr"  > </td>
							                
							            </tr>
							            <tr>
							                <td>Borcun Ödeneceði Tarih:  </td>
							                <td> <input type="text" id="borcOdemeTarihiStr" name="borcOdemeTarihiStr" class="tarih" data-validation="required" > </td>
							                
							            </tr>
							            <tr>
							                <td>Borcun Ödeneceði Miktar:  </td>
							                <td> <input type="text" name="miktar" id="borcOdemeMiktar"  data-validation="required" > TL </td>
							                
							            </tr>
							            <tr>
							                <td>Açýklama :  </td>
							                <td> <textarea id="borcOdemeaciklama" name="aciklama"  cols="40" rows="3"></textarea> </td>
							                
							            </tr>
				           
				        	</table>
					
				
					</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Kaydet" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
					
					</form>
				</div>
			</div>
	</div>
	
	<div id="anketGirModal" class="modal fade" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				
				<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel"> HASTA MEMNUNÝYET ANKETÝ  BÝLGÝLERÝ FORMU</h4>
					</div>
				
				<form action="anketEkle.do" method="post" onsubmit="return validation()">
					<div class="modal-body">
						
									<table class="table">
										
										<tr>
											<td>Anket Arama Tarihi</td>
											<td>
											
											<input class="inputTextfield" name="tarihStr" class="tarih"		id="islemTarihiStr" data-validation="required" />
											 <input type="hidden" name="hastaId" value="${hasta.id }" id="hastaId">
											</td>
							
							
										</tr>
										
										<tr>
											<td>Saat</td>
											<td><select size="1" name="saat" id="saat" style="width: 56px; font-size:12px " data-validation="required">
												<option value="-1" label="Saat">
												<c:forEach items="${saatler}" var="saat" >
												<option value="${saat}" label="${saat}" ></option>				
												</c:forEach>
											</select>
											
											 : <select name="dakika" size="1" id="dakika" style="width: 52px; font-size:12px ">
											<option value="-1" label="Dk">
											<c:forEach items="${dakikalar}" var="dakika">
											<option label="${dakika }" value="${dakika }">
											
											</c:forEach>
											
											</select>
											
											</td>
							
										</tr>
										<tr>
											<td>Memnuniyet Derecesi</td>
											<td><select size="1" name="memnuniyetDerecesi" id="memnuniyetDerecesi" style="width: 229px; font-size:12px " data-validation="required">
												<option value="-1" label="Memnuniyet Derecesi">
												<option value="4" label="Çok iyi">
												<option value="3" label="Ýyi">
												<option value="2" label="Kötü">
												<option value="1" label="Çok Kötü">
													
											</select>
											</td>
										</tr>
										
											
										<tr>
											<td>Açýklama</td>
											<td>
											<textarea style="width: 487px; height: 148px"  name="aciklama" id="aciklama"></textarea>				 
												</td>
							 
							
										</tr>
							
									</table>
	
							
				
					</div>
						
						<div class="modal-footer">
							<input id="bntKaydet" class="btn btn-default" type="submit" value="Kaydet" />
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
						</form>
				</div>
			</div>
	</div>
	
	<!-- button actions dialogsss  END .. -->

	<script type="text/javascript">
	$(document).ready(
			function() {
				
				var myLanguage = {
				        errorTitle: 'Form submission failed!',
				        requiredFields: 'You have not answered all required fields',
				        badTime: 'You have not given a correct time',
				        badEmail: 'You have not given a correct e-mail address',
				        badTelephone: 'You have not given a correct phone number',
				        badSecurityAnswer: 'You have not given a correct answer to the security question',
				        badDate: 'You have not given a correct date',
				        lengthBadStart: 'The input value must be between ',
				        lengthBadEnd: ' karakter olmalý.',
				        lengthTooLongStart: 'The input value is longer than ',
				        lengthTooShortStart: 'Giriþ en az ',
				        notConfirmed: 'Input values could not be confirmed',
				        badDomain: 'Incorrect domain value',
				        badUrl: 'The input value is not a correct URL',
				        badCustomVal: 'The input value is incorrect',
				        andSpaces: ' and spaces ',
				        badInt: 'Lütfen numara giriþi yapýnýz',
				        badSecurityNumber: 'Your social security number was incorrect',
				        badUKVatAnswer: 'Incorrect UK VAT Number',
				        badStrength: 'The password isn\'t strong enough',
				        badNumberOfSelectedOptionsStart: 'You have to choose at least ',
				        badNumberOfSelectedOptionsEnd: ' answers',
				        badAlphaNumeric: 'The input value can only contain alphanumeric characters ',
				        badAlphaNumericExtra: ' and ',
				        wrongFileSize: 'The file you are trying to upload is too large (max %s)',
				        wrongFileType: 'Only files of type %s is allowed',
				        groupCheckedRangeStart: 'Please choose between ',
				        groupCheckedTooFewStart: 'Please choose at least ',
				        groupCheckedTooManyStart: 'Please choose a maximum of ',
				        groupCheckedEnd: ' item(s)',
				        badCreditCard: 'The credit card number is not correct',
				        badCVV: 'The CVV number was not correct',
				        wrongFileDim : 'Incorrect image dimensions,',
				        imageTooTall : 'the image can not be taller than',
				        imageTooWide : 'the image can not be wider than',
				        imageTooSmall : 'the image was too small',
				        min : 'min',
				        max : 'max',
				        imageRatioNotAccepted : 'Image ratio is not accepted'
				    };
				
				$.validate({
					language : myLanguage
				});
			
				  	$('#buttonSec').click(function () {
				        var ids = $.map(table.rows('.selected').data(), function (item) {
				            return item
				        });
				        
				        $('#hasta_id').val(ids[4]);
				        $('#send').submit();
				       
					 });
				 
				 	 $('#example').DataTable( {
					        select: {
					            style: 'single'
					            
					        },
					        language: {
					           
					            sSearch:"Ara:",
					            sLengthMenu:     "Sayfada _MENU_ kayýt göster",
					            sInfo:           "_TOTAL_ kayýttan _START_ - _END_ arasýndaki kayýtlar gösteriliyor",

					           
					        }
				 	 
					    } );

					 var table = $('#example').DataTable();

					 $('#example tbody').on('click', 'tr', function () {
					    	$('#example tbody tr').removeClass('selected');
					        $(this).toggleClass('selected');
					 });

					
					$('#implantAktif').bind('change', function() {

						if ($(this).is(':checked')) {
							$("#islemTipi").hide();
							$("#implantOk").show();
						} else {
							$("#islemTipi").show();
							$("#implantOk").hide();
						}
					});
					
					$("#odemeMiktarModal").keyup(function(){
						 var opUcret= $("#kalanOdemeMiktariModal").val();
						 var miktar= $("#odemeMiktarModal").val();
						 var kalan= opUcret - miktar;
						 if(kalan < 0 )
							 {
							 	alert("Kalan Miktar negatif olamaz..")
							 	$("#kalanMiktarModal").val(null);
							 }
						 else{
					     	$("#kalanMiktarModal").val(kalan);
					     
						 }
					 });
					
					$("#odemeMiktar").keyup(function(){
						
						 var opUcret= $("#operasyonUcret").val();
						 var miktar= $("#odemeMiktar").val();
						 var kalan= opUcret - miktar;
					        $("#kalanMiktar").val(kalan);
					 });
					
					
					 $.datepicker.regional['tr'] = {
							                 closeText: 'kapat',
							 	                prevText: '&#x3C;geri',
							 	                nextText: 'ileri&#x3e',
							 	                currentText: 'bugün',
							 	                monthNames: ['Ocak','Þubat','Mart','Nisan','Mayýs','Haziran',
							 	                'Temmuz','Aðustos','Eylül','Ekim','Kasým','Aralýk'],
							 	                monthNamesShort: ['Oca','Þub','Mar','Nis','May','Haz',
							 	                'Tem','Aðu','Eyl','Eki','Kas','Ara'],
							 	                dayNames: ['Pazar','Pazartesi','Salý','Çarþamba','Perþembe','Cuma','Cumartesi'],
							 	                dayNamesShort: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
							 	                dayNamesMin: ['Pz','Pt','Sa','Ça','Pe','Cu','Ct'],
							 	                weekHeader: 'Hf',
							 	                dateFormat: 'dd.mm.yy',
							 	                firstDay: 1,
							 	                isRTL: false,
							 	                showMonthAfterYear: false,
							 	                yearSuffix: ''};
					 $.datepicker.setDefaults($.datepicker.regional['tr'])
					
					$('.tarih').datepicker({
						   beforeShow: function (textbox, instance) {
						       var txtBoxOffset = $(this).offset();
						       var top = txtBoxOffset.top;
						       var left = txtBoxOffset.left;
						       var textBoxWidth = $(this).outerWidth();
						       setTimeout(function () {
						                   instance.dpDiv.css({
						                       top: top-150, //you can adjust this value accordingly
						                       left: left + textBoxWidth//show at the end of textBox
						               });
						       }, 0);
						
						   }});
					 
					$( ".tarih" ).datepicker( "option", "dateFormat", "yy.mm.dd" ); 
					
				
					
					
					var disno=[];
					
				    $('.disno').on('click', function (e) {
				    	
							var no=$(this).html();
							var varmi=true;
							for (i = 0; i < disno.length; i++) { 
							    text = disno[i];
							    if(text==no)
							    	varmi=false;
							}
							if(varmi)
							disno.push(no);
							
							varmi=true;
							//var txtdisno=$('#disNo').val() +no;							
							$('#disNo').val(disno);
					});
				    $('#disnosil').on('click', function (e) {
				    	
				    		
							var no=$(this).html();
							disno.pop();
							//var txtdisno=$('#disNo').val() +no;							
							$('#disNo').val(disno);
					});
					
					//OPERASYON SIL

					$('#operasyonSilModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var recipient = button.data('opid') // Extract info from data-* attributes
						  var opads = button.data('opad') // Extract info from data-* attributes
						  
						 
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#operasyonId').val(recipient)
						  modal.find('#operasyonAd').html(opads)
					});

					//OPERASYON BITIR
					$('#operasyonBitirModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var opid = button.data('opid') // Extract info from data-* attributes
						  var opads = button.data('opad')
						 
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#operasyonId').val(opid)
						  modal.find('#operasyonAd').html(opads)
					});
					
					//OPERASYON KESINLESTIR
					$('#operasyonKesinlestirModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var opid = button.data('opid') // Extract info from data-* attributes
						  var opads = button.data('opad')
						 
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#operasyonId').val(opid)
						  modal.find('#operasyonAd').html(opads)
					});
					
					
					
					//OPERASYON EKLE
					$('#operasyonEkleModal').on('show.bs.modal', function () {
					       $(this).find('.modal-dialog').css({
					              width:'85%', //probably not needed
					              height:'80%', //probably not needed 
					       });
					});
					
					//OPERASYON GUNCELLE
					$('#operasyonGuncelleModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var opid = button.data('opid') // Extract info from data-* attributes
						  var opad = button.data('opad') // Extract info from data-* attributes
						  var opislem = button.data('opislem') // Extract info from data-* attributes
						  var opbastar = button.data('opbastar') // Extract info from data-* attributes
						  var opbittar = button.data('opbittar') // Extract info from data-* attributes
						  var opucret = button.data('opmiktar') // Extract info from data-* attributes
						  var opaciklama = button.data('opaciklama') // Extract info from data-* attributes
						  var opdisno = button.data('opdisno') // Extract info from data-* attributes
						  var opdurum = button.data('opdurum') // Extract info from data-* attributes
						  
						  
						  var arr = opbastar.split('-');
						  
						  var opbasTarFormat=arr[0]+"."+arr[1]+"."+arr[2];
						  var opbitTarFormat=opbittar;
						  if(opbittar!=""){
						  var arrBit = opbittar.split('-');
						  
						  var opbitTarFormat=arrBit[0]+"."+arrBit[1]+"."+arrBit[2];}
												
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#islemId').val(opid)
						  modal.find('#islemTipi').val(opislem)
						  modal.find('#opaciklama').val(opaciklama)
						  modal.find('#islemTarihiStrModal').val(opbasTarFormat)
						  modal.find('#islemBitisTarihiStrModal').val(opbitTarFormat)
						  modal.find('#miktar').val(opucret)
						  modal.find('#disNo').val(opdisno)
					});
					
					// ODEME EKLE
					$('#odemeEkleModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var opid = button.data('opid') // Extract info from data-* attributes
						  var doktorId = button.data('doktorid') // Extract info from data-* attributes
						  var hastaId = button.data('hastaid') // Extract info from data-* attributes
						  var kalanMiktar = button.data('odkalanmiktar') // Extract info from data-* attributes
						  
						  var date=$.datepicker.formatDate('yy.mm.dd', new Date());
																		
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#odemeTarihiStrModal').val(date)
						  modal.find('#kalanOdemeMiktariModal').val(kalanMiktar)
						  modal.find('#islemIdOdemeModal').val(opid)
						  modal.find('#hastaIdOdemeModal').val(hastaId)
						  modal.find('#doktorIdOdemeModal').val(doktorId)
							
						 
					});
					
					$('#odemeGuncelleModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) // Button that triggered the modal
						  var odemeId = button.data('odemeid') // Extract info from data-* attributes
						  var odememiktar = button.data('odememiktar') // Extract info from data-* attributes
						  var odemeaciklama = button.data('odemeaciklama') // Extract info from data-* attributes
						  
						  
						  var date=$.datepicker.formatDate('yy.mm.dd', new Date());
																		
						  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
						  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
						  var modal = $(this)
						  modal.find('#odemeTarihiStrOdemeGuncelleModal').val(date)
						  modal.find('#odemeGuncelleId').val(odemeId)
						  modal.find('#odememiktarguncellemeModal').val(odememiktar)
						  modal.find('#odemeaciklamaguncellemeModal').val(odemeaciklama)
						  
							
						 
					});
					
					$('#odemeSilModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) 
						  var odemeId = button.data('odemeid') 
						  var odememiktar = button.data('odememiktar') 
						  
						  var modal = $(this)
						  modal.find('#odemeId').val(odemeId)
						  modal.find('#odemeMiktar').html(odememiktar)
						 
					});
					
					
					$('#operasyonOdemeGunuGirModal').on('show.bs.modal', function (event) {
						  var button = $(event.relatedTarget) 
						  var opid = button.data('opid')
						  var kalanMiktar = button.data('kalanmiktar')
						  
						  
						  var modal = $(this)
						  modal.find('#islemId').val(opid)
						  modal.find('#kalan').val(kalanMiktar)
						 
						 
					});
					
					
					
				
			});
	</script>

</body>
</html>