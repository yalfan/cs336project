<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*,java.time.format.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in...</title>
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
	
	String flightID = request.getParameter("flight");
	String ticketClass = request.getParameter("classSelect");
	int customerID = Integer.parseInt(request.getParameter("customerID"));
	double totalFare = 0, bookingFee = 0, changeFee = 25;
	int seatNumber;
    LocalDate currentDate = LocalDate.now();
    LocalTime currentTime = LocalTime.now();
    
    DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("YYYY-MM-dd");
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm:ss");
    String formattedCurrentDate = currentDate.format(dateFormat);
    String formattedCurrentTime = currentTime.format(timeFormat);
	
	ResultSet rs = stmt.executeQuery("SELECT * FROM flight WHERE Flight_Number = '" + flightID + "'");
	Flight flight;
	rs.next();
	flight = new Flight(rs.getString(1), rs.getString(2), rs.getString(3), 
			rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), 
			rs.getString(9), rs.getDouble(10), rs.getDouble(11), rs.getDouble(12));
	
	if (ticketClass.equals("economy")) {
		totalFare = flight.getPriceEconomy();
		bookingFee = flight.getPriceEconomy() * 0.05;
	}
	else if (ticketClass.equals("business")) {
		totalFare = flight.getPriceBusiness();
		bookingFee = flight.getPriceBusiness() * 0.05;
		changeFee = 0;
	}
	else if (ticketClass.equals("first")) {
		totalFare = flight.getPriceFirst();
		bookingFee = flight.getPriceFirst() * 0.05;
		changeFee = 0;
	}
	Random random = new Random();
	rs = stmt.executeQuery("SELECT Num_Seats FROM aircraft WHERE Aircraft_ID = '" + flight.getAircraftID() + "'");	
    
	rs.next();
    seatNumber = random.nextInt(rs.getInt(1) - 0 + 1) + 0;
        
    // Parse the input string to get the DayOfWeek enum   	
    DayOfWeek day = dayAbbreviations.get(flight.getWeekday());
    		
    LocalDate today = LocalDate.now();
    LocalDate nextOccurrence = today.with(day);
    
    // If today is the same day or later, get the date for the next occurrence
    if (today.compareTo(nextOccurrence) >= 0) {
        nextOccurrence = nextOccurrence.plusWeeks(1);
    }
    
    String formattedFlightDate = nextOccurrence.format(dateFormat);
    
    // String sqlStatement = String.format("INSERT INTO flight_ticket (Total_Fare, Seat_Number, Flight_date, Purchase_date, Purchase_time, Booking_fee, ID_Number, class, change_fee) VALUES (%.2f, %d, '%s', '%s', '%s', %.2f, %d, '%s', %d);",
    // 		totalFare, seatNumber, formattedFlightDate, formattedCurrentDate, formattedCurrentTime, bookingFee, customerID, ticketClass, changeFee);

    // String linkingStatement = String.format("INSERT INTO ticket_flights ");
    // out.println(sqlStatement);
    // stmt.executeUpdate(sqlStatement);
	
    String insertFlightTicketSql = "INSERT INTO flight_ticket (Total_Fare, Seat_Number, Flight_date, Purchase_date, Purchase_time, Booking_fee, ID_Number, class, change_fee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstmt = con.prepareStatement(insertFlightTicketSql, Statement.RETURN_GENERATED_KEYS);

	// Set the parameters for the flight_ticket insertion
	pstmt.setDouble(1, totalFare);
	pstmt.setInt(2, seatNumber);
	pstmt.setString(3, formattedFlightDate);
	pstmt.setString(4, formattedCurrentDate);
	pstmt.setString(5, formattedCurrentTime);
	pstmt.setDouble(6, bookingFee);
	pstmt.setInt(7, customerID);
	pstmt.setString(8, ticketClass);
	pstmt.setDouble(9, changeFee);
	
	// Execute the insertion
	int affectedRows = pstmt.executeUpdate();
	
	// Retrieve the generated keys (auto-generated Ticket_Number)
	ResultSet generatedKeys = pstmt.getGeneratedKeys();
	
	if (generatedKeys.next()) {
	    int ticketNumber = generatedKeys.getInt(1); // Retrieve the generated Ticket_Number
	    // Use ticketNumber for further processing or insertion into ticket_flights table
	    String linkingStatement = String.format("INSERT INTO ticket_flights (Ticket_Number, Flight_Number, Company_ID) VALUES (%d, '%s', '%s')", ticketNumber, flight.getFlightNumber(), flight.getCompanyID());
	    stmt.executeUpdate(linkingStatement);
	} 
	
	response.sendRedirect("customerReservation.jsp");
	
	%>
	

</body>
</html>