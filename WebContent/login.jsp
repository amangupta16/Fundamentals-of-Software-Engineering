<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from memberss where uname='" + userid + "' and pass='" + pwd + "'");
    if (rs.next()) {
    	String access = rs.getString("accType");
    	String firsttime = rs.getString("ftlogin");
    	//session.setAttribute("userid", userid);
    	//out.println("welcome " + userid);
    	//out.println("<a href='logout.jsp'>Log out</a>");
    	if(access.equals("U")){
        	response.sendRedirect("welcome.html");
    	} else if (access.equals("M")){
    		if (firsttime.equals("YES"))
    			response.sendRedirect("managerSettings.html");
    		else
    			response.sendRedirect("managerWelcome.html");
    	} else if (access.equals("A")){
    		response.sendRedirect("adminWelcome.html");
    	}
    } else {
        out.println("Invalid password <a href='login.html'>try again</a>");
    }
%>