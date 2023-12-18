<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
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
					<h1>Edit Reservation</h1>
				</div>
				<form action="getCustomerFlights.jsp" class="justify-content-center">
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
				<%
				if (session.getAttribute("customerID") != null) {
					ArrayList<Integer> ticketNums = new ArrayList<Integer>();
					ResultSet rs = stmt.executeQuery("SELECT * FROM flight_ticket WHERE ID_Number = " + session.getAttribute("customerID"));
					%>
					<div>
						<table style="margin: auto">
						<tr>
						<td>Ticket #</td>
						<td>Total Fare</td>
						<td>Seat #</td>
						<td>Flight Date</td>
						<td>Purchase Date</td>
						<td>Purchase Time</td>
						<td>Booking Fee</td>
						<td>Class</td>
						<td>Change Fee</td>
						</tr>
					<%
					while (rs.next()) {
						ticketNums.add(rs.getInt(1));
						%>
						<tr>
						<td><%= rs.getInt(1) %></td>
						<td><%= rs.getDouble(2) %></td>
						<td><%= rs.getInt(3) %></td>
						<td><%= rs.getString(4) %></td>
						<td><%= rs.getString(5) %></td>
						<td><%= rs.getString(6) %></td>
						<td><%= rs.getDouble(7) %></td>
						<td><%= rs.getString(9) %></td>
						<td><%= rs.getInt(10) %></td>
						</tr>
						<%
					}
						%>
						</table>
					</div>
					<form action="handleEditReservation.jsp">
						<div class="form-group">
							<label for="ticketNum">Ticket Number</label>
							<select required id="ticketNum" name="ticketNum">
								<% 
									for (int num: ticketNums) {
										out.println("<option value=\"" + num + "\">" + num + "</option>");
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="seatNum">Seat Number</label>
							<input required type="number" id="seatNum" name="seatNum" min="1" max="200" value="1" />
						</div>
						<div class="form-group">
							<label for="flightDate">Flight Date</label>
							<input required type="date" id="flightDate" name="flightDate" min="<%= LocalDate.now().toString() %>" value="<%= LocalDate.now().toString() %>"/>
						</div>
						
						<div class="form-group">
							<label for="class">Class: </label>
							<select required id="class" name="classSelect">
								<option value="economy">Economy</option>
								<option value="business">Business</option>
								<option value="first">first</option>
							</select>
						</div>
						<div class="mb-3">
							<% 
					  		  	String error = (String)session.getAttribute("error");
					  		  	if (error != null) {
					  				%>
					  				<div class="invalid-feedback" style="display: block;"><%= error %></div>
					  				<%
					  				session.setAttribute("error", null);
					  		  	}
							%>
						</div>
						<input class="btn-primary" type="submit" name="edit" value="Edit"/>
						<input class="btn-danger" type="submit" name="cancel" value="Cancel"/>
					</form>
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