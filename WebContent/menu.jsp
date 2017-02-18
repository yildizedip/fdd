<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>	
<%@ page language="java" contentType="text/html; charset=ISO-8859-9" pageEncoding="ISO-8859-9"%>

<!DOCTYPE html>
<html lang="tr">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<!-- jquery dialog gibi componentlerin gorunumu -->
<link type="text/css" rel="stylesheet"	href="styles/jquery-ui-1.10.4.custom.min.css"> 
<!-- kucuk iconlar icin (menu) -->
<link type="text/css" rel="stylesheet"	href="styles/font-awesome.min.css">

<!-- temel bootstrap css -->
<link type="text/css" rel="stylesheet" href="styles/bootstrap.min.css">

<!-- my css -->
<link type="text/css" rel="stylesheet" href="styles/main.css">

	<script src="script/jquery-1.10.2.min.js"></script>
	<script src="script/jquery-migrate-1.2.1.min.js"></script>
	<script src="script/jquery-ui.js"></script>
	
	<script src="script/bootstrap.min.js"></script>
	<script src="script/bootstrap-hover-dropdown.js"></script>
	<script src="script/html5shiv.js"></script>
	<script src="script/respond.min.js"></script>
	<script src="script/jquery.metisMenu.js"></script>
	<script src="script/jquery.slimscroll.js"></script>
	<script src="script/jquery.cookie.js"></script>
	<script src="script/icheck.min.js"></script>
	<script src="script/custom.min.js"></script>
	<script src="script/jquery.news-ticker.js"></script>
	<script src="script/pace.min.js"></script>
	<script src="script/responsive-tabs.js"></script>
	<script src="script/jquery.flot.js"></script>
	<script src="script/jquery.flot.categories.js"></script>
	<script src="script/jquery.flot.pie.js"></script>
	<script src="script/jquery.flot.tooltip.js"></script>
	<script src="script/jquery.flot.resize.js"></script>
	<script src="script/jquery.flot.fillbetween.js"></script>
	<script src="script/jquery.flot.stack.js"></script>
	<script src="script/jquery.flot.spline.js"></script>
	<script src="script/zabuto_calendar.min.js"></script>
	<script src="script/index.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="script/main.js"></script>
	
	</head>
<body>
	
	
	<nav id="sidebar" role="navigation" data-step="2"
						data-intro="Template has &lt;b&gt;many navigation styles&lt;/b&gt;"
						data-position="right" class="navbar-default navbar-static-side">
			
						<div class="sidebar-collapse menu-scroll">
							<ul id="side-menu" class="nav">
			
								<div class="clearfix"></div>
								
								<c:forEach items="${kullaniciMenuList}" var="menu">
									<c:choose>
										<c:when test="${menu.ustMenuId eq 0 }">
			
												<li>
													<a href="#"> <i class="${menu.menuPath}">
														</i><span class="menu-title">${menu.menuAd}</span>
								
													</a>
															<ul class="nav nav-second-level">
															
																<c:if test="${menu.subMenu[0] ne null}">
																	<c:forEach items="${menu.subMenu}" var="subMenu" >	
																					<li>
																					
																					<a href="${subMenu.menuPage}" target="frame" >
																					  <span class="submenu-title">  ..: ${subMenu.menuAd}   </span></a>
																					  
																					  </li>
																				
																	</c:forEach>		
															
																</c:if>
															</ul>
												</li>
											</c:when>	
									</c:choose>
							</c:forEach>
							</ul>
						</div>
					</nav>
					
</body>
</html>
