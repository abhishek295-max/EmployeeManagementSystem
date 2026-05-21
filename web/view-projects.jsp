<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>View Projects</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    background:#eef4ff;
    font-family:'Segoe UI';
}

.container{
    margin-top:40px;
}

.card{
    border-radius:15px;
}

.table th{
    background:#0a9a6e;
    color:white;
}

.badge-status{
    padding:6px 10px;
    border-radius:6px;
    font-size:12px;
}
.pending{ background:#ffc107; color:black; }
.completed{ background:#28a745; color:white; }

</style>

</head>

<body>

<div class="container">
<div class="card shadow p-4">

    <h4 class="mb-4">
        <i class="bi bi-kanban-fill"></i> All Projects
    </h4>

    <table class="table table-bordered table-hover text-center">

        <thead>
            <tr>
                <th>ID</th>
                <th>Project Name</th>
                <th>Description</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody>

        <%
        try{
            PreparedStatement ps = con.prepareStatement("SELECT * FROM projects ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>

            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("project_name") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("start_date") %></td>
                <td><%= rs.getString("end_date") %></td>
                <td>
    <a href="edit-project.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning">
        <i class="bi bi-pencil"></i>
    </a>

    <a href="delete-project.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger">
        <i class="bi bi-trash"></i>
    </a>
</td>
            </tr>

        <%
            }
        } catch(Exception e){
            out.println("<tr><td colspan='5'>Error: "+e.getMessage()+"</td></tr>");
        }
        %>

        </tbody>

    </table>

    <a href="admin-dashboard.jsp" class="btn btn-secondary mt-3">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>

</div>
</div>

</body>
</html>