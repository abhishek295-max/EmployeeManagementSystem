<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Delete Employees</title>

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
    width:100%;
    border-collapse: collapse;
    background:white;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

th, td {
    padding:10px;
    text-align:center;
    border-bottom:1px solid #ddd;
    font-size:14px;
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

.edit { background:green; }
.delete { background:red; }

.top-btn {
    margin-bottom:15px;
}

</style>
</head>

<body>

<header>
   DELETE EMPLOYEES
</header>

<div class="container">

<a href="admin-dashboard.jsp">
    <button class="btn top-btn">? Back</button>
</a>

<table>

<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Gender</th>
    <th>Department</th>
    <th>Job</th>
    <th>Salary</th>
    <th>Role</th>
    <th>Action</th>
</tr>

<%
try {

    PreparedStatement ps = con.prepareStatement(
        "SELECT e.*, d.name AS dept_name FROM employees e LEFT JOIN departments d ON e.department_id=d.id"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("phone") %></td>
    <td><%= rs.getString("gender") %></td>
    <td><%= rs.getString("dept_name") %></td>
    <td><%= rs.getString("job_title") %></td>
    <td><%= rs.getDouble("salary") %></td>
    <td><%= rs.getString("role") %></td>

    <td>
        

        <a href="delete-employee.jsp?id=<%= rs.getInt("id") %>">
            <button class="btn delete" onclick="return confirm('Delete this employee?')">Delete</button>
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