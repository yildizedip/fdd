<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Hasta Kartý Ekle</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="images/icons/favicon.ico">
<link rel="apple-touch-icon" href="images/icons/favicon.png">
<link rel="apple-touch-icon" sizes="72x72"	href="images/icons/favicon-72x72.png">
<link rel="apple-touch-icon" sizes="114x114"	href="images/icons/favicon-114x114.png">
<!--Loading bootstrap css-->
<link type="text/css" rel="stylesheet"	href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,700">
<link type="text/css" rel="stylesheet"	href="http://fonts.googleapis.com/css?family=Oswald:400,700,300">
<link type="text/css" rel="stylesheet"	href="styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/animate.css">
<link type="text/css" rel="stylesheet" href="styles/all.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link type="text/css" rel="stylesheet"	href="styles/style-responsive.css">
<link type="text/css" rel="stylesheet"	href="styles/zabuto_calendar.min.css">
<link type="text/css" rel="stylesheet" href="styles/pace.css">
<link type="text/css" rel="stylesheet"	href="styles/jquery.news-ticker.css">
<link type="text/css" rel="stylesheet" href="styles/jplist-custom.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap-datepicker.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap-datepicker.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap-datepicker3.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap-datepicker3.min.css">


<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="lib/jquery-1.7.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />


<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>




<script type="text/javascript">

	function kontrol() {

		var protokolNo = document.getElementById("protokolNo").value;
		var tckimlik = document.getElementById("tckimlik").value;
		var tel = document.getElementById("tel").value;

		var regexNum = /\d/;
		var regexLetter = /[a-zA-z]/;

		if (!regexNum.test(protokolNo) && regexLetter.test(protokolNnav-second-levelo)) {
			document.getElementById("protokolNo").value = "";
			alert("Yalnýzca rakam girilebilir.");

		}

		if (!regexNum.test(tckimlik) && regexLetter.test(tckimlik)) {
			document.getElementById("tckimlik").value = "";
			alert("Yalnýzca rakam girilebilir.");

		}
		if (!regexNum.test(tel) && regexLetter.test(tel)) {
			document.getElementById("tel").value = "";
			alert("Yalnýzca rakam girilebilir.");

		}
	}


	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiStr"));
		
		var bas_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiImplantStr"));
				
		var bit_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("islemTarihiImplStr"));
				
		var baee_tar = new Epoch('epoch_popup', 'popup', document
				.getElementById("odemeTarihiStr"));
				
		 $(document).ready(
				function(){
					$("div.implantOperasyonEkleForImplant").hide();				
				}
			);
	}


    $('#sandbox-container input').datepicker({
    });
		
	
</script>

</head>

<body>

<div class="container col-lg-8">
	<div class="panel panel-grey">
	
		<div class="panel-heading">Hasta Kartý Ekle</div>

		<div class="panel-body pan">
		
	<form action="hastaEkle.do" method="post">
			
			
			<input type="hidden"  name="subeId" value="${subeId}" >
				
				<div class="form-body pal">
				
				<h4>Hasta Bilgileri</h4>

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<div class="input-icon">
									<i class="fa fa-user"></i> <input id="inputFirstName"
										type="date" placeholder="Ad" class="form-control" />
										
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<div class="input-icon">
									<i class="fa fa-user"></i> <input id="inputLastName"
										type="text" placeholder="Soyad" class="form-control" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="row"> 
					
						<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-tag"></i> <input id="inputFirstName"
											type="text" placeholder="Protokol No" class="form-control" />
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-user"></i> <input id="inputLastName"
											type="text" placeholder="Tc Kimlik No" class="form-control" />
									</div>
								</div>
							</div>
					
					</div>
					
					<div class="row"> 
					
						<div class="col-md-6">
								<div class="form-group">
									<div class="input-icon">
										<i class="fa fa-phone"></i> <input id="inputFirstName"
											type="text" placeholder="Telefon" class="form-control" />
									</div>
								</div>
							</div>
					
					</div>
					
					<hr />
					<h4>Operasyon Bilgileri</h4> <!-- OPERASYON BILGILERI -->
					
					<div class="row">  <!-- START TAB -->
					
						
						<div id="tab-general">
							<div class="row mbl">
							
									<div class="col-lg-12">
		                                
		                                            <div class="col-md-12">
		                                                <div id="area-chart-spline" style="width: 100%; height: 300px; display: none;"> 
		                                                </div>
		                                            </div>
		                                
		                            </div>
		
		                            <div class="col-lg-12">
		                            <div class="col-lg-12">
					                        <ul id="generalTab" class="nav nav-tabs responsive">
					                        	<li class="active"><a href="#alert-tab" data-toggle="tab"> Normal</a></li>
					                            <li><a href="#note-tab" data-toggle="tab">Implant</a></li>
					                        </ul>
									
									
									
									 <div id="generalTabContent" class="tab-content responsive">
		                            	<div id="alert-tab" class="tab-pane fade in active">
											<div class="row">
		                                    	<div class="col-lg-12">
														<div class="form-group ">
															<select size="1" name="doktorId" class="form-control">
																<option label="Diþ Hekimi Seçiniz.." value="-1"> Hekim Seçiniz</option>
										
																<c:forEach items="${doktorList}" var="doktorDTO">
																	<option  label="${doktorDTO.dAd } ${doktorDTO.dSoyad } "
																		value="${doktorDTO.dId }" 
																		<c:if test="${doktorDTO.dId eq operasyonDoktorId }">
																		selected="selected"
																		</c:if>  
																		>
																		${doktorDTO.dAd } ${doktorDTO.dSoyad } 
																		</option>
																</c:forEach>
															</select> 
														</div>
																				
															<div class="form-group"  >
																<div class="input-icon ">
																	
																	<input class="form-control" name="islemTarihiStr" 
																	id="islemTarihiStr" placeholder="Operasyon Tarihi Giriniz.." <c:if test="${operasyonEklemeTarihi ne null}" >
															
																			value="${operasyonEklemeTarihi}"
															
																			</c:if>="" value="${tarihStr}">
																</div>
															</div>
														
														<div class="form-group">
															<div class="input-icon">
															
																	<select size="1" name="islemTipi" id="islemTipi" class="form-control">
																		<option label="Operasyon Seçiniz.." value="-1"> Operasyon Seçiniz.. </option>
												
																		<c:forEach items="${islemTurList}" var="islem">
																			<option label="${islem.ad}" value="${islem.id}" <c:if test="${iliskiliIslemId ne null && islem.id==43}"> selected="selected"   </c:if>=""> ${islem.ad}</option>
																		</c:forEach>
																	</select>
																
															</div>
														</div>
															
													
														
														<div class="form-group">
															<div class="input-icon">
																<select size="1" name="disAdet" id="disAdet" class="form-control">
																	<option label="Adet Seçiniz.." value="-1"> Adet Seçiniz.. </option>
											
																	<c:forEach items="${disSayisiList}" var="dis">
																		<option label="${dis}" value="${dis}" > ${dis} </option>
																	</c:forEach>
																</select> 
																 
															</div>
														</div>
															
													
														
														<div class="form-group">
															<div class="input-icon">
																<input class="form-control" placeholder="Ücret Giriniz (TL)"	name="miktar" id="miktar" onkeyup="hesapla()" >
																
															</div>
														</div>
															
													
														
														<div class="form-group">
															<div class="input-icon">
																
																 <textarea class="form-control" placeholder="Açýklama Giriniz" rows="4" name="aciklama" id="aciklama" cols="50"></textarea>
															</div>
														</div>
															
													</div>
		                                    	
		                                    	
		                                    	
											</div>
										</div>
		                            	
		                            	
		                            	<div id="note-tab" class="tab-pane fade">
		                                  <div class="row">
		                                    <div class="col-lg-6">
		                                        <div class="note note-success"><h4 class="box-heading">Success! Duis mollis, est non commodo luctus</h4>
		                                        
		                                        
		                                        
		                                        
												</div>
												
												<div class="form-group"  >
																<div class="input-icon ">
																	
																	 <div class="well">
															            <input type="text" class="span2" value="02-16-2012" id="dp1" >
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

					</div>
				</div>  <!-- END TAB -->
				
				<hr />
					<h4>Ücret Bilgileri</h4> <!-- OPERASYON BILGILERI -->				
				
				<div class="row"> 
				<div class="col-lg-12">
							<div class="col-md-6">
									<div class="form-group">
											
												                         <div class="input-group date">
      <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
    </div>
												        </div>
												        
											
										
							</div>
							
							
				</div>
					
				
				
				
				</div>
				
				
				</div>
				
	</form>

		</div>

	</div>
	
</div>

    <script src="script/bootstrap.min.js"></script>
    <script src="script/bootstrap-datepicker.js"></script>
    <script src="script/bootstrap-datepicker.min.js"></script>
    <script src="script/bootstrap-datepicker.tr.min.js"></script>
    
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
    
        <script src="script/jquery-1.10.2.min.js"></script>
    <script src="script/jquery-migrate-1.2.1.min.js"></script>
    <script src="script/jquery-ui.js"></script>
    <script src="script/bootstrap.min.js"></script>
    <script src="script/bootstrap-hover-dropdown.js"></script>
    <script src="script/html5shiv.js"></script>
    <script src="script/respond.min.js"></script>
    <script src="script/jquery.metisMenu.js"></script>
    <script src="script/jquery.slimscroll.js"></script>
    <script src="script/jquery.cookie.js"></script>
    <script src="script/icheck.min.js"></script>
    <script src="script/custom.min.js"></script>
    <script src="script/jquery.news-ticker.js"></script>
    <script src="script/jquery.menu.js"></script>
    <script src="script/pace.min.js"></script>
    <script src="script/holder.js"></script>
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
    <script src="script/highcharts.js"></script>
    <script src="script/data.js"></script>
    <script src="script/drilldown.js"></script>
    <script src="script/exporting.js"></script>
    <script src="script/highcharts-more.js"></script>
    <script src="script/charts-highchart-pie.js"></script>
    <script src="script/charts-highchart-more.js"></script>
    <script src="script/modernizr.min.js"></script>
    <script src="script/jplist.min.js"></script>
    <script src="script/jplist.js"></script>

    <!--CORE JAVASCRIPT-->
    <script src="script/main.js"></script>
    <script>        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r;
            i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
            a = s.createElement(o),
            m = s.getElementsByTagName(o)[0];
            a.async = 1;
            a.src = g;
            m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-145464-12', 'auto');
        ga('send', 'pageview');


</script>
    
    
    <script type="text/javascript">
    


    $('#sandbox-container .input-group.date').datepicker({
    });

    </script>
    

   
</body>
</html>