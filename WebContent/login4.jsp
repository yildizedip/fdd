<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


	<link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

<title>Poliklinik</title>

<style type="text/css">

</style>

</head>
<body class="bg-info" >
 <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
  		     <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header ">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"> Dicle Fırat Diş </a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right " id="bs-example-navbar-collapse-1">
            
                   <form class="navbar-form" role="search"		action="login.do" method="post">
     				<div class="form-group">
							 <p class="bg-warning">  ${requestScope.failure} </p> 
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Ku Adı"
								name="userName"> <input type="password"
								class="form-control" placeholder="Parola" name="password">
						</div>
						
						<input type="submit" class="btn btn-default" value="Login" > 
						
						<br>
						

					</form>
            
              
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
	
   
    
    <div class="bg-white">
    <div id="myCarousel" class="carousel slide">
        <div class="carousel-inner">

            <!--Carousel item 1-->
            <div class="item active" align="center">
                <img src="Images/2.jpg" alt="buffalo-skyline" />
                <div class="carousel-caption">
                </div>
            </div>

       
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a>
    </div>
</div>
    

    <!-- Page Content -->
    <div class="container">

        <!-- Marketing Icons Section -->
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <h1 class="page-header">
                   HİZMETLERİMİZ
                </h1>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading ">
                        <h4 ><i class="fa fa-fw fa-check"></i> İmplant Tedavisi</h4>
                    </div>
                    <div class="panel-body">
                        <p>Dental implantlar; diş eksikliklerinde hastayı dişsizlikten kurtarmak amacıyla 
                        çene kemiğine yerleştirilen titanyum alaşımlı yapay diş köklerinden oluşmaktadır.
                         </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-gift"></i> Ortodonti Tel Tedavisi</h4>
                    </div>
                    <div class="panel-body">
                        <p>Çapraşık dişler nedeniyle oluşan estetik kusurların tedavisi ve
                         etkilerinin en iyi şekilde yeniden yerine getirilmesi amacıyla tedaviler uygulanır. 
                         “Ortodontik tedaviler” halk arasında “Tel tedavisi”olarak bilinir. </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4><i class="fa fa-fw fa-compass"></i> Diş Protezleri</h4>
                    </div>
                    <div class="panel-body">
                        <p>Protez, çeşitli nedenlerle kaybedilen dişlerin yerine konabilen, ağızda estetik bozuklukların giderilmesini
                         sağlayan, fonksiyonel olarak ihtiyaçlara göre çeşitlilik gösteren yapay materyallerdir. </p>
                    </div>
                </div>
            </div>

        </div>
        
        
            
        <!-- /.row -->

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <p>Copyright &copy; Dicle Fırat Diş 2014</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->
    	<script	src="js/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script>
    $('.carousel').carousel({
        interval: 5000 //changes the speed
    })
    </script>
	
</body>
</html>
