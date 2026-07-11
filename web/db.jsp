<%@ page import="java.sql.*" %>

<%
    Connection con = null;

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
                "jdbc:mysql://tokaido.proxy.rlwy.net:23621/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "lxtmFoAtnKIQNeWhZDOnTOXOzssdBBBU"
        );

    } catch (Exception e) {
        out.println(e);
    }
%>