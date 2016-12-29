<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Insert title here</title>
<script type="text/javascript"
     src="http://maps.google.com/maps/api/js?sensor=false">   // sensor true yada false olmas lazım
 </script>
 
 <script type="text/javascript">
   var map;
 function initialize() {
   var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
   var myOptions = {
     zoom: 4,
     center: myLatlng,
     mapTypeId: google.maps.MapTypeId.ROADMAP
   }
   map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
   
  google.maps.event.addListener(map, 'zoom_changed', function() {
     setTimeout(moveToDarwin, 3000);
   });
   
  var marker = new google.maps.Marker({
       position: myLatlng, 
      map: map,
       title:"Hello World!"
   });
   google.maps.event.addListener(marker, 'click', function() {
     map.setZoom(8);
   });
 }
   
function moveToDarwin() {
   var darwin = new google.maps.LatLng(-16.461334, 100.841904);
   map.setCenter(darwin);
 }
 
</script>
</head>
<body onload="initialize()">
<div id="map_canvas" style="width:100%; height:100%"></div>
 
</body>
</html>