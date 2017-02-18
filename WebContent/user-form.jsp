<%@ taglib uri="http://struts.apache.org/tags-tiles" prefix="tiles" %>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-9">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link type="text/css" rel="stylesheet"
	href="styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet"
	href="styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="styles/main.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.dataTables.min.css" />

<title>Dicle Fırat</title>

<script src="js/bootstrap.min.js"></script>

<script src="script/jquery-1.10.2.min.js"></script>
<script src="script/jquery-migrate-1.2.1.min.js"></script>
<script src="script/jquery-ui.js"></script>
<script src="script/bootstrap.min.js"></script>
<script src="script/bootstrap-hover-dropdown.js"></script>
<script src="script/html5shiv.js"></script>
<script src="script/respond.min.js"></script>
<script src="script/jquery.metisMenu.js"></script>
<script src="script/jquery.slimscroll.js"></script>
<script src="script/jquery.cookie.js"></script>
<script src="script/icheck.min.js"></script>
<script src="script/custom.min.js"></script>
<script src="script/jquery.news-ticker.js"></script>
<script src="script/jquery.menu.js"></script>
<script src="script/pace.min.js"></script>
<script src="script/holder.js"></script>
<script src="script/responsive-tabs.js"></script>
<script src="script/jquery.flot.js"></script>
<script src="script/jquery.flot.categories.js"></script>
<script src="script/jquery.flot.pie.js"></script>
<script src="script/jquery.flot.tooltip.js"></script>
<script src="script/jquery.flot.resize.js"></script>
<script src="script/jquery.flot.fillbetween.js"></script>
<script src="script/jquery.flot.stack.js"></script>
<script src="script/jquery.flot.spline.js"></script>
<script src="script/zabuto_calendar.min.js"></script>
<script src="script/index.js"></script>
<script src="js/jquery.dataTables.min.js"></script>
<script src="script/main.js"></script>


<script>
	$(document).ready(function() {
		$("#dialogInfo").dialog({
			autoOpen : false,
		});

		$("#openInfo").on("click", function() {
			$("#dialogInfo").dialog("open");
		});

		$("#dialogSifremiDegistir").dialog({
			autoOpen : false,

		});

		$("#openPassword").on("click", function() {
			$("#dialogSifremiDegistir").dialog("open");

		});

		$("#dialogHastaList").dialog({
			autoOpen : false,

		});

		$("#openHastaList").on("click", function() {
			$("#dialogHastaList").dialog("open");

		});

		$('#buttonSec').click(function() {
			var ids = $.map(table.rows('.selected').data(), function(item) {
				return item
			});

			$('#hasta_id').val(ids[4]);
			$('#send').submit();

		});

		/* 	 	$('#example').DataTable( {
		 select: {
		 style: 'single'
		 }
		 } );

		 var table = $('#example').DataTable();

		 $('#example tbody').on('click', 'tr', function () {
		 $('#example tbody tr').removeClass('selected');
		 $(this).toggleClass('selected');
		 });
		

		 $('#exampleModal').on('show.bs.modal', function (event) {
		 var button = $(event.relatedTarget) // Button that triggered the modal
		 var recipient = button.data('whatever') // Extract info from data-* attributes

		 // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
		 // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
		 var modal = $(this)
		 modal.find('.modal-body #recipient-name').val(recipient)
		 }); */
	});
</script>

<tiles:insert definition="company-template" >
	<tiles:put name="body" value="/randevuGunluk.jsp" />
</tiles:insert>