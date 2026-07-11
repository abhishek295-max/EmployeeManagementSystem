<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
int empCount = 0, managerCount = 0, deptCount = 0;
try {
    ResultSet r1 = con.prepareStatement("SELECT COUNT(*) FROM employees").executeQuery();
    if(r1.next()) empCount = r1.getInt(1);
    ResultSet r2 = con.prepareStatement("SELECT COUNT(*) FROM employees WHERE role='manager'").executeQuery();
    if(r2.next()) managerCount = r2.getInt(1);
    ResultSet r3 = con.prepareStatement("SELECT COUNT(*) FROM departments").executeQuery();
    if(r3.next()) deptCount = r3.getInt(1);
} catch(Exception e){ out.println(e); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #ddeaff;
    background-image:
        radial-gradient(ellipse 80% 65% at 0% 0%,    rgba(80, 150, 255, 0.38) 0%, transparent 55%),
        radial-gradient(ellipse 65% 55% at 100% 100%, rgba(20, 200, 160, 0.28) 0%, transparent 55%),
        radial-gradient(ellipse 55% 50% at 60% 10%,  rgba(170, 100, 255, 0.18) 0%, transparent 50%),
        radial-gradient(ellipse 45% 40% at 100% 5%,  rgba(255, 130, 70,  0.13) 0%, transparent 50%);
    min-height: 100vh;
    color: #1a2a45;
}

.topbar {
    background: rgb(255, 255, 179);
    border-bottom: 1px solid rgba(100, 140, 230, 0.20);
    backdrop-filter: blur(14px);
    padding: 13px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 18px rgba(80, 120, 220, 0.10);
}

.brand {
    display: flex;
    align-items: center;
    gap: 11px;
    font-size: 1.05rem;
    font-weight: 700;
    color: #1a2a45;
}

.brand-icon {
    width: 36px;
    height: 36px;
    background: rgba(42, 100, 230, 0.90);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(42, 100, 230, 0.38);
}

.admin-badge {
    background: rgba(42, 100, 230, 0.12);
    border: 1px solid rgba(42, 100, 230, 0.28);
    padding: 3px 12px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #2a64e6;
}

.logout-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(210, 35, 45, 0.85);
    border: none;
    color: #fff;
    padding: 7px 16px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: opacity 0.15s;
    box-shadow: 0 2px 10px rgba(210, 35, 45, 0.28);
}

.logout-btn:hover { opacity: 0.82; color: #fff; }

.main {
    padding: 32px 28px 52px;
    max-width: 1100px;
    margin: 0 auto;
}

.page-heading {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(42, 100, 200, 0.55);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.55rem;
    font-weight: 800;
    color: #15243c;
    margin-bottom: 26px;
    letter-spacing: -0.3px;
}

.stat-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
    margin-bottom: 26px;
}

.stat-card {
    background: rgba(255, 255, 255, 0.72);
    border: 1px solid rgba(100, 150, 255, 0.18);
    border-radius: 14px;
    padding: 22px 20px;
    display: flex;
    align-items: center;
    gap: 16px;
    box-shadow: 0 2px 14px rgba(80, 120, 220, 0.10);
}

.stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.25rem;
    flex-shrink: 0;
}

.si-blue   { background: rgba(42, 100, 230, 0.12); color: #2a64e6; border: 1px solid rgba(42, 100, 230, 0.22); }
.si-green  { background: rgba(14, 170, 120, 0.12); color: #0ea878; border: 1px solid rgba(14, 170, 120, 0.22); }
.si-violet { background: rgba(140, 70, 225, 0.12); color: #8c46e1; border: 1px solid rgba(140, 70, 225, 0.22); }

.s-label {
    font-size: 0.71rem;
    color: rgba(30, 55, 100, 0.50);
    text-transform: uppercase;
    letter-spacing: 0.8px;
    font-weight: 600;
    margin-bottom: 3px;
}

.s-val {
    font-size: 1.85rem;
    font-weight: 800;
    color: #15243c;
    line-height: 1;
}

.sections-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
}

.sec-card {
    background: rgba(255, 255, 255, 0.65);
    border: 1px solid rgba(100, 150, 255, 0.15);
    border-radius: 14px;
    padding: 22px 20px;
    box-shadow: 0 2px 12px rgba(80, 120, 220, 0.08);
    transition: border-color 0.18s, background 0.18s, box-shadow 0.18s;
}

.sec-card:hover {
    background: rgba(255, 255, 255, 0.88);
    border-color: rgba(42, 100, 230, 0.32);
    box-shadow: 0 6px 24px rgba(42, 100, 230, 0.14);
}

.sec-header {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 16px;
}

.sec-icon {
    width: 34px;
    height: 34px;
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.95rem;
    background: rgba(42, 100, 230, 0.12);
    color: #2a64e6;
    border: 1px solid rgba(42, 100, 230, 0.20);
}

.sec-title {
    font-size: 0.88rem;
    font-weight: 700;
    color: #1a2a45;
}

.btn-group-v {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.action-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    background: rgba(42, 100, 230, 0.08);
    border: 1px solid rgba(42, 100, 230, 0.18);
    color: #2a55cc;
    padding: 9px 14px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.15s, border-color 0.15s, color 0.15s;
}

.action-btn:hover {
    background: rgba(42, 100, 230, 0.16);
    border-color: rgba(42, 100, 230, 0.36);
    color: #1a3eaa;
}

.action-btn i { font-size: 0.82rem; }

@media (max-width: 768px) {
    .stat-grid     { grid-template-columns: 1fr; }
    .sections-grid { grid-template-columns: 1fr; }
    .main          { padding: 20px 16px 40px; }
}
</style>
</head>
<body>

<header class="topbar">
    <div class="brand">
        <div class="brand-icon"><i class="bi bi-buildings-fill"></i></div>
        Employee Management System
        <span class="admin-badge">Admin</span>
    </div>
    <a href="index.html" class="logout-btn">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</header>

<div class="main">

    <div class="page-heading">Overview</div>
    <div class="page-title">Admin Dashboard</div>

    <div class="stat-grid">
        <div class="stat-card">
            <div class="stat-icon si-blue"><i class="bi bi-people-fill"></i></div>
            <div>
                <div class="s-label">Total Employees</div>
                <div class="s-val"><%= empCount %></div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon si-green"><i class="bi bi-person-check-fill"></i></div>
            <div>
                <div class="s-label">Total Managers</div>
                <div class="s-val"><%= managerCount %></div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon si-violet"><i class="bi bi-diagram-3-fill"></i></div>
            <div>
                <div class="s-label">Departments</div>
                <div class="s-val"><%= deptCount %></div>
            </div>
        </div>
    </div>

    <div class="sections-grid">

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-person-lines-fill"></i></div>
                <div class="sec-title">Employee Management</div>
            </div>
            <div class="btn-group-v">
                <a href="add-employee.jsp"    class="action-btn"><i class="bi bi-person-plus-fill"></i> Add Employee</a>
                <a href="view-employee.jsp"   class="action-btn"><i class="bi bi-eye-fill"></i> View Employees</a>
                <a href="update-view-employee.jsp" class="action-btn"><i class="bi bi-pencil-fill"></i> Update Employee</a>
                <a href="delete-view-employee.jsp" class="action-btn"><i class="bi bi-trash3-fill"></i> Delete Employee</a>
            </div>
        </div>

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-diagram-3-fill"></i></div>
                <div class="sec-title">Department Management</div>
            </div>
            <div class="btn-group-v">
                <a href="add-department.jsp"  class="action-btn"><i class="bi bi-plus-circle-fill"></i> Add Department</a>
                <a href="view-department.jsp" class="action-btn"><i class="bi bi-grid-fill"></i> View Departments</a>
            </div>
        </div>

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-shield-fill-check"></i></div>
                <div class="sec-title">Role Management</div>
            </div>
            <div class="btn-group-v">
                <a href="assign-role.jsp" class="action-btn"><i class="bi bi-person-badge-fill"></i> Assign Roles</a>
            </div>
        </div>

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-cash-stack"></i></div>
                <div class="sec-title">Salary Structure</div>
            </div>
            <div class="btn-group-v">
                <a href="salary-setup.jsp" class="action-btn"><i class="bi bi-currency-rupee"></i> Setup Salary</a>
            </div>
        </div>
        
        <div class="sec-card">
    <div class="sec-header">
        <div class="sec-icon"><i class="bi bi-kanban-fill"></i></div>
        <div class="sec-title">Project Management</div>
    </div>
    <div class="btn-group-v">
        <a href="project.jsp" class="action-btn">
            <i class="bi bi-plus-square-fill"></i> Assign Project
        </a>
        <a href="view-projects.jsp" class="action-btn">
            <i class="bi bi-eye-fill"></i> View Projects
        </a>
    </div>
</div>

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-bar-chart-fill"></i></div>
                <div class="sec-title">Reports & Analytics</div>
            </div>
            <div class="btn-group-v">
                <a href="reports.jsp" class="action-btn"><i class="bi bi-file-earmark-bar-graph-fill"></i> View Reports</a>
            </div>
        </div>

        <div class="sec-card">
            <div class="sec-header">
                <div class="sec-icon"><i class="bi bi-gear-fill"></i></div>
                <div class="sec-title">System Settings</div>
            </div>
            <div class="btn-group-v">
                <a href="settings.jsp" class="action-btn"><i class="bi bi-toggles"></i> Permissions</a>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
