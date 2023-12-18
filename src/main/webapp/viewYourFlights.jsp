<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Your Flights</title>
    <style>
        .center {
            text-align: left;
        }
        .section {
            margin-top: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="center">
        <h1>Your Flight Reservations</h1>
    </div>
	<h2>Cancel a Ticket</h2>
    <form action="cancelTicket.jsp" method="post">
        <label for="ticketNumber">Ticket Number:</label>
        <input type="number" id="ticketNumber" name="ticketNumber" required>
        <input type="submit" value="Cancel Ticket">
    </form>
    <%
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Integer userID = (Integer) session.getAttribute("ID_Number");

        try {
            // Past flight reservations
            out.println("<div class='section'>");
			out.println("<h2 class='center'>Past Flights</h2>");

			String pastFlightsQuery = "SELECT * FROM flight_ticket ft "
                        + "JOIN ticket_flights tf ON ft.Ticket_Number = tf.Ticket_Number "
                        + "WHERE ft.ID_Number = ? AND ft.Flight_date < CURDATE()";
			pstmt = con.prepareStatement(pastFlightsQuery);
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("Ticket Number: " + rs.getInt("Ticket_Number") + ", Flight Number: " + rs.getInt("Flight_Number") + ", Date: " + rs.getDate("Flight_date") + "<br>" + "<td>" + rs.getString("class") + "</td>" + "</tr>");
            }
            rs.close();
            pstmt.close();
            out.println("</div>");

            // Upcoming flight reservations
            out.println("<div class='section'>");
            out.println("<h2 class='center'>Upcoming Flights</h2>");

            String upcomingFlightsQuery = "SELECT * FROM flight_ticket ft JOIN ticket_flights tf ON ft.Ticket_Number = tf.Ticket_Number WHERE ft.ID_Number = ? AND ft.Flight_date >= CURDATE()";
            pstmt = con.prepareStatement(upcomingFlightsQuery);
            pstmt.setInt(1, userID);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                out.println("Ticket Number: " + rs.getInt("Ticket_Number") + ", Flight Number: " + rs.getInt("Flight_Number") + ", Date: " + rs.getDate("Flight_date") + "<br>" + "<td>" + rs.getString("class") + "</td>" +  "</tr>");
            }
            out.println("</div>");
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    %>
</body>
</html>
