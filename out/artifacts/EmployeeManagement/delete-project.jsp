<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

try{
    String id = request.getParameter("id");

    if(id != null){

        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM projects WHERE id=?"
        );

        ps.setInt(1, Integer.parseInt(id));

        int i = ps.executeUpdate();

        if(i > 0){
            msg = "? Project Deleted Successfully!";
        } else {
            msg = "? Project Not Found!";
        }
    }

} catch(Exception e){
    msg = "Error: " + e.getMessage();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Delete Project</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f8f9fa;
    font-family:'Segoe UI';
}
.container{
    margin-top:80px;
    max-width:500px;
}
</style>

</head>

<body>

<div class="container">
    <div class="card shadow p-4 text-center">

        <h4>Delete Project</h4>

        <% if(!msg.equals("")){ %>
            <div class="alert alert-info mt-3"><%= msg %></div>
        <% } %>

        <a href="view-projects.jsp" class="btn btn-primary mt-3">
            Back to Projects
        </a>

    </div>
</div>

</body>
</html>