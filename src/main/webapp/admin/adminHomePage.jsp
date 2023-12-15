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
			if (session.getAttribute("user") == null) {
				response.sendRedirect("../login.jsp");
			}
		%>
		<div class="container">
			<div class="jumbotron">
				<h1>Admin options</h1>
				<a href='adminEditInfo.jsp'>Edit customer or representative info</a>
				<br></br>
				<a href='adminSalesReport.jsp'>Sales report</a>
				<br></br>
				<a href='adminListOfReservations.jsp'>Get list of reservations by customer/flight name</a>
				<br></br>
				<a href='adminSummaryOfRevenue.jsp'>Summary listing of revenue</a>
				<br></br>
				<a href='adminRevenueCustomer.jsp'>Top revenue customer</a>
				<br></br>
				<a href='adminMostActiveFlights.jsp'>Most active flights (most tickets sold)</a>
				<br></br>
			</div>
		</div>
		


	</body>
</html>