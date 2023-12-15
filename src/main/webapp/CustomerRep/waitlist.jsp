<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dth">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
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
			<div class="row justify-content-center">
				<h1>Flights</h1>
			</div>
			<form action="getCustomerWaitlist.jsp" class="row justify-content-center">
				<select name="flightNumber">
					<%
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();
					ResultSet flights = stmt.executeQuery("SELECT Flight_Number FROM flight");
					while (flights.next()) {
						out.println("<option value=\"" + flights.getString(1) + "\">" + flights.getString(1) + "</option>");
					}
					flights.close();
					%>
				</select> 
				<input type="submit" value="Submit" />
			</form>
			<div class="row justify-content-center">
				<table>
					<tr>
						<th>Flight Number</th>
						<th>Customer ID</th>
						<th>Username</th>
						<th>First Name</th>
						<th>Last Name</th>
					</tr>
					<%
						ResultSet rs;
						if (session.getAttribute("flightNumber") != null) {
						    int flightNumber = (Integer) session.getAttribute("flightNumber");
						    rs = stmt.executeQuery("SELECT w.Flight_Number, w.ID_Number, a.first_name, a.last_name, a.username FROM waitlist w INNER JOIN account a ON w.ID_Number = a.ID_Number WHERE w.Flight_Number = '" + flightNumber + "'");
						} else {
						    rs = stmt.executeQuery("SELECT w.Flight_Number, w.ID_Number, a.first_name, a.last_name, a.username FROM waitlist w INNER JOIN account a ON w.ID_Number = a.ID_Number");
						}
	
						while (rs.next()) {
						    int customerID = rs.getInt("ID_Number");
						    String firstName = rs.getString("first_name");
						    String lastName = rs.getString("last_name");
						    String username = rs.getString("username");
						    %>
						    <tr>
						    	<td><%= rs.getInt(1) %></td>
						        <td><%= customerID %></td>
						        <td><%= username %></td>
						        <td><%= firstName %></td>
						        <td><%= lastName %></td>
						    </tr>
						    <%
						}
						rs.close();

					%>
				</table>
			</div>


			<div class="row justify-content-center">
				<a href='../index.jsp'>Return</a>
			</div>
		</div>
	</div>



</body>
</html>