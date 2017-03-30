<%@ page import="java.lang.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	int num = Integer.parseInt(request.getParameter("tickets"));
	int n=0;
	int j;
	int age[]=new int[num];
	String cost1 = request.getParameter("ticketprice");
	String flightid = request.getParameter("flightID");
	String launch = request.getParameter("launch");
	String destination = request.getParameter("destination");
	String departDate = request.getParameter("departDate");
	String departTime = request.getParameter("departTime");
	String arriveDate = request.getParameter("arriveDate");
	String arriveTime = request.getParameter("arriveTime");
	String seatType = request.getParameter("seatType");
	String user = session.getAttribute("userid").toString();
	String names[] = new String[num];
	String gender[] = new String[num];
	boolean check=false;
	
    for(j=0; j<num; j++){
    	names[j]=request.getParameter("name"+j);
    	age[j]=Integer.parseInt(request.getParameter("age"+j));
    	gender[j]=request.getParameter("gender"+j);
    }
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
	        "root", "root");
	Statement st = con.createStatement();
	
	while(!check){
		try{
			Random rand = new Random();
			n = rand.nextInt(1000000000);
		    int i = st.executeUpdate("insert into bookid(id) values ('" + n + "')");
			check=true;
		} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
			check=false;
		}
	}

	for(j=0;j<num;j++){
		try{
			System.out.println("Got to try block1");
			int i = st.executeUpdate("insert into booking(bookingid,uname,FlightID,numTickets,seatType,passName,passAge,passGender) values ('"+n+"','"+user+"','"+flightid+"','"+num+"','"+seatType+"','"+names[j]+"','"+age[j]+"','"+gender[j]+"')");
			System.out.println("Got to try block2");
		} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
			check=false;
			System.out.println("Entered catch block");
		}
		System.out.println("Left try block");
	}
	
	if(check){
		response.sendRedirect("success.html");
	} else {
		response.sendRedirect("error.html");
	}
	
%>