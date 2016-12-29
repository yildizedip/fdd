<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Miktar</title>
<jsp:attribute name="miktar"></jsp:attribute>
<jsp:attribute name="paraBirimi"></jsp:attribute>
</head>
<body>

<table>
<tr> 
<td>
<input type="text" name="${miktar}" style="height: 21px"> 
</td>
<td> 
<select size="1" name="${paraBirimi}" style="width: 80px; height: 21px">
<option label="TL" value="TL"/>
<option label="$" value="DOLAR"/>
<option label="Euro" value="EURO"/>
</select>
</td>

</tr>
</table>

</body>
</html>