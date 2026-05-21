<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    String url =
    "jdbc:mysql://kodama.proxy.rlwy.net:13675/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    String user = "root";
    String password = "IJbXCoyUdkhVGDixhECRWJdDPAkbJKxd";

    con = DriverManager.getConnection(url, user, password);

    out.println("<h3 style='color:green;'>Database Connected Successfully!</h3>");

} catch (Exception e) {

    out.println("<h3 style='color:red;'>Database Connection Failed!</h3>");
    e.printStackTrace(new java.io.PrintWriter(out));

}
%>