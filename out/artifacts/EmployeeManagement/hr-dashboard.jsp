<%@ page session="true" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){
    response.sendRedirect("hr-login.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HR Dashboard - Employee Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e2f4ee;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(20, 190, 140, 0.32) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42, 100, 230, 0.22) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(80, 200, 180, 0.16) 0%, transparent 50%),
        radial-gradient(ellipse 40% 40% at 100% 5%,  rgba(255, 180, 60, 0.10) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
    display: flex;
    flex-direction: column;
}

.topbar {
    background: rgba(255, 255, 255, 0.80);
    border-bottom: 1px solid rgba(20, 170, 120, 0.18);
    backdrop-filter: blur(14px);
    padding: 12px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 16px rgba(20, 160, 110, 0.10);
}

.brand {
    display: flex;
    align-items: center;
    gap: 11px;
    font-size: 1.05rem;
    font-weight: 700;
    color: #12283a;
}

.brand-icon {
    width: 36px;
    height: 36px;
    background: rgba(14, 160, 110, 0.92);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(14, 160, 110, 0.38);
}

.hr-badge {
    background: rgba(14, 160, 110, 0.12);
    border: 1px solid rgba(14, 160, 110, 0.28);
    padding: 3px 12px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #0a9a6e;
}

.topbar-nav {
    display: flex;
    align-items: center;
    gap: 4px;
}

.nav-link-custom {
    display: flex;
    align-items: center;
    gap: 5px;
    padding: 6px 13px;
    border-radius: 8px;
    font-size: 0.8rem;
    font-weight: 600;
    color: rgba(18, 40, 58, 0.60);
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
}

.nav-link-custom:hover {
    background: rgba(14, 160, 110, 0.10);
    color: #0a9a6e;
}

.nav-link-custom.active {
    background: rgba(14, 160, 110, 0.12);
    color: #0a9a6e;
}

.logout-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(210, 35, 45, 0.85);
    border: none;
    color: #fff;
    padding: 7px 15px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: opacity 0.15s;
    box-shadow: 0 2px 10px rgba(210, 35, 45, 0.25);
}

.logout-btn:hover { opacity: 0.82; color: #fff; }

.main {
    flex: 1;
    padding: 32px 28px 52px;
    max-width: 1140px;
    margin: 0 auto;
    width: 100%;
}

.welcome-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 28px;
    flex-wrap: wrap;
    gap: 12px;
}

.welcome-text .eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(14, 140, 100, 0.58);
    margin-bottom: 3px;
}

.welcome-text h1 {
    font-size: 1.55rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin: 0;
}

.welcome-text h1 span {
    color: #0a9a6e;
}

.date-pill {
    display: flex;
    align-items: center;
    gap: 7px;
    background: rgba(255, 255, 255, 0.70);
    border: 1px solid rgba(14, 160, 110, 0.18);
    padding: 7px 16px;
    border-radius: 10px;
    font-size: 0.78rem;
    font-weight: 600;
    color: rgba(18, 40, 58, 0.60);
    box-shadow: 0 2px 8px rgba(14, 160, 110, 0.08);
}

.cards-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
}

.h-card {
    background: rgba(255, 255, 255, 0.68);
    border: 1px solid rgba(14, 160, 110, 0.14);
    border-radius: 16px;
    padding: 24px 20px 20px;
    text-decoration: none;
    color: inherit;
    display: flex;
    flex-direction: column;
    cursor: pointer;
    transition: transform 0.20s, border-color 0.20s, background 0.20s, box-shadow 0.20s;
    box-shadow: 0 2px 12px rgba(20, 160, 110, 0.08);
}

.h-card:hover {
    transform: translateY(-6px);
    background: rgba(255, 255, 255, 0.92);
    color: inherit;
    text-decoration: none;
}

.h-card.c1:hover { border-color: rgba(42, 100, 230, 0.36); box-shadow: 0 10px 30px rgba(42, 100, 230, 0.14); }
.h-card.c2:hover { border-color: rgba(14, 170, 120, 0.40); box-shadow: 0 10px 30px rgba(14, 170, 120, 0.14); }
.h-card.c3:hover { border-color: rgba(230, 120, 30, 0.36); box-shadow: 0 10px 30px rgba(230, 120, 30, 0.14); }
.h-card.c4:hover { border-color: rgba(140, 70, 225, 0.36); box-shadow: 0 10px 30px rgba(140, 70, 225, 0.14); }
.h-card.c5:hover { border-color: rgba(14, 190, 100, 0.36); box-shadow: 0 10px 30px rgba(14, 190, 100, 0.14); }
.h-card.c6:hover { border-color: rgba(220, 45, 55, 0.36); box-shadow: 0 10px 30px rgba(220, 45, 55, 0.14); }
.h-card.c7:hover { border-color: rgba(30, 60, 120, 0.36); box-shadow: 0 10px 30px rgba(30, 60, 120, 0.14); }

.card-ico {
    width: 46px;
    height: 46px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    margin-bottom: 16px;
    border: 1px solid transparent;
}

.ico1 { background: rgba(42,  100, 230, 0.12); color: #2a64e6; border-color: rgba(42,  100, 230, 0.20); }
.ico2 { background: rgba(14,  170, 120, 0.12); color: #0ea878; border-color: rgba(14,  170, 120, 0.20); }
.ico3 { background: rgba(230, 120,  30, 0.12); color: #e6781e; border-color: rgba(230, 120,  30, 0.20); }
.ico4 { background: rgba(140,  70, 225, 0.12); color: #8c46e1; border-color: rgba(140,  70, 225, 0.20); }
.ico5 { background: rgba(14,  190, 100, 0.12); color: #0ebe64; border-color: rgba(14,  190, 100, 0.20); }
.ico6 { background: rgba(220,  45,  55, 0.12); color: #dc2d37; border-color: rgba(220,  45,  55, 0.20); }
.ico7 { background: rgba(30,   60, 120, 0.12); color: #1e3c78; border-color: rgba(30,   60, 120, 0.20); }

.card-title {
    font-size: 0.92rem;
    font-weight: 700;
    color: #0e2030;
    margin-bottom: 5px;
}

.card-desc {
    font-size: 0.76rem;
    color: rgba(18, 40, 58, 0.50);
    line-height: 1.55;
    flex: 1;
    margin-bottom: 16px;
}

.card-arrow {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 0.72rem;
    font-weight: 700;
    color: rgba(18, 40, 58, 0.35);
}

.card-arrow i { font-size: 0.78rem; }

.site-footer {
    background: rgba(255, 255, 255, 0.60);
    border-top: 1px solid rgba(14, 160, 110, 0.14);
    text-align: center;
    padding: 12px 20px;
    font-size: 0.73rem;
    color: rgba(18, 40, 58, 0.38);
}

@media (max-width: 992px) { .cards-grid { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 700px) {
    .cards-grid { grid-template-columns: repeat(2, 1fr); }
    .topbar-nav { display: none; }
    .main { padding: 20px 14px 40px; }
}
@media (max-width: 440px) { .cards-grid { grid-template-columns: 1fr; } }
</style>
</head>
<body>

<header class="topbar">
    <div class="brand">
        <div class="brand-icon"><i class="bi bi-people-fill"></i></div>
        Employee Management System
        <span class="hr-badge">HR</span>
    </div>
    <div class="topbar-nav">
        <a href="hr-dashboard.jsp" class="nav-link-custom active"><i class="bi bi-house-fill"></i> Home</a>
        <a href="hr-profile.jsp"   class="nav-link-custom"><i class="bi bi-person-circle"></i> Profile</a>
    </div>
    <a href="index.html" class="logout-btn">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</header>

<div class="main">

    <div class="welcome-bar">
        <div class="welcome-text">
            <div class="eyebrow">HR Panel</div>
            <h1>Welcome back, <span><%= hr %></span></h1>
        </div>
        <div class="date-pill">
            <i class="bi bi-calendar3"></i>
            <span id="todayDate"></span>
        </div>
    </div>

    <div class="cards-grid">

        <a href="add-employee-hr.jsp" class="h-card c1">
            <div class="card-ico ico1"><i class="bi bi-person-plus-fill"></i></div>
            <div class="card-title">Add Employee</div>
            <div class="card-desc">Create and register a new employee record in the system.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="attendance.jsp" class="h-card c2">
            <div class="card-ico ico2"><i class="bi bi-calendar2-check-fill"></i></div>
            <div class="card-title">Attendance</div>
            <div class="card-desc">Track and manage daily employee attendance logs.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="leave-management.jsp" class="h-card c3">
            <div class="card-ico ico3"><i class="bi bi-calendar-x-fill"></i></div>
            <div class="card-title">Leave Requests</div>
            <div class="card-desc">Review, approve or reject employee leave applications.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="performance.jsp" class="h-card c4">
            <div class="card-ico ico4"><i class="bi bi-graph-up-arrow"></i></div>
            <div class="card-title">Performance Review</div>
            <div class="card-desc">Evaluate and record individual employee performance.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="payroll.jsp" class="h-card c5">
            <div class="card-ico ico5"><i class="bi bi-cash-stack"></i></div>
            <div class="card-title">Payroll</div>
            <div class="card-desc">Process monthly salaries and generate payslips.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="documents.jsp" class="h-card c6">
            <div class="card-ico ico6"><i class="bi bi-folder-fill"></i></div>
            <div class="card-title">Documents</div>
            <div class="card-desc">Upload and manage employee documents securely.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

        <a href="reports-hr.jsp" class="h-card c7">
            <div class="card-ico ico7"><i class="bi bi-file-earmark-bar-graph-fill"></i></div>
            <div class="card-title">Reports</div>
            <div class="card-desc">Generate and export detailed HR and payroll reports.</div>
            <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
        </a>

    </div>
</div>

<footer class="site-footer">
    &copy; 2026 EMS  &nbsp;&mdash;&nbsp; HR Panel &nbsp;&mdash;&nbsp; Employee Management System by Abhishek Samadhiya
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
var d = new Date();
document.getElementById('todayDate').textContent = d.toLocaleDateString('en-IN', { weekday:'short', day:'numeric', month:'short', year:'numeric' });
</script>

</body>
</html>
