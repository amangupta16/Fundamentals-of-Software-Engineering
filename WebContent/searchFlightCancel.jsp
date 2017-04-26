<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="javax.activation.*"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Transport"%>



<head>
<meta charset="utf-8">
<title>Search Flights</title>
<link rel="stylesheet" href="assets/stylesheets/main.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Lato:100,300,400">
</head>


<body>
	<style>
table {
	border-collapse: collapse;
	border-spacing: 2px;
	width: 100%;
}

th, td {
	font-size: 90%;
	text-align: center;
	padding: 6px;
}
</style>

	<!-- Header -->

	<header class="primary-header container group">

		<h1 class="logo">
			<a href="managerWelcome.html">FLY ROYAL <br> AIRLINES
			</a>
		</h1>

		<h3 class="tagline">World-Class Facilities</h3>

		<nav class="nav primary-nav">
			<ul>
          <li><a href="managerWelcome.html">Home</a></li><!--
          --><li><a href="cancelTicketSearch.html">Cancel Ticket</a></li><!--
          --><li><a href="#">Book Ticket</a></li><!--
          --><li><a href="searchFlightManager.html">Check in</a></li><!--
          --><li><a href="managerSettings.html">Settings</a></li><!--
          --><li><a href='logout.jsp'>Log out</a></li>
        </ul>
		</nav>

	</header>
	
	<section class="row-alt">
	<div class="lead container">
	
		<%
			String fnumber = request.getParameter("fnumber");
			

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/form";
			String username = "root";
			String password = "root";
			Connection con = DriverManager.getConnection(url, username, password);
			String query = "select * from booking where FlightID = '"+fnumber+"'";

			Statement st = con.createStatement();

			try 
			{
				ResultSet rs;
				rs = st.executeQuery(query);
				
				
				
				while (rs.next()) 
				{

					
					String passName = rs.getString("passName");
					String passAge = rs.getString("passAge");
					String passGender = rs.getString("passGender");			
					String bookingID = rs.getString("bookingID");
					String seatType = rs.getString("seatType");
					String FlightID = rs.getString("FlightID");

					
	
						
		%>
							<table class="table">
							<tr>
								<th>Booking ID</th>
								<th>Flight ID</th>
								<th>Seat Type</th>
								<th>Passenger Name</th>
								<th>Passenger Age</th>
								<th>Passenger Gender</th>
							</tr>

						<tr>
							<td><%=rs.getInt("bookingID")%></td>
							<td><%=rs.getString("FlightID")%></td>
							<td><%=rs.getString("seatType")%></td>
							<td><%=rs.getString("passName")%></td>
							<td><%=rs.getString("passAge")%></td>
							<td><%=rs.getString("passGender")%></td>
							<td><form action="cancellationcomplete.jsp"><input type="hidden" name="FlightID" value="<%=rs.getInt("FlightID")%>">
							<input type="hidden" name="bookingID" value="<%=rs.getString("bookingID")%>">
							<input type="hidden" name="passName" value="<%=rs.getString("passName")%>">
							<input class="btn btn-default" type="submit" name="checkin"
									value="Cancel Ticket"></form></td>
							
						</tr>
						
			
			
			</table>
			
			<%
						

					}

				}
			catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				out.println("This username, email, or password is already taken <a href='register.html'>TRY AGAIN</a>");
			}
			%>
			
			<h1>
			
		

				<!-- Lead -->
			</h1>

		</div>
	</section>



	<footer class="primary-footer container group">

		<small>&copy; FLY ROYAL AIRLINES</small>

		<nav class="nav">
			<ul>
          <li><a href='logout.jsp'>Log out</a></li>
		</nav>

	</footer>
</body>