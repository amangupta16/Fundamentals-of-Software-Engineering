<%@ page import="java.sql.*"%>

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
          <li><a href="index.html">Home</a></li><!--
          --><li><a href="#">Special Offers</a></li><!--
          --><li><a href="#">Membership</a></li><!--
          --><li><a href="#">Frequent Flyers</a></li><!--
          --><li><a href="login.html">Login</a></li>
        </ul>
		</nav>

	</header>
	
	<section class="row-alt">
	<div class="lead container">
	
	<script>
		function success() {
		    alert("Success! Flight has been removed");
		}
		function fail() {
		    alert("Sorry! Flight has been booked, cannot remove");
		}
		function invalid() {
		    alert("Warning! Flight ID is invalid");
		}
	</script>
	
		<%
			
			String planeid = request.getParameter("PlaneID");

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/form";
			String username = "root";
			String password = "root";
			Connection con = DriverManager.getConnection(url, username, password);
			String query = "select * from plane where PlaneID='" + planeid + "'";

			Statement st = con.createStatement();

			try 
			{
				ResultSet rs;
				rs = st.executeQuery(query);
				
				
				if (rs.next()){ //valid plane id
					// seach associate flights
					rs = st.executeQuery("select FlightID from flight where PlaneID='" + planeid + "'");
					boolean check = true;
					String bookedFlight = "";
					
					while(rs.next()){ //the plane has been assigned to a flight
						String flightid = rs.getString("FlightID");
						ResultSet result = st.executeQuery("select * from booking where FlightID='"+ flightid+"'");
						if(result.next()){ //this plane has associated flight that is booked
							check = false;
							bookedFlight = bookedFlight.concat(flightid);
							bookedFlight += " ";
						}						
					}
					if(check){
						rs = st.executeQuery("select FlightID from flight where PlaneID='" + planeid + "'");
						while(rs.next()){
							String flight = rs.getString("FlightID");
							st.executeUpdate("delete from flight where FlightID='" + flight + "'");
						}						
						
						int i = st.executeUpdate("delete from plane where PlaneID='" + planeid + "'");
						if(i > 0){
							out.println("Success! Plane has been removed <a href='removePlane.html'>try again</a>");
						}
					}else{
						out.println("Sorry! Plane has been booked <a href='removePlane.html'>try again</a>");	
					}

				}else{
					out.println("Invalid Plane ID <a href='removePlane.html'>try again</a>");
				}
			}catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
				out.println("Exception <a href='register.html'>TRY AGAIN</a>");
			}
			%>
			
		</div>
	</section>

	
	<footer class="primary-footer container group">

		<small>&copy; FLY ROYAL AIRLINES</small>

		<nav class="nav">
			<ul>
          <li><a href="index.html">Home</a></li><!--
          --><li><a href="#">Special Offers</a></li><!--
          --><li><a href="#">Membership</a></li><!--
          --><li><a href="#">Frequent Flyers</a></li><!--
          --><li><a href="login.html">Login</a></li>
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