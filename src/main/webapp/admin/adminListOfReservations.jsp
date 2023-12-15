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
		
		<div class="container">
			<div class="jumbotron">
				<h1>Produce a list of reservations by flight number or by customer name</h1>
				<p>Enter a flight number or customer name to view reservations</p>

				<form action="adminListOfReservations.jsp">
					<div class="form-group">
						<input type="text" class="form-control" name="flightNumber" placeholder="Enter flight number">
					</div>
					<p> OR </p>
					<div class="form-group">
						<input type="text" class="form-control" name="customerFirstName" placeholder="Enter first name">
						<input type="text" class="form-control" name="customerLastName" placeholder="Enter last name">
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
			</div>
		</div>

		<table class="table table-striped" border="1" id="flights">

		<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String flightNumber = request.getParameter("flightNumber");
		String customerFirstName = request.getParameter("customerFirstName");
		String customerLastName = request.getParameter("customerLastName");

		if (flightNumber != null) {
			rs = stmt.executeQuery("SELECT t.Ticket_Number, t.Total_Fare, t.Seat_Number, t.Flight_date, t.class,  f.Flight_Number, f.Company_ID AS Flight_Company_ID, f.departure_time, f.arrival_time, f.Flight_type, f.From_Airport_ID AS Departure_Airport_ID, f.To_Airport_ID AS Arrival_Airport_ID, f.Aircraft_ID, a.first_name, a.last_name FROM flight_ticket t JOIN ticket_flights tf ON t.Ticket_Number = tf.Ticket_Number JOIN flight f ON tf.Flight_Number = f.Flight_Number JOIN account a ON t.ID_Number = a.ID_Number WHERE f.Flight_Number = '" + flightNumber + "'");
		%>
		<tr>
			<th>Ticket #</th>
			<th>Fare</th>
			<th>Seat</th>
			<th>Flight Date</th>
			<th>Class</th>
			<th>Flight #</th>
			<th>Airline</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>Flight Type</th>
			<th>Departure</th>
			<th>Arrival</th>
			<th>First Name</th>
			<th>Last Name</th>
		</tr>
		<%
			while (rs.next()) {
		%>
			 <tr>
				<td><%= rs.getInt("Ticket_Number") %></td>
				<td><%= rs.getInt("Total_Fare") %></td>
				<td><%=rs.getInt("Seat_Number") %></td>
				<td><%= rs.getDate("Flight_date") %></td>
				 <td><%= rs.getString("class") %></td>
				<td><%= rs.getInt("Flight_Number") %></td>
				<td><%= rs.getString("Flight_Company_ID") %></td>
				<td><%= rs.getTime("departure_time")%></td>
				<td><%= rs.getTime("arrival_time") %></td>
				<td><%= rs.getString("Flight_type") %></td>
				<td><%= rs.getString("Departure_Airport_ID") %></td>
				<td><%= rs.getString("Arrival_Airport_ID") %></td>
				<td><%= rs.getString("first_name")%></td>
				<td><%= rs.getString("last_name") %></td>
				 <% }
		} if ( customerFirstName != null && customerLastName != null) {
			String query = "SELECT t.Ticket_Number, t.Total_Fare, t.Seat_Number, t.Flight_date, t.class,  f.Flight_Number, f.Company_ID AS Flight_Company_ID, f.departure_time, f.arrival_time, f.Flight_type, f.From_Airport_ID AS Departure_Airport_ID, f.To_Airport_ID AS Arrival_Airport_ID, f.Aircraft_ID, a.first_name, a.last_name FROM flight_ticket t JOIN ticket_flights tf ON t.Ticket_Number = tf.Ticket_Number JOIN flight f ON tf.Flight_Number = f.Flight_Number JOIN account a ON t.ID_Number = a.ID_Number WHERE a.first_name = '" + customerFirstName + "' AND a.last_name = '" + customerLastName + "';";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
		%>
			 <tr>
				<td><%= rs.getInt("Ticket_Number") %></td>
				<td><%= rs.getInt("Total_Fare") %></td>
				<td><%=rs.getInt("Seat_Number") %></td>
				<td><%= rs.getDate("Flight_date") %></td>
				 <td><%= rs.getString("class") %></td>
				<td><%= rs.getInt("Flight_Number") %></td>
				<td><%= rs.getString("Flight_Company_ID") %></td>
				<td><%= rs.getTime("departure_time")%></td>
				<td><%= rs.getTime("arrival_time") %></td>
				<td><%= rs.getString("Flight_type") %></td>
				<td><%= rs.getString("Departure_Airport_ID") %></td>
				<td><%= rs.getString("Arrival_Airport_ID") %></td>
				<td><%= rs.getString("first_name")%></td>
				<td><%= rs.getString("last_name") %></td>
				 <% }

		}%>
			</tr>
		</table>
	</body>
</html>