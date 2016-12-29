var resNesne;
if (navigator.appName.search("Microsoft") > -1) {
	resNesne = new ActiveXObject("MSXML2.XMLHTTP");
} else {
	resNesne = new XMLHttpRequest();
}
function yolla() {
	alert("merhaba");
	for (i = 1; i <= 16; i++) {
		if (this.document.f.sehir.options[i - 1].selected) {
			resNesne.open('get', 'sehir.php?nerede=' + i, true);
			resNesne.onreadystatechange = handleResponse;
			resNesne.send(null);
			break;
		}
	}
}
function handleResponse() {
	if (resNesne.readyState == 4) {
		document.getElementById("sc").innerHTML = resNesne.responseText;
	}
}