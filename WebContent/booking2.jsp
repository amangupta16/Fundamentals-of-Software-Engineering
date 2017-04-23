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
        int num = Integer.parseInt(request.getParameter("tickets"));
        String cost1 = request.getParameter("ticketprice");
        String flightid = request.getParameter("flightID");
        String launch = request.getParameter("launch");
        String destination = request.getParameter("destination");
        String departDate = request.getParameter("departDate");
        String departTime = request.getParameter("departTime");
        String arriveDate = request.getParameter("arriveDate");
        String arriveTime = request.getParameter("arriveTime");
        String seatType = request.getParameter("seatType");
        
        String wflightid = request.getParameter("wflightID");
        String wlaunch = request.getParameter("wlaunch");
        String wdestination = request.getParameter("wdestination");
        String wdepartDate = request.getParameter("wdepartDate");
        String wdepartTime = request.getParameter("wdepartTime");
        String warriveDate = request.getParameter("warriveDate");
        String warriveTime = request.getParameter("warriveTime");
        
        String rwflightid = request.getParameter("rwflightID");
        String rwlaunch = request.getParameter("rwlaunch");
        String rwdestination = request.getParameter("rwdestination");
        String rwdepartDate = request.getParameter("rwdepartDate");
        String rwdepartTime = request.getParameter("rwdepartTime");
        String rwarriveDate = request.getParameter("rwarriveDate");
        String rwarriveTime = request.getParameter("rwarriveTime");
        
        String rcost1 = request.getParameter("rticketprice");
        String rflightid = request.getParameter("rflightID");
        String rlaunch = request.getParameter("rlaunch");
        String rdestination = request.getParameter("rdestination");
        String rdepartDate = request.getParameter("rdepartDate");
        String rdepartTime = request.getParameter("rdepartTime");
        String rarriveDate = request.getParameter("rarriveDate");
        String rarriveTime = request.getParameter("rarriveTime");
        String rseatType = request.getParameter("rseatType");
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
                "root", "root");
        Statement st = con.createStatement();
        ResultSet flight;
        ResultSet plane;
        ResultSet booking;
        int numseats=0;
        int planeid=0;
        flight = st.executeQuery("select * from flight where FlightID='" + flightid+"'");
        if(flight.next()){
	        planeid = flight.getInt("PlaneID");
	        plane = st.executeQuery("select * from plane where PlaneID='"+ planeid +"'");
	        if(plane.next()){
		        if(seatType.equals("economy")){
		        	numseats = plane.getInt("eclassSeats");
		        } else if(seatType.equals("business")){
		        	numseats = plane.getInt("bclassSeats");
		        } else if(seatType.equals("first")){
		        	numseats = plane.getInt("fclassSeats");
		        }
	        }
        }
        booking = st.executeQuery("select * from booking where FlightID='"+flightid + "' and seatType='"+seatType+"'");    
        int seatsTaken=0;
        while(booking.next()){
        	seatsTaken=seatsTaken+1;
        }
        int remaining=numseats-seatsTaken;
        remaining=remaining-num;
        
        ResultSet rflight;
        ResultSet rplane;
        ResultSet rbooking;
        int rnumseats=0;
        int rplaneid=0;
        int rseatsTaken=0;
        int rRemaining=0;
        
        if(!rflightid.equals("null")){
	        rflight = st.executeQuery("select * from flight where FlightID='" + rflightid+"'");
	        if(rflight.next()){
		        rplaneid = rflight.getInt("PlaneID");
		        rplane = st.executeQuery("select * from plane where PlaneID='"+ rplaneid +"'");
		        if(rplane.next()){
			        if(rseatType.equals("economy")){
			        	rnumseats = rplane.getInt("eclassSeats");
			        } else if(rseatType.equals("business")){
			        	rnumseats = rplane.getInt("bclassSeats");
			        } else if(rseatType.equals("first")){
			        	rnumseats = rplane.getInt("fclassSeats");
			        }
		        }
	        }
	        rbooking = st.executeQuery("select * from booking where FlightID='"+rflightid + "' and seatType='"+rseatType+"'");    
	        while(rbooking.next()){
	        	rseatsTaken=rseatsTaken+1;
	        }
	        rRemaining=rnumseats-rseatsTaken;
	        rRemaining=rRemaining-num;
        }
        
        if(remaining>=0 && !rflightid.equals("null") && rRemaining>=0){
	        char cost2[] = cost1.toCharArray();
	        String cost3 = "";
	        for(int j=1; j<cost2.length; j++){
	         cost3=cost3+cost2[j];
	        }
	        int cost = Integer.parseInt(cost3);
	        int price = num*cost;
	        
	        cost2 = rcost1.toCharArray();
	        cost3 = "";
	        for(int j=1; j<cost2.length; j++){
	         cost3=cost3+cost2[j];
	        }
	        int rcost = Integer.parseInt(cost3);
	        int rprice = num*rcost;
	        int total = price + rprice;
	        
	        %>
	        <h2>For <%=num%> passengers in the <%=seatType%> class, your total is $<%=price%>.<br> 
	        	For <%=num%> passengers in the <%=rseatType%> class, your total is $<%=rprice%>.<br>
	        	Your total price for both flights is $<%=total%>.</h2>
	
	      </div>
	    </section>
	
	    <!-- Main content -->
	
	    <section class="row">
	      <div class="grid">
	
	        <!-- Details -->
	
	        <form class="col-1-3" action="booking3.jsp" method="post"> 
	
	          <fieldset class="register-group">
	            
	            <%
	            int i;
	            for(i=0; i<num; i++){ 
	            %>
	            
	            <label>
	              Passenger Name
	              <input type="text" name="<%="name"+i%>" placeholder="Name" required>
	            </label>
	            
	            <label>
	              Age
	              <input type="number" name="<%="age"+i%>" required>
	            </label>
	            
	            <label>
	              Gender
	              <input type="text" name="<%="gender"+i%>" required>
	            </label>
	            
	            <%
	            }
	            %>
	            
	          </fieldset>
			  <input type="hidden" name="tickets" value=<%=num%>>
              <input type="hidden" name="flightID" value="<%=flightid%>">
			  <input type="hidden" name="launch" value="<%=launch%>">
			  <input type="hidden" name="destination" value="<%=destination%>">
			  <input type="hidden" name="departDate" value="<%=departDate%>">
			  <input type="hidden" name="departTime" value="<%=departTime%>">
			  <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
			  <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
			  <input type="hidden" name="wflightID" value="<%=wflightid%>">
			  <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
			  <input type="hidden" name="wdestination" value="<%=wdestination%>">
			  <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
			  <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
			  <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
			  <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
			  <input type="hidden" name="ticketprice" value="<%=cost1%>">
			  <input type="hidden" name="seatType" value="<%=seatType%>">
			  <input type="hidden" name="rflightID" value="<%=rflightid%>">
			  <input type="hidden" name="rlaunch" value="<%=rlaunch%>">
			  <input type="hidden" name="rdestination" value="<%=rdestination%>">
			  <input type="hidden" name="rdepartDate" value="<%=rdepartDate%>">
			  <input type="hidden" name="rdepartTime" value="<%=rdepartTime%>">
			  <input type="hidden" name="rarriveDate" value="<%=rarriveDate%>">
			  <input type="hidden" name="rarriveTime" value="<%=rarriveTime%>">
			  <input type="hidden" name="rwflightID" value="<%=rwflightid%>">
			  <input type="hidden" name="rwlaunch" value="<%=rwlaunch%>">
			  <input type="hidden" name="rwdestination" value="<%=rwdestination%>">
			  <input type="hidden" name="rwdepartDate" value="<%=rwdepartDate%>">
			  <input type="hidden" name="rwdepartTime" value="<%=rwdepartTime%>">
			  <input type="hidden" name="rwarriveDate" value="<%=rwarriveDate%>">
			  <input type="hidden" name="rwarriveTime" value="<%=rwarriveTime%>">
			  <input type="hidden" name="rticketprice" value="<%=rcost1%>">
			  <input type="hidden" name="rseatType" value="<%=rseatType%>">
	          <input class="btn btn-default" type="submit" name="submit" value="Submit">
	
	        </form>
	
	      </div>
	    </section>
	    <%
        } else if(remaining>=0 && !rflightid.equals("null") && rRemaining<0) {
        %>
            
           	<h2>We're sorry, the return flight does not have enough of the seats you are looking for.
           	 Please try	another flight. </h2>
          </div>
  	    </section>
   	    <%
        } else if(remaining>=0 && rflightid.equals("null")) {
        	char cost2[] = cost1.toCharArray();
	        String cost3 = "";
	        for(int j=1; j<cost2.length; j++){
	         cost3=cost3+cost2[j];
	        }
	        int cost = Integer.parseInt(cost3);
	        int price = num*cost;	        
	        %>
	        <h2>For <%=num%> passengers in the <%=seatType%> class, your total is $<%=price%>. </h2>
	
	      </div>
	    </section>
	
	    <!-- Main content -->
	
	    <section class="row">
	      <div class="grid">
	
	        <!-- Details -->
	
	        <form class="col-1-3" action="booking3.jsp" method="post"> 
	
	          <fieldset class="register-group">
	            
	            <%
	            int i;
	            for(i=0; i<num; i++){ 
	            %>
	            
	            <label>
	              Passenger Name
	              <input type="text" name="<%="name"+i%>" placeholder="Name" required>
	            </label>
	            
	            <label>
	              Age
	              <input type="number" name="<%="age"+i%>" required>
	            </label>
	            
	            <label>
	              Gender
	              <input type="text" name="<%="gender"+i%>" required>
	            </label>
	            
	            <%
	            }
	            %>
	            
	          </fieldset>
			  <input type="hidden" name="tickets" value=<%=num%>>
              <input type="hidden" name="flightID" value="<%=flightid%>">
			  <input type="hidden" name="launch" value="<%=launch%>">
			  <input type="hidden" name="destination" value="<%=destination%>">
			  <input type="hidden" name="departDate" value="<%=departDate%>">
			  <input type="hidden" name="departTime" value="<%=departTime%>">
			  <input type="hidden" name="arriveDate" value="<%=arriveDate%>">
			  <input type="hidden" name="arriveTime" value="<%=arriveTime%>">
			  <input type="hidden" name="wflightID" value="<%=wflightid%>">
			  <input type="hidden" name="wlaunch" value="<%=wlaunch%>">
			  <input type="hidden" name="wdestination" value="<%=wdestination%>">
			  <input type="hidden" name="wdepartDate" value="<%=wdepartDate%>">
			  <input type="hidden" name="wdepartTime" value="<%=wdepartTime%>">
			  <input type="hidden" name="warriveDate" value="<%=warriveDate%>">
			  <input type="hidden" name="warriveTime" value="<%=warriveTime%>">
			  <input type="hidden" name="ticketprice" value="<%=cost1%>">
			  <input type="hidden" name="seatType" value="<%=seatType%>">
			  <input type="hidden" name="rflightID" value="<%=rflightid%>">
			  <input type="hidden" name="rlaunch" value="<%=rlaunch%>">
			  <input type="hidden" name="rdestination" value="<%=rdestination%>">
			  <input type="hidden" name="rdepartDate" value="<%=rdepartDate%>">
			  <input type="hidden" name="rdepartTime" value="<%=rdepartTime%>">
			  <input type="hidden" name="rarriveDate" value="<%=rarriveDate%>">
			  <input type="hidden" name="rarriveTime" value="<%=rarriveTime%>">
			  <input type="hidden" name="rwflightID" value="<%=rwflightid%>">
			  <input type="hidden" name="rwlaunch" value="<%=rwlaunch%>">
			  <input type="hidden" name="rwdestination" value="<%=rwdestination%>">
			  <input type="hidden" name="rwdepartDate" value="<%=rwdepartDate%>">
			  <input type="hidden" name="rwdepartTime" value="<%=rwdepartTime%>">
			  <input type="hidden" name="rwarriveDate" value="<%=rwarriveDate%>">
			  <input type="hidden" name="rwarriveTime" value="<%=rwarriveTime%>">
			  <input type="hidden" name="rticketprice" value="<%=rcost1%>">
			  <input type="hidden" name="rseatType" value="<%=rseatType%>">
	          <input class="btn btn-default" type="submit" name="submit" value="Submit">
	
	        </form>
	
	      </div>
	    </section>
   	    <%
       	} else {
        %>
        
        	<h2>We're sorry, this flight does not have enough of the seats you are looking for.
        	 Please try	another flight.</h2>
          </div>
	    </section>
	    <%
        }
        %>

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