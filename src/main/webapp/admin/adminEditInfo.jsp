<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="styles.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
				<h1>Add, Edit information or Delete a customer representative or customer</h1>
				<br></br>
				
				<h2>Add customer / rep</h2>
				<form action="adminEditInfo.jsp">
					<input type="text" name="addCustomerFirstName" placeholder="First Name">
					<input type="text" name="addCustomerLastName" placeholder="Last Name">
					<input type="text" name="addCustomerUsername" placeholder="Username">
					<input type="text" name="addCustomerPassword" placeholder="Password">
					<input type="checkbox" name="addCustomerRep" value="addCustomerRep"> Add as customer rep<br>
					<button type="submit" class="btn btn-primary">Add</button>
				</form>

				<%
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					Statement st = con.createStatement();
					ResultSet rs;

					out.println("<table class=\"table table-striped\" border=\"1\">");
					out.println("<tr><th>Username</th><th>First Name</th><th>Last Name</th><th>Account Type</th></tr>");


					String query = "SELECT username, first_name, last_name, account_type From Account where account_type = 'customer' OR account_type = 'customer_rep'";
					rs = st.executeQuery(query);
					while (rs.next()) {
						out.println("<tr>");
						out.println("<td>" + rs.getString("username") + "</td>");
						out.println("<td>" + rs.getString("first_name") + "</td>");
						out.println("<td>" + rs.getString("last_name") + "</td>");
						out.println("<td>" + rs.getString("account_type") + "</td>");
						out.println("</tr>");
					}


				%>
				<h2>Edit customer / rep</h2>
				<form action="adminEditInfo.jsp">
				<input type="text" name="editCustomerUsername" placeholder="Username">
				<input type="text" name="editCustomerFirstName" placeholder="First Name">
				<input type="text" name="editCustomerLastName" placeholder="Last Name">
				<br></br>
				<input type="text" name="editCustomerNewUsername" placeholder="New Username">
				<input type="text" name="editCustomerNewFirstName" placeholder="New First Name">
				<input type="text" name="editCustomerNewLastName" placeholder="New Last Name">
				<br></br>


					<button type="submit" class="btn btn-primary">Edit</button> 
				</form>

				<h2>Delete customer / rep</h2>
				<form action="adminEditInfo.jsp">
				<input type="text" name="deleteCustomerUsername" placeholder="Username">
				<input type="text" name="deleteCustomerFirstName" placeholder="First Name">
				<input type="text" name="deleteCustomerLastName" placeholder="Last Name">
				<button type="submit" class="btn btn-primary">Delete</button> 

				<br></br>

				<% 

					String customerFirstName = request.getParameter("addCustomerFirstName");
					String customerLastName = request.getParameter("addCustomerLastName");
					String customerUsername = request.getParameter("addCustomerUsername");
					String customerPassword = request.getParameter("addCustomerPassword");
					if (customerFirstName != null && customerLastName != null && customerUsername != null && customerPassword != null) {
						if (request.getParameter("addCustomerRep") != null)
							st.executeUpdate("INSERT INTO Account (username, password, first_name, last_name, account_type) VALUES ('" + customerUsername + "', '" + customerPassword + "', '" + customerFirstName + "', '" + customerLastName + "'" + ", 'customer_rep')");
						else
							st.executeUpdate("INSERT INTO Account (username, password, first_name, last_name, account_type) VALUES ('" + customerUsername + "', '" + customerPassword + "', '" + customerFirstName + "', '" + customerLastName + "'" + ", 'customer')");

					}

					String editCustomerUsername = request.getParameter("editCustomerUsername");
					String editCustomerFirstName = request.getParameter("editCustomerFirstName");
					String editCustomerLastName = request.getParameter("editCustomerLastName");
					String editCustomerNewUsername = request.getParameter("editCustomerNewUsername");
					String editCustomerNewFirstName = request.getParameter("editCustomerNewFirstName");
					String editCustomerNewLastName = request.getParameter("editCustomerNewLastName");

					if (editCustomerUsername != null && editCustomerFirstName != null && editCustomerLastName != null && editCustomerNewUsername != null && editCustomerNewFirstName != null && editCustomerNewLastName != null) {
						st.executeUpdate("UPDATE Account SET username = '" + editCustomerNewUsername + "', first_name = '" + editCustomerNewFirstName + "', last_name = '" + editCustomerNewLastName + "' WHERE username = '" + editCustomerUsername + "' AND first_name = '" + editCustomerFirstName + "' AND last_name = '" + editCustomerLastName + "'");
					}

				String deleteCustomerUsername = request.getParameter("deleteCustomerUsername");
				String deleteCustomerFirstName = request.getParameter("deleteCustomerFirstName");
				String deleteCustomerLastName = request.getParameter("deleteCustomerLastName");

				if (deleteCustomerUsername != null && deleteCustomerFirstName != null && deleteCustomerLastName != null) {
					st.executeUpdate("DELETE FROM Account WHERE username = '" + deleteCustomerUsername + "' AND first_name = '" + deleteCustomerFirstName + "' AND last_name = '" + deleteCustomerLastName + "'");
				}

				%>
				
				
			</div>
			
		</div>
		


	</body>
</html>