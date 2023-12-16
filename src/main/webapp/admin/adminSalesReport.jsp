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
				<h1>Obtain a sales report for a particular month</h1>

				<form action="adminSalesReport.jsp" >
					<div class="form-group">
						<label for="month">Month</label>
						<input type="text" class="form-control" name="month" placeholder="Enter month (number only)">
					</div>
					<div class="form-group">
						<label for="year">Year</label>
						<input type="text" class="form-control" name="year" placeholder="Enter year (number only)">
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>

				</form>
			</div>
</div>

				<table class="table table-striped" border="1">
					<tr>
						<th>Month</th>
						<th>Year</th>
						<th>Number of Sales</th>
						<th>Total Revenue</th>
					</tr>
					<%
						ApplicationDB db = new ApplicationDB();
						Connection con = db.getConnection();
						Statement stmt = con.createStatement();
						ResultSet rs = null;
						String month = request.getParameter("month");
						String year = request.getParameter("year");
						if (month != null && year != null) {
							String query = "SELECT MONTH(ft.Purchase_date) AS Month, YEAR(ft.Purchase_date) AS Year, COUNT(ft.Ticket_Number) AS Total_Tickets, SUM(ft.Total_Fare) AS Total_Sales FROM flight_ticket ft WHERE MONTH(ft.Purchase_date) = 1 AND YEAR(ft.Purchase_date) = 2023 GROUP BY MONTH(ft.Purchase_date), YEAR(ft.Purchase_date)";
							rs = stmt.executeQuery(query);
							while (rs.next()) {
								out.println("<tr>");
								out.println("<td>" + rs.getString("Month") + "</td>");
								out.println("<td>" + rs.getDate("Year") + "</td>");
								out.println("<td>" + rs.getString("Total_Tickets") + "</td>");
								out.println("<td>" + rs.getString("Total_Sales") + "</td>");
								out.println("</tr>");
							}
						}
					%>
				</table>

	</body>
</html>