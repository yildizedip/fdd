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

$(document).ready(function () {
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var calendar = $('#calendar').fullCalendar({
        aspectRatio: 1.45,
        droppable: true,
        weekend: true,
        firstHour: 7,
        columnFormat: {
          month: 'dddd',    
          week: 'ddd, dS', 
          day: 'dddd, MMM dS'
       },
        header: {
            right: 'prev,next',
            center: 'title',
            left: 'month,agendaWeek,agendaDay'
       },
        viewDisplay: function(view) {
              try {
                  setTimeline();
              } catch(err) {}
       },          
        agenda: 'h:mm{ - h:mm}',
                '': 'h(:mm)t',
        drop: function (date, allDay) {
            var originalEventObject = $(this).data('eventObject');
            var copiedEventObject = $.extend({}, originalEventObject);
            copiedEventObject.start = date;
            copiedEventObject.end = new Date(date.getDate()+2);
            copiedEventObject.allDay = allDay;
            start = $.fullCalendar.formatDate(copiedEventObject.start, "yyyy-MM-dd HH:mm:ss");
            end = $.fullCalendar.formatDate(copiedEventObject.end, "yyyy-MM-dd HH:mm:ss");
            $.ajax({
                    url: '<?php echo SITEURL; ?>/fullcalendar/add_events.php',
                    data: 'title=' + copiedEventObject.title + '&start=' +start + '&end=' +end + "&backgroundColor=" + copiedEventObject.backgroundColor + '&creator=<?php print_r($_SESSION["uid"]); ?>',
                    type: "POST",
                    success: function (response) {
                        console.log(response);
                        $('#calendar').fullCalendar('refetchEvents');
                    }
                });
            if ($('#drop-remove').is(':checked')) {
                $(this).remove();
            }
        },
        editable: true,
        defaultView: 'agendaWeek',
        firstDay: 1,
        handleWindowResize: true,
        dragOpacity: 0.7,
        allDayDefault: false,
        events: "<?php echo SITEURL; ?>/fullcalendar/events.php?creator=<?php print_r($_SESSION['uid']); ?>",
        timeFormat:  'HH:mm { - HH:mm}',
        selectable: true,
        selectHelper: true,
        select: function (start, end, allDay) {
            $(".popup").show();
            $(".submitForm").click(function(){
                var title = $(".title").val();
                if (title) {
                    start = $.fullCalendar.formatDate(start, "yyyy-MM-dd HH:mm:ss");
                    end = $.fullCalendar.formatDate(end, "yyyy-MM-dd HH:mm:ss");
                    $.ajax({
                        url: '<?php echo SITEURL; ?>/fullcalendar/add_events.php',
                        data: 'title=' + title + '&start=' + start + '&end=' + end +  '&creator=<?php print_r($_SESSION["uid"]); ?>',
                        type: "POST",
                        success: function (json) {
                            console.log(json);
                            $('#calendar').fullCalendar('refetchEvents');
                        }
                    });
                 console.log("start " + start + " end " + end);
                }
                calendar.fullCalendar('unselect');
                $(".popup").hide();
            });
            $(".exit").click(function(){
             // clear all info, unselect events and...
              $(".popup").hide();
            });
        },
        eventDrop: function (event, delta) {
            start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
            end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
            $.ajax({
                url: '<?php echo SITEURL; ?>/fullcalendar/update_events.php',
                data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                type: "POST",
                success: function (response) {
                         console.log(response);
                  }
            });
        },
        eventClick: function (event, jsEvent, view) {
            if (confirm("Really delete event " + event.title + "with id " + event.id + "?") ) {
               $.ajax({
                url:   "<?php echo SITEURL; ?>/fullcalendar/delete_event.php",
                data: 'eid='+event.id,
                type: "POST",
                success: function (response) {
                      console.log(response); 
                      calendar.fullCalendar('removeEvents', event.id);
                  }
                });
            }
        },
        eventResize: function (event) {
            start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
            end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
            $.ajax({
                url: '<?php echo SITEURL; ?>/fullcalendar/update_events.php',
                data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                type: "POST",
                success: function (response) {
                      console.log(response);
                }
            });
        }
    });
    $('#external-events div.external-event').each(function () {
        var eventObject = {
            title: $.trim($(this).text()),
            backgroundColor : $.trim($(this).attr('bgc'))
        };
        $(this).data('eventObject', eventObject);
        $(this).draggable({
            zIndex: 999,
            revert: true, 
            revertDuration: 0
        });
    });
});
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

<div class="popup" style="display:none; position:fixed; top:25%; left:25%; background-color:white;">
  <input class"title" type="text" size="26" />
  <a href="#" onclick="return false" class="submitFrom">submit</a>&emsp;
  <a href="#" onclick="return false" class="exit">cancel</a>
</div>

</body>
</html>