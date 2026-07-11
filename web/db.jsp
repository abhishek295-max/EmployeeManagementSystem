<%@ page import="java.sql.*" %>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection(
                "jdbc:mysql://tokaido.proxy.rlwy.net:23621/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "lxtmFoAtnKIQNeWhZDOnTOXOzssdBBBU"
        );

        out.println("<h2 style='color:green'>Database Connected Successfully!</h2>");

        con.close();

    } catch (Exception e) {
        out.println("<h2 style='color:red'>Database Connection Failed!</h2>");
        out.println(e);
    }
%>