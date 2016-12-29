<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<link rel="stylesheet" href="css/edip.css" type="text/css" />
<script type="text/javascript" language="javascript" src="lib/jquery-1.7.js"></script>

<title>Hasta Operasyon Listesi</title>
<style type="text/css">

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}

#boxes .window {
	position: fixed;
	left: 0;
	top: 0;
	width: 440px;
	height: 200px;
	display: none;
	z-index: 9999;
	padding: 20px;
}

#boxes #dialogOperasyonuBitir {
	width: 400px;
	height: 160px;
	padding: 10px;		background-image: url("Images/untitled.png");
	background-repeat:repeat-x;
}

#boxes #dialogLabIslemOnayla {
	width: 600px;
	height: 360px;
	padding: 10px;	
	background-image: url("Images/untitled.png");
	background-repeat:repeat-x;
}




</style>
<link rel="stylesheet" href="css/epoch_styles.css" 	type="text/css" />
<link rel="stylesheet" href="css/edip.css" 	type="text/css" />
<script type="text/javascript"src="js/epoch_classes.js"></script>

<script type="text/javascript">
window.onload = 
function() 
{

new Epoch('epoch_popup','popup', document.getElementById("tarihStr"));	
												
}

$(document).ready(function() {
		//select all the a tag with name equal to modal
		$('a[name=modal]').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			//Get the A tag
			var id = $(this).attr('href');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set heigth and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//transition effect		
			$('#mask').fadeIn(1000);
			$('#mask').fadeTo("slow", 0.8);

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			$(id).css('top', winH / 2 - $(id).height() / 2);
			$(id).css('left', winW / 2 - $(id).width() / 2);

			//transition effect
			$(id).fadeIn(2000);

		});

		//if close button is clicked
		$('.window .close').click(function(e) {
			//Cancel the link behavior
			e.preventDefault();

			$('#mask').hide();
			$('.window').hide();
		});

		//if mask is clicked
		$('#mask').click(function() {
			$(this).hide();
			$('.window').hide();
		});

		$(window).resize(function() {

			var box = $('#boxes .window');

			//Get the screen height and width
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			//Set height and width to mask to fill up the whole screen
			$('#mask').css({
				'width' : maskWidth,
				'height' : maskHeight
			});

			//Get the window height and width
			var winH = $(window).height();
			var winW = $(window).width();

			//Set the popup window to center
			box.css('top', winH / 2 - box.height() / 2);
			box.css('left', winW / 2 - box.width() / 2);

		});

	});

function go_to(param) {

var par=param;
 document.getElementById("id").value=par;

}

function openLabOnaylaDialog(param) {
	
	var operasyonList="${hastaOperasyonListesi}";
	alert(operasyonList);
	var ve= "${requestScope.hasta.protokolNo}";
	
	
	
	'<%
	
	String name=request.getParameter("name");
	
		request.setAttribute("deneme", name);
		 %>';
	
	document.getElementById("islemTipi").value="${deneme}";
	
	alert(param);
	alert(ve);

}

</script>

</head>
<body>
<div>

		<hr>
		<form action="hastaRandevuSorgula.do" method="post">
		<table class="sorgulama">
			<tr>
				<td colspan="2" style="text-align: center;">HASTA BİLGİLERİ</td>
			</tr>
			<tr>
				<td>Protokol No</td>
				<td><input readonly="readonly" class="inputTextfield"
					name="protokolNo" id="protokolNo"
					value="${requestScope.hasta.protokolNo }"></td>
			</tr>
			<tr>
				<td>Ad-Soyad</td>
				<td><input readonly="readonly" class="inputTextfield" name="ad"
					id="ad"
					value="${requestScope.hasta.ad } ${requestScope.hasta.soyad}"></td>
			</tr>
			<tr>
				<td>Tc Kimlik</td>
				<td><input readonly="readonly" class="inputTextfield" name="tc"
					id="tc" value="${requestScope.hasta.tckimlik }"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><label
					id="lbl_error" style="color: red;">${requestScope.warn}
				${requestScope.noContent} </label></td>
			</tr>
		</table>

		</form>
		
		
		<hr>
		<table class="sofT" >
			<tr>
				<td colspan="14" class="helpHed">OPERASYON LİSTESİ</td>
			</tr>
			<tr>

				<td class="helpHed"></td>
				<td class="helpHed">Operasyon</td>
				<td class="helpHed">Adet</td>
				<td class="helpHed">Doktor</td>
				<td class="helpHed">Operasyon Durum</td>
				<td class="helpHed">Baş. Tar.</td>
				<td class="helpHed">Bit. Tar.</td>
				<td class="helpHed">Açıklama</td>
				<td class="helpHed">Ücret</td>
				<td class="helpHed">Ödemeler</td>
				<td class="helpHed">Lab Durum</td>
				<td class="helpHed">Lab Provalar</td>
				

				<c:if test="${silAktif ne '0' }">
					<c:choose>
						<c:when test="${param.islem eq '6' }">
							<td class="helpHed"></td>
						</c:when>
						<c:otherwise>
							<td class="helpHed"></td>
							<td class="helpHed"></td>
							<td class="helpHed"></td>
						</c:otherwise>
					</c:choose>
				</c:if>

			</tr>
			
			
			<c:forEach items="${hastaOperasyonListesi}" var="operasyon"
				varStatus="count">
				<tr>
					<td class="helpBod">${count.count}</td>
					<td class="helpBod">${operasyon.islemTip.ad} </td>
					<td class="helpBod">${operasyon.disAdet} </td>					
					<td class="helpBod">${operasyon.doktor.dAd} - ${operasyon.doktor.dSoyad}</td>
						<td class="helpBod">
							<c:choose>
								<c:when test="${operasyon.durumu eq 'A'}">D. Ediyor</c:when>
								<c:when test="${operasyon.durumu eq 'B'}">Bitmiş</c:when>		
							</c:choose>
					
					</td>
					<td class="helpBod">${operasyon.islemTarihi}</td>
					<td class="helpBod">${operasyon.islemBitisTarihi}</td>
					<td class="helpBod">${operasyon.aciklama}</td>
					<td class="helpBod">${operasyon.miktar}</td>
					<td class="helpBod">
								<c:forEach items="${operasyon.odemeList}" var="odeme">
									${odeme.miktar} - ${odeme.aciklama }
									<br>
								</c:forEach>				
				   </td>
				   
				   <td class="helpBod" style=" text-align: left;">
							   <c:choose>  
									   <c:when test="${operasyon.labratuvarList[0] ne null}">
									  		 ${operasyon.labratuvarList[0].laboratuvarIslemDurum.toString} 
										 	 <br/> İşlem: ${operasyon.labratuvarList[0].labIslemTipAd}	
											 <br>
										 </c:when>
									   <c:otherwise>
									   
									   </c:otherwise>
							   
							   </c:choose>
				   </td>
				

				<td class="helpBod" style=" text-align: left;">			   <c:choose>  
									   <c:when test="${operasyon.labratuvarList[0] ne null}">									  		
										 Provalar:
											 <c:forEach items="${operasyon.labratuvarList[0].provaList}" var="prova">
												 ${prova.provaTipEnm } :
												 <br/>
												 ${prova.provaTar }
											 </c:forEach>					
									   
										 </c:when>
									   <c:otherwise>
									   
									   </c:otherwise>
							   
							   </c:choose>
				   </td>
					
					<c:choose>
						 <c:when test="${silAktif ne '0' && (operasyon.durumu eq 'A' || operasyon.durumu eq 'B')}">

							<c:if test="${(sessionScope.sessionMember[0].kuTur eq '4') || (sessionMember[0].kuTur eq '6') }">

								<c:choose>
									<c:when test="${param.islem eq '6' }">
										<td class="helpBod">
											<html:link
											action="/HastaOdemeListesiGetir?islemId=${operasyon.id}&hastaId=${requestScope.hasta.id}&tip=${param.islem}"> Ödeme Listesi Görüntüle</html:link>
										</td>
										<td class="helpBod"></td>
									</c:when>
									<c:when test="${param.islem eq '2' }">
										<td class="helpBod"><html:link
											action="/HastaOdemeListesiGetir?islemId=${operasyon.id}&hastaId=${requestScope.hasta.id}&tip=${param.islem}"> Ödeme Ekle</html:link>
										</td>
										<td class="helpBod"></td>
									</c:when>
									
									<c:when test="${param.islem eq '8' }">
									
										<c:choose>
											<c:when test="${operasyon.labratuvarList[0].laboratuvarIslemDurum.state eq 'A'}">
												 
											</c:when>
											
											<c:when test="${operasyon.labratuvarList[0].laboratuvarIslemDurum.state eq 'B'}">
											     <td class="helpBod">
											     
											     <!-- 
											     <a href="#dialogLabIslemOnayla" name="modal" onclick="openLabOnaylaDialog(${operasyon.labratuvarList[0].aciklama})"
												style="text-decoration: none"> Laboratuvar İşlem Onayla-Reddet </a>
												
												 -->
												 <html:link action="/HastaLabrotuvarIslemleri?labIslemId=${operasyon.labratuvarList[0].id}&labIslemTip=14"> Lab İşlem Onayla Red</html:link>
												
												</td>
										         
										        
											</c:when>
											<c:when test="${(operasyon.labratuvarList[0].laboratuvarIslemDurum.state eq 'A') || (operasyon.labratuvarList[0].laboratuvarIslemDurum.state eq 'C') || (operasyon.labratuvarList[0].laboratuvarIslemDurum.state eq 'D')}">
											<td  class="helpBod" > <html:link action="/HastaLabrotuvarIslemleri?labIslemId=${operasyon.labratuvarList[0].id}&labIslemTip=15"> Lab İslem Detay Göster</html:link> </td>
																					
											
											</c:when>
											<c:otherwise>
											<td class="helpBod">
											<html:link action="/HastaLabrotuvaraGonderPageOpen?islemId=${operasyon.id}&hastaId=${requestScope.hasta.id}&tip=${param.islem}"> Laboratuvara Gönder</html:link>
											     </td>
											
											</c:otherwise>
										</c:choose>
										
									</c:when>
									
									<c:otherwise>


										<td class="helpBod"><html:link
											action="/OperasyonSil?id=${operasyon.id}"> Sil </html:link></td>
										<td class="helpBod"><html:link
											action="/OperasyonGetir?operasyonId=${operasyon.id}&&hastaId=${requestScope.hasta.id}&&islem=7"> Guncelle </html:link>
										</td>
										
										<c:if test="${operasyon.durumu ne 'B'}">
											<td class="helpBod">
											<a href="#dialogOperasyonuBitir" name="modal" onclick="go_to(${operasyon.id})"> Operasyonu Bitir </a></td>
										</c:if>

									</c:otherwise>
								</c:choose>
							</c:if>
						</c:when>
							<c:otherwise>
								<td class="helpBod"></td>
								<td class="helpBod"></td>
								<td class="helpBod"></td>
							</c:otherwise>


					</c:choose>

				</tr>

			</c:forEach>

		</table>


<div id="boxes">


<div id="dialogOperasyonuBitir" class="window">

<form name="SifreForm" action="OperasyonBitir.do" method="post"
	onsubmit="return validateSifreForm()" >
<div id="guncelle">OPERASYONU BİTİR
<hr>
<div><label> Operasyon Bitirme Tarihi..........:</label> 
<input class="inputTextfield" name="tarihStr" id="tarihStr" value="${tarihStr}"/>
<input type="hidden" name="id" id="id" value="${operasyon.id}">
<input type="hidden" name="hastaId" id="id" value="${hasta.id}">

</div>
<br>Yıl formatı : Yıl.Ay.Gün (Örn : 2012.01.30) 
<hr>
<div><input type="submit" value="Operasyonu Bitir"></div>
</div>
</form>

<div><a id="close" href="#" class="close"> Kapat </a></div>

</div>


<div id="dialogLabIslemOnayla" class="window">

<form name="SifreForm" action="LabIslemOnayla.do" method="post" >
<div id="guncelle">LABORATUVAR İŞLEM ONAYLA
<hr>

<table>
							<tr>
								<td style="width: 78px;">Laboratuvar İşlem :</td>
								<td><input class="inputTextfield" 
								name="protokolNo" style="width: 324px; 
								background-color: threedlightshadow;" readonly="readonly" id="islemTipi" 
								/> 
								<input type="hidden" name="labIslemId" /></td>
							</tr>
							<tr>
								<td style="width: 88px;">Adet:</td>
								<td><input class="inputTextfield" 
								style="width: 198px; background-color: threedlightshadow;" name="adet" 
								readonly="readonly" id="adet" /></td>
							</tr>
							<tr>
								<td>Prova :</td>
								<td><input class="inputTextfield" 
								style="width: 106px; background-color: threedlightshadow;" 
								name="prova" readonly="readonly" id="prova" /></td>
							</tr>
							<tr>
								<td>Açıklama :</td>
								<td><textarea 
								style="background-color: threedlightshadow; width: 280px; height: 75px" 
								readonly="readonly" id="labAciklama"> </textarea></td>
							</tr>
							<tr>
								<td>Puan :</td>
								<td>
								<input class="inputTextfield" 
								 name="labPuan" id="labPuan" ></td>
							</tr>
						</table>







</div>


</form>

<div><a id="close" href="#" class="close"> Kapat </a></div>

</div>


<!-- SIFREMI GUNCELLE DIV --> <!-- Do not remove div#mask, because you'll need it to fill the whole screen -->
<div id="mask"></div>
</div>

</div>
</body>
</html>