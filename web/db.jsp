<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {


    Class.forName("com.mysql.cj.jdbc.Driver");


    String url = System.getenv("DB_URL");
    String user = System.getenv("DB_USER");
    String pass = System.getenv("DB_PASS");


    if(url == null || user == null || pass == null){
        url = "jdbc:mysql://kodama.proxy.rlwy.net:13675/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        user = "root";
        pass = "IJbXCoyUdkhVGDixhECRWJdDPAkbJKxd";
    }


    con = DriverManager.getConnection(url, user, pass);

    out.println("<h6 style='color:green;'>Database Connected Successfully!</h6>");

} catch (Exception e) {

    out.println("<h3 style='color:red;'>Database Connection Failed!</h3>");
    e.printStackTrace(new java.io.PrintWriter(out));
}
%>