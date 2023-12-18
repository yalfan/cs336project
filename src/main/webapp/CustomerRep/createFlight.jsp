<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
		%>
		<div class="container">
			<div class="jumbotron">
				<div class = "row justify-content-center">
					<h1>Create/Edit/Delete Information</h1>
				</div>
				
				<form style="border: 1px solid; padding: 10px;" action="handleCreateFlight.jsp" class="justify-content-center">
					<h2>Flights</h2>
					<div class="form-group">
						<label for="flightNumber">Flight Number: </label>
						<input type="number" required name="flightNumber" id="flightNumber" />
					</div>
					<div class="form-group">
						<label for="airline">Airline: </label>
						<select id="airline" name="airlineSelect">
							<% 
								
								ResultSet companies = stmt.executeQuery("SELECT Company_ID FROM airline");
								while (companies.next()) {
									out.println("<option value=\"" + companies.getString(1) + "\">" + companies.getString(1) + "</option>");
								}
							%>
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
						<label for="aircraftSelect">Aircraft: </label>
						<select id="aircraftSelect" name="aircraftSelect">
							<% 
								
								ResultSet aircrafts = stmt.executeQuery("SELECT Aircraft_ID FROM aircraft");
								while (aircrafts.next()) {
									out.println("<option value=\"" + aircrafts.getString(1) + "\">" + aircrafts.getString(1) + "</option>");
								}
							%>
						</select>
					</div>
					
					<div class="form-group">
						<label for="departureTime">Departure Time: </label>
						<input type="time" id="departureTime" name="departureTime"/>
						<label for="arrivalTime">Arrival Time: </label>
						<input type="time" id="arrivalTime" name="arrivalTime"/>
					</div>
					<div class="form-group">
						<label for="weekday">Weekday: </label>
						<select id="weekday" name="weekdaySelect">
							<option value="Mon">Monday</option>
							<option value="Tue">Tuesday</option>
							<option value="Wed">Wednesday</option>
							<option value="Thu">Thursday</option>
							<option value="Fri">Friday</option>
							<option value="Sat">Saturday</option>
							<option value="Sun">Sunday</option>
						</select>
					</div>
					<div class="form-group">
						<label for="flightType">Flight Type: </label>
						<select id="flightType" name="flightTypeSelect">
							<option value="Domestic">Domestic</option>
							<option value="International">International</option>
						</select>
					</div>
					<div class="form-group">
						<label for="economy">Economy Class Price ($)</label>
						<input required type="number" id="economy" name="economy" min="0"/>
					</div>
					<div class="form-group">
						<label for="business">Business Class Price ($)</label>
						<input required type="number" id="business" name="business" min="0"/>
					</div>
					<div class="form-group">
						<label for="first">First Class Price ($)</label>
						<input required type="number" id="first" name="first" min="0"/>
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
					<input class="btn-success" type="submit" name="create" value="Create"/>
					<input class="btn-primary" type="submit" name="edit" value="Edit"/>
					<input class="btn-danger" type="submit" name="cancel" value="Delete"/>
				</form>
				
				<form style="border: 1px solid; padding: 10px;" action="handleCreateAircraft.jsp" class="justify-content-center">
					<h2>Aircrafts</h2>
					<div class="form-group">
						<label for="aircraftID">Aircraft ID: </label>
						<input type="text" required name="aircraftID" id="aircraftID" />
					</div>
					<div class="form-group">
						<label for="airline2">Airline: </label>
						<select id="airline2" name="airlineSelect2">
							<% 
								
								ResultSet companies2 = stmt.executeQuery("SELECT Company_ID FROM airline");
								while (companies2.next()) {
									out.println("<option value=\"" + companies2.getString(1) + "\">" + companies2.getString(1) + "</option>");
								}
							%>
						</select>
					</div>
					<div class="form-group">
						<label for="numSeats">Number of Seats: </label>
						<input type="number" required name="numSeats" id="numSeats" />
					</div>
					<input class="btn-success" type="submit" name="create" value="Create"/>
					<input class="btn-primary" type="submit" name="edit" value="Edit"/>
					<input class="btn-danger" type="submit" name="cancel" value="Delete"/>
				</form>
				
				
				
				<form style="border: 1px solid; padding: 10px;" action="handleCreateAirport.jsp" class="justify-content-center">
					<h2>Airports</h2>
					<div class="form-group">
						<label for="airportIDSelect">Airport ID: </label>
						<input type="text" required name="airportIDSelect" id="airportIDSelect" maxlength="3" minlength="3"/>
					</div>
					<div class="form-group">
						<label for="airportNameSelect">Airport Name: </label>
						<input type="text" required name="airportNameSelect" id="airportNameSelect" />
					</div>
					<input class="btn-success" type="submit" name="create" value="Create"/>
					<input class="btn-primary" type="submit" name="edit" value="Edit"/>
					<input class="btn-danger" type="submit" name="cancel" value="Delete"/>
				</form>
				
				<div class="row justify-content-center">
					<a href='../index.jsp'>Return</a>
				</div>
			</div>
		</div>
		


	</body>
</html>