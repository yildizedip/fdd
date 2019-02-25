<%@page import="tr.com.fdd.dto.THastaDTO"%>
<%@page import="java.sql.Connection"%>
<%@page import="tr.com.fdd.mysql.DbConnection"%>
<%@page import="tr.com.fdd.struts.actions.SQLUtils"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>

<%
	SQLUtils db = new SQLUtils();

	String ad = request.getParameter("term");
	
	System.out.println(ad);
	
	Connection conn = DbConnection.getMySqlConneciton();
	
	Integer subeId = (Integer) request.getSession().getAttribute("subeId");
	
	List<THastaDTO> hastalar = db.getHastaList(conn, subeId, ad, null, null, null, false);

	for (int i = 0; i < hastalar.size(); i++) {
		
		THastaDTO hastaDTO= hastalar.get(i);
		out.println(hastaDTO);
	}
	
%>