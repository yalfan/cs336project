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
	
	int ticketNum = Integer.parseInt(request.getParameter("ticketNum"));
	if (request.getParameter("cancel") != null) {
		stmt.executeUpdate("DELETE FROM ticket_flights WHERE Ticket_Number = " + ticketNum);
		stmt.executeUpdate("DELETE FROM flight_ticket WHERE Ticket_Number = " + ticketNum);
		response.sendRedirect("editReservation.jsp");
		return;
	}
	double totalFare = 0, bookingFee = 0, changeFee = 25;
	if (request.getParameter("seatNum").equals("") || request.getParameter("classSelect") == null || request.getParameter("flightDate") == null) {
		session.setAttribute("error", "Missing information!");
    	response.sendRedirect("editReservation.jsp");
    	return;
	}
	int seatNum = Integer.parseInt(request.getParameter("seatNum"));
	String ticketClass = request.getParameter("classSelect");
	String date = request.getParameter("flightDate");
	
	
	ResultSet rs = stmt.executeQuery("SELECT Flight_Number FROM ticket_flights WHERE Ticket_Number = " + ticketNum);
	rs.next();
	int flightNum = rs.getInt(1);
	ResultSet rs2 = stmt.executeQuery("SELECT Price_Economy, Price_Business, Price_First, weekday From flight WHERE Flight_Number = " + flightNum);
	rs2.next();
	if (ticketClass.equals("economy")) {
		totalFare = rs2.getDouble(1);
		bookingFee = totalFare * 0.05;
	}
	else if (ticketClass.equals("business")) {
		totalFare = rs2.getDouble(2);
		bookingFee = totalFare * 0.05;
		changeFee = 0;
	}
	else if (ticketClass.equals("first")) {
		totalFare = rs2.getDouble(3);
		bookingFee = totalFare * 0.05;
		changeFee = 0;
	}
	String flightWeekday = rs2.getString(4);

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    LocalDate date1 = LocalDate.parse(date, formatter);
    
    // Get the DayOfWeek for each date
    DayOfWeek dayOfWeek1 = date1.getDayOfWeek();
    DayOfWeek dayOfWeek2 = dayAbbreviations.get(flightWeekday);
	
    if (dayOfWeek1 != dayOfWeek2) {
		session.setAttribute("error", "Incorrect day of week!");
    	response.sendRedirect("editReservation.jsp");
    	return;
    }
	
	String sqlStatement = String.format("UPDATE flight_ticket SET Seat_Number = %d, class = '%s', change_fee = %f, Total_Fare = %f, Booking_Fee = %f WHERE Ticket_Number = %d",
			seatNum, ticketClass, changeFee, totalFare, bookingFee, ticketNum);
	stmt.executeUpdate(sqlStatement);
	response.sendRedirect("editReservation.jsp");

	%>
	

</body>
</html>