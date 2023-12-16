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
				<h1>Produce a list of most active flights (most tickets sold) </h1>
			</div>
		</div>
		<table class="table table-header" border="1">

			<tr>
				<th>Flight Number</th>
				<th>Number of Tickets Sold</th>
			</tr>

			<%
				ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();
				Statement stmt = con.createStatement();
				ResultSet rs = null;
				String query = "SELECT tf.Flight_Number, COUNT(tf.Ticket_Number) AS Tickets_Sold FROM ticket_flights tf GROUP BY tf.Flight_Number ORDER BY Tickets_Sold DESC LIMIT 10";
				stmt.executeQuery(query);
				rs = stmt.getResultSet();

				while(rs.next()) {
					String flightNumber = rs.getString("Flight_Number");
					String ticketsSold = rs.getString("Tickets_Sold");
					out.println("<tr>");
					out.println("<td>" + flightNumber + "</td>");
					out.println("<td>" + ticketsSold + "</td>");
					out.println("</tr>");
				}
			%>



		</table>
		


	</body>
</html>