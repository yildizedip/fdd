<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@page import="java.text.DateFormat"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form class="form-horizontal" action="HastaGuncelle.do" method="post" >
	
	
	<input type="hidden" name="id" value="${lastHasta.id}"></td>

		<div class="row">
			<!-- left column -->
			<div class="col-md-4">
				<h4>${lastHasta.ad} ${lastHasta.soyad}</h4>

				<div class="text-center">
					<img src="Images/default_user.jpg" class="avatar img-circle"
						alt="avatar">
					<h6>Resim Ekle...</h6>
				
				</div>
			</div>

			<!-- edit form column -->
			<div class="col-md-8 personal-info">

				<div class="form-group">
					<label class="col-lg-3 control-label">Ad:</label>
					<div class="col-lg-8">
						<input class="form-control" type="text" name="ad" id="ad" value="${lastHasta.ad}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">Soyad: </label>
					<div class="col-lg-8">
						<input class="form-control" type="text" name="soyad" id="soyad" value="${lastHasta.soyad}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">Protokol No:</label>
					<div class="col-lg-8">
						<input class="form-control" type="text"
							value="${lastHasta.protokolNo}" name="protokolNo"  readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">Telefon : </label>
					<div class="col-lg-8">
						<input class="form-control" type="text" name="tel" id="tel"
							value="${lastHasta.tel}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-lg-3 control-label">Kimlik No:</label>
					<div class="col-lg-8">
						<input class="form-control" type="text"
							value="${lastHasta.tckimlik}" name="tckimlik">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-lg-3 control-label">Adres:</label>
					<div class="col-lg-8">
						<input class="form-control" type="text"
							value="${lastHasta.adres}" name="adres">
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-3 control-label">Eklenme Tarihi:</label>
					<div class="col-md-8">
						<input class="form-control" type="text"
							value="${lastHasta.eklenmeTarihiStr}" readonly="readonly">
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-3 control-label"></label>
					<div class="col-md-8">
						
						
						<c:if test="${silAktif ne '0' }">
										<c:if test="${sessionScope.sessionMember[0].kuTur ne '3' }">
	
										
												
					<input type="submit" class="btn btn-primary"
							value="Değişiklikleri Kaydet"> <span></span>
							
							

						<button type="button" class="btn btn-danger " data-toggle="modal"
							data-target="#hastasSilModal" data-whatever="${lastHasta.id}">Sil</button>
												
												
										</c:if>
								</c:if>
						
						
						
					</div>
				</div>

			</div>
		</div>

	</form>

</body>
</html>