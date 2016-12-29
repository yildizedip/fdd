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

<script>


$(document).ready(function () {

    var all_events = [{
        title: 'Event cross Jul/Aug',
        start: '2014-07-21',
        end: '2014-08-02'
    }, {
        title: 'Event cross Aug/Sep',
        start: '2014-08-21',
        end: '2014-09-02'
    }, {
        title: 'All Day 09 Event',
        start: '2014-09-04',
        city: 'Yekaterinburg'
    }, {
        title: 'All Day Event',
        start: '2014-08-01'
    }, {
        title: 'Long Event',
        start: '2014-08-21',
        end: '2014-08-24'
    }, {
        id: 999,
        title: 'Repeating Event',
        start: '2014-08-23'
    }, {
        id: 999,
        title: 'Repeating Event',
        start: '2014-08-25'
    }, {
        title: 'Meeting',
        start: '2014-08-26'
    }, {
        title: 'Lunch',
        start: '2014-08-26'
    }, {
        title: 'Birthday Party',
        start: '2014-08-27'
    }, {
        title: 'Click for Google',
        url: 'http://google.com/',
        start: '2014-08-28'
    }, {
        title: 'Birthday Party',
        start: '2014-10-06'
    }, {
        title: 'Birthday Party2',
        start: '2014-10-04',
        end: '2014-10-08'
    }];

    var cal0 = $('#calendar0');
    var cal1 = $('#calendar1');
    var cal2 = $('#calendar2');

    cal0.fullCalendar({
        header: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        events: all_events,
        viewRender: function (view, element) {
            cur = view.intervalStart;
            nextMonth = moment(cur).add(1, 'months');
            cal1.fullCalendar('gotoDate', nextMonth);
            prevMonth = moment(cur).subtract(1, 'months');
            cal2.fullCalendar('gotoDate', prevMonth);
        },
        dayClick: function(date, jsEvent, view) {
            getEvents(date);
            // change the day's background color just for fun
            $(this).addClass('ac_checked_date');
            $('.fc-day').not($(this)).removeClass('ac_checked_date');

            $('#calendar0').fullCalendar('clientEvents', function(event) {
                
                var clickedDate = date;

                
                if(clickedDate >= event.start && clickedDate <= event.end) {
                }
            });
        }
    });

    cal1.fullCalendar({
        header: {
            left: '',
            center: 'title',
            right: ''
        },
        defaultDate: nextMonth,
        events: all_events
    });
    
    cal2.fullCalendar({
        header: {
            left: '',
            center: 'title',
            right: ''
        },
        defaultDate: prevMonth,
        events: all_events
    });
    
    function getEvents(date){
        all_events.forEach(function(entry) {
            if (entry['start'] == date.format()){
                alert(entry['title']);}
            else if (entry['start'] <= date.format() && entry['end'] >= date.format()){
                alert(entry['title']);}
         });
    
    }
    
});

function send(){
	
	var ttt=$('#calendar').fullCalendar('clientEvents'[0]);
     alert("title : " + ttt[0]['start'])
}

</script>

<style>

body {
    margin-top: 20px;
    font-family:"Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}
#calendar0 {
    width: 500px;
    font-size: 10px;
    margin: 0 auto;
}
#calendar1,
#calendar2{
    width: 500px;
    font-size: 10px;
    margin: 0 auto;
}

.ac_checked_date{
   background-color:lightblue;
}
}
	

</style>



<title>Randevu</title>
</head>
<body>
Selam
<input type="submit" name="Save" onclick="send()" > </input>

<div id='calendar2'></div>
<br>
<div id='calendar0'></div>
<br>
<div id='calendar1'></div>



</body>
</html>