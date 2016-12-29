<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<title>Hasta Sorgula</title>
<script type="text/javascript">


</script>
</head>
<body>
<div>
<table align="center">
	<tr>
		<td align="left" style="color: red" >
		${requestScope.warn}
		</td>
</table>




</div>
</body>
</html>