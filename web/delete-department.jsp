<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
try {
    int id = Integer.parseInt(request.getParameter("id"));

    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM departments WHERE id=?"
    );

    ps.setInt(1, id);
    int i = ps.executeUpdate();

    if(i > 0){
%>
        <script>
            alert("Department Deleted ?");
            window.location="view-department.jsp";
        </script>
<%
    } else {
        out.println("Delete Failed ?");
    }

} catch(Exception e){
    out.println(e);
}
%>