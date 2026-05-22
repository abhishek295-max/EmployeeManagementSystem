<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {

    // Load MySQL Driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Render Environment Variables
    String url = System.getenv("DB_URL");
    String user = System.getenv("DB_USER");
    String pass = System.getenv("DB_PASS");

    // Agar env variables null ho toh fallback Railway DB use kare
    if(url == null || user == null || pass == null){
        url = "jdbc:mysql://kodama.proxy.rlwy.net:13675/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        user = "root";
        pass = "IJbXCoyUdkhVGDixhECRWJdDPAkbJKxd";
    }

    // Connection
    con = DriverManager.getConnection(url, user, pass);

    out.println("<h3 style='color:green;'>Database Connected Successfully!</h3>");

} catch (Exception e) {

    out.println("<h3 style='color:red;'>Database Connection Failed!</h3>");
    e.printStackTrace(new java.io.PrintWriter(out));
}
%>