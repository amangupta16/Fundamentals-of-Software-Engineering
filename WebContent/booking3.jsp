<%@ page import="java.lang.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
<%@page import="com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
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
	
	String rcost1 = request.getParameter("rticketprice");
    String rflightid = request.getParameter("rflightID");
    String rlaunch = request.getParameter("rlaunch");
    String rdestination = request.getParameter("rdestination");
    String rdepartDate = request.getParameter("rdepartDate");
    String rdepartTime = request.getParameter("rdepartTime");
    String rarriveDate = request.getParameter("rarriveDate");
    String rarriveTime = request.getParameter("rarriveTime");
    String rseatType = request.getParameter("rseatType");
	
	String user = session.getAttribute("userid").toString();
	String names[] = new String[num];
	String gender[] = new String[num];
	boolean check=false;
	boolean rcheck = false;
	
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
			int i = st.executeUpdate("insert into booking(bookingid,uname,FlightID,numTickets,seatType,passName,passAge,passGender,snumber,nofbags,tbweight,checkedin) values ('"+n+"','"+user+"','"+flightid+"','"+num+"','"+seatType+"','"+names[j]+"','"+age[j]+"','"+gender[j]+"','NULL','NULL','NULL','false')");
			System.out.println("Got to try block2");
		} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
			check=false;
			System.out.println("Entered catch block");
		}
		System.out.println("Left try block");
	}
	
	if(!rflightid.equals("null")){
		while(!rcheck){
			try{
				Random rand = new Random();
				n = rand.nextInt(1000000000);
			    int i = st.executeUpdate("insert into bookid(id) values ('" + n + "')");
				rcheck=true;
			} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
				rcheck=false;
			}
		}
	
		for(j=0;j<num;j++){
			try{
				System.out.println("Got to try block1");
				int i = st.executeUpdate("insert into booking(bookingid,uname,FlightID,numTickets,seatType,passName,passAge,passGender) values ('"+n+"','"+user+"','"+rflightid+"','"+num+"','"+rseatType+"','"+names[j]+"','"+age[j]+"','"+gender[j]+"')");
				System.out.println("Got to try block2");
			} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
				rcheck=false;
				System.out.println("Entered catch block");
			}
			System.out.println("Left try block");
		}
	}
	

	ResultSet rs1 = st.executeQuery("select passName, passAge, passGender, bookingID, planeNumber, f.FlightID as FlightID, launch, destination, departure, arrive from booking b, flight f, plane p where bookingID = '"+n+"' and b.FlightID = f.FlightID and f.PlaneID = f.PlaneID;");
	if(rs1.next()){			
	String passName = rs1.getString("passName");
	String passAge = rs1.getString("passAge");
	String passGender = rs1.getString("passGender");			
	String bookingID = rs1.getString("bookingID");
	String planeNumber = rs1.getString("planeNumber");
	String FlightID = rs1.getString("FlightID");

	try {
		OutputStream file = new FileOutputStream(new File("Booking"+n+".pdf"));

		Document document = new Document();
		PdfWriter.getInstance(document, file);

		document.open();
		document.add(new Paragraph("\n\n Hello,"+
		"\n\n Your flight has been booked."+
		"\n Following are the details of your booking:"+
		"\n\n\t\t\t\t Booking ID:  "+n+
		"\n\t\t\t\t Passenger Name:  "+passName+
		"\n\t\t\t\t Age:  "+passAge+
		"\n\t\t\t\t Gender:  "+passGender+
		"\n\n\n Your Flight Details:"));
		

		
		document.add(new Paragraph("\n\t\t\t\t Flight ID:  "+FlightID+
				"\n\t\t\t\t Plane Name:  "+planeNumber+
				"\n\t\t\t\t Seat Type:  "+seatType+
				"\n\t\t\t\t From:  "+launch+
				"\n\t\t\t\t To:  "+destination+
				"\n\t\t\t\t Depart Time:  "+departTime+
				"\n\t\t\t\t Arrival Time:  "+arriveTime+
				"\n\n\n Total number of tickets:  "+num+
				"\n Price per ticket:  "+cost1));
		
		

		document.close();
		file.close();

	} catch (Exception e) {

		e.printStackTrace();
	}
	}

	ResultSet rs = st.executeQuery("select distinct(email) from memberss where uname = '"+user+"'");
	if(rs.next()){
	String email = rs.getString("email");
	Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.socketFactory.port", "465");
	props.put("mail.smtp.socketFactory.class",
			"javax.net.ssl.SSLSocketFactory");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.port", "465");

	Session session1 = Session.getInstance(props,
		new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("flyroyalairlines","fundamentals");
			}
		});

	try {

		BodyPart messageBodyPart = new MimeBodyPart();
		Multipart multipart = new MimeMultipart();
		Message message = new MimeMessage(session1);
		message.setFrom(new InternetAddress("flyroyalairlines@gmail.com"));
		message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(email));
		message.setSubject("Congrats!! Your tickets have been booked successfully");
		 messageBodyPart = new MimeBodyPart();
		 message.setText("Dear Customer," +
					"\n\n You ticket has been booked." +
					"\n Please find attached the pdf." +
					"\n\n Warm Regards," +
					"\n Fly Royal Airlines");
	     String filename = "Booking"+n+".pdf";
	     DataSource source = new FileDataSource(filename);
	     messageBodyPart.setDataHandler(new DataHandler(source));
	     messageBodyPart.setFileName(filename);
	     multipart.addBodyPart(messageBodyPart);
	     message.setContent(multipart );

		Transport.send(message);

		System.out.println("Done");

	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
	}
	
	if(!rflightid.equals("null")){
		if(check && rcheck){
			response.sendRedirect("success.html");		
		} else {
			response.sendRedirect("error.html");
		}
	} else {
		if(check){
			response.sendRedirect("success.html");		
		} else {
			response.sendRedirect("error.html");
		}
	}
	
	
	
	
	
%>