<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<title>Search</title>
</head>
<body>
	<%
	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
	}
	%>
	
	<div class="container">
			<div class="jumbotron">
				<div class = "row justify-content-center">
					<h1>Find Flights</h1>
				</div>
				
				
				<form style="border: 1px solid; padding: 10px;" action = "search.jsp" method = "GET" class="justify-content-center">
					<h2>Filters</h2>
					From airport <input type = "text" name = "from"> to airport <input type = "text" name = "to">  <br/>  <br/> 
				
					Price below <input type = "number" name = "price_below"> and above <input type = "number" name = "price_above"> ($) for class: <select name="class">
						<option value="Economy">Economy</option>
						<option value="Business">Business</option>
						<option value="First">First</option>
					</select> <br/>  <br/>  
					
					Departure time after <input type = "time" name = "depart_time_after"> and before <input type = "time" name = "depart_time_before"> (hh:mm:ss) <br/> <br/> 
					Arrival time after <input type = "time" name = "arrival_time_after"> and before <input type = "time" name = "arrival_time_before"> (hh:mm:ss) <br/> <br/> 
					
					<h5>Departs On:</h5>
					
					<input type = "checkbox" name = "sun"  /> Sunday <br/> 
					<input type = "checkbox" name = "mon"  /> Monday <br/> 
					<input type = "checkbox" name = "tue"  /> Tuesday <br/> 
					<input type = "checkbox" name = "wed"  /> Wednesday <br/> 
					<input type = "checkbox" name = "thu"  /> Thursday <br/> 
					<input type = "checkbox" name = "fri"  /> Friday <br/> 
					<input type = "checkbox" name = "sat"  /> Saturday <br/> 
					<br/>
					
					
					<h5>Sort By:</h5>
					
					<select name="sort">
						<option value="price">Price</option>
						<option value="takeoff">Departure Time</option>
						<option value="land">Arrival Time</option>
						<option value="time">Flight Time</option>
					</select> <br/>  
					
					<select name="sort_type">
						<option value="asc">Ascending</option>
						<option value="desc">Descending</option>
					</select> <br/>  
					
					<br/> 
					<input class="btn-success" type = "submit" value = "Search" />
			     </form>
				
				<br/>
				
				<div class="row justify-content-center">
				<h2>Search Results</h2>
				
					<table border="1" id=flights>
					<tr>
					<td>Airline</td>
					<td>Flight#</td>
					<td>Weekday</td>
					<td>Departure</td>
					<td>Arrival</td>
					<td>Type</td>
					<td>From</td>
					<td>To</td>
					<td>On</td>
					<% if (request.getParameter("class") != null) {%>
						<%  if (request.getParameter("class").equals("Business")) { %>
							<td>Price ($) (Business)</td>
						<% } else if (request.getParameter("class").equals("First")) { %>
							<td>Price ($) (First)</td>
						<% } else { %>
							<td>Price ($) (Economy)</td>
						<% }
						} else {%>
							<td>Price ($) (Economy)</td>
						<% } %>
					
					</tr>
				
					<%
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();	
					Statement st = con.createStatement();
					ResultSet rs;
					String query = "select * from flight where 1=1";
					
					if (request.getParameter("class") != null) {
						if(!request.getParameter("from").equals("")) {
							query = query + " and From_Airport_ID = '" + request.getParameter("from") + "'";
						}
						
						if(!request.getParameter("to").equals("")) {
							query = query + " and To_Airport_ID = '" + request.getParameter("to") + "'";
						}
						
						if(!request.getParameter("price_below").equals("")) {
							if(request.getParameter("class").equals("Business")) {
								query = query + " and Price_Business <= " + request.getParameter("price_below");
							} else if(request.getParameter("class").equals("First")) {
								query = query + " and Price_First <= " + request.getParameter("price_below");
							} else {
								query = query + " and Price_Economy <= " + request.getParameter("price_below");
							}
						}
						
						if(!request.getParameter("price_above").equals("")) {
							if(request.getParameter("class").equals("Business")) {
								query = query + " and Price_Business >= " + request.getParameter("price_above");
							} else if(request.getParameter("class").equals("First")) {
								query = query + " and Price_First >= " + request.getParameter("price_above");
							} else {
								query = query + " and Price_Economy >= " + request.getParameter("price_above");
							}
						}
						
						if(!request.getParameter("depart_time_before").equals("")) {
							query = query + " and departure_time <= '" + request.getParameter("depart_time_before") + "'";
						}
						
						if(!request.getParameter("depart_time_after").equals("")) {
							query = query + " and departure_time >= '" + request.getParameter("depart_time_after") + "'";
						}
						
						if(!request.getParameter("arrival_time_before").equals("")) {
							query = query + " and arrival_time <= '" + request.getParameter("arrival_time_before") + "'";
						}
						
						if(!request.getParameter("arrival_time_after").equals("")) {
							query = query + " and arrival_time >= '" + request.getParameter("arrival_time_after") + "'";
						}
						
						boolean sun = request.getParameter("sun")!=null && request.getParameter("sun").equals("on");
						boolean mon = request.getParameter("mon")!=null && request.getParameter("mon").equals("on");
						boolean tue = request.getParameter("tue")!=null && request.getParameter("tue").equals("on");
						boolean wed = request.getParameter("wed")!=null && request.getParameter("wed").equals("on");
						boolean thu = request.getParameter("thu")!=null && request.getParameter("thu").equals("on");
						boolean fri = request.getParameter("fri")!=null && request.getParameter("fri").equals("on");
						boolean sat = request.getParameter("sat")!=null && request.getParameter("sat").equals("on");
						
						if(sun || mon || tue || wed || thu || fri || sat) {
							query = query + " and weekday in (";
							
							if(sun) { query = query + "'sun', "; }
							if(mon) { query = query + "'mon', "; }
							if(tue) { query = query + "'tue', "; }
							if(wed) { query = query + "'wed', "; }
							if(thu) { query = query + "'thu', "; }
							if(fri) { query = query + "'fri', "; }
							if(sat) { query = query + "'sat', "; }
							
							query = query.substring(0, query.length() - 2);
							
							query = query + ")";
						}
						
						if(request.getParameter("sort")!=null) {
							if(request.getParameter("sort").equals("price")) {
								if(request.getParameter("class").equals("Business")) {
									query = query + " order by Price_Business";
								} else if(request.getParameter("class").equals("First")) {
									query = query + " order by Price_First";
								} else {
									query = query + " order by Price_Economy";
								}
							} else if(request.getParameter("sort").equals("takeoff")) {
								query = query + " order by departure_time";
							} else if(request.getParameter("sort").equals("land")) {
								query = query + " order by arrival_time";
							} else if(request.getParameter("sort").equals("time")) {
								query = query + " order by arrival_time - departure_time";
							} else {
								query = query + "order by Price_Economy";
							}
						}
						
						if(request.getParameter("sort_type")!=null) {
							if(request.getParameter("sort_type").equals("asc")) {
								query = query + " asc";
							}
							else {
								query = query + " desc";
							}
						}
						
					}
					
					rs = st.executeQuery(query);
					while(rs.next()) {
					%>
						<tr>
						<td><%=rs.getString("Company_ID") %></td>
						<td><%=rs.getInt("Flight_Number") %></td>
						<td><%=rs.getString("weekday") %></td>
						<td><%=rs.getTime("departure_time") %></td>
						<td><%=rs.getTime("arrival_time") %></td>
						<td><%=rs.getString("Flight_type") %></td>
						<td><%=rs.getString("From_Airport_ID") %></td>
						<td><%=rs.getString("To_Airport_ID") %></td>
						<td><%=rs.getString("Aircraft_ID") %></td>
						
						<% if (request.getParameter("class") != null) {%>
							<% if (request.getParameter("class").equals("Business")) { %>
								<td><%=rs.getInt("Price_Business") %></td>
							<% } else if (request.getParameter("class").equals("First")) { %>
								<td><%=rs.getInt("Price_First") %></td>
							<% } else { %>
								<td><%=rs.getInt("Price_Economy") %></td>
							<% }
						} else {%>
							<td><%=rs.getInt("Price_Economy") %></td>
						<% } %>
						</tr> <% 
					} 
					con.close(); %>
				
					</table>
				</div>
				
				<br>
				
				<div class="row justify-content-center">
					<a href='index.jsp'>Return</a>
				</div>
			</div>
		</div>
	
</body>
</html>