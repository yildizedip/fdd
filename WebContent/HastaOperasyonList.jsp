<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="java.text.DateFormat"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="row">
		
				<form action="HastaOperasyonEkle.do" method="post"
					onsubmit="return validateFormOperasyonEkle()"
					name="operasyonEkleForm">

				<div class="col-lg-12 col-md-12">
				
							<input name="hastaId" type="hidden" value="${lastHasta.id}">
							
							<div class="row">
							
							<div class="col-lg-6 col-md-6">
									<div class="form-group">

										 <span> Tedavi Tarihi : </span>
										  <input
											name="islemTarihiStr" id="islemTarihiStr" class="tarih"
											type="text" placeholder="Tedavi Tarih Giriniz."
											data-validation="required"
											data-validation-error-msg="Zorunlu Alan">
									</div>
								</div>
							
							</div>
			
							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">

										<div class="input-icon">

											
											<div class="btn-group btn-group-xs toothgroup" id="buttons" >
											
											
											<div class="row"  style=" text-align: center;">
													<button type="button"
														class="btn disno btn-success" style="width: 200px; height: 35px; font-weight: normal;"  ><span>Üst Çene</span></button>
													
											</div>
											
											<div class="row toothup"  >
												<div class="col-lg-6 col-md-6 col-sm-6">
												
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/18.png) no-repeat"><span>18</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/17.png) no-repeat"><span>17</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/16.png) no-repeat"><span>16</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/15.png) no-repeat"><span>15</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/14.png) no-repeat"><span>14</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/13.png) no-repeat"><span>13</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/12.png) no-repeat"><span>12</span></button>
												<button type="button" class="btn btn-info disno toothdown" style=" background:  url(Images/tooth/11.png) no-repeat"><span>11</span></button>
												</div>
												<div class="col-lg-6 col-md-6 col-sm-6">
												
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/21.png) no-repeat"><span>21</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/22.png) no-repeat"><span>22</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/23.png) no-repeat"><span>23</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/24.png) no-repeat"><span>24</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/25.png) no-repeat"><span>25</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/26.png) no-repeat"><span>26</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/28.png) no-repeat"><span>27</span></button>
												<button type="button" class="btn btn-success disno toothdown" style=" background:  url(Images/tooth/28.png) no-repeat"><span>28</span></button>
												
												</div>
											
											</div>
											<div class="row"  >
												<div class="col-lg-6 col-md-6 col-sm-6">
												
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/48.png) no-repeat"><span>48</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/47.png) no-repeat"><span>47</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/46.png) no-repeat"><span>46</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/45.png) no-repeat"><span>45</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/44.png) no-repeat"><span>44</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/43.png) no-repeat"><span>43</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/41.png) no-repeat"><span>42</span></button>
												<button type="button" class="btn btn-danger disno toothup" style=" background:  url(Images/tooth/41.png) no-repeat"><span>41</span> </button>
												</div>
												<div class="col-lg-6 col-md-6 col-sm-6">
												<button type="button" class="btn btn-warning disno toothup " style=" background:  url(Images/tooth/31.png) no-repeat"><span>31</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/32.png) no-repeat"><span>32</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/33.png) no-repeat"> <span>33</span> </button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/34.png) no-repeat"><span>34</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/35.png) no-repeat"><span>35</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/36.png) no-repeat"><span>36</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/37.png) no-repeat"><span>37</span></button>
												<button type="button" class="btn btn-warning disno toothup" style=" background:  url(Images/tooth/38.png) no-repeat"><span>38</span></button>
												</div>
											
											</div>

												<div class="row"  style=" text-align: center;">
													<button type="button"
														class="btn btn-success disno" style="background-color: #2A3141; width: 200px; height: 35px; font-weight: normal;"  > <span> Alt Çene</span> </button>
													
											</div>
												
											</div>

										</div>
									</div>
								</div>
							</div>
							
							<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6"> 
							
							<!-- TEDAVI BILGILERI BASLA -->
							<h5>Tedavi Bilgileri</h5>
									
							<div class="row">
								<div class="col-lg-6 col-md-6">
									<div class="form-group ">
										<select size="1" name="doktorId" class="form-control">
											<option label="Diş Hekimi Seçiniz.." value="-1">
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
						   </div>
							<div class="row">
								
									<div class="col-lg-6 col-md-6">
									<div class="form-group">
										<input class="form-control" placeholder="Ücret (TL)"
											name="operasyonUcret" id="operasyonUcret" onkeyup="hesapla()"
											data-validation="required"
											data-validation-error-msg="Zorunlu Alan">

									</div>
								</div>
									
								
						   </div>
						   		
				
							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">
										<div class="input-icon">
											<textarea class="form-control" name="operasyonAciklama"
												placeholder="Not.." rows="2" id="aciklama"
												cols="20"></textarea>
										</div>
									</div>

								</div>
							</div>
							
							
								<div class="row">
								<div class="col-lg-9 col-md-9">
									<div class="form-group">

										<input class="form-control" placeholder="Diş Numarası"
											name="disNo" id="disNo" data-validation="required" readonly="readonly"
											data-validation-error-msg="Zorunlu Alan">
											
											
										<input
											class="form-control" placeholder="Adet" name="disAdet"
											id="disAdet" data-validation="required"
											data-validation-error-msg="Zorunlu Alan" type="hidden"  >




									</div>
								</div>
								
								<div class="col-lg-3 col-md-3">
									<div class="form-group">

										<button type="button" id="disnosil" class="btn btn-warning">Sil</button>
									</div>
								</div>
							</div>

							<div class="row">


								


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
											<option label="Protez Doktor Seçiniz.." value="-1">Protez Doktor Seçiniz..</option>

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
											<option label="Cerrah Doktor Seçiniz.." value="-1">Cerrah Doktor Seçiniz..</option>

											<c:forEach items="${doktorList}" var="doktorDTO">
												<option label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
													value="${doktorDTO.dId }">${doktorDTO.dAd }
													${doktorDTO.dSoyad }</option>
											</c:forEach>
										</select>
									</div>
								</div>



							</div>


							<div class="row">
							


								<div class="col-lg-6 col-md-6">
									<div class="form-group">

										<div class="input-icon">
											<div class="checkbox">
												<label> <input type="checkbox" id="durumu"
													name="operasyonDurum" /> &nbsp; Kesinleşmedi
												</label>
											</div>

										</div>
									</div>
								</div>


							</div>
							
							<!-- TEDAVI BILGILERI BITIR -->
							
							
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
							
							
										<h5>Ücret Bilgileri</h5>
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
											placeholder="Ödeme Miktarı Giriniz (TL)" name="odemeMiktar"
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
											<option label="Peşinat" value="2" >Peşinat</option>
											<option label="Taksit" value="3" >Taksit</option>
											<option label="Kredi Kartı" value="4" >Kredi Kartı</option>
											<option label="EFT / Havale" value="5" >EFT / Havale</option>

										</select>

									</div>
								</div>
							</div>




							<div class="row">
								<div class="col-lg-12 col-md-12">
									<div class="form-group">
										<div class="input-icon">
											<textarea class="form-control" placeholder="Açıklama Giriniz"
												rows="4" name="odemeAciklama" id="aciklama" cols="50"></textarea>
										</div>
									</div>

								</div>
							</div>
							
							
							 </div>
							
							
							</div>
							
							
						

						
						<input id="bntKaydetTedavi" class="btn btn-default pull-right" type="submit" value="Ekle" />
				</div>
		</form>
		

</div>
	<div class="row">
	
	<hr>

	<div class="col-lg-12">
	
	
		<h4>Uygulanmış Tedaviler - Ödemeler</h4>	
		
		<c:forEach items="${lastHasta.hastaOperasyonList}" var="operasyon"	varStatus="count">

			<div class="col-md-6">
                        <div class="panel panel-default  panel--styled">

                            <div class="panel-heading" >
                            
                            <div class="row">
                            
                            <div class="col-lg-6"> <p><strong>    ${operasyon.islemTip.ad}  </strong></p> </div>
                            <div class="col-lg-6"> 
                            
                             <button type="button" class="btn btn-secondary pull-right btn-sm randevuEkleButton"
													id="randevuEkle" value="${operasyon.doktorId}"
													data-opId="${operasyon.id}" >Randevu Ekle </button>
                            
                            </div>
                             
                            
                           
                            
                            
                             </div>
                            
                           
                            
                            </div>
                            <div class="panel-body bg-info">
  									<div class="col-md-6">
                                        <p> <strong>  Hekim : </strong> ${operasyon.doktor.dAd}
													${operasyon.doktor.dSoyad}  </p>
                                    </div>
  									<div class="col-md-6">
                                       <strong>  Durum : </strong>

													<c:choose>
														<c:when test="${operasyon.durumu eq 'A'}">Devam Ediyor</c:when>
														<c:when test="${operasyon.durumu eq 'B'}">Bitmiş</c:when>
														<c:when test="${operasyon.durumu eq 'K'}">Kesinleşmedi</c:when>
													</c:choose>
                                    </div>
                                    
                                    <div class="col-md-7">

                                        <p><strong> Tedavi Tarihi :  </strong> ${operasyon.islemTarihi} - ${operasyon.islemBitisTarihi}</p>
                                        <p>
                                        <p><strong> Diş No : </strong> ${operasyon.disNo}</p>
                                        <p>
                                        <p><strong> Tedavi Ücreti :  ${operasyon.miktar} </strong> </p>
                                        <p><strong style="color: red;"> Kalan Ödeme :  ${operasyon.kalanMiktar} </strong> </p>

                                    </div>
                                    
                                    <div class="col-md-5">
                                        <p> <strong>   Tedavi Notu : </strong> ${operasyon.aciklama}   </p>
                                    </div>


									<div class="col-md-12">
                                        <c:if test="${!empty operasyon.odemeList}">
                                        
                                        <h5><strong> Yapılmış Ödemeler </strong> </h5>
											<table class="table table-hover table-bordered">
												<thead>
													<tr>
														<td class="helpHed">Ödeme Tarih</td>
														<td class="helpHed">Miktar</td>
														<td class="helpHed">Tür</td>
														<td class="helpHed">Açıklama</td>

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
																								Peşinat
																								</c:when>

																	<c:when test="${odeme.odemeTuru eq 3}">
																								Taksit
																								</c:when>
																	<c:when test="${odeme.odemeTuru eq 4}">
																								Kredi Kartı
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
																			data-toggle="modal" data-target="#odemeGuncelleModal"
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
						
									<c:if test="${silAktif ne '0' }">
										<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
										
											<c:if test="${operasyon.kalanMiktar >0}">
												<button type="button" class="btn btn-link btn-sm"
													data-toggle="modal" data-target="#odemeEkleModal"
													data-opid="${operasyon.id}"
													data-odkalanmiktar="${operasyon.kalanMiktar}"
													data-doktorid="${operasyon.doktorId}"
													data-hastaid="${lastHasta.id}">Ödeme Ekle</button>
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
													data-opad="${operasyon.islemTip.ad}">Kesinleştir</button>
													
												<button type="button" class="btn btn-link btn-sm"
													data-toggle="modal" data-target="#aramaKaydiEkleModal"
													data-opid="${operasyon.id}"
													data-opad="${operasyon.islemTip.ad}">Arama Ekle</button>
											</c:if>


											<button type="button" class="btn btn-link btn-sm"
												data-toggle="modal"
												data-target="#operasyonOdemeGunuGirModal"
												data-opid="${operasyon.id}"
												data-kalanmiktar="${operasyon.kalanMiktar}">Ödeme Günü Gir</button>
										
										
										
											<button type="button" class="btn btn-info pull-right btn-sm"
												data-toggle="modal" data-target="#operasyonGuncelleModal"
												data-opid="${operasyon.id}"
												data-opdoktor="${operasyon.doktorId}"
												data-opbastar="${operasyon.islemTarihi}"
												data-opbittar="${operasyon.islemBitisTarihi}"
												data-opislem="${operasyon.islemTipi}"
												data-opaciklama="${operasyon.aciklama}"
												data-opdisno="${operasyon.disNo}"
												data-opmiktar="${operasyon.miktar}">Güncelle</button>
										
											<button type="button"
												class="btn btn-danger pull-right btn-sm" data-toggle="modal"
												data-target="#operasyonSilModal" data-opid="${operasyon.id}"
												data-opad="${operasyon.islemTip.ad}">Sil</button>

										</c:if>


									</c:if>


                                </div>



                        </div>
                    </div>

					</c:forEach>
					
	</div>
	</div>

</body>
</html>