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
				return;
			}
			if (session.getAttribute("account_type") != null && !session.getAttribute("account_type").equals("customer_rep")) {
				response.sendRedirect("../login.jsp");
				return;
			}
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
		%>
		<div class="container">
			<div class="jumbotron">
				<div class = "row justify-content-center">
					<h1>Flights</h1>
				</div>
				<form action="createReservation.jsp" class="justify-content-center" style="padding-left: 30%;">
					<div class="form-group">
						<label for="class">Class: </label>
						<select id="class" name="classSelect">
							<option value="economy">Economy</option>
							<option value="business">Business</option>
							<option value="first">first</option>
						</select>
					</div>
					<div class="form-group">
						<label for="flights">Flight: </label>
						<select id="flights" name="flight">
							<% 
								ResultSet rs = stmt.executeQuery("SELECT * FROM flight");
								while (rs.next()) {
									Flight flight = new Flight(rs.getString(1), rs.getString(2), rs.getString(3), 
											rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), 
											rs.getString(9), rs.getDouble(10), rs.getDouble(11), rs.getDouble(12));
									String visibleText = String.format("[%s %s-%s] From: %s, To: %s", flight.getWeekday(), flight.getDepartureTime(), flight.getArrivalTime(), flight.getFromAirportID(), flight.getToAirportID());
									out.println("<option value=\"" + flight.getFlightNumber() + "\">" + visibleText + "</option>");
								}
							%>
						</select>
					</div>
					<div class="form-group">
						<label for="customerID">Customer ID: </label>
						<select id="customerID" name="customerID">
							<% 
								
								ResultSet rs2 = stmt.executeQuery("SELECT ID_Number FROM account WHERE account_type = 'customer'");
								while (rs2.next()) {
									out.println("<option value=\"" + rs2.getInt(1) + "\">" + rs2.getInt(1) + "</option>");
								}
							%>
						</select>
					</div>
					<input type="submit" value="Submit" />
				
				</form>
				
				<div class="row justify-content-center">
					<a href='../index.jsp'>Return</a>
				</div>
			</div>
		</div>
		


	</body>
</html>