<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Insert title here</title>
</head>
<body>
<h3> Oturumunuz Sona Ermiştir.. Lütfen Tekrar Giriş Yapınız..<a href="login4.jsp" > Giriş için lütfen tıklayınız. </a> </h3> 



<%
session.isNew();	
session.invalidate();
%>
<jsp:forward page="login4.jsp"></jsp:forward>

</body>
</html>