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
				<div class = "row justify-content-center">
					<h1>Flights</h1>
				</div>
				<form action="flightSearch.jsp" class="row justify-content-center">
					<select name="airportSelect">
						<% 
							ApplicationDB db = new ApplicationDB();	
							Connection con = db.getConnection();
					
							//Create a SQL statement
							Statement stmt = con.createStatement();
							ResultSet airportIDs = stmt.executeQuery("SELECT Airport_ID FROM airport");
							while (airportIDs.next()) {
								out.println("<option value=\"" + airportIDs.getString(1) + "\">" + airportIDs.getString(1) + "</option>");
							}
						%>
					</select>
					<input type="submit" value="Submit" />
				</form>
				<%
					
					ResultSet rs;
					if (session.getAttribute("airport") != null) {
						String airport = (String) session.getAttribute("airport");
						rs = stmt.executeQuery("select * from flight where From_Airport_ID = '" + airport + "' OR To_Airport_ID = '" + airport + "'");
					}
					else {
						rs = stmt.executeQuery("select * from flight");
					}
					%>
						<div class="row justify-content-center">
							<% out.println("flightNumber, company, day, type, from, to, aircraftID, departure, arrival, economy, business, first"); %>
						</div>
					<%
					while (rs.next()) {
						Flight flight = new Flight(rs.getString(1), rs.getString(2), rs.getString(3), 
								rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), 
								rs.getString(9), rs.getDouble(10), rs.getDouble(11), rs.getDouble(12));
						%>
						<div class="row justify-content-center">
							<% out.println(flight.toString()); %>
						</div>
						<%
					}
				
				%>
				
				<div class="row justify-content-center">
					<a href='../index.jsp'>Return</a>
				</div>
			</div>
		</div>
		


	</body>
</html>