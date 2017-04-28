<%@ page import ="java.sql.*" %>
<%@page import="java.security.spec.KeySpec"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="javax.crypto.spec.DESedeKeySpec"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%
    String userid = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    
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
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st1 = con1.createStatement();
    ResultSet rs1;
    rs1 = st1.executeQuery("select * from memberss where uname='" + userid + "'");
    if (rs1.next()) {
    	String encryptedString = rs1.getString("pass");
    	String decryptedText=null;
    	cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] encryptedText = Base64.decodeBase64(encryptedString);
        byte[] plainText = cipher.doFinal(encryptedText);
        decryptedText= new String(plainText);
        System.out.println(decryptedText);
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/form",
            "root", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    System.out.println(pwd);
    if (pwd.equals(decryptedText)) {
    	String access = rs1.getString("accType");
    	System.out.println(access);
    	String firsttime = rs1.getString("ftlogin");
    	session.setAttribute("userid", userid);
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
    } 
    else {
        out.println("Invalid password <a href='login.html'>try again</a>");
    }
    }
    else {
        out.println("Invalid username <a href='login.html'>try again</a>");
    }
    
%>