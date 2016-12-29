<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="tr">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1254">
<title>Insert title here</title>
</head>
<body bgcolor=>

	<table border="0" width="200" cellspacing="0" cellpadding="0"
		bgcolor="#FFFFFF" align="left">
		<tr>
			<td>&nbsp;</td>

		</tr>
		<tr>
			<td>
				<form action="getPageAddGider.do" method="post">
					<input type="submit" value="Gider Ekle" width="24px"
						style="text-shadow: aqua; background: white-space; vertical-align: middle; width: 170px; height: 25px">
				</form>
			</td>
		</tr>
		<tr>
			<td><form action="getPageAddGelir.do" method="post">

					<input type="submit" value="Gelir Ekle" width="24px"
						style="text-shadow: aqua; background: white-space; vertical-align: middle; width: 170px; height: 25px">
				</form></td>
		</tr>
		<tr>
			<td><form action="getPageGelirSorgulama.do" method="post">
					<input type="submit" value="Gelir Durumu Sorgula" width="24px"
						style="text-shadow: aqua; background: white-space; vertical-align: middle; width: 170px; height: 25px">
				</form></td>
		</tr>
		<tr>
			<td><form action="getPageGiderSorgulama.do" method="post">
					<input type="submit" value="Gider Durumu Sorgula" width="24px"
						style="text-shadow: aqua; background: white-space; vertical-align: middle; width: 170px; height: 25px">
				</form>
			</td>
		</tr>
		
		
					<tr>
			<td><form action="getPageGunlukDurum.do" method="post">

					<input type="submit" value="Günlük Durum" width="24px"
						style="text-shadow: aqua; background: white-space; vertical-align: middle; width: 170px; height: 25px">
				</form></td>
		</tr>
	</table>



</body>
</html>