<!DOCTYPE html>
<html>
<head>
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

        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();

        $('#button_id').click(function() {
            var newEvent = {
                title: 'NEW EVENT',
                start: new Date(y, m, d),
                deneme:'dsfs'
            };
            $('#calendar').fullCalendar( 'renderEvent', newEvent , 'stick');
        });

        $('#calendar').fullCalendar({
        	
        	header: {
        		left: 'prev,next today',
        		center: 'title',
        		right: 'month,agendaWeek,agendaDay'
        	},
            editable: true
        });

    });

</script>
<style>

    body {
        margin-top: 40px;
        text-align: center;
        font-size: 14px;
        font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
        }

    #calendar {
        width: 900px;
        margin: 0 auto;
        }

</style>
</head>
<body>
<button type="button" id="button_id" onClick=>Create new event</button>
<div id='calendar'></div>
</body>
</html>