<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Insert title here</title>
</head>
<body>
<%
session.isNew();	
session.invalidate();
%>
<h3> Oturumunuz Sona Ermiştir.. Lütfen Tekrar Giriş Yapınız..</h3> 





</body>
</html>