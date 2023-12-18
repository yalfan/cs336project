<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    PreparedStatement pstmt = null;
    int ticketNumber = Integer.parseInt(request.getParameter("ticketNumber"));

    try {
        // Begin transaction
        con.setAutoCommit(false);

        // Check the class of the ticket
        String classQuery = "SELECT class FROM flight_ticket WHERE Ticket_Number = ?";
        pstmt = con.prepareStatement(classQuery);
        pstmt.setInt(1, ticketNumber);
        ResultSet rs = pstmt.executeQuery();

        String ticketClass = null;
        if (rs.next()) {
            ticketClass = rs.getString("class");
        }
        rs.close();
        pstmt.close();

        // Cancel the ticket if it's Business or First class
        if ("Business".equals(ticketClass) || "First".equals(ticketClass)) {
            String deleteQuery = "DELETE FROM flight_ticket WHERE Ticket_Number = ?";
            pstmt = con.prepareStatement(deleteQuery);
            pstmt.setInt(1, ticketNumber);
            pstmt.executeUpdate();
            pstmt.close();

            // Commit transaction
            con.commit();
            out.println("Ticket cancelled successfully.");
        } else {
            out.println("Ticket can only be cancelled if it is Business or First class.");
        }
    } catch (Exception e) {
        // Rollback transaction if exception occurs
        if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        out.println("An error occurred: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (con != null) try { con.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Cancellation Complete</title>
</head>
<body>
    <!-- Output success or failure message here -->
</body>
</html>
