<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="robots" content="noindex, nofollow">
<meta name="googlebot" content="noindex, nofollow">


<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>


<link rel="stylesheet" type="text/css" href="/css/normalize.css">


<script type="text/javascript"
	src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/result-light.css">

<link rel="stylesheet" type="text/css"
	href="http://arshaw.com/js/fullcalendar-1.5.3/fullcalendar/fullcalendar.css">
<script type="text/javascript"
	src="http://www.arshaw.com/js/fullcalendar-1.5.3/fullcalendar/fullcalendar.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="http://arshaw.com/js/fullcalendar-1.5.3/demos/cupertino/theme.css">

<style type="text/css">
</style>

<title>by 100thGear</title>







<script type='text/javascript'>
	//<![CDATA[
	$(window)
			.load(
					function() {
						$(document)
								.ready(
										function() {
											$myCalendar = $('#myCalendar')
													.fullCalendar(
															{
																header : {
																	left : 'prev,next today',
																	center : 'title',
																	right : ''
																},
																theme : true,
																selectable : true,
																selectHelper : true,
																height : 500,
																select : function(
																		start,
																		end,
																		allDay) {
																	$(
																			'#eventStart')
																			.datepicker(
																					"setDate",
																					new Date(
																							start));
																	$(
																			'#eventEnd')
																			.datepicker(
																					"setDate",
																					new Date(
																							end));
																	$(
																			'#calEventDialog')
																			.dialog(
																					'open');
																},
																eventClick : function(
																		calEvent,
																		jsEvent,
																		view) {
																	$(
																			'#eventStart')
																			.datepicker(
																					"setDate",
																					new Date(
																							calEvent.start));
																	$(
																			'#eventEnd')
																			.datepicker(
																					"setDate",
																					new Date(
																							calEvent.end));
																	$(
																			'#calEventDialog #eventTitle')
																			.val(
																					calEvent.title);
																	//                    alert(calEvent.className);
																	//                alert(calEvent.className=="gbcs-halfday-event"?"1":"2");
																	//                    $('#allday[value="' + calEvent.className=="gbcs-halfday-event"?"1":"2" + '"]').prop('checked', true);
																	$(
																			'#calEventDialog #allday')
																			.val(
																					[ calEvent.className == "gbcs-halfday-event" ? "1"
																							: "2" ])
																			.prop(
																					'checked',
																					true);
																	$(
																			"#calEventDialog")
																			.dialog(
																					"option",
																					"buttons",
																					[
																							{
																								text : "Save",
																								click : function() {
																									$(
																											this)
																											.dialog(
																													"close");
																								}
																							},
																							{
																								text : "Delete",
																								click : function() {
																									$(
																											this)
																											.dialog(
																													"close");
																								}
																							},
																							{
																								text : "Cancel",
																								click : function() {
																									$(
																											this)
																											.dialog(
																													"close");
																								}
																							} ]);
																	$(
																			"#calEventDialog")
																			.dialog(
																					"option",
																					"title",
																					"Edit Event");
																	$(
																			'#calEventDialog')
																			.dialog(
																					'open');
																},
																editable : true
															});

											var title = $('#eventTitle');
											var start = $('#eventStart');
											var end = $('#eventEnd');
											var eventClass, color;
											$('#calEventDialog')
													.dialog(
															{
																resizable : false,
																autoOpen : false,
																title : 'Add Event',
																width : 400,
																buttons : {
																	Save : function() {
																		if ($(
																				'input:radio[name=allday]:checked')
																				.val() == "1") {
																			eventClass = "gbcs-halfday-event";
																			color = "#9E6320";
																			end
																					.val(start
																							.val());
																		} else {
																			eventClass = "gbcs-allday-event";
																			color = "#875DA8";
																		}
																		if (title
																				.val() !== '') {
																			$myCalendar
																					.fullCalendar(
																							'renderEvent',
																							{
																								title : title
																										.val(),
																								start : start
																										.val(),
																								end : end
																										.val(),
																								allDay : true,
																								className : eventClass,
																								color : color
																							},
																							true // make the event "stick"
																					);
																		}
																		$myCalendar
																				.fullCalendar('unselect');
																		$(this)
																				.dialog(
																						'close');
																	},
																	Cancel : function() {
																		$(this)
																				.dialog(
																						'close');
																	}
																}
															});
										});
					});//]]>
</script>


</head>

<body>
	<div id="calEventDialog">
		<form>
			<fieldset>
				<label for="eventTitle">Title</label> <input type="text"
					name="eventTitle" id="eventTitle" /><br> <label
					for="eventStart">Start Date</label> <input type="text"
					name="eventStart" id="eventStart" /><br> <label
					for="eventEnd">End Date</label> <input type="text" name="eventEnd"
					id="eventEnd" /><br> <input type="radio" id="allday"
					name="allday" value="1"> Half Day <input type="radio"
					id="allday" name="allday" value="2"> All Day
			</fieldset>
		</form>
	</div>
	<div style="border: solid 2px red;">
		<div id='myCalendar'></div>
	</div>


	<script>
		// tell the embed parent frame the height of the content
		if (window.parent && window.parent.parent) {
			window.parent.parent.postMessage([ "resultsFrame", {
				height : document.body.getBoundingClientRect().height,
				slug : "JeDFG"
			} ], "*")
		}
	</script>

</body>

</html>