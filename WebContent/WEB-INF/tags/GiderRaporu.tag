<%@ tag body-content="scriptless"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="silAktif" required="false" rtexprvalue="true" %>
<%@tag import="tr.com.fdd.dto.TOdemeSekliDTO"%>
<%@tag import="tr.com.fdd.dto.TTurKodDTO"%>
<%@tag import="java.util.List"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@tag pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="tr">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<script src="/js/jquery-3.1.1.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/epoch_classes.js"></script>
<script src="/script/bootstrap.min.js"></script>


<link type="text/css" rel="stylesheet"	href="/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="/styles/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="/styles/main.css">
<link rel="stylesheet" href="/css/epoch_styles.css" type="text/css" />
<link rel="stylesheet" href="/css/edip.css" type="text/css" />
</head>
<body>
	<c:if test="${not empty giderList}">
		
		<table  class="table table-bordered">
		<tr> <td class="bg-warning" colspan="8" align="center"> Gider Listesi </td> </tr> 
			<tr>
				<td class=""></td>
				<td class="">Tarih</td>
				<td class="">Gider Turu</td>
				<td class="">Miktar</td>
				<td class="">Ödeme Şekli</td>
				<td class="">Aciklama</td>
				<c:if test="${silAktif ne '0' }">
				<c:if test="${sessionScope.sessionMember[0].kuTur eq '4' }">
				<td class=""></td>
				<td class=""></td>
				</c:if>
				</c:if>
			</tr>
			<c:forEach items="${giderList}" var="gider"
				varStatus="count">
				<tr>
					<td class="" >${count.count}</td>
					<td class="" >${gider.tarihStr}</td>
					<td class="" >${gider.turAd}</td>
					<td class="" >${gider.miktar} ${gider.paraBirimi }</td>
					<td class="" >${gider.odemeSekliStr }</td>
					
					
					
					<td class="" >${gider.aciklama}</td>
					<c:if test="${silAktif ne '0' }">
						<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
						<td class="">
						
						<button type="button" class="btn btn-link btn-xs " style="color: red;"
													data-toggle="modal" data-target="#silModal"
													data-giderid="${gider.id}"
													data-gidermiktar="${gider.miktar}"
													
													>Sil</button>
						</td>
						<td class="">
						<button type="button" class="btn btn-link" data-toggle="modal" 
						 data-target="#guncelleModal" 
						 data-opid="${gider.id}" 
						 data-aciklama="${gider.aciklama}" 
						 data-tarih="${gider.tarihStr}" 
						 data-tur="${gider.turKodDTO.turKod}" 
						 data-miktar="${gider.miktar}" style="font-size: "
						 > Güncelle</button>
						
						</td>
						</c:if>
					</c:if>
				</tr>

			</c:forEach>
			<tr> 
				<td colspan="4" class="" style="font-size: 13px; color: blue;"> TOPLAM MIKTAR </td> 
				<td class="" style="font-size: 13px; color: blue; " > ${toplamGider} </td> 
				<td class="" colspan="3"></td> 
			</tr>


		</table>
	</c:if>
	
	
		<div id="guncelleModal" class="modal fade" >
			<div class="modal-dialog" role="document">
				<div class="modal-content">
				
					<div class="modal-header bg-success">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">GİDER GÜNCELLE</h4>
					</div>
					
					<form action="GiderGuncelle.do" method="post">
					
					<input 	name="id" id="id" type="hidden"> 
					
					<div class="modal-body">
						
						<div class="row">
									
										<div class="col-lg-6">
										<div class="form-group">
										<label for="tarih"> Tarih</label>
											<input 	name="tarihstr" id="tarih" class="form-control"> 
										</div>
										
										</div>
									
										<div class="col-lg-4">
										<div class="form-group">
										<label for="tarih"> Gider Türü</label>
										    <select size="1" name="giderTuru"  id="giderTuru" class="form-control">
												<option label="Gider Türü Seçiniz.." value="-1">Gider Türü Seçiniz..</option>
														<c:forEach items="${sessionScope.giderTurKodlari}" var="turKodDTO">
																<option label="${turKodDTO.turAd}" value="${turKodDTO.turKod}"> ${turKodDTO.turAd} </option>
														</c:forEach>
											</select>
										</div>
										</div>
										
										<div class="clearfix"></div>
										
										
										<div class="col-lg-6">
										<div class="form-group">
										<label for="tarih"> Miktar</label>
											
											<input 	name="miktar" id="miktar" class="form-control">
										</div> 
										</div> 
										
										<div class="col-lg-4">
										<div class="form-group">
										<label for="tarih"> Açıklama</label>
										
										   <input 	name="aciklama" id="aciklama" class="form-control">
										</div>
										</div>
										
									</div>
						</div>
						
						
						<div class="modal-footer">
							<input type="submit"  class="btn btn-default" value="Güncelle" id="btn_gonder" name="bnt_gonder"/>
							<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
						</div>
						
						</form>
				</div>
			</div>
	</div>
	
	
<div id="silModal" class="modal fade">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">ÖDEME SİL</h4>
				</div>
				<form action="SilGider.do" method="post">
					<div class="modal-body">
						<h5>
							<span id="giderMiktar"> </span> <span> TL miktarında gider
								silinecektir.. Emin misiniz? </span>
						</h5>
						<input type="hidden" name="id" id="giderId">

					</div>

					<div class="modal-footer">
						<input id="bntKaydet" class="btn btn-default" type="submit"
							value="Sil" />
						<button type="button" class="btn btn-default" data-dismiss="modal">Vazgeç</button>
					</div>

				</form>
			</div>
		</div>
	</div>
	
	
	

<script type="text/javascript">


$(document).ready(
		function() {

			$('#guncelleModal').on('show.bs.modal', function (event) {
				  var button = $(event.relatedTarget) // Button that triggered the modal
				  var id = button.data('opid') // Extract info from data-* attributes
				  var aciklama = button.data('aciklama') // Extract info from data-* attributes
				  var tarih = button.data('tarih') // Extract info from data-* attributes
				  var tur = button.data('tur') // Extract info from data-* attributes
				  var miktar = button.data('miktar') // Extract info from data-* attributes


				  var modal = $(this)
				  modal.find('#id').val(id)
				  modal.find('#aciklama').val(aciklama)
				  modal.find('#tarih').val(tarih)
				  modal.find('#giderTuru').val(tur)
				  modal.find('#miktar').val(miktar)
				 
			});
			
			
			$('#silModal').on(
					'show.bs.modal',
					function(event) {
						var button = $(event.relatedTarget)
						var giderId = button.data('giderid')
						var giderMiktar = button.data('gidermiktar')

						var modal = $(this)
						modal.find('#giderId').val(giderId)
						modal.find('#giderMiktar').html(giderMiktar)

					});
			
			
			
			
		});


</script>
</body>
</html>