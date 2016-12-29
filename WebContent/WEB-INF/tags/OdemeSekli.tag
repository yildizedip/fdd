<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<link rel="stylesheet" href="css/edip.css" 	type="text/css" />
<title>odemeSekli</title>
<%@ attribute name="odemeSekliList" required="false" rtexprvalue="true" %>
<%@ tag body-content="scriptless" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</head>
<body>

<table>
<tr> 
<td> 
<select size="1" name="odemeSekli" id="odemeSekli"
									class="giderTuru">
										<option label="Odeme Sekli Seciniz.." value="0"></option>

										<%
										
											List<TOdemeSekliDTO> list=(List<TOdemeSekliDTO>)session.getAttribute("odemeSekliList");
											System.out.println(list.size());										 
											for(int i=0; i<list.size(); i++)
											{
											TOdemeSekliDTO dto=(TOdemeSekliDTO) list.get(i);
										
										%>
									
											<option label="<%=dto.getOdemeSekli() %>"
												value="<%=dto.getKod()%>"></option>
									<%} %>
								</select>
</td>

</tr>
</table>

</body>
</html>