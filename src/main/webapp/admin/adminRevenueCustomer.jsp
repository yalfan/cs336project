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
		%>
		<div class="container">
			<div class="jumbotron">
				<h1>Find out which customer generated most total revenue </h1>
				<h3>The top customer right now is:</h3>
				<%
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					Statement stmt = con.createStatement();
					ResultSet rs = null;

					String query = "SELECT a.ID_Number, a.first_name, a.last_name, SUM(ft.Total_Fare) AS Total_Revenue FROM account a JOIN flight_ticket ft ON a.ID_Number = ft.ID_Number GROUP BY a.ID_Number, a.first_name, a.last_name ORDER BY Total_Revenue DESC LIMIT 1;";

					rs = stmt.executeQuery(query);

					while (rs.next()) {
						String id = rs.getString("ID_Number");
						String first = rs.getString("first_name");
						String last = rs.getString("last_name");
						String total = rs.getString("Total_Revenue");

						out.println("<p>" + first + " " + last + " with ID number " + id + " has generated $" + total + " in total revenue.</p>");
					}
				%>

			</div>
		</div>
		


	</body>
</html>