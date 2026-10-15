<%@ page import="java.sql.*" %>

<%
    Connection con = null;

    try {

        Class.forName("com.mysql.cj.jdbc.Driver");

        con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ems?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "Abhishek295"
        );

    } catch (Exception e) {
        out.println(e);
    }
%>