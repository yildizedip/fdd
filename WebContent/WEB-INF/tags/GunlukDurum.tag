<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>

<%@ tag body-content="scriptless" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title></title>
<link rel="stylesheet" href="css/edip.css" 	type="text/css" />
<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="silAktif" required="false" rtexprvalue="true"%>
</head>
<body>
<label class="fonte"> <jsp:doBody/> tarihindeki gelir ve giderler : </label> 
	<table class="sofT" >	
		<tr>
			<td class="helpHed"></td>
			<td class="helpHed">Odeme Sekli</td>			
			<td class="helpHed">Gelir</td>
			<td class="helpHed">Gider</td>
			<td class="helpHed">Kalan </td>		
		
		</tr>
		<c:forEach items="${sessionScope.gunlukGelirGiderFarkListesi}" var="gelir" varStatus="count">
		<tr>
		    <td class="helpBod" > ${count.count}</td>
			
			<td class="helpBod" >${gelir.odemeSekliStr}</td>
			<td class="helpBod" >${gelir.gelirMiktar}</td>
			<td class="helpBod" >${gelir.giderMiktar}</td>			
			<td class="helpBod" >${gelir.fark} ${gelir.paraBirimi }</td>
			
					
		</tr>
	
		</c:forEach>
		
	</table>

<br>


</body>
</html>