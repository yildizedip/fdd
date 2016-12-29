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


<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" src="js/epoch_classes.js"></script>

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

	<div align="left">
	<form action="${param.sorgulamaAction}" method="post">

						<table class="sorgulama">
							<tr>
								<td colspan="2" style="text-align: center; font: bold;">SORGULAMA</td>
							</tr>

							<tr>
								<td>Tarih :</td>
								<td>
									<table>
										<tr>
											<td><input class=inputTextfield name="bas_tar"
												id="bas_tar">
											</td>
											<td>/</td>
											<td><input class=inputTextfield name="bit_tar"
												id="bit_tar" onfocus="getDate()" onblur="getDate()">
												<script type="text/javascript">
										function getDate() {
											var bit_tar = new Epoch('epoch_popup','popup', document.getElementById("bit_tar"));
												document.getElementById("bit_tar").value="<%=date%>";
										}
																	
									</script></td>
										</tr>
									</table></td>
							</tr>


							<tr>
								<td>Açıklama</td>
								<td><input type="text" name="aciklama"></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center;"><input type="submit"
									name="btn_Sorgula" value="Sorgula">
								</td>
							</tr>
						</table>
					</form>
	</div>
</body>
</html>