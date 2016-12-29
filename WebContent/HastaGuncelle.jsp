<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<title>Hasta Güncelle</title>
</head>
<body>
<div>
<table align="center">
	<tr>
		<td align="left" valign="top" style="width: 650px">
		<hr>

		<form action="HastaGuncelle.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA GÜNCELLE</td>
			</tr>
			<tr>
				<td>Protokol No</td>

				<td><input class="inputTextfield" name="protokolNo" id="protokolNo"
					value="${hasta.protokolNo }" /> </td>
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tckimlik }" /> <input type="hidden" name="id"
					value="${hasta.id }"></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad"
					value="${hasta.ad }" /> <input class="inputTextfield" name="soyad"
					id="soyad" value="${hasta.soyad }" /></td>
			</tr>


			<tr>
				<td>Tel</td>
				<td><input class="inputTextfield" name="tel" id="tel"
					value="${hasta.tel }" /></td>
			</tr>
			<tr>

				<td colspan="3" style="text-align: center;"><input
					id="bntKaydet" type="submit" value="Güncelle" /></td>
			</tr>


			<tr>
				<td colspan="2" align="left"><label style="color: red;">
				${requestScope.warn }</label></td>

			</tr>

		</table>
		</form>
		</td>
</table>
</div>
</body>
</html>