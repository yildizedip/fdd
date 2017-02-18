<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>..Poliklinik..</title>

    <link type="text/css" rel="stylesheet" href="styles/jquery-ui-1.10.4.custom.min.css">
    <link type="text/css" rel="stylesheet" href="styles/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="styles/animate.css">
    <link type="text/css" rel="stylesheet" href="styles/all.css">
    <link type="text/css" rel="stylesheet" href="styles/main.css">
    <link type="text/css" rel="stylesheet" href="styles/style-responsive.css">
    <link type="text/css" rel="stylesheet" href="styles/zabuto_calendar.min.css">
    <link type="text/css" rel="stylesheet" href="styles/pace.css">
    <link type="text/css" rel="stylesheet" href="styles/jquery.news-ticker.css">

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
    <!--LOADING SCRIPTS FOR CHARTS-->
    <script src="script/highcharts.js"></script>
    <script src="script/data.js"></script>
    <script src="script/drilldown.js"></script>
    <script src="script/exporting.js"></script>
    <script src="script/highcharts-more.js"></script>
    <script src="script/charts-highchart-pie.js"></script>
    <script src="script/charts-highchart-more.js"></script>
    <!--CORE JAVASCRIPT-->
    <script src="script/main.js"></script>
	
	<script>

	$(document).ready(function() {
	    $( "#dialogInfo" ).dialog({
	        autoOpen: false,
	      });
	   

	    $( "#openInfo" ).on( "click", function() {
	        $( "#dialogInfo" ).dialog( "open" );
	      });

		$( "#dialogSifremiDegistir" ).dialog({
	        autoOpen: false,
	     
	      });

	 	$("#openPassword" ).on( "click", function() {
	        $( "#dialogSifremiDegistir" ).dialog( "open" );

		});
	 	
		$( "#dialogHastaList" ).dialog({
	        autoOpen: false,
	     
	      });

	 	$("#openHastaList" ).on( "click", function() {
	        $( "#dialogHastaList" ).dialog( "open" );

		});
	 	
	 	$('#buttonSec').click(function () {
	        var ids = $.map(table.rows('.selected').data(), function (item) {
	            return item
	        });
	        
	        $('#hasta_id').val(ids[4]);
	        $('#send').submit();
	       
	 });
	 	
/* 	 	$('#example').DataTable( {
		        select: {
		            style: 'single'
		        }
		    } );

		 var table = $('#example').DataTable();

		 $('#example tbody').on('click', 'tr', function () {
		    	$('#example tbody tr').removeClass('selected');
		        $(this).toggleClass('selected');
		 });
		 

		$('#exampleModal').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget) // Button that triggered the modal
				  var recipient = button.data('whatever') // Extract info from data-* attributes

				  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
				  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
				  var modal = $(this)
				  modal.find('.modal-body #recipient-name').val(recipient)
		}); */
	 });
	   
	</script>

</head>
<body>



	<c:if test="${sessionScope.sessionMember[0] eq null}">
		<%
		session.isNew();
		session.invalidate();
		%>
		<jsp:forward page="logout.jsp"></jsp:forward>
	</c:if>



<div>  

<form id="send" action="hastaSorgulaForRandevu.do"  method="post">

<input type="hidden" name="hastaId" id="hasta_id" >
</form>

</div>

	<a id="totop" href="#"> ÜST<i class="fa fa-angle-up"></i></a>

	<!--BEGIN TOPBAR-->
	<div id="header-topbar-option-demo" class="page-header-topbar">
		<nav id="topbar" role="navigation" style="margin-bottom: 0;" data-step="3" class="navbar navbar-default navbar-static-top">
			<div class="navbar-header">
				<button type="button" data-toggle="collapse"
					data-target=".sidebar-collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span><span
						class="icon-bar"></span><span class="icon-bar"></span><span
						class="icon-bar"></span>
				</button>
				<a id="logo" href="redirect_div.jsp" class="navbar-brand"><span class="logo-text" style="font-family:monospace; font-size: 20px;">${sube.sAd}</span>
					</a>
			</div>
			
			
			<div class="topbar-main">
			
				<a id="menu-toggle" href="#" class="hidden-xs"><i
					class="fa fa-bars"></i></a>
					<!-- 
                 <form id="topbar-search" action="" method="post" class="hidden-sm hidden-xs">
                    <div class="input-icon right text-black">
                    
                    <a id="openHastaListee" data-toggle="modal" data-target="#exampleModal" data-whatever="" ><i class="fa fa-search"></i></a>
                    
                    <input type="text" placeholder="Hasta Listesi Getir.." readonly="readonly" class="form-control text-black"/>
                    
                    </div>
                    
                </form>
                 -->

				<ul class="nav navbar navbar-top-links navbar-right mbn">
					<li class="dropdown topbar-user">

					<a data-hover="dropdown"
						href="#" class="dropdown-toggle">
						
						<span class="hidden-xs">
								..: ${sessionScope.sessionMember[1].kuAd }	${sessionScope.sessionMember[1].kuSoyad } - ${sube.sAd} :..						
						</span>&nbsp;
						<span class="caret">
								
						</span>
								
					</a>
								
								<ul class="dropdown-menu dropdown-user pull-right">
									<c:forEach items="${menu.subMenu}" var="subMenu" >	
							
									 	<li> <a target="_parent" href="${subMenu.menuPage}"> ..: ${subMenu.menuAd} </a>	 </li>
					
									</c:forEach>			
								
						
							<li><a  id="openInfo" ><i class="fa fa-user"></i>Bilgilerim</a></li>
							<li><a id="openPassword" href="#dialogSifremiDegistir"><i class="fa fa-key"></i>Sifremi Deðiþtir</a></li>
							<li class="divider"></li>
							<li>
							
							<a href="cikis.jsp"> <i class="fa fa-arrow-left" aria-hidden="true"></i> Çýkýþ</a>
							
							</li>
						</ul>
						
						
						</li>
					
				</ul>
				
			
			</div>
		</nav>
		
	</div>
	
	
	<!--END TOPBAR-->

  <div id="wrapper">
            <!--BEGIN SIDEBAR MENU-->
					<nav id="sidebar" role="navigation" data-step="2"
						data-intro="Template has &lt;b&gt;many navigation styles&lt;/b&gt;"
						data-position="right" class="navbar-default navbar-static-side">
			
						<div class="sidebar-collapse menu-scroll">
						
						
						
						
							<ul id="side-menu" class="nav">

					<div class="clearfix"></div>

					<c:forEach items="${kullaniciMenuList}" var="menu">
									<c:choose>
										<c:when test="${menu.ustMenuId eq 0 }">
			
												<li>
												
													<a href="${menu.menuPage}" target="frame" > <i class="${menu.menuPath}">
														</i><span class="submenu-title">${menu.menuAd} </span>
								
													</a>
															<ul class="nav nav-second-level">
															
																<c:if test="${menu.subMenu[0] ne null}">
																	<c:forEach items="${menu.subMenu}" var="subMenu" >	
																					<li>
																					
																					<a href="${subMenu.menuPage}" target="frame" >
																					  	<span class="submenu-title">  ..: ${subMenu.menuAd}   </span>
																					  
																					  </a>
																					  
																					  </li>
																				
																	</c:forEach>		
															
																</c:if>
															</ul>
												</li>
											</c:when>	
									</c:choose>
							</c:forEach>
							
							
							</ul>
						</div>
					</nav>

		<!--END SIDEBAR MENU-->
		
		
          
            <div id="page-wrapper">
                
                
                <!--BEGIN CONTENT-->
                <div class="page-content">
                    <div id="tab-general">
                        <div class="row mbl">
                            <div class="col-lg-12">
                                
                                            <div class="col-md-12">
                                                <div id="area-chart-spline" style="width: 100%; height: 300px; display: none;">
                                                </div>
                                            </div>
                                
                            </div>
                            
                            
                 
                            
                             <iframe src="main.jsp" name="frame" width="100%" height="900" frameborder="0" scrolling="auto"></iframe>
                            	
                            	
                        </div>
                    </div>
                </div>
                <!--END CONTENT-->
                <!--BEGIN FOOTER-->
                <div id="footer">
                    <div class="copyright">
                        <a href="http://themifycloud.com">2016 © Dicle Fýrat </a></div>
                </div>
                <!--END FOOTER-->
            </div>
            <!--END PAGE WRAPPER-->

	   </div>
            <!--END PAGE WRAPPER-->
      
 
            
<div id="dialogInfo" title="Bilgilerimi Güncelle">

	<form action="KullaniciGuncelle.do?tip=kisiselBilgileriGuncelle" method="post" >
	
      <div id="guncelle"> BÝLGÝLERÝM
        <hr>
        <div>
          <label> Ad...........:</label>
          <input readonly="readonly" class="inputTextfield"
		name="ad" value="${sessionScope.sessionMember[1].kuAd}">
		
		 <input readonly="readonly" type="hidden"
		name="kuloginId" value="${sessionScope.sessionMember[1].kuLoginId}">
		
		 <input readonly="readonly" type="hidden"
		name="kuTur" value="${sessionScope.sessionMember[0].kuTur}">
		
        </div>
        <div>
          <label> Soyad......:</label>
          <input
		class="inputTextfield" readonly="readonly" name="soyad" value="${sessionScope.sessionMember[1].kuSoyad}">
        </div>
        <div>
          <label> Tel...........:</label>
          <input class="inputTextfield"
		name="tel" value="${sessionScope.sessionMember[1].kuTel}"> *
        </div>
        <div>
          <label> Adres.......:</label>
          <textarea name="adres" rows="3" cols="20">${sessionScope.sessionMember[1].kuAdres}</textarea> *
		
        </div>
        <br>
       * : Güncellenebilir alan.
       <br>
        <div>
          <input type="submit" value="Güncelle">
        </div>
      </div>     
	</form>

</div>

<div id="dialogSifremiDegistir" title="Þifremi Güncelle">

	<form name="SifreForm" action="SifremiGuncelle.do?" method="post" onsubmit="return validateSifreForm()" >
        <div>
          <label> Eski Þifre..............:</label>
          <input type="password"
		name="password" >
		
		 <input type="hidden"
		name="kuloginId" value="${sessionScope.sessionMember[1].kuLoginId}">
		
        </div>
        <div>
          <label> Yeni Þifre..............:</label>
          <input type="password" name="newPassword" >
        </div>
        <div>
          <label> Yeni Þifre Tekrar...:</label>
          <input type="password" name="reNewPassword" > 
        </div>
		<hr>
        <div>
          <input type="submit" value="Güncelle">
        </div>
	</form>

</div>

</body>
</html>