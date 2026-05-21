<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){
    try {

        String attendance = request.getParameter("attendance");
        String payroll = request.getParameter("payroll");
        String leave = request.getParameter("leave");
        String autoLeave = request.getParameter("auto_leave");
        String email = request.getParameter("email");

        PreparedStatement ps = con.prepareStatement(
        "UPDATE system_settings SET setting_value=? WHERE setting_key=?"
        );

        ps.setString(1, attendance); ps.setString(2, "attendance"); ps.executeUpdate();
        ps.setString(1, payroll); ps.setString(2, "payroll"); ps.executeUpdate();
        ps.setString(1, leave); ps.setString(2, "leave"); ps.executeUpdate();
        ps.setString(1, autoLeave); ps.setString(2, "auto_approve_leave"); ps.executeUpdate();
        ps.setString(1, email); ps.setString(2, "email_notifications"); ps.executeUpdate();

        msg = "Settings Saved Successfully ?";

    } catch(Exception e){
        msg = e.toString();
    }
}

String attendance="on", payroll="on", leave="on", autoLeave="off", email="on";

try{
    PreparedStatement ps = con.prepareStatement("SELECT * FROM system_settings");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
        String key = rs.getString("setting_key");
        String val = rs.getString("setting_value");

        if(key.equals("attendance")) attendance = val;
        if(key.equals("payroll")) payroll = val;
        if(key.equals("leave")) leave = val;
        if(key.equals("auto_approve_leave")) autoLeave = val;
        if(key.equals("email_notifications")) email = val;
    }

}catch(Exception e){
    out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>System Settings</title>

<style>
body { font-family: Arial; background:#eef2f7; margin:0; }

header {
    background:#273775;
    color:white;
    text-align:center;
    padding:15px;
}

.container {
    width:450px;
    margin:30px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

.row {
    display:flex;
    justify-content:space-between;
    margin:10px 0;
}

button {
    width:100%;
    padding:10px;
    background:#273775;
    color:white;
    border:none;
    cursor:pointer;
    margin-top:15px;
}

button:hover { background:#1a2450; }

.msg {
    text-align:center;
    color:green;
    margin-bottom:10px;
}
</style>
</head>

<body>

<header>
    SYSTEM SETTINGS
</header>

<div class="container">

<div class="msg"><%= msg %></div>

<form method="post">

<div class="row">
    <label>Attendance Module</label>
    <input type="checkbox" name="attendance" value="on" <%= attendance.equals("on")?"checked":"" %>>
</div>

<div class="row">
    <label>Payroll Module</label>
    <input type="checkbox" name="payroll" value="on" <%= payroll.equals("on")?"checked":"" %>>
</div>

<div class="row">
    <label>Leave Management</label>
    <input type="checkbox" name="leave" value="on" <%= leave.equals("on")?"checked":"" %>>
</div>



<div class="row">
    <label>Email Notifications</label>
    <input type="checkbox" name="email" value="on" <%= email.equals("on")?"checked":"" %>>
</div>

<button type="submit">Save Settings</button>

</form>

<br>
<a href="admin-dashboard.jsp">
    <button>Back</button>
</a>

</div>

</body>
</html>