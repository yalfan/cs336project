<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>CS336 Project</title>
</head>

<body>
	<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
	}
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	if (request.getParameter("questionID") == null) {
		response.sendRedirect("question.jsp");
		return;
	}
	
	int questionID = Integer.parseInt(request.getParameter("questionID"));
	session.setAttribute("questionID", questionID);
	
	%>
	<div class="container">
		<div class="jumbotron">
            <h2>Answers</h2>
            <div class="row justify-content-center">
				<a href='index.jsp'>Return</a>
			</div>
			<%
        	if (session.getAttribute("account_type").equals("customer_rep")) {
        		ResultSet question = stmt.executeQuery("select * from question q WHERE Question_ID=" + questionID);
        		if (!question.next()) {
        			session.setAttribute("questionID", null);
    				response.sendRedirect("question.jsp");
					return;
        		}
        		%>
        		<form id="new-question-form" class="container post-container" action="createAnswer.jsp">
	                <h4><%= question.getString("Question_Text") %></h4>
	                <div class="form-group">
	                	<textarea id="new-answer-content" name="new-answer-content" class="container"></textarea>
	                </div>
	                <input id="submit-btn" type="submit" class="btn btn-primary" value="Answer"/>
		        </form>
        		<%
        	}
			
			ResultSet answers = stmt.executeQuery("select * from answer r JOIN account a ON a.ID_Number = r.Customer_Rep_ID WHERE Question_ID=" + questionID);
			while (answers.next()) {
        		%>
	       		<div class="container post-container">
		            <h5 class="post-user"><%= answers.getString("username") %></h5>
		            <p class="post-content"><%= answers.getString("Answer_Text") %></p>
		        </div>
        		<%
        	}
			%>
		</div>
	</div>



</body>
</html>