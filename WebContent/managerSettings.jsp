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
    String opass = request.getParameter("oldpass");    
    String npass = request.getParameter("newpass");
    String cnpass = request.getParameter("cnewpass");
    String userid = session.getAttribute("userid").toString();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    ResultSet rs;
    if(npass.equals(cnpass)){
	    rs = st.executeQuery("select * from memberss where uname='" + userid + "' and pass='" + opass + "'");
	    if(rs.next()){
	    	PreparedStatement preparedStmt = con.prepareStatement("update memberss set pass = ? where uname = ?");
	        preparedStmt.setString(1,npass);
	        preparedStmt.setString(2,userid);
	        preparedStmt.executeUpdate();
	        st.executeUpdate("update memberss set ftlogin = 'NO' where uname ='" + userid + "'");
	        //rs.setString("pass",npass);
	    	response.sendRedirect("managerWelcome.html");
	    } else {
	    	out.println("Invalid password <a href='managerSettings.html'>try again</a>");
	    }
    } else {
    	out.println("Passwords do not match. <a href='managerSettings.html'>try again</a>");
    }
%>