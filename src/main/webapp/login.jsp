<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="styles.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<title>Login</title>
	</head>
	
	<body>
	<%
		if (session.getAttribute("user") != null) {
			response.sendRedirect("index.jsp");
		}
	%>
		<div class="form-container py-5 text-center">
			<h1>Login</h1>
			<form method="post" action="loginAccount.jsp">
			  <div class="mb-3">
		  		  <input class="form-control mx-auto w-auto" type="text" placeholder="Username" name="username"/>
			  </div>
			  <div class="mb-3">
		  		  <input class="form-control mx-auto w-auto" type="password" placeholder="Password" name="password"/>
				  <% 
		  		  	String error = (String)session.getAttribute("error");
		  		  	if (error != null) {
		  				%>
		  				<div class="invalid-feedback" style="display: block;"><%= error %></div>
		  				<%
		  				session.setAttribute("error", null);
		  		  	}
		  		  	else {
		  		  		%>
		  				<div class="valid-feedback" style="display: block; color: black;"> If you don't have an account, you can register <a href='register.jsp'>here</a></div>
		  				<%
		  		  	}
		  		  %>
			  </div>
			  <button class="btn btn-primary" type="submit">Log In</button>
			</form>
		</div>							  	
	</body>
</html>