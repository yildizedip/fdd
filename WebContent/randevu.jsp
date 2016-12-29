<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/fullcalendar.print.min.css" media="print" />
 
<script src="js/jquery.min.js"></script>
<script src="js/jquery-1.9.0.js"></script>
<script src="js/moment.min.js"></script>
<script src="js/fullcalendar.js"></script>
<script  src="js/fullcalendar.min.js"></script>
<script src='js/locale-all.js'></script>

<script>

$(document).ready(function() {
    $('#calendar').fullCalendar({
    	header: {
    		left: 'prev,next today',
    		center: 'title',
    		right: 'month,agendaWeek,agendaDay'
    	},
    	defaultView: 'agendaWeek',
    	locale: 'tr',
    	navLinks: true, // can click day/week names to navigate views
		selectable: true,
		select: function(start, end) {
			var title = prompt('Aciklama Gir:');
			title += '<br>'+prompt('Aciklama2 Gir:');
			var eventData;
			if (title) {
				eventData = {
					title: title,
					start: start,
					end: end
				};
				$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
			}
			$('#calendar').fullCalendar('unselect');
		},

		selectHelper: true,
        editable: true,
        events: "randevu.do"
        
    });

});

function send(){
	
	var events=$('#calendar').fullCalendar('clientEvents');
	
	var text = "";
	var i;
	for (i = 0; i < events.length; i++) {
	    text += events[i]['title'] +" - ";
	}
	
     alert("text : " + text)
 
}

</script>

<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 12px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	
	

</style>



<title>Randevu</title>
</head>
<body>
Selam
<input type="submit" name="Save" onclick="send()" > </input>

<div id="calendar"></div>



</body>
</html>