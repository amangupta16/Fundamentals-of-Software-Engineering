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
<title>Flight Maps</title>
<link rel="stylesheet" href="assets/stylesheets/main.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Lato:100,300,400">
	
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
#map {
        height: 70%;
        
      }
      /* Optional: Makes the sample page fill the window. */
  
</style>
</head>

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

<body>
	<section class="row-alt">
	<div class="lead container">
	<h2>FLight Maps</h2>
		<input class="btn btn-default" type="submit" onclick = "goBack()" value="Go Back">
										
		<%
			String start = request.getParameter("launch");
			String end = request.getParameter("destination");
			float startLat=0;
			float startLon=0;
			float endLat=0;
			float endLon=0;

			boolean flightsFound = false;

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/form";
			String username = "root";
			String password = "root";
			Connection con = DriverManager.getConnection(url, username, password);
			String query = "select * from airports";
			boolean user;

			Statement st = con.createStatement();
			Statement sr = con.createStatement();


			try 
			{
				ResultSet rs;
				ResultSet wr;
				rs = st.executeQuery(query);
				wr = sr.executeQuery(query);
				
				while (rs.next()) 
				{
					if (rs.getString("airport").equals(start))
					{
						startLat = rs.getFloat("latitude");
						startLon = rs.getFloat("longitude");
					}
					
					if (rs.getString("airport").equals(end))
					{
						endLat = rs.getFloat("latitude");
						endLon = rs.getFloat("longitude");
					}
				}
				
				
			} catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e) {
					out.println("This username, email, or password is already taken <a href='register.html'>TRY AGAIN</a>");
			}
			
			
		%>
		
		<script>
			function goBack() {
		    window.history.back();
			}
		</script>	
			
		<div id="map"></div>
		<script>
		      function initMap() {
		        
		    	var startLocation = {lat: <%=startLat%>, lng: -<%=startLon%>};
		        var endLocation = {lat: <%=endLat%>, lng: -<%=endLon%>};
		        
		        
		        var map = new google.maps.Map(document.getElementById('map'), {
		          zoom: 4,
		          center: startLocation
		        });
		
		        var startMarker = new google.maps.Marker({
		          position: startLocation,
		          map: map,
		          title: 'Click to zoom'
		        });
		
		        var endMarker = new google.maps.Marker({
		            position: endLocation,
		            map: map,
		            title: 'Click to zoom'
		          });
		        
		        var markers = [];
		        markers[0] = startMarker;
		        markers[1] = endMarker;
		        var bounds = new google.maps.LatLngBounds();
		        for (var i = 0; i < markers.length; i++) {
		         bounds.extend(markers[i].getPosition());
		        }
		        map.fitBounds(bounds);
		        
		        var line = new google.maps.Polyline({
		            path: [new google.maps.LatLng(<%=startLat%>, -<%=startLon%>), new google.maps.LatLng(<%=endLat%>, -<%=endLon%>)],
		            strokeColor: "#FF0000",
		            strokeOpacity: 1.0,
		            strokeWeight: 10,
		            geodesic: true,
		            map: map
		        });
		        	        
		        
		        startMarker.addListener('click', function() {
		          map.setZoom(8);
		          map.setCenter(startMarker.getPosition());
		        });
		        
		        startMarker.addListener('mouseover', function() {
		        	var infowindow = new google.maps.InfoWindow({content:"Departure: <%=start%>"});
		        	infowindow.open(map,startMarker);
		        });
		        
		        endMarker.addListener('click', function() {
		        	map.setZoom(8);
		        	map.setCenter(endMarker.getPosition());
		        });
		        
		        endMarker.addListener('mouseover', function() {
		        	var infowindow = new google.maps.InfoWindow({content:"Arrival: <%=end%>"});
		        	infowindow.open(map,endMarker);
		        });
		       
		
		      }
		</script>
		    
		 <script async defer
		    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2_9s07v4Jg1prL0L1nrMwsLc1byD1XU8&callback=initMap">
		 </script>
  
    </div>
	</section>
</body>

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
	


