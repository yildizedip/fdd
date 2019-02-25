<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="tr.com.fdd.utils.GenelDegiskenler"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ page import="java.text.DateFormat"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="row">
	
	<hr>

	<div class="col-lg-12">
	
		<c:forEach items="${lastHasta.hastaRandevuList}" var="randevu"	varStatus="count">

			<div class="col-md-6">
                        <div class="panel panel-default  panel--styled">

                            <div class="panel-heading" >
                            
                            <div class="row">
                            
                            <div class="col-lg-6"> <p><strong> ${randevu.randevuTarihiStr}  Saat : ${randevu.randevuBasSaat}  -  ${randevu.randevuBitSaat}  </strong></p> </div>
                            
                             </div>
                            
                           
                            
                            </div>
                            <div class="panel-body bg-success">
  									
                                <div class="col-md-12">
                                        <p> <strong>  Hekim : </strong> ${randevu.doktor.dAd}
													${randevu.doktor.dSoyad}  </p>
                                    </div>
                                <div class="col-md-12">
                                        <p> <strong>  Randevu Açıklaması : </strong> ${randevu.aciklama}
													 </p>
                                    </div>
                                <div class="col-md-12">
                                        <p> <strong>  Beklenen Ödeme : </strong> ${randevu.beklenenOdeme}
													 </p>
                                    </div>

                            </div>

 						


                        </div>
                    </div>

					</c:forEach>
					
	</div>
	</div>

</body>
</html>