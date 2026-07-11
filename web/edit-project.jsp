<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

String id = request.getParameter("id");

String name = "";
String desc = "";
String start = "";
String end = "";

// ? STEP 1: FETCH EXISTING DATA
if(id != null && request.getMethod().equalsIgnoreCase("GET")){
    try{
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM projects WHERE id=?"
        );
        ps.setInt(1, Integer.parseInt(id));

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            name = rs.getString("project_name");
            desc = rs.getString("description");
            start = rs.getString("start_date");
            end = rs.getString("end_date");
        }

    } catch(Exception e){
        msg = e.getMessage();
    }
}

// ? STEP 2: UPDATE DATA
if(request.getMethod().equalsIgnoreCase("POST")){
    try{
        id = request.getParameter("id");
        name = request.getParameter("project_name");
        desc = request.getParameter("description");
        start = request.getParameter("start_date");
        end = request.getParameter("end_date");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE projects SET project_name=?, description=?, start_date=?, end_date=? WHERE id=?"
        );

        ps.setString(1, name);
        ps.setString(2, desc);
        ps.setString(3, start);
        ps.setString(4, end);
        ps.setInt(5, Integer.parseInt(id));

        int i = ps.executeUpdate();

        if(i > 0){
            msg = "? Project Updated Successfully!";
        } else {
            msg = "? Update Failed!";
        }

    } catch(Exception e){
        msg = e.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Project</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#eef4ff;
    font-family:'Segoe UI';
}
.container{
    margin-top:50px;
    max-width:600px;
}
.card{
    border-radius:15px;
}
</style>

</head>

<body>

<div class="container">
<div class="card shadow p-4">

    <h4>Edit Project</h4>

    <% if(!msg.equals("")){ %>
        <div class="alert alert-info mt-2"><%= msg %></div>
    <% } %>

    <form method="post">

        <input type="hidden" name="id" value="<%= id %>">

        <label>Project Name</label>
        <input type="text" name="project_name" value="<%= name %>" class="form-control mb-3" required>

        <label>Description</label>
        <textarea name="description" class="form-control mb-3" required><%= desc %></textarea>

        <label>Start Date</label>
        <input type="date" name="start_date" value="<%= start %>" class="form-control mb-3" required>

        <label>End Date</label>
        <input type="date" name="end_date" value="<%= end %>" class="form-control mb-3" required>

        <button class="btn btn-success">Update Project</button>
        <a href="view-projects.jsp" class="btn btn-secondary">Back</a>

    </form>

</div>
</div>

</body>
</html>