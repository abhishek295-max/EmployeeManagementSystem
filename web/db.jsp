<%@ page import="java.sql.*" %>

<%
Connection con = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

   String url = System.getenv("DB_URL");
   String user = System.getenv("DB_USER");
   String pass = System.getenv("DB_PASS");

   Connection con = DriverManager.getConnection(url, user, pass);

    con = DriverManager.getConnection(url, user, password);

    out.println("<h3 style='color:green;'>Database Connected Successfully!</h3>");

} catch (Exception e) {

    out.println("<h3 style='color:red;'>Database Connection Failed!</h3>");
    e.printStackTrace(new java.io.PrintWriter(out));

}
%>