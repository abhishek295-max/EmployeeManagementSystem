<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){
    response.sendRedirect("hr-login.jsp");
}
%>
<%
String emp    = request.getParameter("employee_id");
String date   = request.getParameter("date");
String status = request.getParameter("status");
String cin    = request.getParameter("check_in");
String cout   = request.getParameter("check_out");
String msg    = "";
String msgType = "";
if(emp != null){
    try{
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO attendance(employee_id,date,status,check_in,check_out) VALUES (?,?,?,?,?)"
        );
        ps.setInt(1, Integer.parseInt(emp));
        ps.setString(2, date);
        ps.setString(3, status);
        ps.setString(4, cin);
        ps.setString(5, cout);
        ps.executeUpdate();
        msg = "Attendance marked successfully for Employee ID " + emp;
        msgType = "success";
    }catch(Exception e){
        msg = "Error: " + e.getMessage();
        msgType = "error";
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Attendance Management ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e2f4ee;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(20,190,140,0.30) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.20) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(80,200,180,0.14) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
}

.topbar {
    background: rgba(255,255,255,0.80);
    border-bottom: 1px solid rgba(20,170,120,0.18);
    backdrop-filter: blur(14px);
    padding: 12px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 16px rgba(20,160,110,0.10);
}

.brand {
    display: flex;
    align-items: center;
    gap: 11px;
    font-size: 1.05rem;
    font-weight: 700;
    color: #12283a;
    text-decoration: none;
}

.brand-icon {
    width: 36px;
    height: 36px;
    background: rgba(14,160,110,0.92);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(14,160,110,0.38);
}

.hr-badge {
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.28);
    padding: 3px 12px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #0a9a6e;
}

.back-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.22);
    color: #0a9a6e;
    padding: 7px 15px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.15s;
}

.back-btn:hover {
    background: rgba(14,160,110,0.18);
    color: #0a9a6e;
}

.main {
    padding: 32px 28px 52px;
    max-width: 1100px;
    margin: 0 auto;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(14,140,100,0.55);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.5rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin-bottom: 26px;
}

.layout {
    display: grid;
    grid-template-columns: 360px 1fr;
    gap: 24px;
    align-items: start;
}

.form-card {
    background: rgba(255,255,255,0.75);
    border: 1px solid rgba(14,160,110,0.16);
    border-radius: 16px;
    padding: 26px 24px;
    box-shadow: 0 4px 18px rgba(14,160,110,0.10);
}

.form-card-title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 0.95rem;
    font-weight: 700;
    color: #0e2030;
    margin-bottom: 22px;
    padding-bottom: 14px;
    border-bottom: 1px solid rgba(14,160,110,0.12);
}

.form-card-title .fc-icon {
    width: 34px;
    height: 34px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.20);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0a9a6e;
    font-size: 0.95rem;
}

.f-label {
    font-size: 0.71rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: rgba(18,40,58,0.52);
    margin-bottom: 5px;
    display: block;
}

.f-input {
    width: 100%;
    background: rgba(255,255,255,0.80);
    border: 1px solid rgba(14,160,110,0.22);
    border-radius: 9px;
    color: #12283a;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.85rem;
    padding: 10px 13px;
    margin-bottom: 14px;
    outline: none;
    transition: border-color 0.18s, box-shadow 0.18s;
}

.f-input:focus {
    border-color: #0a9a6e;
    box-shadow: 0 0 0 3px rgba(14,160,110,0.14);
    background: #fff;
}

.f-select {
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%230a9a6e' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 13px center;
    cursor: pointer;
}

.time-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
}

.submit-btn {
    width: 100%;
    padding: 11px;
    background: rgba(14,160,110,0.90);
    border: none;
    border-radius: 9px;
    color: #fff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.86rem;
    font-weight: 700;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    transition: opacity 0.15s, transform 0.15s;
    box-shadow: 0 3px 14px rgba(14,160,110,0.30);
    margin-top: 4px;
}

.submit-btn:hover { opacity: 0.88; transform: translateY(-1px); }

.alert-success {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.25);
    color: #0a7a58;
    padding: 11px 14px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 600;
    margin-bottom: 16px;
}

.alert-error {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(220,40,50,0.08);
    border: 1px solid rgba(220,40,50,0.22);
    color: #b91c1c;
    padding: 11px 14px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 600;
    margin-bottom: 16px;
}

.table-card {
    background: rgba(255,255,255,0.75);
    border: 1px solid rgba(14,160,110,0.14);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(14,160,110,0.08);
}

.table-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(14,160,110,0.12);
}

.table-header-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.t-icon {
    width: 34px;
    height: 34px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.18);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0a9a6e;
    font-size: 0.95rem;
}

.t-title {
    font-size: 0.92rem;
    font-weight: 700;
    color: #0e2030;
}

.table-wrap {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead tr {
    background: rgba(14,160,110,0.08);
    border-bottom: 1px solid rgba(14,160,110,0.14);
}

thead th {
    padding: 11px 16px;
    font-size: 0.68rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.9px;
    color: rgba(18,40,58,0.50);
    text-align: left;
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid rgba(14,160,110,0.08);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(14,160,110,0.05); }

tbody td {
    padding: 11px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    text-align: left;
}

.badge-present {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.22);
    color: #0a7a58;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
}

.badge-absent {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(220,40,50,0.10);
    border: 1px solid rgba(220,40,50,0.20);
    color: #b91c1c;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
}

.badge-leave {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(230,120,30,0.10);
    border: 1px solid rgba(230,120,30,0.20);
    color: #b45309;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
}

.empty-row td {
    text-align: center;
    padding: 30px;
    color: rgba(18,40,58,0.40);
    font-size: 0.82rem;
}

@media (max-width: 900px) {
    .layout { grid-template-columns: 1fr; }
    .main { padding: 20px 14px 40px; }
    .time-row { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="hr-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-people-fill"></i></div>
        Employee Management System
        <span class="hr-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">

    <div class="page-eyebrow">HR Panel</div>
    <div class="page-title">Attendance Management</div>

    <div class="layout">

        <div>
            <% if(!msg.isEmpty()){ %>
                <% if(msgType.equals("success")){ %>
                    <div class="alert-success">
                        <i class="bi bi-check-circle-fill"></i> <%= msg %>
                    </div>
                <% } else { %>
                    <div class="alert-error">
                        <i class="bi bi-exclamation-circle-fill"></i> <%= msg %>
                    </div>
                <% } %>
            <% } %>

            <div class="form-card">
                <div class="form-card-title">
                    <div class="fc-icon"><i class="bi bi-calendar2-plus-fill"></i></div>
                    Mark Attendance
                </div>
                <form method="post">
                    <label class="f-label">Employee ID</label>
                    <input type="number" name="employee_id" class="f-input" placeholder="Enter Employee ID" required>

                    <label class="f-label">Date</label>
                    <input type="date" name="date" class="f-input" required>

                    <label class="f-label">Status</label>
                    <select name="status" class="f-input f-select">
                        <option value="Present">Present</option>
                        <option value="Absent">Absent</option>
                        <option value="Leave">Leave</option>
                    </select>

                    <div class="time-row">
                        <div>
                            <label class="f-label">Check In</label>
                            <input type="time" name="check_in" class="f-input">
                        </div>
                        <div>
                            <label class="f-label">Check Out</label>
                            <input type="time" name="check_out" class="f-input">
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="bi bi-check-circle-fill"></i> Save Attendance
                    </button>
                </form>
            </div>
        </div>

        <div class="table-card">
            <div class="table-header">
                <div class="table-header-left">
                    <div class="t-icon"><i class="bi bi-table"></i></div>
                    <div class="t-title">Attendance Records</div>
                </div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Employee ID</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Check In</th>
                            <th>Check Out</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean hasRows = false;
try {
    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM attendance ORDER BY date DESC");
    while(rs.next()){
        hasRows = true;
        String rowStatus = rs.getString("status");
        String badgeClass = "badge-present";
        if("Absent".equalsIgnoreCase(rowStatus)) badgeClass = "badge-absent";
        else if("Leave".equalsIgnoreCase(rowStatus)) badgeClass = "badge-leave";
%>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><strong><%= rs.getInt("employee_id") %></strong></td>
                            <td><%= rs.getString("date") %></td>
                            <td><span class="<%= badgeClass %>"><%= rowStatus %></span></td>
                            <td><%= rs.getString("check_in") != null ? rs.getString("check_in") : "?" %></td>
                            <td><%= rs.getString("check_out") != null ? rs.getString("check_out") : "?" %></td>
                        </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!hasRows){ %>
                        <tr class="empty-row">
                            <td colspan="6"><i class="bi bi-inbox"></i> No attendance records found.</td>
                        </tr>
<% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
