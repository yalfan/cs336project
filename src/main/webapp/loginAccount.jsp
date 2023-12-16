<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logging in...</title>
</head>
<body>
	<%
	String username = request.getParameter("username");
	String pwd = request.getParameter("password");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from account where username='" + username + "' and password='" + pwd
	+ "'");
	if (rs.next()) {
		session.setAttribute("user", username); // the username will be stored in the session
		session.setAttribute("user_id", rs.getInt("ID_Number"));
		session.setAttribute("account_type", rs.getString("account_type"));
		con.close();
		response.sendRedirect("index.jsp");
	} else {
		session.setAttribute("error", "Invalid username or password! If you don't have an account, you can register <a href='register.jsp'>here</a>");
		con.close();
		response.sendRedirect("login.jsp");
	}
	%>
	

</body>
</html>