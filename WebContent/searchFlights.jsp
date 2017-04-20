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
			<a href="welcome.html">FLY ROYAL <br> AIRLINES
			</a>
		</h1>

		<h3 class="tagline">World-Class Facilities</h3>

		<nav class="nav primary-nav">
			<ul>
          <li><a href="welcome.html">Home</a></li><!--
          --><li><a href="membershipriveleges.html">Membership</a></li><!--
          --><li><a href="frequentflyers.html">Frequent Flyers</a></li><!--
          --><li><a href="searchFlights.html">Search Flights</a></li><!--
          --><li><a href="userSettings.html">Settings</a></li><!--
          --><li><a href='logout.jsp'>Log out</a></li>
        </ul>
		</nav>

	</header>
	
	<section class="row-alt">
	<div class="lead container">
		<h2>Search Flights</h2>
	
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
			boolean user;

			Statement st = con.createStatement();
			String choice = null;
			
			if(returnDate!=""){
				choice="searchReturnFlights.jsp";
				session.setAttribute("returnDate",returnDate);
			} else {
				choice="booking.jsp";
			}

			try 
			{
				ResultSet rs;
				rs = st.executeQuery(query);
				
				if (session == null || session.getAttribute("userid") == null) {
				    user = false;
				} else {
				    user = true;
				}
				
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
							<%if(user==true){ %>
								<td><form action="<%=choice%>">
									<input type="hidden" name="flightID" value="<%=rs.getInt("FlightID")%>">
									<input type="hidden" name="launch" value="<%=rs.getString("launch")%>">
									<input type="hidden" name="destination" value="<%=rs.getString("destination")%>">
									<input type="hidden" name="departDate" value="<%=rs.getDate("departure")%>">
									<input type="hidden" name="departTime" value="<%=rs.getTime("departure")%>">
									<input type="hidden" name="arriveDate" value="<%=rs.getDate("arrive")%>">
									<input type="hidden" name="arriveTime" value="<%=rs.getTime("arrive")%>">
									<input type="hidden" name="rFlightID" value="null">
									<input type="hidden" name="rLaunch" value="null">
									<input type="hidden" name="rDestination" value="null">
									<input type="hidden" name="rDepartDate" value="null">
									<input type="hidden" name="rDepartTime" value="null">
									<input type="hidden" name="rArriveDate" value="null">
									<input type="hidden" name="rArriveTime" value="null">
									<input type="hidden" name="rSeatType" value="null">
									<input type="hidden" name="seatType" value="economy">
									<input class="btn btn-default" type="submit" name="ticketprice"
									value="<%="$" + rs.getInt("economyPrice")%>">
									</form></td>
								<td><form action="<%=choice%>">
									<input type="hidden" name="flightID" value="<%=rs.getInt("FlightID")%>">
									<input type="hidden" name="launch" value="<%=rs.getString("launch")%>">
									<input type="hidden" name="destination" value="<%=rs.getString("destination")%>">
									<input type="hidden" name="departDate" value="<%=rs.getDate("departure")%>">
									<input type="hidden" name="departTime" value="<%=rs.getTime("departure")%>">
									<input type="hidden" name="arriveDate" value="<%=rs.getDate("arrive")%>">
									<input type="hidden" name="arriveTime" value="<%=rs.getTime("arrive")%>">
									<input type="hidden" name="rFlightID" value="null">
									<input type="hidden" name="rLaunch" value="null">
									<input type="hidden" name="rDestination" value="null">
									<input type="hidden" name="rDepartDate" value="null">
									<input type="hidden" name="rDepartTime" value="null">
									<input type="hidden" name="rArriveDate" value="null">
									<input type="hidden" name="rArriveTime" value="null">
									<input type="hidden" name="rSeatType" value="null">
									<input type="hidden" name="rTicketprice" value="null">									
									<input type="hidden" name="seatType" value="business">
									<input class="btn btn-default" type="submit" name="ticketprice"
									value="<%="$" + rs.getInt("businessClassPrice")%>">
									</form></td>
								<td><form action="<%=choice%>">
									<input type="hidden" name="flightID" value="<%=rs.getInt("FlightID")%>">
									<input type="hidden" name="launch" value="<%=rs.getString("launch")%>">
									<input type="hidden" name="destination" value="<%=rs.getString("destination")%>">
									<input type="hidden" name="departDate" value="<%=rs.getDate("departure")%>">
									<input type="hidden" name="departTime" value="<%=rs.getTime("departure")%>">
									<input type="hidden" name="arriveDate" value="<%=rs.getDate("arrive")%>">
									<input type="hidden" name="arriveTime" value="<%=rs.getTime("arrive")%>">
									<input type="hidden" name="rFlightID" value="null">
									<input type="hidden" name="rLaunch" value="null">
									<input type="hidden" name="rDestination" value="null">
									<input type="hidden" name="rDepartDate" value="null">
									<input type="hidden" name="rDepartTime" value="null">
									<input type="hidden" name="rArriveDate" value="null">
									<input type="hidden" name="rArriveTime" value="null">
									<input type="hidden" name="rSeatType" value="null">
									<input type="hidden" name="seatType" value="first">
									<input class="btn btn-default" type="submit" name="ticketprice"
									value="<%="$" + rs.getInt("firstClassPrice")%>">
									</form></td>
							<% } else { %>
								<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
									value="<%="$" + rs.getInt("economyPrice")%>"></form></td>
								<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
									value="<%="$" + rs.getInt("businessClassPrice")%>"></form></td>
								<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
									value="<%="$" + rs.getInt("firstClassPrice")%>"></form></td>
							<%} %>
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
          <li><a href="welcome.html">Home</a></li><!--
          --><li><a href="membershipriveleges.html">Membership</a></li><!--
          --><li><a href="frequentflyers.html">Frequent Flyers</a></li><!--
          --><li><a href="searchFlights.html">Search Flights</a></li><!--
          --><li><a href="userSettings.html">Settings</a></li><!--
          --><li><a href='logout.jsp'>Log out</a></li>
        </ul>
		</nav>

	</footer>
</body>="#">Membership</a></li><!--
          --><li><a href="#">Frequent Flyers</a></li><!--
          --><li><a href="login.html">Login</a></li>
        </ul>
		</nav>

	</footer>
</body>