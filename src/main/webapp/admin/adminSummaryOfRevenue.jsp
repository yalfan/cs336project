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
				<h1>Produce a summary listing of revenue generated by a particular flight, airline, or customer </h1>
				<p>Enter the flight number, airline name, or customer name to view the revenue generated by that flight, airline, or customer.</p>

				<form action="adminSummaryOfRevenue.jsp">
					<div class="form-group">
						<label for="flightNumber">Flight Number</label>
						<input type="text" class="form-control" name="flightNumber" placeholder="Flight Number">
					</div>
					<p>OR</p>
					<div class="form-group">
						<label for="airlineName">Airline Name</label>
						<input type="text" class="form-control" name="airlineName" placeholder="Airline Name">
					</div>
					<p>OR</p>
					<div class="form-group">
						<label for="firstName">First Name</label>
						<input type="text" class="form-control" name="customerFirstName" placeholder="First Name">
						<label for="lastName">Last Name </label>
						<input type="text" class="form-control" name="customerLastName" placeholder="Last Name">

					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
				</form>
			</div>
		</div>

	<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String flightNumber = request.getParameter("flightNumber");
		String airlineName = request.getParameter("airlineName");
		String customerFirstName = request.getParameter("customerFirstName");
		String customerLastName = request.getParameter("customerLastName");

		if (flightNumber != "" && flightNumber != null) {
//			 Get the revenue generated by the flight
			String query = "SELECT a.ID_Number, a.first_name, a.last_name, ft.Ticket_Number, ft.Total_Fare FROM account a JOIN flight_ticket ft ON a.ID_Number = ft.ID_Number JOIN ticket_flights tf ON ft.Ticket_Number = tf.Ticket_Number WHERE tf.Flight_Number = " + flightNumber;
			rs = stmt.executeQuery(query);
			out.println("<h1>Revenue Generated by Flight " + flightNumber + "</h1>");
			out.println("<table class=\"table table-striped\" border=\"1\">");
			out.println("<thead>");
			out.println("<tr>");
			out.println("<th scope=\"col\">ID Number</th>");
			out.println("<th scope=\"col\">First Name</th>");
			out.println("<th scope=\"col\">Last Name</th>");
			out.println("<th scope=\"col\">Ticket Number</th>");
			out.println("<th scope=\"col\">Total Fare</th>");
			out.println("</tr>");
			out.println("</thead>");
			out.println("<tbody>");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getInt("ID_Number") + "</td>");
				out.println("<td>" + rs.getString("first_name") + "</td>");
				out.println("<td>" + rs.getString("last_name") + "</td>");
				out.println("<td>" + rs.getString("Ticket_Number") + "</td>");
				out.println("<td>" + rs.getString("Total_Fare") + "</td>");
				out.println("</tr>");

			}

		} if (airlineName != "" && airlineName != null) {
			String query = "SELECT f.Flight_Number, a.ID_Number, a.first_name, a.last_name, ft.Ticket_Number, ft.Total_Fare FROM account a JOIN flight_ticket ft ON a.ID_Number = ft.ID_Number JOIN ticket_flights tf ON ft.Ticket_Number = tf.Ticket_Number JOIN flight f ON tf.Flight_Number = f.Flight_Number AND tf.Company_ID = f.Company_ID WHERE f.Company_ID = '" + airlineName + "'";
			rs = stmt.executeQuery(query);
			out.println("<h1>Revenue Generated by Airline " + airlineName + "</h1>");
			out.println("<table class=\"table table-striped\" border=\"1\">");
			out.println("<thead>");
			out.println("<tr>");
			out.println("<th scope=\"col\">Flight Number</th>");
			out.println("<th scope=\"col\">ID Number</th>");
			out.println("<th scope=\"col\">First Name</th>");
			out.println("<th scope=\"col\">Last Name</th>");
			out.println("<th scope=\"col\">Ticket Number</th>");
			out.println("<th scope=\"col\">Total Fare</th>");
			out.println("</tr>");
			out.println("</thead>");
			out.println("<tbody>");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getInt("Flight_Number") + "</td>");
				out.println("<td>" + rs.getInt("ID_Number") + "</td>");
				out.println("<td>" + rs.getString("first_name") + "</td>");
				out.println("<td>" + rs.getString("last_name") + "</td>");
				out.println("<td>" + rs.getString("Ticket_Number") + "</td>");
				out.println("<td>" + rs.getString("Total_Fare") + "</td>");
				out.println("</tr>");

			}
//
//		out.println("Airline name : " + airlineName);

		} if (customerFirstName != "" && customerLastName != "" && customerFirstName != null && customerLastName != null) {
			// Get the revenue generated by the customer
			String query = "SELECT a.first_name, a.last_name, a.ID_Number, COUNT(t.Ticket_Number) AS Total_Tickets, SUM(t.Total_Fare) AS Total_Revenue FROM account a JOIN flight_ticket t ON a.ID_Number = t.ID_Number WHERE a.first_name = '" + customerFirstName + "' AND a.last_name = '" + customerLastName + "' GROUP BY a.first_name, a.last_name, a.ID_Number;\n";

			rs = stmt.executeQuery(query);
			out.println("<h1>Revenue Generated by Customer " + customerFirstName + " "+ customerLastName + "</h1>");
			out.println("<table class=\"table table-striped\" border=\"1\">");
			out.println("<thead>");
			out.println("<tr>");
			out.println("<th scope=\"col\">First Name</th>");
			out.println("<th scope=\"col\">Last Name</th>");
			out.println("<th scope=\"col\">ID Number</th>");
			out.println("<th scope=\"col\">Total Tickets</th>");
			out.println("<th scope=\"col\">Total Revenue</th>");
			out.println("</tr>");
			out.println("</thead>");
			out.println("<tbody>");
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td>" + rs.getString("first_name") + "</td>");
				out.println("<td>" + rs.getString("last_name") + "</td>");
				out.println("<td>" + rs.getInt("ID_Number") + "</td>");
				out.println("<td>" + rs.getInt("Total_Tickets") + "</td>");
				out.println("<td>" + rs.getInt("Total_Revenue") + "</td>");
				out.println("</tr>");

			}

		} %>
		


	</body>
</html>