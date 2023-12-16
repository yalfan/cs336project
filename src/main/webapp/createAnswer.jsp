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
	
	String answerContent = request.getParameter("new-answer-content");
	if (answerContent == null || answerContent.isEmpty()) {
		session.setAttribute("error", "Missing information!");
    	response.sendRedirect("answer.jsp");
    	return;
	}
		
	String insertStatement = String.format("INSERT INTO answer (Question_ID, Customer_Rep_ID, Answer_Text) VALUES ('%s', '%s', '%s');",
    		session.getAttribute("questionID"), session.getAttribute("user_id"), answerContent);
    stmt.executeUpdate(insertStatement);
    
    stmt.executeUpdate("UPDATE question SET Answered_Status=1 WHERE Question_ID=" + session.getAttribute("questionID"));
    
    session.setAttribute("questionID", null);
    
	response.sendRedirect("answer.jsp");
	%>
	

</body>
</html>