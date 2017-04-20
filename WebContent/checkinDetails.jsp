<%@ page import="java.lang.*"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <title>Booking - FLY ROYAL AIRLINES</title>
    <link rel="stylesheet" href="assets/stylesheets/main.css">
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:100,300,400">
  </head>

  <body>

    <!-- Header -->

    <header class="primary-header container group">

      <h1 class="logo">
        <a href="managerWelcome.html">FLY ROYAL <br> AIRLINES</a>
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

    <!-- Lead -->

    <section class="row-alt">
      <div class="lead container">

        <h1>Booking</h1>
        <%
        String bookingID = request.getParameter("bookingID");
    	String passName = request.getParameter("passName");
    	String FlightID = request.getParameter("FlightID");
	        %>
	        
	
	      </div>
	    </section>
	
	    <!-- Main content -->
	
	    <section class="row">
	      <div class="grid">
	
	        <!-- Details -->
	
	        <form class="col-1-3" action="generatebp.jsp" method="post">

				<fieldset class="register-group">
					
					<label>Enter Seat Number
					<input type="text" name="snumber" placeholder="Seat Number" required>
				    </label>
				    
				    <label>Numbers of bags
					<input type="text" name="nofbags" placeholder="Number of bags" required>
				    </label>
				    
				    <label>Total Baggage Weight(in KGs)
					<input type="text" name="tbweight" placeholder="Total Baggage Weight" required>
				    </label>

				</fieldset>

				<input class="btn btn-default" type="submit" name="submit"
					value="Check In">
					<input type="hidden" name="FlightID" value="<%=FlightID%>">
					<input type="hidden" name="bookingID" value="<%=bookingID%>">
					<input type="hidden" name="passName" value="<%=passName%>">

			</form>
	
	      </div>
	    </section>
	    
        
       
          </div>
	    </section>
	   

    <!-- Footer -->

    <footer class="primary-footer container group">

      <small>&copy; Styles Conference</small>

      <nav class="nav">
        <ul>
          <li><a href='logout.jsp'>Log out</a></li>
        </ul>
      </nav>

    </footer>

  </body>
</html>