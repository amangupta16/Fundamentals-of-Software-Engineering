<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%@page import="java.util.Properties"%>                                                                                                     
<%@page import="javax.mail.Session"%>                                                                                                       
<%@page import="javax.mail.Authenticator"%>                                                                                                 
<%@page import="javax.mail.PasswordAuthentication"%>                                                                                        
<%@page import="javax.mail.Message"%>                                                                                                       
<%@page import="javax.mail.internet.MimeMessage"%>                                                                                          
<%@page import="javax.mail.internet.InternetAddress"%>                                                                                      
<%@page import="javax.mail.Transport"%>

<%
    String from = request.getParameter("from");    
    String destination= request.getParameter("destination");
    String departureDate = request.getParameter("departureDate");
    String returnDate = request.getParameter("returnDate");
    
    boolean flightsFound = false;

    Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/form";
    String username="root";
    String password="root";
    Connection con = DriverManager.getConnection(url,username,password);
    String query="select * from flight";
    
    Statement st = con.createStatement();
    
    try{
    	ResultSet rs;
    	//rs = st.executeQuery("select * from plane where planeID = '" + from + "'");
    	rs=st.executeQuery(query);
  
    	while (rs.next())
    	{
    		if (rs.getString("launch").equals(from) && rs.getString("destination").equals(destination))
    		{
    			out.println(rs.getInt("FlightID"));
    			out.println(rs.getString("launch"));
    			out.println(rs.getString("destination"));
    			//out.println(rs.getTime("depaprture"));
    			//out.println(rs.getTime("arrive"));
    			out.println(rs.getInt("economyPrice"));
    			out.println(rs.getInt("businessClassPrice"));
    			out.println(rs.getInt("firstClassPrice"));
        	    flightsFound=true;
    		}
    		out.println("\n_____________\n");
    		
    	}
    	if(flightsFound==false)
    	{
    		out.println("No flights were found <a href='searchFlight.html'>try again</a>");
    	}
    	
    	/*if (rs.next()) {
    		int i = st.executeUpdate("insert into flight(FlightID, PlaneID, launch, destination, departure, arrive, firstClassPrice, businessClassPrice, economyPrice) values ('" + 1 + "','" + 1 + "','" + 1 + "','" + 1 + "','" + from + "','" + from + "','" + 1 + "','" + from + "','" + 1 + "')");
    	    if (i > 0) {
    	        //session.setAttribute("userid", user);
    	        response.sendRedirect("addFlightSuccess.html");
    	       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    			
    	        
    	    } else {
    	        response.sendRedirect("index.jsp");
    	    }
    	} else {
            out.println("No flights were found <a href='searchFlight.html'>try again</a>");
        }*/
    	
    	
    } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
    	out.println("This username, email, or password is already taken <a href='register.html'>try again</a>");
    }
%>