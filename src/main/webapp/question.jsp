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
	%>
	<div class="container">
		<div class="jumbotron">
            <h2>Ask Questions</h2>
            <div class="row justify-content-center">
				<a href='index.jsp'>Return</a>
			</div>
			
			<form id="new-question-form" class="container post-container" action="createQuestion.jsp">
                <h4>New Question</h4>
                <div class="form-group">
                	<textarea id="new-question-content" name="new-question-content" class="container"></textarea>
                </div>
                <input id="submit-btn" type="submit" class="btn btn-primary" value="Ask"/>
	        </form>
	        <%
				ResultSet questions = stmt.executeQuery("select * from question q JOIN account a ON q.User_ID = a.ID_Number;");
	        	while (questions.next()) {
	        		%>
		       		<div class="container post-container">
			            <h5 class="post-user"><%= questions.getString("username") %></h5>
			            <p class="post-content"><%= questions.getString("Question_Text") %></p>
			            <%
			            if (session.getAttribute("account_type").equals("customer_rep")) {
			            	%>
			            	<form action="answer.jsp">
			            		<input type="hidden" disabled value="<%= questions.getInt("Question_ID") %>"/>
         				    	<input type="submit" value="Reply"/>
			            	</form>
			            	<%
			            }
			            %>
			        </div>
	        		<%
	        	}
	        %>
	        
	       
		</div>
	</div>



</body>
</html>