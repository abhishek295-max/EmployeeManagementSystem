<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

int id = 0;
String name="", email="", phone="", gender="", job="", hireDate="", address="";
int deptId = 0;
double salary = 0;

try {
    id = Integer.parseInt(request.getParameter("id"));

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM employees WHERE id=?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        name = rs.getString("name");
        email = rs.getString("email");
        phone = rs.getString("phone");
        gender = rs.getString("gender");
        deptId = rs.getInt("department_id");
        job = rs.getString("job_title");
        hireDate = rs.getString("hire_date");
        salary = rs.getDouble("salary");
        address = rs.getString("address");
    }

} catch(Exception e){
    out.println(e);
}

if(request.getMethod().equalsIgnoreCase("POST")){
    try {

        name = request.getParameter("name");
        email = request.getParameter("email");
        phone = request.getParameter("phone");
        gender = request.getParameter("gender");
        deptId = Integer.parseInt(request.getParameter("department"));
        job = request.getParameter("job_title");
        hireDate = request.getParameter("hire_date");
        salary = Double.parseDouble(request.getParameter("salary"));
        address = request.getParameter("address");

        PreparedStatement ps = con.prepareStatement(
        "UPDATE employees SET name=?,email=?,phone=?,gender=?,department_id=?,job_title=?,hire_date=?,salary=?,address=? WHERE id=?"
        );

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, phone);
        ps.setString(4, gender);
        ps.setInt(5, deptId);
        ps.setString(6, job);
        ps.setString(7, hireDate);
        ps.setDouble(8, salary);
        ps.setString(9, address);
        ps.setInt(10, id);

        int i = ps.executeUpdate();

        if(i > 0){
            msg = "Employee Updated Successfully ?";
        } else {
            msg = "Update Failed ?";
        }

    } catch(Exception e){
        msg = e.toString();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Update Employee</title>

<style>
body { font-family: Arial; background:#eef2f7; margin:0; }

header {
    background:#273775;
    color:white;
    text-align:center;
    padding:15px;
}

.container {
    width:420px;
    margin:30px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

input, select, textarea {
    width:100%;
    padding:10px;
    margin:6px 0;
}

button {
    width:100%;
    padding:10px;
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
    UPDATE EMPLOYEE
</header>

<div class="container">

<div class="msg"><%= msg %></div>

<form method="post">

    <input type="text" name="name" value="<%= name %>" required>

    <input type="email" name="email" value="<%= email %>" required>

    <input type="text" name="phone" value="<%= phone %>" required>

    <select name="gender" required>
        <option <%= gender.equals("Male")?"selected":"" %>>Male</option>
        <option <%= gender.equals("Female")?"selected":"" %>>Female</option>
    </select>

    <select name="department" required>
        <%
        try{
            PreparedStatement ps2 = con.prepareStatement("SELECT * FROM departments");
            ResultSet rs2 = ps2.executeQuery();

            while(rs2.next()){
                int did = rs2.getInt("id");
        %>
            <option value="<%= did %>" <%= (did==deptId)?"selected":"" %>>
                <%= rs2.getString("name") %>
            </option>
        <%
            }
        } catch(Exception e){
            out.println(e);
        }
        %>
    </select>

    <input type="text" name="job_title" value="<%= job %>" required>

    <input type="date" name="hire_date" value="<%= hireDate %>" required>

    <input type="number" name="salary" value="<%= salary %>" required>

    <textarea name="address"><%= address %></textarea>

    <button type="submit">Update Employee</button>

</form>

<br>
<a href="view-employee.jsp">
    <button>Back</button>
</a>

</div>

</body>
</html>