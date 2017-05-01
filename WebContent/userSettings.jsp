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
    String opass = request.getParameter("oldpass");    
    String npass = request.getParameter("newpass");
    String cnpass = request.getParameter("cnewpass");
    String userid = session.getAttribute("userid").toString();
    
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
    byte[] plainText = opass.getBytes(UNICODE_FORMAT);
    byte[] encryptedText = cipher.doFinal(plainText);
    encryptedString = new String(Base64.encodeBase64(encryptedText));
    
    String encryptedString1 = null;
    cipher.init(Cipher.ENCRYPT_MODE, key);
    byte[] plainText1 = npass.getBytes(UNICODE_FORMAT);
    byte[] encryptedText1 = cipher.doFinal(plainText1);
    encryptedString1 = new String(Base64.encodeBase64(encryptedText1));
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    ResultSet rs;
    if(npass.equals(cnpass)){
	    rs = st.executeQuery("select * from memberss where uname='" + userid + "' and pass='" + encryptedString + "'");
	    if(rs.next()){
	    	PreparedStatement preparedStmt = con.prepareStatement("update members set pass = ? where uname = ?");
	        preparedStmt.setString(1,encryptedString1);
	        preparedStmt.setString(2,userid);
	        preparedStmt.executeUpdate();
	        //rs.setString("pass",npass);
	    	response.sendRedirect("welcome.html");
	    } else {
	    	out.println("Invalid password <a href='userSettings.html'>try again</a>");
	    }
    } else {
    	out.println("Passwords do not match. <a href='userSettings.html'>try again</a>");
    }
%>