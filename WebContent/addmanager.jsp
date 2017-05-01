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
<%@page import="java.security.spec.KeySpec"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="javax.crypto.spec.DESedeKeySpec"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%
    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    
    String UNICODE_FORMAT = "UTF8";
    String DESEDE_ENCRYPTION_SCHEME = "DESede";
    KeySpec ks;
    SecretKeyFactory skf;
    Cipher cipher;
    byte[] arrayBytes;
    String myEncryptionKey;
    String myEncryptionScheme;
    SecretKey key;
    
    myEncryptionKey = "ThisIsSpartaThisIsSparta";
    myEncryptionScheme = DESEDE_ENCRYPTION_SCHEME;
    arrayBytes = myEncryptionKey.getBytes(UNICODE_FORMAT);
    ks = new DESedeKeySpec(arrayBytes);
    skf = SecretKeyFactory.getInstance(myEncryptionScheme);
    cipher = Cipher.getInstance(myEncryptionScheme);
    key = skf.generateSecret(ks);
    
    String encryptedString = null;
    cipher.init(Cipher.ENCRYPT_MODE, key);
    byte[] plainText = pwd.getBytes(UNICODE_FORMAT);
    byte[] encryptedText = cipher.doFinal(plainText);
    encryptedString = new String(Base64.encodeBase64(encryptedText));
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into memberss(first_name, last_name, email, uname, pass, regdate, accType, ftlogin) values ('" + fname + "','" + lname + "','" + email + "','" + user + "','" + encryptedString + "', CURDATE(), 'M', 'YES')");
    if (i > 0) {
        
        response.sendRedirect("adminWelcome.html");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
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

			Message message = new MimeMessage(session1);
			message.setFrom(new InternetAddress("flyroyalairlines@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(email));
			message.setSubject("Hurray!! You have been added as a manager at Fly Royal Airlines");
			message.setText("Dear " + fname +
					"\n\n You have been added as a manager at Fly Royal Airlines." +
					"\n Your username is: " + user + " and password is: " + pwd +
					"\n You are recommended to change the password when logging in first time. Go to settings and change password." +
					"\n\n Warm Regards," +
					"\n Fly Royal Airlines");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
        
    } else {
        response.sendRedirect("adminWelcome.jsp");
    }
%>