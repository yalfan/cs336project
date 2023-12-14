<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Searching...</title>
</head>
<body>
	<%
	Map<String, DayOfWeek> dayAbbreviations = new HashMap<>();
    dayAbbreviations.put("Mon", DayOfWeek.MONDAY);
    dayAbbreviations.put("Tue", DayOfWeek.TUESDAY);
    dayAbbreviations.put("Wed", DayOfWeek.WEDNESDAY);
    dayAbbreviations.put("Thu", DayOfWeek.THURSDAY);
    dayAbbreviations.put("Fri", DayOfWeek.FRIDAY);
    dayAbbreviations.put("Sat", DayOfWeek.SATURDAY);
    dayAbbreviations.put("Sun", DayOfWeek.SUNDAY);
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	if (request.getParameter("flightNumber") == null) {
		session.setAttribute("error", "Missing information!");
    	response.sendRedirect("createFlight.jsp");
    	return;
	}
	
	int flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
	if (request.getParameter("cancel") != null) {
		stmt.executeUpdate("DELETE FROM flight WHERE Flight_Number = " + flightNumber);
		// ResultSet deletedTickets = stmt.executeQuery("SELECT Ticket_Number FROM ticket_flights WHERE Flight_Number = " + flightNumber);
		// while (deletedTickets.next()) {
		// 	stmt.executeUpdate("DELETE FROM flight_ticket WHERE Ticket_Number = " + deletedTickets.getInt(1));
		// }
		// stmt.executeUpdate("DELETE FROM ticket_flights WHERE Flight_Number = " + flightNumber);
		response.sendRedirect("createFlight.jsp");
		return;
	}
	String companyID = request.getParameter("airlineSelect");
	String weekday = request.getParameter("weekdaySelect");
	
	String departureTime = request.getParameter("departureTime");
	String arrivalTime = request.getParameter("arrivalTime");
	
	String flightType = request.getParameter("flightTypeSelect");
	
	String fromAirport = request.getParameter("fromAirportSelect");
	String toAirport = request.getParameter("toAirportSelect");
	String aircraftID = request.getParameter("aircraftSelect");
	
	int economyPrice = Integer.parseInt(request.getParameter("economy"));
	int businessPrice = Integer.parseInt(request.getParameter("business"));
	int firstPrice = Integer.parseInt(request.getParameter("first"));
	
	if (request.getParameter("edit") != null) {
		String sqlStatement = String.format("UPDATE flight SET `weekday` = '%s', `departure_time` = '%s', `arrival_time` = '%s', `Flight_type` = '%s', `From_Airport_ID` = '%s', `To_Airport_ID` = '%s', `Aircraft_ID` = '%s', `Price_Economy` = '%d', `Price_Business` = '%d', `Price_First` = '%d' WHERE (`Flight_Number` = '%d') and (`Company_ID` = '%s');",
				weekday, departureTime, arrivalTime, flightType, fromAirport, toAirport, aircraftID, economyPrice, businessPrice, firstPrice, flightNumber, companyID);
	    stmt.executeUpdate(sqlStatement);
		response.sendRedirect("createFlight.jsp");
		return;
	}
	
	String insertStatement = String.format("INSERT INTO flight (Flight_Number, Company_ID, weekday, departure_time, arrival_time, Flight_type, From_Airport_ID, To_Airport_ID, Aircraft_ID, Price_Economy, Price_Business, Price_First) VALUES (%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', %d, %d, %d);",
			flightNumber, companyID, weekday, departureTime, arrivalTime, flightType, fromAirport, toAirport, aircraftID, economyPrice, businessPrice, firstPrice);
    stmt.executeUpdate(insertStatement);
	response.sendRedirect("createFlight.jsp");
	


	%>
	

</body>
</html>