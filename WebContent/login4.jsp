
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
	
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="tr">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DentalNet</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- CSS Files -->
<link href="backyard/css/bootstrap.min.css" rel="stylesheet"	media="screen">
<link href="backyard/css/font-awesome.min.css" rel="stylesheet">
<link href="backyard/css/animate.css" rel="stylesheet" media="screen">

<!-- Colors -->
<link href="backyard/css/css-index.css" rel="stylesheet" media="screen">

<!-- Google Fonts -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Lato:100,300,400,700,900,100italic,300italic,400italic,700italic,900italic" />

</head>

<body data-spy="scroll" data-target="#navbar-scroll">

	<div id="preloader"></div>
	<div id="top"></div>

	<!-- /.parallax full screen background image -->
	<div class="fullscreen landing parallax bg-info"
		style="background-image: url('Images/2.jpg');" data-img-width="2000"
		data-img-height="1333" data-diff="100">

		<div class="overlay ">
			<div class="container">
				<div class="row">
					<div class="col-md-7">

						<!-- /.logo -->
						<div class="logo wow fadeInDown">
							<a href=""> <font size="15"> D e n t a l N e t </font>
							</a>
						</div>

						<!-- /.main title -->
						<h1 class="wow fadeInLeft">Online Hasta Takip Sistemi</h1>

						<!-- /.header paragraph -->
						<div class="landing-text wow fadeInUp">
							<p>DentalNet hastane sisteminizi online olarak takip etmenize
								imkan sunar.</p>
						</div>



					</div>

					<!-- /.signup form -->
					<div class="col-md-5">

						<div class="signup-header wow fadeInUp">
							<h3 class="form-title text-center">Sisteme Giris</h3>
							<form class="form-header" action="login.do" method="post"
								role="form">
								<input type="hidden" name="u" value="503bdae81fde8612ff4944435">
								<input type="hidden" name="id" value="bfdba52708">
								
								<div class="form-group">
									<input class="form-control input-lg" name="userName" id="name"
										type="text" placeholder="Ad" required>
								</div>
								<div class="form-group">
									<input class="form-control input-lg" name="password" id="email"
										type="password" placeholder="Parola" required>
								</div>
								<div class="form-group last">
									<input type="submit" class="btn btn-warning btn-block btn-lg"
										value="Sisteme Giris">
								</div>
								
								<c:if test="${!requestScope.failure} "> 
									<p class="bg-danger">  ${requestScope.failure} </p> 
								</c:if>
								 
								<p class="privacy text-center"></p>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- NAVIGATION -->
	<div id="menu">
		<nav class="navbar-wrapper navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-backyard">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>

				</div>

				<div id="navbar-scroll"
					class="collapse navbar-collapse navbar-backyard navbar-right">
					<ul class="nav navbar-nav">
						<li> <p>Copyright &copy; Dental Net 2014</p> </li>

					</ul>
				</div>
			</div>
		</nav>
	</div>

	<!-- /.javascript files -->
	<script src="backyard/js/jquery.js"></script>
	<script src="backyard/js/bootstrap.min.js"></script>
	<script src="backyard/js/custom.js"></script>
	<script src="backyard/js/jquery.sticky.js"></script>
	<script src="backyard/js/wow.min.js"></script>
	<script src="backyard/js/owl.carousel.min.js"></script>
	<script>
		new WOW().init();
	</script>
</body>
</html>