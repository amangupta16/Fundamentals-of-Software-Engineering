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
    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    try{
	    int i = st.executeUpdate("insert into memberss(first_name, last_name, email, uname, pass, regdate, accType, ftlogin) values ('" + fname + "','" + lname + "','" + email + "','" + user + "','" + pwd + "', CURDATE(), 'U', 'NO')");
	    if (i > 0) {
	        //session.setAttribute("userid", user);
	        response.sendRedirect("login.html");
	       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
			
	        
	    } else {
	        response.sendRedirect("index.jsp");
	    }
    } catch (com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
    	out.println("This username, email, or password is already taken <a href='register.html'>try again</a>");
    }
%>