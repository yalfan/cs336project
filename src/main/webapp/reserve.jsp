<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = null;
    int ticketNumber = -1;


        String companyID = request.getParameter("companyID");
        int flightNumber = Integer.parseInt(request.getParameter("flightNumber"));
        String ticketClass = request.getParameter("ticketClass");
        double fare = 20.00;
        String priceQuery = "SELECT Price_Economy, Price_Business, Price_First FROM flight WHERE Flight_Number = "+ flightNumber + " AND Company_ID = '" + companyID + "'";
        rs = stmt.executeQuery(priceQuery);
        if (rs.next()) {
            if ("Business".equals(ticketClass)) {
                fare = rs.getDouble("Price_Business");
            } else if ("First".equals(ticketClass)) {
                fare = rs.getDouble("Price_First");
            } else {
                fare = rs.getDouble("Price_Economy");
            }
        }

        String id_query = "SELECT ID_Number FROM Account WHERE username = '" + session.getAttribute("user") + "'";
        rs = stmt.executeQuery(id_query);
        int IDNumber = -1;
        if (rs.next()) {
            IDNumber = rs.getInt("ID_Number");
        }

        java.sql.Date purchaseDate = java.sql.Date.valueOf("2023-12-17");
        java.sql.Time purchaseTime = java.sql.Time.valueOf("15:30:00");
        java.sql.Date flightDate = java.sql.Date.valueOf("2023-12-19");
        int seatNumber = 1;

            String insertTicketQuery = "INSERT INTO flight_ticket (Total_Fare, Seat_Number, Flight_date, Purchase_date, Purchase_time, Booking_fee, ID_Number, class, change_fee) VALUES (" + fare + "," + seatNumber + ", '" + flightDate + "', '" + purchaseDate + "', '" + purchaseTime + "', 0, " + IDNumber + ", '" + "Economy" + "', 0)";
            stmt.executeUpdate(insertTicketQuery);
            String ticketNumberQuery = "SELECT Ticket_Number FROM flight_ticket WHERE ID_Number = " + IDNumber + " AND Purchase_date = '" + purchaseDate + "' AND Purchase_time = '" + purchaseTime + "'";
            rs = stmt.executeQuery(ticketNumberQuery);

            while (rs.next()) {
                ticketNumber = rs.getInt("Ticket_Number");
            }

            if (ticketNumber != -1) {
                String insertTicketFlightsQuery = "INSERT INTO ticket_flights (Ticket_Number, Flight_Number, Company_ID) VALUES (" + ticketNumber + ", " + flightNumber + ", '" + companyID + "')";
                stmt.executeUpdate(insertTicketFlightsQuery);

                out.println("Reservation for returning flight complete. ");
        } else {
            String insertWaitlistQuery = "INSERT INTO waitlist (ID_Number, Flight_Number, Company_ID) VALUES (" + IDNumber + ", " + flightNumber + ", '" + companyID + "')";
           stmt.executeUpdate(insertWaitlistQuery);
            out.println("Added to waitlist for returning flight. ");
       }
	
	if(request.getParameter("flightNumber_dep") != null && (request.getParameter("companyID_dep") != null)) {
		companyID = request.getParameter("companyID_dep");
        flightNumber = Integer.parseInt(request.getParameter("flightNumber_dep"));
        ticketClass = request.getParameter("ticketClass_dep");
        fare = 20.00;
        priceQuery = "SELECT Price_Economy, Price_Business, Price_First FROM flight WHERE Flight_Number = "+ flightNumber + " AND Company_ID = '" + companyID + "'";
        rs = stmt.executeQuery(priceQuery);
        if (rs.next()) {
            if ("Business".equals(ticketClass)) {
                fare = rs.getDouble("Price_Business");
            } else if ("First".equals(ticketClass)) {
                fare = rs.getDouble("Price_First");
            } else {
                fare = rs.getDouble("Price_Economy");
            }
        }

        id_query = "SELECT ID_Number FROM Account WHERE username = '" + session.getAttribute("user") + "'";
        rs = stmt.executeQuery(id_query);
        IDNumber = -1;
        if (rs.next()) {
            IDNumber = rs.getInt("ID_Number");
        }

        purchaseDate = java.sql.Date.valueOf("2023-12-17");
        purchaseTime = java.sql.Time.valueOf("15:30:00");
        flightDate = java.sql.Date.valueOf("2023-12-19");
        seatNumber = 1;

            insertTicketQuery = "INSERT INTO flight_ticket (Total_Fare, Seat_Number, Flight_date, Purchase_date, Purchase_time, Booking_fee, ID_Number, class, change_fee) VALUES (" + fare + "," + seatNumber + ", '" + flightDate + "', '" + purchaseDate + "', '" + purchaseTime + "', 0, " + IDNumber + ", '" + "Economy" + "', 0)";
            stmt.executeUpdate(insertTicketQuery);
            ticketNumberQuery = "SELECT Ticket_Number FROM flight_ticket WHERE ID_Number = " + IDNumber + " AND Purchase_date = '" + purchaseDate + "' AND Purchase_time = '" + purchaseTime + "'";
            rs = stmt.executeQuery(ticketNumberQuery);

            while (rs.next()) {
                ticketNumber = rs.getInt("Ticket_Number");
            }

            if (ticketNumber != -1) {
                String insertTicketFlightsQuery = "INSERT INTO ticket_flights (Ticket_Number, Flight_Number, Company_ID) VALUES (" + ticketNumber + ", " + flightNumber + ", '" + companyID + "')";
                stmt.executeUpdate(insertTicketFlightsQuery);

                out.println("Reservation for departing flight complete.");
        } else {
            String insertWaitlistQuery = "INSERT INTO waitlist (ID_Number, Flight_Number, Company_ID) VALUES (" + IDNumber + ", " + flightNumber + ", '" + companyID + "')";
           stmt.executeUpdate(insertWaitlistQuery);
            out.println("Added to waitlist for departing flight.");
       }
		
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Reservation Complete!</title>
</head>
<body>
	<div class="container">
		<div class="jumbotron">
			<div class = "row justify-content-center">
				<h1>Reservation Complete!</h1>
			</div>
			
			<div class="row justify-content-center">
				<a href='index.jsp'>Return</a>
			</div>
		</div>
	</div>
    <!-- Output success or failure message here -->
</body>
</html>
