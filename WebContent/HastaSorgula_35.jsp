<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<link rel="stylesheet" href="css/demo_page.css" type="text/css" />
<link rel="stylesheet" href="css/demo_table.css" type="text/css" />
<title>Hasta Sorgula</title>
<script type="text/javascript" language="javascript"
	src="lib/jquery-1.7.js"></script>
<script type="text/javascript" language="javascript"
	src="lib/jquery.dataTables.js"></script>

<script>

$("document").ready(
					function() {
					
					$.post("hastaSorgula.do",
						{
							"param1":'deneme'
							
						},
						function(data){
				          //  $("#cikti").html(data);

				            }					
						);		

					});

	$("document").ready(
					function() {
							$('#example')
								.dataTable(
										{
											
											sPaginationType : "full_numbers",
											"oLanguage" : {
											
												"sLengthMenu" : "Sayfada _MENU_ kayıt gösterilsin.",
												"sZeroRecords" : "",
												"sInfo" : "_TOTAL_ kayıt arasından  _START_ ile _END_ kayıt gösterilmektedir.",
												"sInfoEmpty" : "",
												"sInfoFiltered" : "(filtered from _MAX_ total records)",
												"sSearch" : "Aranacak Kelimeyi Yazın:",
												"sPrevious": "Önceki"
											
											}

										});

					});
</script>
</head>
<body id="dt_example">

<div id="container">

			<h1>..: Hasta Güncelleme Silme</h1>
	
		

	
		<div id="demo">

		<table class="display" id="example" cellpadding="0" cellspacing="0" border="0" >
			<thead>
				<tr>
					<th></th>
					<th >Protokol No</th>
					
					<th>Ad-Soyad</th>
					<th>TcKimlik</th>
					<th >Tel</th>

					<c:if test="${silAktif ne '0' }">
						<th></th>
						<th></th>
					</c:if>

				</tr>
			</thead>
			<tbody>
			
			<c:forEach items="${hastaListesi}" var="hasta" varStatus="count">
				<tr class="gradeA">
					<td >${count.count}</td>
					<td >${hasta.protokolNo}</td>
			
					<td >${hasta.ad} ${hasta.soyad} </td>
					<td> ${hasta.tckimlik}</td>
					<td >${hasta.tel}</td>					
						<c:if test="${silAktif ne '0' && sessionScope.sessionMember[0].kuTur ne '3' }">
							<td><html:link
								action="/HastaSil?id=${hasta.id}"> Sil </html:link></td>

							<td><html:link
								action="/HastaGetir?id=${hasta.id}&type=3"> Güncelle </html:link>
							</td>
						</c:if>
			
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<th> </th>
					<th> </th>
					<th></th>
					<th> </th>
					<th> </th>
					<th> </th>
					<th> </th>
				
				</tr>
			</tfoot>
			
			
		</table>
		</div>
		<div class="spacer"></div>
		
	<div id="cikti"></div>
		

</div>
</body>
</html>