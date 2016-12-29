<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="myTagFiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">


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
<body>

<div align="center">
				<table>
					
					
					<tr> 					
					
					<td align="left" valign="top"  bgcolor="white" >
								
					<c:import url="Sorgulama.jsp" >
					<c:param name="sorgulamaAction" value="getGelirSorgulama.do"></c:param>
					</c:import>
					<br>
					<font color="Red"> ${resquestScope.warn} </font>
					<br><br>
					 
					 <myTagFiles:GelirRaporu>
					 </myTagFiles:GelirRaporu>	
					 				 
					 
					<br>
					<table>
					<tr > <td colspan=2"> 
					
					<myTagFiles:GelirParaBirimBazliRapor></myTagFiles:GelirParaBirimBazliRapor>
					</td> </tr>
					<tr> 
					<td> 
					<myTagFiles:GelirIstatistikler></myTagFiles:GelirIstatistikler>	
					</td> 
					
					
					</tr>
					<tr> <td> 
					<myTagFiles:GelirDoktorIstatistik></myTagFiles:GelirDoktorIstatistik>
					</td> </tr>
					</table>
								
								
					</td>
					
					</tr>
					
					<tr> 
						<td width="308" bgcolor="#FFFFFF">
						</td>
					
					<td width="657" bgcolor="#FFFFFF">
									
					</td>
					
					</tr>
					
				</table>
			</div>
</body>
</html>