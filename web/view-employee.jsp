<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
int totalCount = 0;
try {
    ResultSet rc = con.createStatement().executeQuery("SELECT COUNT(*) FROM employees");
    if(rc.next()) totalCount = rc.getInt(1);
} catch(Exception e){}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Employees — EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #eef2ff;
    background-image:
        radial-gradient(ellipse 80% 65% at 0% 0%,   rgba(59,108,246,0.14) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(14,190,140,0.10) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 50% 0%,   rgba(100,60,220,0.07) 0%, transparent 55%);
    min-height: 100vh;
    color: #1a2040;
}

.grid-bg {
    position: fixed;
    inset: 0;
    background-image:
        linear-gradient(rgba(59,108,246,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(59,108,246,0.04) 1px, transparent 1px);
    background-size: 44px 44px;
    pointer-events: none;
    z-index: 0;
}

.topbar {
    position: relative;
    z-index: 10;
    background: rgba(255,255,255,0.84);
    border-bottom: 1px solid rgba(59,108,246,0.12);
    backdrop-filter: blur(14px);
    padding: 0 32px;
    height: 62px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 1px 16px rgba(59,108,246,0.07);
}

.brand {
    display: flex;
    align-items: center;
    gap: 11px;
    text-decoration: none;
}

.brand-icon {
    width: 36px;
    height: 36px;
    background: linear-gradient(135deg, #3b6cf6, #2d55d6);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.05rem;
    color: #fff;
    box-shadow: 0 2px 12px rgba(59,108,246,0.30);
}

.brand-name {
    font-size: 0.92rem;
    font-weight: 700;
    color: #1a2040;
    line-height: 1.2;
}

.brand-name small {
    display: block;
    font-size: 0.60rem;
    font-weight: 500;
    color: rgba(40,60,160,0.45);
    letter-spacing: 0.5px;
    text-transform: uppercase;
}

.admin-badge {
    background: rgba(59,108,246,0.10);
    border: 1px solid rgba(59,108,246,0.22);
    padding: 3px 11px;
    border-radius: 20px;
    font-size: 0.67rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #3b6cf6;
}

.topbar-right {
    display: flex;
    align-items: center;
    gap: 10px;
}

.clock-box {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(255,255,255,0.68);
    border: 1px solid rgba(59,108,246,0.13);
    padding: 4px 12px;
    border-radius: 8px;
    font-size: 0.75rem;
    font-weight: 600;
    color: rgba(30,45,120,0.55);
    font-variant-numeric: tabular-nums;
}

.back-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(59,108,246,0.09);
    border: 1px solid rgba(59,108,246,0.18);
    color: #3b6cf6;
    padding: 7px 15px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.15s;
}

.back-btn:hover { background: rgba(59,108,246,0.16); color: #3b6cf6; }

.main {
    position: relative;
    z-index: 2;
    padding: 32px 28px 52px;
    max-width: 1300px;
    margin: 0 auto;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(59,108,246,0.50);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.45rem;
    font-weight: 800;
    color: #0e1830;
    letter-spacing: -0.3px;
    margin-bottom: 24px;
}

.summary-row {
    display: grid;
    grid-template-columns: repeat(4,1fr);
    gap: 16px;
    margin-bottom: 24px;
}

.sum-card {
    background: rgba(255,255,255,0.80);
    border: 1px solid rgba(59,108,246,0.12);
    border-radius: 13px;
    padding: 18px 18px;
    display: flex;
    align-items: center;
    gap: 13px;
    box-shadow: 0 2px 12px rgba(59,108,246,0.07);
}

.sum-icon {
    width: 42px;
    height: 42px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    flex-shrink: 0;
}

.si-b  { background: rgba(59,108,246,0.10);  color: #3b6cf6;  border: 1px solid rgba(59,108,246,0.18); }
.si-g  { background: rgba(14,150,100,0.10);  color: #059669;  border: 1px solid rgba(14,150,100,0.18); }
.si-a  { background: rgba(217,119,6,0.10);   color: #d97706;  border: 1px solid rgba(217,119,6,0.18); }
.si-v  { background: rgba(124,58,237,0.10);  color: #7c3aed;  border: 1px solid rgba(124,58,237,0.18); }

.sum-info .sv { font-size: 1.5rem; font-weight: 800; color: #0e1830; line-height: 1; }
.sum-info .sl { font-size: 0.67rem; color: rgba(30,50,120,0.44); text-transform: uppercase; letter-spacing: 0.8px; font-weight: 600; margin-top: 3px; }

.table-card {
    background: rgba(255,255,255,0.82);
    border: 1px solid rgba(59,108,246,0.12);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(59,108,246,0.08);
}

.table-head-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(59,108,246,0.09);
    flex-wrap: wrap;
    gap: 12px;
}

.table-head-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.th-icon {
    width: 34px;
    height: 34px;
    background: rgba(59,108,246,0.10);
    border: 1px solid rgba(59,108,246,0.16);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #3b6cf6;
    font-size: 0.95rem;
}

.th-title { font-size: 0.92rem; font-weight: 700; color: #0e1830; }

.search-box {
    display: flex;
    align-items: center;
    gap: 8px;
    background: rgba(255,255,255,0.85);
    border: 1px solid rgba(59,108,246,0.16);
    border-radius: 8px;
    padding: 7px 13px;
    min-width: 220px;
}

.search-box i { color: rgba(59,108,246,0.45); font-size: 0.88rem; }

.search-box input {
    border: none;
    outline: none;
    background: transparent;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    font-size: 0.82rem;
    color: #1a2040;
    width: 100%;
}

.search-box input::placeholder { color: rgba(30,50,120,0.34); }

.add-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: #3b6cf6;
    color: #fff;
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 700;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: background 0.15s, transform 0.15s;
    box-shadow: 0 3px 12px rgba(59,108,246,0.26);
}

.add-btn:hover { background: #4f80ff; transform: translateY(-1px); color: #fff; }

.table-wrap { overflow-x: auto; }

table { width: 100%; border-collapse: collapse; }

thead tr {
    background: rgba(59,108,246,0.06);
    border-bottom: 1px solid rgba(59,108,246,0.10);
}

thead th {
    padding: 11px 16px;
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.9px;
    color: rgba(30,50,120,0.46);
    text-align: left;
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid rgba(59,108,246,0.06);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(59,108,246,0.03); }

tbody td {
    padding: 12px 16px;
    font-size: 0.82rem;
    color: #1a2040;
    vertical-align: middle;
    text-align: left;
}

.emp-name-cell {
    display: flex;
    align-items: center;
    gap: 10px;
}

.emp-mini-avatar {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: linear-gradient(135deg, #3b6cf6, #7c3aed);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.68rem;
    font-weight: 700;
    color: #fff;
    flex-shrink: 0;
}

.emp-name { font-weight: 600; font-size: 0.83rem; color: #0e1830; }
.emp-id   { font-size: 0.70rem; color: rgba(30,50,120,0.44); }

.gender-chip {
    font-size: 0.68rem;
    font-weight: 600;
    padding: 3px 9px;
    border-radius: 6px;
}

.gc-male   { background: rgba(59,108,246,0.08); color: #3b6cf6; border: 1px solid rgba(59,108,246,0.16); }
.gc-female { background: rgba(236,72,153,0.08); color: #be185d;  border: 1px solid rgba(236,72,153,0.16); }
.gc-other  { background: rgba(124,58,237,0.08); color: #7c3aed;  border: 1px solid rgba(124,58,237,0.16); }

.dept-chip {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background: rgba(14,150,100,0.08);
    border: 1px solid rgba(14,150,100,0.16);
    color: #059669;
    padding: 3px 9px;
    border-radius: 6px;
    font-size: 0.70rem;
    font-weight: 600;
}

.salary-cell {
    font-weight: 700;
    color: #059669;
    font-size: 0.82rem;
}

.role-chip {
    font-size: 0.68rem;
    font-weight: 600;
    padding: 3px 9px;
    border-radius: 6px;
    background: rgba(59,108,246,0.08);
    border: 1px solid rgba(59,108,246,0.14);
    color: #3b6cf6;
    text-transform: capitalize;
}

.empty-row td {
    text-align: center;
    padding: 40px;
    color: rgba(30,50,120,0.38);
    font-size: 0.83rem;
}

@media (max-width: 900px) {
    .summary-row { grid-template-columns: repeat(2,1fr); }
    .main { padding: 20px 14px 40px; }
    .topbar { padding: 0 16px; }
}

@media (max-width: 480px) {
    .summary-row { grid-template-columns: 1fr; }
    .table-head-bar { flex-direction: column; align-items: flex-start; }
}
</style>
</head>
<body>

<div class="grid-bg"></div>

<header class="topbar">
    <a href="admin-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-buildings-fill"></i></div>
        <div class="brand-name">
            EMS Pro
            <small>Admin Panel</small>
        </div>
    </a>
    <span class="admin-badge">Admin</span>
    <div class="topbar-right">
        <div class="clock-box"><i class="bi bi-clock"></i><span id="clk"></span></div>
        <a href="admin-dashboard.jsp" class="back-btn">
            <i class="bi bi-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</header>

<div class="main">

    <div class="page-eyebrow">Admin Panel</div>
    <div class="page-title">Employee Records</div>

<%
int maleCount = 0, femaleCount = 0;
double avgSal = 0;
try {
    ResultSet rm = con.createStatement().executeQuery("SELECT COUNT(*) FROM employees WHERE gender='Male'");
    if(rm.next()) maleCount = rm.getInt(1);
    ResultSet rf = con.createStatement().executeQuery("SELECT COUNT(*) FROM employees WHERE gender='Female'");
    if(rf.next()) femaleCount = rf.getInt(1);
    ResultSet rs2 = con.createStatement().executeQuery("SELECT AVG(salary) FROM employees");
    if(rs2.next()) avgSal = rs2.getDouble(1);
} catch(Exception e){}
%>

    <div class="summary-row">
        <div class="sum-card">
            <div class="sum-icon si-b"><i class="bi bi-people-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= totalCount %></div><div class="sl">Total Employees</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-g"><i class="bi bi-person-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= maleCount %></div><div class="sl">Male</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-a"><i class="bi bi-person-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= femaleCount %></div><div class="sl">Female</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-v"><i class="bi bi-currency-rupee"></i></div>
            <div class="sum-info"><div class="sv">&#8377;<%= String.format("%.0f", avgSal) %></div><div class="sl">Avg. Salary</div></div>
        </div>
    </div>

    <div class="table-card">
        <div class="table-head-bar">
            <div class="table-head-left">
                <div class="th-icon"><i class="bi bi-person-lines-fill"></i></div>
                <div class="th-title">All Employees</div>
            </div>
            <div style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" id="searchInput" placeholder="Search employees..." oninput="filterTable()">
                </div>
                <a href="add-employee.jsp" class="add-btn">
                    <i class="bi bi-person-plus-fill"></i> Add Employee
                </a>
            </div>
        </div>

        <div class="table-wrap">
            <table id="empTable">
                <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Gender</th>
                        <th>Department</th>
                        <th>Job Title</th>
                        <th>Salary</th>
                        <th>Role</th>
                    </tr>
                </thead>
                <tbody>
<%
boolean hasRows = false;
try {
    ResultSet rs = con.prepareStatement(
        "SELECT e.*, d.name AS dept_name FROM employees e LEFT JOIN departments d ON e.department_id=d.id ORDER BY e.id DESC"
    ).executeQuery();
    while(rs.next()){
        hasRows = true;
        String eName = rs.getString("name");
        String eGender = rs.getString("gender") != null ? rs.getString("gender") : "";
        String gClass = "Male".equalsIgnoreCase(eGender) ? "gc-male" : ("Female".equalsIgnoreCase(eGender) ? "gc-female" : "gc-other");
        String avatarInitials = (eName != null && eName.trim().length() >= 2) ? eName.trim().substring(0,2).toUpperCase() : "EM";
%>
                    <tr>
                        <td>
                            <div class="emp-name-cell">
                                <div class="emp-mini-avatar"><%= avatarInitials %></div>
                                <div>
                                    <div class="emp-name"><%= eName %></div>
                                    <div class="emp-id">#<%= rs.getInt("id") %></div>
                                </div>
                            </div>
                        </td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("phone") %></td>
                        <td><span class="gender-chip <%= gClass %>"><%= eGender %></span></td>
                        <td><span class="dept-chip"><i class="bi bi-building"></i> <%= rs.getString("dept_name") != null ? rs.getString("dept_name") : "—" %></span></td>
                        <td><%= rs.getString("job_title") %></td>
                        <td class="salary-cell">&#8377;<%= String.format("%.2f", rs.getDouble("salary")) %></td>
                        <td><span class="role-chip"><%= rs.getString("role") != null ? rs.getString("role") : "—" %></span></td>
                    </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!hasRows){ %>
                    <tr class="empty-row">
                        <td colspan="8"><i class="bi bi-inbox"></i>&nbsp; No employee records found.</td>
                    </tr>
<% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function tick() {
    var el = document.getElementById('clk');
    if(el) el.textContent = new Date().toLocaleTimeString('en-IN', { hour:'2-digit', minute:'2-digit', second:'2-digit' });
}
tick();
setInterval(tick, 1000);

function filterTable() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    var rows = document.querySelectorAll('#empTable tbody tr');
    rows.forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>

</body>
</html>
