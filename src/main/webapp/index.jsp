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
		<title>CS336 Project</title>
	</head>
	
	<body>
		<% 
			if (session.getAttribute("user") == null || session.getAttribute("account_type") == null) {
				response.sendRedirect("login.jsp");
			}
		%>
		<div class="container">
			<div class="jumbotron">
				<h1>Welcome, <%= session.getAttribute("user") %>!</h1>
				<br><br>
				<a> Account Type: <%= session.getAttribute("account_type") %> </a> 
				<br><br>
				
				<% if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer")) { %>
					<a href='search.jsp'>Search flights</a> 
					<br> <br>
				<% } else if (session.getAttribute("account_type") != null && session.getAttribute("account_type").equals("customer_rep")){ %>
					<div class="row justify-content-center">
						<a href='CustomerRep/customerReservation.jsp'>Make Reservations</a>
					</div>
					<div class="row justify-content-center">
						<a href='CustomerRep/editReservation.jsp'>Edit Information</a>
					</div>
					<div class="row justify-content-center">
						<a href='CustomerRep/flightSearch.jsp'>View Flights</a>
					</div>
					<!-- add stuff for other account types here -->
				<% } %>
				
				<a href='logout.jsp'>Log out</a>
			</div>
		</div>
		


	</body>
</html>