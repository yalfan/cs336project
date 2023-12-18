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
	
	try {
		if (request.getParameter("aircraftID") == null) {
			session.setAttribute("error", "Missing information!");
	    	response.sendRedirect("createFlight.jsp");
	    	return;
		}
		
		String aircraftID = request.getParameter("aircraftID");
		if (request.getParameter("cancel") != null) {
			stmt.executeUpdate("DELETE FROM aircraft WHERE Aircraft_ID = '" + aircraftID + "'");
			response.sendRedirect("createFlight.jsp");
			return;
		}
		String companyID = request.getParameter("airlineSelect2");
		int numSeats = Integer.parseInt(request.getParameter("numSeats"));
		
		if (request.getParameter("edit") != null) {
			String sqlStatement = String.format("UPDATE aircraft SET Company_ID = '%s', Num_Seats = %d WHERE (Aircraft_ID = '%s');",
					companyID, numSeats, aircraftID);
		    stmt.executeUpdate(sqlStatement);
			response.sendRedirect("createFlight.jsp");
			return;
		}
		
		String insertStatement = String.format("INSERT INTO aircraft (Aircraft_ID, Company_ID, Num_Seats) VALUES ('%s', '%s', %d);",
	    		aircraftID, companyID, numSeats);
	    stmt.executeUpdate(insertStatement);
		response.sendRedirect("createFlight.jsp");
	}
	catch (Exception e) {
		response.sendRedirect("createFlight.jsp");
	}
	
	
	%>
	

</body>
</html>