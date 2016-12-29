
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib tagdir="/WEB-INF/tags"  prefix="myTagFiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/epoch_styles.css" 	type="text/css" />
<script type="text/javascript"src="js/epoch_classes.js"></script>
<title></title>

<script type="text/javascript">
window.onload = 
function() 
{


var bas_tar = new Epoch('epoch_popup','popup', document.getElementById("tarihStr"));	
												
}
								
</script>

</head>
<body>
	<div>	
	<table align="center" >
	<tr> <td colspan="2"> <c:import url="FrameUstBaslik.jsp"></c:import> </td> </tr>
	<tr> 
		<td> <c:import url="FrameSolMenu.jsp"></c:import> </td> 
		<td align="left" valign="top"  bgcolor="white" style="width: 650px ">
		<form action="doktorEkle.do" method="post">
						<table bgcolor="#E1F0F0" align="left"
							style="width: 600px; height: 270px">
							<tr>
								<td colspan="2" align="center">DOKTOR EKLE</td>
							</tr>
							<tr>
								<td>Ad </td>
								<td>
								<input type="text" name="txtDoktorAd">
								</td>
							</tr>
							<tr>
								<td>Soyad</td>
								<td><input type="text" name="txtDoktorSoyad"></td>
							</tr>
							<tr>
								<td>Branş</td>
								<td>
							<select style="height: 22px; width: 160px"> 
							<option label="Diş Hekimi" value="Diş Hekimi"></option>
						
							</select>
								</td>
							</tr>

							
							
							<tr>
								<td colspan="2" align="center"><input type="submit"
									value="Ekle" name="bnt_gonder" style="width: 100px; height: 22px">
								</td>
							</tr>
							<tr>
								<td colspan="2"><label id="lbl_error" style="color: red;">${requestScope.warn}
								</label>
								</td>
							</tr>
						</table>
					</form>	
		</td>
	</tr>	
	</table>
	</div>
</body>
</html>