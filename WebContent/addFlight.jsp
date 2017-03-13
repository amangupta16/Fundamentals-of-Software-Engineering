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
    String flightID = request.getParameter("flightID");    
    String model= request.getParameter("model");
    String lauchID = request.getParameter("launchID");
    String destID = request.getParameter("destID");
    String depart = request.getParameter("depart");
    String arrive = request.getParameter("arrive");
    String FCP = request.getParameter("FCP");
    String BCP = request.getParameter("BCP");
    String ECP = request.getParameter("ECP");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    try{
    	ResultSet rs;
    	rs = st.executeQuery("select * from plane where planeID = '" + model + "'");
    	if (rs.next()) {
    		int i = st.executeUpdate("insert into flight(FlightID, PlaneID, launch, destination, departure, arrive, firstClassPrice, businessClassPrice, economyPrice) values ('" + flightID + "','" + model + "','" + lauchID + "','" + destID + "','" + depart + "','" + arrive + "','" + FCP + "','" + BCP + "','" + ECP + "')");
    	    if (i > 0) {
    	        //session.setAttribute("userid", user);
    	        response.sendRedirect("addFlightSuccess.html");
    	       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    			
    	        
    	    } else {
    	        response.sendRedirect("index.jsp");
    	    }
    	} else {
            out.println("Invalid Plane ID <a href='addFlight.html'>try again</a>");
        }
    } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
    	out.println("This username, email, or password is already taken <a href='register.html'>try again</a>");
    }
%>