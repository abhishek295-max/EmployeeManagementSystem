<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){
    try {
        String deptName = request.getParameter("deptName");

        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM departments WHERE name=?"
        );
        check.setString(1, deptName);
        ResultSet rs = check.executeQuery();

        if(rs.next()){
            msg = "Department already exists ?";
        } else {

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO departments(name) VALUES(?)"
            );
            ps.setString(1, deptName);

            int i = ps.executeUpdate();

            if(i > 0){
                msg = "Department Added Successfully ?";
            } else {
                msg = "Failed ?";
            }
        }

    } catch(Exception e){
        msg = e.toString();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Department</title>

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
    width:400px;
    margin:50px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

input {
    width:100%;
    padding:10px;
    margin:10px 0;
}

button {
    width:100%;
    padding:10px;
    background:#273775;
    color:white;
    border:none;
    cursor:pointer;
}

button:hover {
    background:#1a2450;
}

.msg {
    text-align:center;
    margin-bottom:10px;
    color:green;
}
</style>
</head>

<body>

<header>
    ADD DEPARTMENT
</header>

<div class="container">

<div class="msg"><%= msg %></div>

<form method="post">

    <input type="text" name="deptName" placeholder="Enter Department Name" required>

    <button type="submit">Add Department</button>

</form>

<br>
<a href="admin-dashboard.jsp">
    <button>Back to Dashboard</button>
</a>

</div>

</body>
</html> 