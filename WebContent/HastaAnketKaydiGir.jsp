<%@page import="tr.com.fdd.dto.THastaDTO"%>
<%@page import="tr.com.fdd.dto.TIslemDTO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@page import="tr.com.fdd.mysql.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />

<script type="text/javascript" src="js/epoch_classes.js"></script>
<link rel="stylesheet" href="css/epoch_styles.css" type="text/css" />
<title>Hasta G�ncelle</title>
<script type="text/javascript">
	window.onload = function() {

		var bas_tar = new Epoch('epoch_popup', 'popup', document.getElementById("islemTarihiStr"));
		<% 
		Date dat = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String date = sdf.format(dat);
		
		%>
		
				document.getElementById("islemTarihiStr").value="<%=date%>";;

	}
	
	function validation(){
	 var tar =	document.getElementById("islemTarihiStr").value;
	 var memnuniyetDerecesi =	document.getElementById("memnuniyetDerecesi").value;
	 var saat =	document.getElementById("saat").value;
	 var dakika =	document.getElementById("dakika").value;
	 var aciklama =	document.getElementById("aciklama").value;
	 
	 if(memnuniyetDerecesi=="-1"){
		 alert("L�tfen memniyet Derecesi se�iniz.");
		 return false;
	 }
	 if(saat=="-1" || dakika=="-1"){
		 alert("L�tfen saat dakika se�iniz.");
		 return false;
	 }
	 if(tar==""){
		 alert("L�tfen tarih se�iniz.");
		 return false;
	 }
	 
	 if((memnuniyetDerecesi=="2" || memnuniyetDerecesi=="1") && aciklama==""){
		 alert("L�tfen a��klama se�iniz.");
		 return false;
	 }
	 
	 return true;
	}
</script>

<%
String hastaId= request.getParameter("hastaId");
String subeId= request.getParameter("subeId");
SQLUtils utils= new SQLUtils();
Connection conn =DbConnection.getMySqlConneciton();
THastaDTO hasta=new THastaDTO();
System.out.print(subeId);
if(subeId!=null && hastaId!=null)
hasta= utils.getHasta(Integer.parseInt(hastaId),conn,new Integer(subeId).intValue());

request.setAttribute("hasta",hasta);

 %>
</head>
<body>
<div>

			<hr>
		<font
			style="font-size: 12px; font-family: monospace; color: graytext;">
		..: Hasta Memnuniyet Anket Kayd� Gir </font>
		<hr>

		
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA B�LG�LER�</td>
			</tr>
			<tr>
				<td>Protokol No</td>

				<td><input class="inputTextfield" name="protokolNo" id="protokolNo"
					value="${hasta.protokolNo }"  readonly="readonly" /> </td>
			</tr>

			<tr>
				<td>TC Kimlik</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tckimlik }"  readonly="readonly" /> 
					
			</tr>
			<tr>
				<td>Ad-Soyad</td>

				<td><input class="inputTextfield" name="ad" id="ad"
					value="${hasta.ad }"  readonly="readonly" /> <input class="inputTextfield"  readonly="readonly" name="soyad"
					id="soyad" value="${hasta.soyad }" /></td>
					
					
			</tr>

				<tr>
				<td>TEl</td>
				<td><input class="inputTextfield" name="tckimlik" id="tckimlik"
					value="${hasta.tel}" readonly="readonly" /> </td>
			</tr>

		

			<tr>
				<td colspan="2" align="left">
				
				<label style="color: red;">
				${requestScope.warn}</label>
				
				</td>

			</tr>

		</table>
		
		<hr>
		<c:if test="${odemeListesi eq null}">
		
		<form action="anketEkle.do" method="post" onsubmit="return validation()">
		<table class="sorgulama">
			<tr>
				<td colspan="3" style="text-align: center;">HASTA MEMNUN�YET ANKET�  B�LG�LER� FORMU</td>
			</tr>
			<tr>
				<td>Anket Arama Tarihi</td>
				<td>
				
				<input class="inputTextfield" name="tarihStr" 
				id="islemTarihiStr" value="" />
				 <input type="hidden" name="hastaId"
					value="${hasta.id }">
				</td>


			</tr>
			
			<tr>
				<td>Saat</td>
				<td><select size="1" name="saat" id="saat" style="width: 56px; font-size:12px ">
					<option value="-1" label="Saat">
					<c:forEach items="${saatler}" var="saat" >
					<option value="${saat}" label="${saat}" ></option>				
					</c:forEach>
				</select>
				
				 : <select name="dakika" size="1" id="dakika" style="width: 52px; font-size:12px ">
				<option value="-1" label="Dk">
				<c:forEach items="${dakikalar}" var="dakika">
				<option label="${dakika }" value="${dakika }">
				
				</c:forEach>
				
				</select>
				
				</td>

			</tr>
			<tr>
				<td>Memnuniyet Derecesi</td>
				<td><select size="1" name="memnuniyetDerecesi" id="memnuniyetDerecesi" style="width: 229px; font-size:12px ">
					<option value="-1" label="Memnuniyet Derecesi">
					<option value="4" label="�ok iyi">
					<option value="3" label="�yi">
					<option value="2" label="K�t�">
					<option value="1" label="�ok K�t�">
						
				</select>
				</td>
			</tr>
			
				
			<tr>
				<td>A��klama</td>
				<td>
				<textarea style="width: 487px; height: 148px"  name="aciklama" id="aciklama"></textarea>				 
					</td>
 

			</tr>

			<tr>
				<td colspan="3" style="text-align: center;">
				<input type="submit" value="Kaydet" 
				id="btn_gonder" name="bnt_gonder"/>
				
				</td>
				
			</tr>
		</table>
		</form>
		</c:if>
	
</div>
</body>
</html>