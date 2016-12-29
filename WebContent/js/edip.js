/**
 * 
 */

function noSagTik( ){
	var doc=document;
	doc.onmousedown = click;

	var times = 0;

	var times2 = 10;

	function click() {

		if ((event.button == 2) || (event.button == 3)) {

			if (times >= 1) {
				
			}

			alert("Sað týk çalýþmamaktadýr!");

			times++;
		}
	}

	
	
}