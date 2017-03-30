<%@ page import="java.lang.*"%>
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
        <a href="welcome.html">FLY ROYAL <br> AIRLINES</a>
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
        String cost = request.getParameter("ticketprice");
        String flightid = request.getParameter("flightID");
        String launch = request.getParameter("launch");
        String destination = request.getParameter("destination");
        String departDate = request.getParameter("departDate");
        String departTime = request.getParameter("departTime");
        String arriveDate = request.getParameter("arriveDate");
        String arriveTime = request.getParameter("arriveTime");
        String seatType = request.getParameter("seatType");
        %>

      </div>
    </section>

    <!-- Main content -->

    <section class="row">
      <div class="grid">

        <!-- Details -->

        <form class="col-1-3" action="booking2.jsp" method="post"> 

          <fieldset class="register-group">
            
            <label>
              Number of tickets
              <input type="number" name="tickets" required>
              <input type="hidden" name="flightID" value="<%=flightid%>">
			  <input type="hidden" name="launch" value="<%=launch%>">
			  <input type="hidden" name="destination" value="<%=destination%>">
			  <input type="hidden" name="departDate" value="<%=departDate%>">
			  <input type="hidden" name="departTime" value="<%=departTime%>">
			  <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
			  <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
			  <input type="hidden" name="ticketprice" value="<%=cost%>">
			  <input type="hidden" name="seatType" value="<%=seatType%>">
            </label>
            
          </fieldset>

          <input class="btn btn-default" type="submit" name="submit" value="Submit">

        </form>

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