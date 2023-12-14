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
				response.sendRedirect("login.jsp");
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
				<form action="createReservation.jsp">
					<div class="form-group">
						<select name="classSelect">
							<option value="economy">Economy</option>
							<option value="business">Business</option>
							<option value="first">first</option>
						</select>
					</div>
					<div class="form-group">
						<label for="fromAirportSelect">From: </label>
						<select id="fromAirportSelect" name="fromAirportSelect">
							<% 
								
								ResultSet fromAirportIDs = stmt.executeQuery("SELECT Airport_ID FROM airport");
								while (fromAirportIDs.next()) {
									out.println("<option value=\"" + fromAirportIDs.getString(1) + "\">" + fromAirportIDs.getString(1) + "</option>");
								}
							%>
						</select>
						<label for="toAirportSelect">To: </label>
						<select id="toAirportSelect" name="toAirportSelect">
							<% 
								
								ResultSet toAirportIDs = stmt.executeQuery("SELECT Airport_ID FROM airport");
								while (toAirportIDs.next()) {
									out.println("<option value=\"" + toAirportIDs.getString(1) + "\">" + toAirportIDs.getString(1) + "</option>");
								}
							%>
						</select>
					</div>
					<div class="form-group">
						
					</div>
					<input type="submit" value="Submit" />
				
				</form>
				
				<div class="row justify-content-center">
					<a href='index.jsp'>Return</a>
				</div>
			</div>
		</div>
		


	</body>
</html>