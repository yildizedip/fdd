<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/epoch_classes.js"></script>
<script src="script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />

<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/jquery-ui.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<script type="text/javascript" src="js/edip.js"></script>
<script type="text/javascript" src="js/jquery.ui.datepicker-tr.js"></script>


<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>


<link rel="stylesheet" href="css/epoch_styles.css" 	type="text/css" />
<script type="text/javascript"src="js/epoch_classes.js"></script>


<script type="text/javascript">
		window.onload = function() {
		var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("bas_tar"));
					<%
						Date dat = new Date();																								
						SimpleDateFormat sdf= new SimpleDateFormat("yyyy.MM.dd");
						String date =sdf.format(dat);											    				
					%>	
						document.getElementById("bas_tar").value="<%=date%>";
						document.getElementById("bit_tar").value="<%=date%>";
			}
									
</script>

<title></title>
</head>
<body style="color:black ; background-color: white;">

	<div id="title-breadcrumb-option-demo" class="page-title-breadcrumb">
			<div class="page-header ">
			<div class="page-title" style="font-size: 20px;">
			
				Gider Sorgulama
			
			</div>

			<button class="btn pull-right"
				style="background-image: url('Images/printIcon2.jpg'); height: 24px; width: 32px"
				onclick="window.print()"></button>

		</div>
		<div class="bg-success">${requestScope.warn}</div>

		<div class="clearfix"></div>
	</div>

<div class="col-lg-6">
				
					<c:import
						url="Sorgulama.jsp">
						<c:param name="sorgulamaAction" value="getGiderSorgulama.do"></c:param>
					</c:import> <br>	
					</div>
					 
					 <myTagFiles:GiderRaporu>
					 <c:if test="${param.bas_tar ==null}">
									${bugun} - ${bugun}
									
									</c:if>
					${param.bas_tar} - ${param.bit_tar}
					 </myTagFiles:GiderRaporu>
				
					 				 
					 
					<br>
					
					
			
</body>
</html>