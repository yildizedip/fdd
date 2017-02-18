<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/mycss.css" rel="stylesheet">

<title>Poliklinik</title>

</head>
<body>


	<div class="container-fluid">

		<nav class="navbar navbar-inverse ">
			<div class="container-fluid">
				<div class="navbar-header">
				
				 <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			      </button>
      
					<a class="navbar-brand" href="#"> Dicle Fırat Diş </a>

				</div>
				
				
				<div class="collapse navbar-collapse navbar-right" id="bs-example-navbar-collapse-1">
					   
     
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
			        
      
    			</div><!-- /.navbar-collapse -->
				
			</div>
		</nav>

	</div>
	<script	src="js/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
