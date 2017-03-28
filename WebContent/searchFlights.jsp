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
				<li><a href="index.html">Home</a></li>
				<!--
          -->
				<li><a href="#">Cancel Ticket</a></li>
				<!--
          -->
				<li><a href="#">Book Ticket</a></li>
				<!--
          -->
				<li><a href="#">Check in</a></li>
				<!--
          -->
				<li><a href="managerSettings.html">Settings</a></li>
			</ul>
		</nav>

	</header>
	
	<section class="row-alt">
	<div class="lead container">
	
		<%
			String from = request.getParameter("from");
			String destination = request.getParameter("destination");
			String departureDate = request.getParameter("departureDate");
			String returnDate = request.getParameter("returnDate");

			boolean flightsFound = false;

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/form";
			String username = "root";
			String password = "root";
			Connection con = DriverManager.getConnection(url, username, password);
			String query = "select * from flight";

			Statement st = con.createStatement();

			try 
			{
				ResultSet rs;
				rs = st.executeQuery(query);
				
				while (rs.next()) 
				{

					String temp = rs.getTimestamp("departure").toString();
					String dDate = temp.substring(0, 10);

					temp = rs.getTimestamp("arrive").toString();
					String aDate = temp.substring(0, 10);

					if (rs.getString("launch").equals(from) && rs.getString("destination").equals(destination) && dDate.equals(departureDate)) 
					{
						if(flightsFound==false)
						{
		%>
							<table class="table">
							<tr>
								<th>FlightID</th>
								<th>From</th>
								<th>To</th>
								<th>Departure Date</th>
								<th>Departure Time</th>
								<th>Arrival Date</th>
								<th>Arrival Time</th>
								<th>Economy</th>
								<th>Business</th>
								<th>First Class</th>
							</tr>
			<%
						}
			%>
						<tr>
							<td><%=rs.getInt("FlightID")%></td>
							<td><%=rs.getString("launch")%></td>
							<td><%=rs.getString("destination")%></td>
							<td><%=rs.getDate("departure")%></td>
							<td><%=rs.getTime("departure")%></td>
							<td><%=rs.getDate("arrive")%></td>
							<td><%=rs.getTime("arrive")%></td>
							<td><input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("economyPrice")%>"></td>
							<td><input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("businessClassPrice")%>"></td>
							<td><input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("firstClassPrice")%>"></td>
						</tr>

			<%
						flightsFound = true;

					}

				}
			%>
			
			</table>
			
			<h1>

			<%
				if (flightsFound == false) 
				{
					out.println("No flights were found: <a href='searchFlights.html'>TRY AGAIN</a>");
				}
				} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					out.println("This username, email, or password is already taken <a href='register.html'>TRY AGAIN</a>");
				}
			%>
				<!-- Lead -->
			</h1>

		</div>
	</section>



	<footer class="primary-footer container group">

		<small>&copy; FLY ROYAL AIRLINES</small>

		<nav class="nav">
			<ul>
				<li><a href="speakers.html">Speakers</a></li>
				<!--
          -->
				<li><a href="schedule.html">Schedule</a></li>
				<!--
          -->
				<li><a href="venue.html">Venue</a></li>
				<!--
          -->
				<li><a href="register.html">Register</a></li>
			</ul>
		</nav>

	</footer>
</body>