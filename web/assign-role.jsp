<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){
    try {
        int empId = Integer.parseInt(request.getParameter("emp_id"));
        String role = request.getParameter("role");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE employees SET role=? WHERE id=?"
        );

        ps.setString(1, role);
        ps.setInt(2, empId);

        int i = ps.executeUpdate();

        if(i > 0){
            msg = "Role Assigned Successfully ?";
        } else {
            msg = "Failed ?";
        }

    } catch(Exception e){
        msg = e.toString();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Assign Role</title>

<style>
body {
    font-family: Arial;
    background:#eef2f7;
    margin:0;
}

header {
    background:#273775;
    color:white;
    text-align:center;
    padding:15px;
}

.container {
    width:420px;
    margin:40px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

select, button {
    width:100%;
    padding:10px;
    margin:10px 0;
}

button {
    background:#273775;
    color:white;
    border:none;
    cursor:pointer;
}

button:hover { background:#1a2450; }

.msg {
    text-align:center;
    margin-bottom:10px;
    color:green;
}
</style>
</head>

<body>

<header>
    ASSIGN ROLE
</header>

<div class="container">

<div class="msg"><%= msg %></div>

<form method="post">

    <!-- Employee Dropdown -->
    <select name="emp_id" required>
        <option value="">Select Employee</option>

        <%
        try{
            PreparedStatement ps = con.prepareStatement("SELECT id, name FROM employees");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>
            <option value="<%= rs.getInt("id") %>">
                <%= rs.getString("name") %> (ID: <%= rs.getInt("id") %>)
            </option>
        <%
            }
        } catch(Exception e){
            out.println(e);
        }
        %>
    </select>

    <!-- Role Dropdown -->
    <select name="role" required>
        <option value="">Select Role</option>
        <option>Admin</option>
        <option>HR</option>
        <option>Manager</option>
        <option>Employee</option>
    </select>

    <button type="submit">Assign Role</button>

</form>

<br>
<a href="admin-dashboard.jsp">
    <button>Back to Dashboard</button>
</a>

</div>

</body>
</html>