<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){
    String name = request.getParameter("project_name");
    String desc = request.getParameter("description");
    String start = request.getParameter("start_date");
    String end = request.getParameter("end_date");

    try{
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO projects (project_name, description, start_date, end_date) VALUES (?, ?, ?, ?)"
        );

        ps.setString(1, name);
        ps.setString(2, desc);
        ps.setString(3, start);
        ps.setString(4, end);

        int i = ps.executeUpdate();

        if(i > 0){
            msg = "? Project Created Successfully!";
        } else {
            msg = "? Error creating project!";
        }

    } catch(Exception e){
        msg = e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Create Project</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">
    <div class="card p-4 shadow">

        <h4>Create Project</h4>

        <% if(!msg.equals("")){ %>
            <div class="alert alert-info"><%= msg %></div>
        <% } %>

        <form method="post">

            <input type="text" name="project_name" placeholder="Project Name" class="form-control mb-3" required>

            <textarea name="description" placeholder="Description" class="form-control mb-3" required></textarea>

            <label>Start Date</label>
            <input type="date" name="start_date" class="form-control mb-3" required>

            <label>End Date</label>
            <input type="date" name="end_date" class="form-control mb-3" required>

            <button class="btn btn-success">Create Project</button>

        </form>

    </div>
</div>

</body>
</html>