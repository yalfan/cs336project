<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Searching...</title>
</head>
<body>
	<%
	if (request.getParameter("flightNumber") != null) {
		int flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
		session.setAttribute("flightNumber", flightNumber);
		response.sendRedirect("waitlist.jsp");
	}
	else {
		session.setAttribute("flightNumber", null);
		response.sendRedirect("waitlist.jsp");
	}
	
	%>
	

</body>
</html>