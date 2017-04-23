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
		
		<h2>Search Return Flights</h2>

			<%
				
				String cost = request.getParameter("ticketprice");
		        String flightid = request.getParameter("flightID");
		        String destination = request.getParameter("destination");
		        String launch = request.getParameter("launch");
		        String departDate = request.getParameter("departDate");
		        String departTime = request.getParameter("departTime");
		        String arriveDate = request.getParameter("arriveDate");
		        String arriveTime = request.getParameter("arriveTime");
		        String wflightid = request.getParameter("wflightID");
		        String wdestination = request.getParameter("wdestination");
		        String wlaunch = request.getParameter("wlaunch");
		        String wdepartDate = request.getParameter("wdepartDate");
		        String wdepartTime = request.getParameter("wdepartTime");
		        String warriveDate = request.getParameter("warriveDate");
		        String warriveTime = request.getParameter("warriveTime");
		        String seatType = request.getParameter("seatType");
		        String returnDate = session.getAttribute("returnDate").toString();
				boolean flightsFound = false;

				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/form";
				String username = "root";
				String password = "root";
				Connection con = DriverManager.getConnection(url, username, password);
				String query = "select * from flight";
				boolean user;

				Statement st = con.createStatement();
				Statement sr = con.createStatement();
				String choice = "booking.jsp";
				
				try {
					ResultSet rs;
					ResultSet wr;
					rs = st.executeQuery(query);
					wr = sr.executeQuery(query);

					if (session == null || session.getAttribute("userid") == null) {
						user = false;
					} else {
						user = true;
					}

					while (rs.next()) {

						String temp = rs.getTimestamp("departure").toString();
						String dDate = temp.substring(0, 10);

						temp = rs.getTimestamp("arrive").toString();
						String aDate = temp.substring(0, 10);

						if ((rs.getString("launch").equals(destination) || (!wflightid.equals("null") && rs.getString("launch").equals(wdestination))) && dDate.equals(returnDate))
						{
							if (flightsFound == false)
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
					
					if(rs.getString("destination").equals(launch))
					{
				%>
				<tr>
					<td><%=rs.getInt("FlightID")%></td>
					<td><%=rs.getString("launch")%></td>
					<td><%=rs.getString("destination")%></td>
					<td><%=rs.getDate("departure")%></td>
					<td><%=rs.getTime("departure")%></td>
					<td><%=rs.getDate("arrive")%></td>
					<td><%=rs.getTime("arrive")%></td>
					<%
						if (user == true) {
					%>
					<td><form action="<%=choice%>">
							<input type="hidden" name="flightID" value="<%=flightid%>">
					  	    <input type="hidden" name="launch" value="<%=launch%>">
						    <input type="hidden" name="destination" value="<%=destination%>">
						    <input type="hidden" name="departDate" value="<%=departDate%>">
						    <input type="hidden" name="departTime" value="<%=departTime%>">
						    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
						    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
						    <input type="hidden" name="ticketprice" value="<%=cost%>">
						    <input type="hidden" name="seatType" value="<%=seatType%>">
							<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
							<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
							<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
							<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
							<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
							<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
							<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
							<input type="hidden" name="wflightID" value="<%=wflightid%>">
					  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
						    <input type="hidden" name="wdestination" value="<%=wdestination%>">
						    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
						    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
						    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
						    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
							<input type="hidden" name="rwFlightID" value="null">
							<input type="hidden" name="rwLaunch" value="null">
							<input type="hidden" name="rwDestination"	value="null">
							<input type="hidden" name="rwDepartDate" value="null">
							<input type="hidden" name="rwDepartTime" value="null">
							<input type="hidden" name="rwArriveDate" value="null">
							<input type="hidden" name="rwArriveTime" value="null">
							<input type="hidden" name="rSeatType" value="economy">
							<input class="btn btn-default" type="submit" name="rTicketprice"
								value="<%="$" + rs.getInt("economyPrice")%>">
						</form></td>
					<td><form action="<%=choice%>">
							<input type="hidden" name="flightID" value="<%=flightid%>">
					  	    <input type="hidden" name="launch" value="<%=launch%>">
						    <input type="hidden" name="destination" value="<%=destination%>">
						    <input type="hidden" name="departDate" value="<%=departDate%>">
						    <input type="hidden" name="departTime" value="<%=departTime%>">
						    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
						    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
						    <input type="hidden" name="ticketprice" value="<%=cost%>">
						    <input type="hidden" name="seatType" value="<%=seatType%>">
							<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
							<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
							<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
							<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
							<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
							<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
							<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
							<input type="hidden" name="wflightID" value="<%=wflightid%>">
					  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
						    <input type="hidden" name="wdestination" value="<%=wdestination%>">
						    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
						    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
						    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
						    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
							<input type="hidden" name="rwFlightID" value="null">
							<input type="hidden" name="rwLaunch" value="null">
							<input type="hidden" name="rwDestination"	value="null">
							<input type="hidden" name="rwDepartDate" value="null">
							<input type="hidden" name="rwDepartTime" value="null">
							<input type="hidden" name="rwArriveDate" value="null">
							<input type="hidden" name="rwArriveTime" value="null">
							<input type="hidden" name="rSeatType" value="business"> 
							<input class="btn btn-default" type="submit" name="rTicketprice"
								value="<%="$" + rs.getInt("businessClassPrice")%>">
						</form></td>
					<td><form action="<%=choice%>">
							<input type="hidden" name="flightID" value="<%=flightid%>">
					  	    <input type="hidden" name="launch" value="<%=launch%>">
						    <input type="hidden" name="destination" value="<%=destination%>">
						    <input type="hidden" name="departDate" value="<%=departDate%>">
						    <input type="hidden" name="departTime" value="<%=departTime%>">
						    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
						    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
						    <input type="hidden" name="ticketprice" value="<%=cost%>">
						    <input type="hidden" name="seatType" value="<%=seatType%>">
							<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
							<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
							<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
							<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
							<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
							<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
							<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
							<input type="hidden" name="wflightID" value="<%=wflightid%>">
					  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
						    <input type="hidden" name="wdestination" value="<%=wdestination%>">
						    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
						    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
						    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
						    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
							<input type="hidden" name="rwFlightID" value="null">
							<input type="hidden" name="rwLaunch" value="null">
							<input type="hidden" name="rwDestination"	value="null">
							<input type="hidden" name="rwDepartDate" value="null">
							<input type="hidden" name="rwDepartTime" value="null">
							<input type="hidden" name="rwArriveDate" value="null">
							<input type="hidden" name="rwArriveTime" value="null">
							<input type="hidden" name="rSeatType" value="first">
							<input class="btn btn-default" type="submit" name="rTicketprice"
								value="<%="$" + rs.getInt("firstClassPrice")%>">
						</form></td>
					<%
						} else {
					%>
					<td><form action="login.html">
							<input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("economyPrice")%>">
						</form></td>
					<td><form action="login.html">
							<input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("businessClassPrice")%>">
						</form></td>
					<td><form action="login.html">
							<input class="btn btn-default" type="submit" name="submit"
								value="<%="$" + rs.getInt("firstClassPrice")%>">
						</form></td>
					<%
						}
					%>
				</tr>

				<%
					} else {
						while(wr.next()){
							temp = wr.getTimestamp("departure").toString();
							String wdDate = temp.substring(0,10);
							
							temp = wr.getTimestamp("arrive").toString();
							String waDate = temp.substring(0,10);
							
							long j = wr.getTimestamp("departure").getTime()-rs.getTimestamp("arrive").getTime();
							long k = j/(60*60*1000);
							long l = j/(60*1000)%60;
							boolean time = false;
							if((k==6 && l==0) || (k<6 && k>0)){
								time = true;
							}
							//System.out.println(k+","+l+","+rs.getString("FlightID")+","+wr.getString("FlightID")+","+time);
							
							
							if(rs.getString("destination").equals(wr.getString("launch")) && wr.getString("destination").equals(launch) && time)
							{
								//System.out.println("This flight can cause a layover.");
								%>
									<tr>
										<td><%=rs.getInt("FlightID")%><br><%=wr.getInt("FlightID")%></td>
										<td><%=rs.getString("launch")%><br><%=wr.getString("launch")%></td>
										<td><%=rs.getString("destination")%><br><%=wr.getString("destination")%></td>
										<td><%=rs.getDate("departure")%><br><%=wr.getDate("departure")%></td>
										<td><%=rs.getTime("departure")%><br><%=wr.getTime("departure")%></td>
										<td><%=rs.getDate("arrive")%><br><%=wr.getDate("arrive")%></td>
										<td><%=rs.getTime("arrive")%><br><%=wr.getTime("arrive")%></td>
										<%if(user==true){ %>
											<td><form action="<%=choice%>">
												<input type="hidden" name="flightID" value="<%=flightid%>">
										  	    <input type="hidden" name="launch" value="<%=launch%>">
											    <input type="hidden" name="destination" value="<%=destination%>">
											    <input type="hidden" name="departDate" value="<%=departDate%>">
											    <input type="hidden" name="departTime" value="<%=departTime%>">
											    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
											    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
											    <input type="hidden" name="ticketprice" value="<%=cost%>">
											    <input type="hidden" name="seatType" value="<%=seatType%>">
												<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
												<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
												<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
												<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
												<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
												<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
												<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
												<input type="hidden" name="wflightID" value="<%=wflightid%>">
										  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
											    <input type="hidden" name="wdestination" value="<%=wdestination%>">
											    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
											    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
											    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
											    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
												<input type="hidden" name="rwFlightID" value="<%=wr.getInt("FlightID")%>">
												<input type="hidden" name="rwLaunch" value="<%=wr.getString("launch")%>">
												<input type="hidden" name="rwDestination"	value="<%=wr.getString("destination")%>">
												<input type="hidden" name="rwDepartDate" value="<%=wr.getDate("departure")%>">
												<input type="hidden" name="rwDepartTime" value="<%=wr.getTime("departure")%>">
												<input type="hidden" name="rwArriveDate" value="<%=wr.getDate("arrive")%>">
												<input type="hidden" name="rwArriveTime" value="<%=wr.getTime("arrive")%>">
												<input type="hidden" name="rSeatType" value="economy">
												<input class="btn btn-default" type="submit" name="rTicketprice"
												value="<%="$" + (rs.getInt("economyPrice")+wr.getInt("economyPrice"))%>">
												</form></td>
											<td><form action="<%=choice%>">
												<input type="hidden" name="flightID" value="<%=flightid%>">
										  	    <input type="hidden" name="launch" value="<%=launch%>">
											    <input type="hidden" name="destination" value="<%=destination%>">
											    <input type="hidden" name="departDate" value="<%=departDate%>">
											    <input type="hidden" name="departTime" value="<%=departTime%>">
											    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
											    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
											    <input type="hidden" name="ticketprice" value="<%=cost%>">
											    <input type="hidden" name="seatType" value="<%=seatType%>">
												<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
												<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
												<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
												<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
												<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
												<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
												<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
												<input type="hidden" name="wflightID" value="<%=wflightid%>">
										  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
											    <input type="hidden" name="wdestination" value="<%=wdestination%>">
											    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
											    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
											    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
											    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
												<input type="hidden" name="rwFlightID" value="<%=wr.getInt("FlightID")%>">
												<input type="hidden" name="rwLaunch" value="<%=wr.getString("launch")%>">
												<input type="hidden" name="rwDestination"	value="<%=wr.getString("destination")%>">
												<input type="hidden" name="rwDepartDate" value="<%=wr.getDate("departure")%>">
												<input type="hidden" name="rwDepartTime" value="<%=wr.getTime("departure")%>">
												<input type="hidden" name="rwArriveDate" value="<%=wr.getDate("arrive")%>">
												<input type="hidden" name="rwArriveTime" value="<%=wr.getTime("arrive")%>">									
												<input type="hidden" name="rSeatType" value="business">
												<input class="btn btn-default" type="submit" name="rTicketprice"
												value="<%="$" + (rs.getInt("businessClassPrice")+wr.getInt("businessClassPrice"))%>">
												</form></td>
											<td><form action="<%=choice%>">
												<input type="hidden" name="flightID" value="<%=flightid%>">
										  	    <input type="hidden" name="launch" value="<%=launch%>">
											    <input type="hidden" name="destination" value="<%=destination%>">
											    <input type="hidden" name="departDate" value="<%=departDate%>">
											    <input type="hidden" name="departTime" value="<%=departTime%>">
											    <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
											    <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
											    <input type="hidden" name="ticketprice" value="<%=cost%>">
											    <input type="hidden" name="seatType" value="<%=seatType%>">
												<input type="hidden" name="rFlightID" value="<%=rs.getInt("FlightID")%>">
												<input type="hidden" name="rLaunch" value="<%=rs.getString("launch")%>">
												<input type="hidden" name="rDestination"	value="<%=rs.getString("destination")%>">
												<input type="hidden" name="rDepartDate" value="<%=rs.getDate("departure")%>">
												<input type="hidden" name="rDepartTime" value="<%=rs.getTime("departure")%>">
												<input type="hidden" name="rArriveDate" value="<%=rs.getDate("arrive")%>">
												<input type="hidden" name="rArriveTime" value="<%=rs.getTime("arrive")%>">
												<input type="hidden" name="wflightID" value="<%=wflightid%>">
										  	    <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
											    <input type="hidden" name="wdestination" value="<%=wdestination%>">
											    <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
											    <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
											    <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
											    <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
												<input type="hidden" name="rwFlightID" value="<%=wr.getInt("FlightID")%>">
												<input type="hidden" name="rwLaunch" value="<%=wr.getString("launch")%>">
												<input type="hidden" name="rwDestination"	value="<%=wr.getString("destination")%>">
												<input type="hidden" name="rwDepartDate" value="<%=wr.getDate("departure")%>">
												<input type="hidden" name="rwDepartTime" value="<%=wr.getTime("departure")%>">
												<input type="hidden" name="rwArriveDate" value="<%=wr.getDate("arrive")%>">
												<input type="hidden" name="rwArriveTime" value="<%=wr.getTime("arrive")%>">
												<input type="hidden" name="rSeatType" value="first">
												<input class="btn btn-default" type="submit" name="rTicketprice"
												value="<%="$" + (rs.getInt("firstClassPrice")+wr.getInt("firstClassPrice"))%>">
												</form></td>
										<% } else { %>
											<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
												value="<%="$" + (rs.getInt("economyPrice")+wr.getInt("economyPrice"))%>"></form></td>
											<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
												value="<%="$" + (rs.getInt("businessClassPrice")+wr.getInt("businessClassPrice"))%>"></form></td>
											<td><form action="login.html"><input class="btn btn-default" type="submit" name="submit"
												value="<%="$" + (rs.getInt("firstClassPrice")+wr.getInt("firstClassPrice"))%>"></form></td>
										<%} %>
									</tr>
			
								<%
							}
							}
						}
					flightsFound = true;

							}
						}
				%>

			</table>

			<h1>

				<%
					if (flightsFound == false) {
							out.println("No flights were found: <a href='searchFlights.html'>TRY AGAIN</a>" + returnDate);
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
</body>