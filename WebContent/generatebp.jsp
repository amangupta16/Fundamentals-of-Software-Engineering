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
	
	String bookingID = request.getParameter("bookingID");
	String passName = request.getParameter("passName");
	String snumber = request.getParameter("snumber");
	String nofbags = request.getParameter("nofbags");
	String tbweight = request.getParameter("tbweight");
	System.out.println(bookingID);
	System.out.println(passName);
	System.out.println(nofbags);
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
	        "root", "root");
	Statement st = con.createStatement();
	
		

	
		try{
			
			int i = st.executeUpdate("Update booking set snumber = '"+snumber+"', nofbags = '"+nofbags+"', tbweight = '"+tbweight+"', checkedin = 'true' where bookingID = '"+bookingID+"' and passName = '"+passName+"'");
			System.out.println("Weight and seatnumber added and checked in");
		} catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e){
			System.out.println("SQL Exception");
		}
		
	

	ResultSet rs1 = st.executeQuery("select snumber, nofbags, tbweight, passName, passAge, passGender, bookingID, planeNumber, f.FlightID as FlightID, launch, destination, departure, arrive from booking b, flight f, plane p where bookingID = '"+bookingID+"' and b.FlightID = f.FlightID and f.PlaneID = f.PlaneID;");
	if(rs1.next()){			
	
	String passAge = rs1.getString("passAge");
	String passGender = rs1.getString("passGender");			
	String planeNumber = rs1.getString("planeNumber");
	String FlightID = rs1.getString("FlightID");

	try {
		OutputStream file = new FileOutputStream(new File("BoardingPass"+bookingID+".pdf"));

		Document document = new Document();
		PdfWriter.getInstance(document, file);

		document.open();
		document.add(new Paragraph("\n\n Hello,"+
		"\n\n Your flight has been booked."+
		"\n Following are the details of your booking:"+
		"\n\n\t\t\t\t Booking ID:  "+bookingID+
		"\n\t\t\t\t Passenger Name:  "+passName+
		"\n\t\t\t\t Age:  "+passAge+
		"\n\t\t\t\t Gender:  "+passGender+
		"\n\n\n Your Boarding Details:"));
		

		
		document.add(new Paragraph("\n\t\t\t\t Flight ID:  "+FlightID+
				"\n\t\t\t\t Plane Name:  "+planeNumber+
				"\n\t\t\t\t Seat Number:  "+snumber+
				"\n\t\t\t\t No of bags:  "+nofbags+
				"\n\t\t\t\t Total Weight of Bags:  "+tbweight));
		
		

		document.close();
		file.close();

	} catch (Exception e) {

		e.printStackTrace();
	}
	}

	
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
				InternetAddress.parse("aman-gupta@uiowa.edu"));
		message.setSubject("Congrats!! Your tickets have been booked successfully");
		 messageBodyPart = new MimeBodyPart();
		 message.setText("Dear Customer," +
					"\n\n You ticket has been booked." +
					"\n Please find attached the pdf." +
					"\n\n Warm Regards," +
					"\n Fly Royal Airlines");
	     String filename = "BoardingPass"+bookingID+".pdf";
	     DataSource source = new FileDataSource(filename);
	     messageBodyPart.setDataHandler(new DataHandler(source));
	     messageBodyPart.setFileName(filename);
	     multipart.addBodyPart(messageBodyPart);
	     message.setContent(multipart );

		Transport.send(message);

		System.out.println("Done");
		response.sendRedirect("successCheckin.html");

	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
	
	
	
	
	
	
	
	
%>