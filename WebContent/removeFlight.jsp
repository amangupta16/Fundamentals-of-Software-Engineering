<%@ page import="java.sql.*"%>

<head>
<meta charset="utf-8">
<title>Update Flight</title>
<link rel="stylesheet" href="assets/stylesheets/main.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Lato:100,300,400">
	<style>		
		/* The container <div> - needed to position the dropdown content */
		.flight {
		    position: relative;
		    display: inline-block;
		}
		
		/* Dropdown Content (Hidden by Default) */
		.flight-content {
		    display: none;
		    position: absolute;
		    background-color: #f9f9f9;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}
		
		/* Links inside the dropdown */
		.flight-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		/* Change color of dropdown links on hover */
		.flight-content a:hover {background-color: #f1f1f1}
		
		/* Show the dropdown menu on hover */
		.flight:hover .flight-content {
		    display: block;
		}
		
		.plane {
		    position: relative;
		    display: inline-block;
		}
		
		/* Dropdown Content (Hidden by Default) */
		.plane-content {
		    display: none;
		    position: absolute;
		    background-color: #f9f9f9;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}
		
		/* Links inside the dropdown */
		.plane-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		/* Change color of dropdown links on hover */
		.plane-content a:hover {background-color: #f1f1f1}
		
		/* Show the dropdown menu on hover */
		.plane:hover .plane-content {
		    display: block;
		}
	</style>
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
        <a href="adminWelcome.html">FLY ROYAL <br> AIRLINES</a>
      </h1>

      <h3 class="tagline">World-Class Facilities</h3>

      <nav class="nav primary-nav">
        <ul>
          <li><a href="adminWelcome.html">Home</a></li><!--
          --><li><a href="addmanager.html">Add Manager</a></li><!--
          --><div class="flight">
  				<li class="flightbtn">Flights</li>
 				<div class="flight-content">
    				<a href="addFlight.html">Add Flight</a>
    				<a href="removeFlight.html">Remove Flight</a>
    				<a href="updateFlight.html">Update Flight</a>
  				</div>
			</div><!--
          --><div class="plane">
  				<li class="planebtn">Planes</li>
 				<div class="plane-content">
    				<a href="addPlane.html">Add Plane</a>
    				<a href="removePlane.html">Remove Plane</a>
    				<a href="updatePlane.html">Update Plane</a>
  				</div>
			</div><!--
		  --><li><a href="adminSettings.html">Settings</a></li><!--
          --><li><a href='logout.jsp'>Log out</a></li>
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
			
			String flightid = request.getParameter("flightID");

			boolean flightsFound = false;

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/form";
			String username = "root";
			String password = "root";
			Connection con = DriverManager.getConnection(url, username, password);
			String query = "select * from flight where FlightID='" + flightid + "'";
			boolean user;

			Statement st = con.createStatement();

			try 
			{
				ResultSet rs;
				rs = st.executeQuery(query);
				
				
				if (rs.next()){ //valid flight id
					rs = st.executeQuery("select * from booking where FlightID='" + flightid + "'");
					
					if(rs.next()){ //flight has been booked
						//alert("Sorry! Flight has been booked, cannot remove");
						out.println("Sorry! Flight has been booked, cannot remove <a href='removeFlight.html'>try again</a>");
						
					}else{ //flight has not been booked
						int i = st.executeUpdate("delete from flight where FlightID='" + flightid + "'");
						if(i > 0){
							//alert("Success! Flight has been removed");
							out.println("Success! Flight has been removed <a href='removeFlight.html'>try again</a>");
						}
					}

				}else{
					//alert("Warning! Flight ID is invalid");
					out.println("Invalid flight ID <a href='removeFlight.html'>try again</a>");
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
</body>