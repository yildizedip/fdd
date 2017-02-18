<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>


<!DOCTYPE html>
<html lang="tr">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>..Poliklinik..</title>

<!-- jquery dialog gibi componentlerin gorunumu -->
<link type="text/css" rel="stylesheet"	href="styles/jquery-ui-1.10.4.custom.min.css"> 
<!-- kucuk iconlar icin (menu) -->
<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">

<!-- temel bootstrap css -->
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">

<!-- my css -->
<link type="text/css" rel="stylesheet" href="styles/main.css">


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
	


<a id="totop" href="#"> TOP<i class="fa fa-angle-up"></i></a>
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
					
                 <form id="topbar-search" action="" method="post" class="hidden-sm hidden-xs">
                    <div class="input-icon right text-black">
                    
                    <a id="openHastaListee" data-toggle="modal" data-target="#exampleModal" data-whatever="" ><i class="fa fa-search"></i></a>
                    
                    <input type="text" placeholder="Hasta Listesi Getir.." readonly="readonly" class="form-control text-black"/>
                    
                    </div>
                    
                </form>

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
							
									 	<li> <a  href="${subMenu.menuPage}"> ..: ${subMenu.menuAd} </a>	 </li>
					
									</c:forEach>			
								
						
							<li><a  id="openInfo" ><i class="fa fa-user"></i>Bilgilerim</a></li>
							<li><a id="openPassword" href="#dialogSifremiDegistir"><i class="fa fa-key"></i>Sifremi Değiştir</a></li>
							<li class="divider"></li>
							<li><a href="logout.jsp"> <i class="fa fa-arrow-left" aria-hidden="true"></i> Çıkış</a></li>
						</ul>
						
						
						</li>
					
				</ul>
				
			
			</div>
		</nav>
		
	</div>
<div id="dialogInfo" title="Bilgilerimi Güncelle">

	<form action="KullaniciGuncelle.do?tip=kisiselBilgileriGuncelle" method="post" >
	
      <div id="guncelle"> BİLGİLERİM
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

<div id="dialogSifremiDegistir" title="Şifremi Güncelle">

	<form name="SifreForm" action="SifremiGuncelle.do?" method="post" onsubmit="return validateSifreForm()" >
        <div>
          <label> Eski Şifre..............:</label>
          <input type="password"
		name="password" >
		
		 <input type="hidden"
		name="kuloginId" value="${sessionScope.sessionMember[1].kuLoginId}">
		
        </div>
        <div>
          <label> Yeni Şifre..............:</label>
          <input type="password" name="newPassword" >
        </div>
        <div>
          <label> Yeni Şifre Tekrar...:</label>
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
	
	<!--END TOPBAR-->