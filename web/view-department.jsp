<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>View Departments</title>

<style>
body {
    font-family: Arial;
    margin:0;
    background:#eef2f7;
}

header {
    background:#273775;
    color:white;
    text-align:center;
    padding:15px;
}

.container {
    padding:20px;
}

table {
    width:60%;
    margin:auto;
    border-collapse: collapse;
    background:white;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

th, td {
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

th {
    background:#273775;
    color:white;
}

tr:hover {
    background:#f5f5f5;
}

.btn {
    padding:6px 10px;
    border:none;
    border-radius:4px;
    cursor:pointer;
    color:white;
}

.delete {
    background:red;
}

.top-btn {
    margin-bottom:15px;
}
</style>
</head>

<body>

<header>
    VIEW DEPARTMENTS
</header>

<div class="container">

<a href="admin-dashboard.jsp">
    <button class="btn top-btn">? Back</button>
</a>

<table>

<tr>
    <th>ID</th>
    <th>Department Name</th>
    <th>Action</th>
</tr>

<%
try {

    PreparedStatement ps = con.prepareStatement("SELECT * FROM departments");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>

    <td>
        <a href="delete-department.jsp?id=<%= rs.getInt("id") %>">
            <button class="btn delete" onclick="return confirm('Delete this department?')">
                Delete
            </button>
        </a>
    </td>
</tr>

<%
    }

} catch(Exception e){
    out.println(e);
}
%>

</table>

</div>

</body>
</html>