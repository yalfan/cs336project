<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registering...</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at register.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		
		String getUsernames = "SELECT * FROM account WHERE username='" + username + "'";
		Statement usernameStmt = con.prepareStatement(getUsernames);

		ResultSet result = stmt.executeQuery(getUsernames);
		if (result.next()) {
			session.setAttribute("error", "Username already exists!");
			response.sendRedirect("register.jsp");
			return;
		}

		//Make an insert statement for the account table:
		String insert = "INSERT INTO account(username, password, first_name, last_name)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, firstName);
		ps.setString(4, lastName);
		ps.executeUpdate();
		
		ResultSet generatedKeys = ps.getGeneratedKeys();
	
		if (generatedKeys.next()) {  
			session.setAttribute("user_id", generatedKeys.getInt(1));
		} 
		
		session.setAttribute("user", username);
		session.setAttribute("account_type", "customer");
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		response.sendRedirect("index.jsp");
	} catch (Exception ex) {
		session.setAttribute("error", "An error occured!" + ex.toString());
		response.sendRedirect("register.jsp");
	}
	%>
	</body>
</html>