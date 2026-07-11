<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

try {

    int id = Integer.parseInt(request.getParameter("id"));

    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM employees WHERE id=?"
    );

    ps.setInt(1, id);

    int i = ps.executeUpdate();

    if(i > 0){
%>
        <script>
            alert("Employee Deleted Successfully ?");
            window.location="view-employee.jsp";
        </script>
<%
    } else {
        out.println("Delete Failed ?");
    }

} catch(Exception e){
    out.println(e);
}
%>