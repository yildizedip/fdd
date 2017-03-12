<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="tr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">

<link rel="stylesheet"	href="http://cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">

<script src="script/jquery-1.10.2.min.js"></script>
<script src="script/bootstrap.min.js"></script>

<script src="js/raphael.min.js"></script>
<script src="js/morris.min.js"></script>


</head>
<body>
	<div class="panel">

		<div class="panel-body bg-success">

			<p class="icon">
				<i class="icon fa fa-group"></i> <span>Hasta Sayısı :	${getHastaSayisi}</span>
			</p>

		</div>
	</div>


	<div id="myfirstchart" style="height: 300px;"></div>

	<script type="text/javascript">
		var val = [];

		<c:forEach items="${getTopOperations}" var="op">

		var event = {
			oper : '${op[0]}',
			value : '${op[1]}'
		}

		val.push(event);

		</c:forEach>

		new Morris.Bar({

			// ID of the element in which to draw the chart.
			element : 'myfirstchart',
			// Chart data records -- each entry in this array corresponds to a point on
			// the chart.
			data : val,
			// The name of the data record attribute that contains x-values.
			xkey : 'oper',
			// A list of names of data record attributes that contain y-values.
			ykeys : [ 'value' ],
			// Labels for the ykeys -- will be displayed when you hover over the
			// chart.
			labels : [ 'value' ]
		});
	</script>

</body>
</html>