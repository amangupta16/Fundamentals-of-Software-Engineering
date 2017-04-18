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
	String planeid = request.getParameter("PlaneID");  
    String manfac = request.getParameter("manfac");    
    String model = request.getParameter("model");
    String fclassNum = request.getParameter("fclass");
    String bclassNum = request.getParameter("bclass");
    String eclassNum = request.getParameter("eclass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    String query = "select * from plane where PlaneID='" + planeid + "'";
    Statement st = con.createStatement();
    //ResultSet rs;
    try{
    	ResultSet rs;
    	rs = st.executeQuery(query);
    	
    	if (rs.next()){ //valid flight id
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
				int i = st.executeUpdate("update plane set manufacture ='"+ manfac +"', planeNumber='"+ model +"', fclassSeats='"+ fclassNum +"', bclassSeats='"+ bclassNum +"', eclassSeats='"+ eclassNum +"' where PlaneID = '"+ planeid +"'");
				if(i > 0){
					//alert("Success! Flight has been removed");
					out.println("Success! Flight has been updated <a href='updateFlight.html'>UPDATE ANOTHER FLIGHT</a>");
				}
			}else{
				out.println("Sorry! Plane has been booked <a href='updatePlane.html'>try again</a>");	
			}
    	}else{
			out.println("Invalid Plane ID <a href='updatePlane.html'>try again</a>");
		}
	    
    } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
    	out.println("This plane ID is already taken <a href='register.html'>try again</a>");
    }
%>