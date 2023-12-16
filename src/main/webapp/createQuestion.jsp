<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Searching...</title>
</head>
<body>
	<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String questionContent = request.getParameter("new-question-content");
	if (questionContent == null || questionContent.isEmpty()) {
		session.setAttribute("error", "Missing information!");
    	response.sendRedirect("question.jsp");
    	return;
	}
		
	String insertStatement = String.format("INSERT INTO question (User_ID, Question_Text) VALUES ('%s', '%s');",
    		session.getAttribute("user_id"), questionContent);
    stmt.executeUpdate(insertStatement);
	response.sendRedirect("question.jsp");
	%>
	

</body>
</html>