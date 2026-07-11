<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
int totalEmp = 0;
double avgSalary = 0, maxSalary = 0, minSalary = 0;
try {
    ResultSet r1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM employees");
    if(r1.next()) totalEmp = r1.getInt(1);
    ResultSet r2 = con.createStatement().executeQuery("SELECT AVG(salary),MAX(salary),MIN(salary) FROM employees");
    if(r2.next()){ avgSalary = r2.getDouble(1); maxSalary = r2.getDouble(2); minSalary = r2.getDouble(3); }
} catch(Exception e){ out.println(e); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reports & Analytics ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e8f0fb;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(42,100,230,0.26) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(14,190,100,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 0%,   rgba(230,120,30,0.10) 0%, transparent 50%),
        radial-gradient(ellipse 40% 40% at 0% 100%,  rgba(150,60,220,0.10) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
}

.topbar {
    background: rgba(255,255,255,0.82);
    border-bottom: 1px solid rgba(42,100,230,0.16);
    backdrop-filter: blur(14px);
    padding: 12px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 16px rgba(42,100,230,0.10);
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
    background: rgba(42,100,230,0.90);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(42,100,230,0.36);
}

.admin-badge {
    background: rgba(42,100,230,0.12);
    border: 1px solid rgba(42,100,230,0.26);
    padding: 3px 12px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #2a64e6;
}

.back-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(42,100,230,0.10);
    border: 1px solid rgba(42,100,230,0.20);
    color: #2a64e6;
    padding: 7px 15px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.15s;
}

.back-btn:hover { background: rgba(42,100,230,0.18); color: #2a64e6; }

.main {
    padding: 32px 28px 52px;
    max-width: 1160px;
    margin: 0 auto;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(42,100,230,0.52);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.5rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin-bottom: 26px;
}

.summary-grid {
    display: grid;
    grid-template-columns: repeat(4,1fr);
    gap: 16px;
    margin-bottom: 28px;
}

.sum-card {
    background: rgba(255,255,255,0.74);
    border: 1px solid rgba(42,100,230,0.13);
    border-radius: 14px;
    padding: 20px 18px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 14px rgba(42,100,230,0.08);
    transition: transform 0.18s, box-shadow 0.18s;
}

.sum-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 24px rgba(42,100,230,0.13);
}

.sum-icon {
    width: 46px;
    height: 46px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    flex-shrink: 0;
}

.si-b { background: rgba(42,100,230,0.12);  color: #2a64e6; border: 1px solid rgba(42,100,230,0.20); }
.si-g { background: rgba(14,160,110,0.12);  color: #0a9a6e; border: 1px solid rgba(14,160,110,0.20); }
.si-a { background: rgba(230,120,30,0.12);  color: #e6781e; border: 1px solid rgba(230,120,30,0.20); }
.si-r { background: rgba(220,40,50,0.10);   color: #dc2832; border: 1px solid rgba(220,40,50,0.18); }

.sum-info .sv {
    font-size: 1.55rem;
    font-weight: 800;
    color: #0e2030;
    line-height: 1;
}

.sum-info .sl {
    font-size: 0.67rem;
    font-weight: 600;
    color: rgba(18,40,58,0.46);
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin-top: 3px;
}

.reports-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
}

.report-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(42,100,230,0.13);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(42,100,230,0.08);
}

.report-head {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(42,100,230,0.10);
}

.r-icon {
    width: 34px;
    height: 34px;
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.95rem;
}

.ri-b { background: rgba(42,100,230,0.12); color: #2a64e6; border: 1px solid rgba(42,100,230,0.18); }
.ri-a { background: rgba(230,120,30,0.12);  color: #e6781e; border: 1px solid rgba(230,120,30,0.18); }

.r-title { font-size: 0.92rem; font-weight: 700; color: #0e2030; }

.table-wrap { overflow-x: auto; }

table { width: 100%; border-collapse: collapse; }

thead tr {
    background: rgba(42,100,230,0.06);
    border-bottom: 1px solid rgba(42,100,230,0.10);
}

thead th {
    padding: 10px 16px;
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.9px;
    color: rgba(18,40,58,0.46);
    text-align: left;
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid rgba(42,100,230,0.06);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(42,100,230,0.04); }

tbody td {
    padding: 11px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    vertical-align: middle;
}

.dept-chip {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(42,100,230,0.10);
    border: 1px solid rgba(42,100,230,0.18);
    color: #2a55cc;
    padding: 3px 11px;
    border-radius: 6px;
    font-size: 0.76rem;
    font-weight: 600;
}

.count-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: rgba(42,100,230,0.12);
    border: 1px solid rgba(42,100,230,0.20);
    color: #2a64e6;
    width: 34px;
    height: 24px;
    border-radius: 6px;
    font-size: 0.78rem;
    font-weight: 700;
}

.rank-cell {
    display: flex;
    align-items: center;
    gap: 8px;
}

.rank-num {
    width: 26px;
    height: 26px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.72rem;
    font-weight: 700;
    flex-shrink: 0;
}

.rank-1 { background: rgba(255,200,30,0.20); color: #b8860b; border: 1px solid rgba(255,200,30,0.35); }
.rank-2 { background: rgba(180,180,180,0.20); color: #666; border: 1px solid rgba(180,180,180,0.35); }
.rank-3 { background: rgba(200,120,50,0.18); color: #a0522d; border: 1px solid rgba(200,120,50,0.30); }
.rank-n { background: rgba(42,100,230,0.10); color: #2a64e6; border: 1px solid rgba(42,100,230,0.18); }

.salary-amount {
    font-size: 0.84rem;
    font-weight: 700;
    color: #0a7a58;
    font-variant-numeric: tabular-nums;
}

.empty-row td {
    text-align: center;
    padding: 30px;
    color: rgba(18,40,58,0.38);
    font-size: 0.82rem;
}

@media (max-width: 900px) {
    .summary-grid { grid-template-columns: repeat(2,1fr); }
    .reports-grid { grid-template-columns: 1fr; }
    .main { padding: 20px 14px 40px; }
}

@media (max-width: 480px) {
    .summary-grid { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="admin-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-bar-chart-fill"></i></div>
        Employee Management System <span class="admin-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">

    <div class="page-eyebrow">Analytics</div>
    <div class="page-title">Reports & Analytics</div>

    <div class="summary-grid">
        <div class="sum-card">
            <div class="sum-icon si-b"><i class="bi bi-people-fill"></i></div>
            <div class="sum-info">
                <div class="sv"><%= totalEmp %></div>
                <div class="sl">Total Employees</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-g"><i class="bi bi-currency-rupee"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", avgSalary) %></div>
                <div class="sl">Average Salary</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-a"><i class="bi bi-graph-up-arrow"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", maxSalary) %></div>
                <div class="sl">Highest Salary</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-r"><i class="bi bi-graph-down-arrow"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", minSalary) %></div>
                <div class="sl">Lowest Salary</div>
            </div>
        </div>
    </div>

    <div class="reports-grid">

        <div class="report-card">
            <div class="report-head">
                <div class="r-icon ri-b"><i class="bi bi-diagram-3-fill"></i></div>
                <div class="r-title">Department Wise Employees</div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Department</th>
                            <th>Total Employees</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean d1 = false;
try {
    ResultSet rs = con.createStatement().executeQuery(
        "SELECT d.name, COUNT(e.id) AS total FROM departments d LEFT JOIN employees e ON d.id=e.department_id GROUP BY d.name ORDER BY total DESC"
    );
    while(rs.next()){
        d1 = true;
%>
                        <tr>
                            <td><span class="dept-chip"><i class="bi bi-building"></i> <%= rs.getString("name") %></span></td>
                            <td><span class="count-badge"><%= rs.getInt("total") %></span></td>
                        </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!d1){ %><tr class="empty-row"><td colspan="2"><i class="bi bi-inbox"></i>&nbsp; No department data.</td></tr><% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="report-card">
            <div class="report-head">
                <div class="r-icon ri-a"><i class="bi bi-trophy-fill"></i></div>
                <div class="r-title">Top 5 Paid Employees</div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Employee Name</th>
                            <th>Salary</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean d2 = false;
int rank = 1;
try {
    ResultSet rs = con.createStatement().executeQuery(
        "SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 5"
    );
    while(rs.next()){
        d2 = true;
        String rankClass = rank == 1 ? "rank-1" : rank == 2 ? "rank-2" : rank == 3 ? "rank-3" : "rank-n";
%>
                        <tr>
                            <td>
                                <div class="rank-cell">
                                    <div class="rank-num <%= rankClass %>"><%= rank %></div>
                                </div>
                            </td>
                            <td><strong><%= rs.getString("name") %></strong></td>
                            <td class="salary-amount">&#8377;<%= String.format("%.2f", rs.getDouble("salary")) %></td>
                        </tr>
<% rank++; } } catch(Exception e){ out.println(e); } %>
<% if(!d2){ %><tr class="empty-row"><td colspan="3"><i class="bi bi-inbox"></i>&nbsp; No employee data.</td></tr><% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
