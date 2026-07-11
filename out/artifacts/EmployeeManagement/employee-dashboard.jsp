<%@ page session="true" %>
<%
String emp = (String) session.getAttribute("employee");
if(emp == null){ response.sendRedirect("employee-login.jsp"); }
String initials = (emp != null && emp.trim().length() >= 2) ? emp.trim().substring(0,2).toUpperCase() : "EM";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Dashboard ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f0f6f2;
    background-image:
        radial-gradient(ellipse 70% 55% at 100% 0%,   rgba(14,190,140,0.10) 0%, transparent 60%),
        radial-gradient(ellipse 55% 45% at 0% 100%,   rgba(42,100,230,0.07) 0%, transparent 60%);
    min-height: 100vh;
    color: #0f2a1e;
    display: flex;
}

.sidebar {
    width: 248px;
    min-height: 100vh;
    background: rgba(255,255,255,0.92);
    border-right: 1px solid rgba(10,120,80,0.12);
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    display: flex;
    flex-direction: column;
    box-shadow: 2px 0 20px rgba(10,120,80,0.07);
    z-index: 50;
}

.sidebar-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 20px 20px 18px;
    border-bottom: 1px solid rgba(10,120,80,0.10);
}

.sidebar-brand-icon {
    width: 36px;
    height: 36px;
    background: linear-gradient(135deg, #0a9a6e, #0b7a58);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.05rem;
    color: #fff;
    box-shadow: 0 2px 10px rgba(10,150,100,0.30);
    flex-shrink: 0;
}

.sidebar-brand-text {
    font-size: 0.88rem;
    font-weight: 700;
    color: #0f2a1e;
    line-height: 1.2;
}

.sidebar-brand-text small {
    display: block;
    font-size: 0.60rem;
    font-weight: 500;
    color: rgba(10,80,50,0.44);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.sidebar-user {
    display: flex;
    align-items: center;
    gap: 11px;
    padding: 16px 20px;
    margin: 8px 12px;
    background: rgba(10,150,100,0.07);
    border: 1px solid rgba(10,150,100,0.12);
    border-radius: 12px;
}

.user-avatar {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: linear-gradient(135deg, #0a9a6e, #0b7a58);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.85rem;
    font-weight: 700;
    color: #fff;
    flex-shrink: 0;
    box-shadow: 0 2px 8px rgba(10,150,100,0.25);
}

.user-name {
    font-size: 0.83rem;
    font-weight: 700;
    color: #0f2a1e;
    line-height: 1.2;
}

.user-role {
    font-size: 0.67rem;
    color: rgba(10,50,30,0.48);
    font-weight: 500;
}

.sidebar-nav {
    flex: 1;
    padding: 10px 12px;
    display: flex;
    flex-direction: column;
    gap: 2px;
    overflow-y: auto;
}

.nav-section-label {
    font-size: 0.60rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.4px;
    color: rgba(10,60,40,0.38);
    padding: 10px 10px 4px;
}

.nav-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 500;
    color: rgba(10,50,30,0.60);
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
}

.nav-item:hover { background: rgba(10,150,100,0.09); color: #0a7a58; text-decoration: none; }
.nav-item.active { background: rgba(10,150,100,0.12); color: #0a9a6e; font-weight: 600; }
.nav-item i { font-size: 1rem; width: 18px; text-align: center; flex-shrink: 0; }

.nav-divider { height: 1px; background: rgba(10,100,70,0.08); margin: 8px 0; }

.nav-logout {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 500;
    color: rgba(200,40,40,0.65);
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
}

.nav-logout:hover { background: rgba(220,40,40,0.07); color: #b91c1c; }
.nav-logout i { font-size: 1rem; width: 18px; text-align: center; }

.sidebar-footer {
    padding: 14px 20px;
    border-top: 1px solid rgba(10,100,70,0.09);
    font-size: 0.68rem;
    color: rgba(10,50,30,0.34);
    text-align: center;
}

.content {
    margin-left: 248px;
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.topbar {
    background: rgba(255,255,255,0.84);
    border-bottom: 1px solid rgba(10,120,80,0.10);
    backdrop-filter: blur(12px);
    padding: 0 28px;
    height: 60px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 40;
    box-shadow: 0 1px 14px rgba(10,120,80,0.07);
}

.topbar-left h5 {
    font-size: 1rem;
    font-weight: 700;
    color: #0f2a1e;
    margin: 0;
}

.topbar-left p {
    font-size: 0.73rem;
    color: rgba(10,50,30,0.48);
    margin: 0;
}

.topbar-right {
    display: flex;
    align-items: center;
    gap: 10px;
}

.clock-pill {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(255,255,255,0.70);
    border: 1px solid rgba(10,120,80,0.13);
    padding: 5px 13px;
    border-radius: 8px;
    font-size: 0.76rem;
    font-weight: 600;
    color: rgba(10,45,28,0.58);
    font-variant-numeric: tabular-nums;
    box-shadow: 0 1px 6px rgba(10,80,50,0.05);
}

.online-pill {
    display: flex;
    align-items: center;
    gap: 5px;
    background: rgba(10,150,100,0.08);
    border: 1px solid rgba(10,150,100,0.18);
    padding: 4px 12px;
    border-radius: 30px;
    font-size: 0.68rem;
    font-weight: 600;
    color: #0a7a58;
}

.pulse-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #0a9a6e;
    animation: pulse 2s infinite;
}

@keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.2} }

.main-content {
    flex: 1;
    padding: 28px 28px 48px;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(10,120,80,0.50);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.45rem;
    font-weight: 800;
    color: #071a10;
    letter-spacing: -0.3px;
    margin-bottom: 26px;
}

.cards-grid {
    display: grid;
    grid-template-columns: repeat(3,1fr);
    gap: 18px;
    margin-bottom: 28px;
}

.dash-card {
    background: rgba(255,255,255,0.84);
    border: 1px solid rgba(10,120,80,0.11);
    border-radius: 16px;
    padding: 24px 22px 20px;
    cursor: pointer;
    text-decoration: none;
    color: inherit;
    display: flex;
    flex-direction: column;
    position: relative;
    overflow: hidden;
    transition: transform 0.20s, box-shadow 0.20s, border-color 0.20s, background 0.20s;
    box-shadow: 0 2px 12px rgba(10,120,80,0.06);
}

.dash-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    opacity: 0;
    transition: opacity 0.20s;
}

.dash-card:hover {
    transform: translateY(-5px);
    background: #fff;
    color: inherit;
    text-decoration: none;
}

.dash-card:hover::before { opacity: 1; }

.dc-profile::before   { background: linear-gradient(90deg, #3b6cf6, #60a5fa); }
.dc-leave::before     { background: linear-gradient(90deg, #0a9a6e, #34d399); }
.dc-attend::before    { background: linear-gradient(90deg, #7c3aed, #a78bfa); }
.dc-salary::before    { background: linear-gradient(90deg, #d97706, #fbbf24); }
.dc-projects::before  { background: linear-gradient(90deg, #dc2626, #f87171); }
.dc-perf::before      { background: linear-gradient(90deg, #0891b2, #38bdf8); }

.dc-profile:hover  { border-color: rgba(59,108,246,0.30); box-shadow: 0 12px 36px rgba(59,108,246,0.12); }
.dc-leave:hover    { border-color: rgba(10,150,100,0.30); box-shadow: 0 12px 36px rgba(10,150,100,0.12); }
.dc-attend:hover   { border-color: rgba(124,58,237,0.30); box-shadow: 0 12px 36px rgba(124,58,237,0.12); }
.dc-salary:hover   { border-color: rgba(217,119,6,0.30);  box-shadow: 0 12px 36px rgba(217,119,6,0.12); }
.dc-projects:hover { border-color: rgba(220,38,38,0.30);  box-shadow: 0 12px 36px rgba(220,38,38,0.12); }
.dc-perf:hover     { border-color: rgba(8,145,178,0.30);  box-shadow: 0 12px 36px rgba(8,145,178,0.12); }

.card-icon-box {
    width: 44px;
    height: 44px;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    margin-bottom: 16px;
    border: 1px solid transparent;
}

.cib-blue   { background: rgba(59,108,246,0.10);  color: #3b6cf6;  border-color: rgba(59,108,246,0.16); }
.cib-green  { background: rgba(10,150,100,0.10);  color: #0a9a6e;  border-color: rgba(10,150,100,0.16); }
.cib-violet { background: rgba(124,58,237,0.10);  color: #7c3aed;  border-color: rgba(124,58,237,0.16); }
.cib-amber  { background: rgba(217,119,6,0.10);   color: #d97706;  border-color: rgba(217,119,6,0.16); }
.cib-red    { background: rgba(220,38,38,0.10);   color: #dc2626;  border-color: rgba(220,38,38,0.16); }
.cib-cyan   { background: rgba(8,145,178,0.10);   color: #0891b2;  border-color: rgba(8,145,178,0.16); }

.card-name {
    font-size: 0.92rem;
    font-weight: 700;
    color: #0f2a1e;
    margin-bottom: 4px;
}

.card-hint {
    font-size: 0.76rem;
    color: rgba(10,50,30,0.46);
    line-height: 1.5;
    flex: 1;
    margin-bottom: 14px;
}

.card-arrow {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 0.72rem;
    font-weight: 600;
    color: rgba(10,50,30,0.34);
}

.quick-info {
    display: grid;
    grid-template-columns: repeat(3,1fr);
    gap: 16px;
}

.qi-card {
    background: rgba(255,255,255,0.80);
    border: 1px solid rgba(10,120,80,0.10);
    border-radius: 13px;
    padding: 18px 18px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 10px rgba(10,120,80,0.05);
}

.qi-icon {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.05rem;
    flex-shrink: 0;
}

.qi-icon.g { background: rgba(10,150,100,0.10); color: #0a9a6e; border: 1px solid rgba(10,150,100,0.16); }
.qi-icon.b { background: rgba(59,108,246,0.10);  color: #3b6cf6;  border: 1px solid rgba(59,108,246,0.16); }
.qi-icon.a { background: rgba(217,119,6,0.10);   color: #d97706;  border: 1px solid rgba(217,119,6,0.16); }

.qi-val {
    font-size: 1.4rem;
    font-weight: 800;
    color: #071a10;
    line-height: 1;
    margin-bottom: 3px;
}

.qi-lbl {
    font-size: 0.69rem;
    color: rgba(10,50,30,0.46);
    text-transform: uppercase;
    letter-spacing: 0.7px;
    font-weight: 500;
}

.page-footer {
    background: rgba(255,255,255,0.60);
    border-top: 1px solid rgba(10,100,70,0.09);
    padding: 12px 28px;
    font-size: 0.71rem;
    color: rgba(10,50,30,0.34);
    text-align: right;
}

@media (max-width: 1024px) {
    .cards-grid { grid-template-columns: repeat(2,1fr); }
    .quick-info { grid-template-columns: 1fr; }
}

@media (max-width: 768px) {
    .sidebar { transform: translateX(-100%); }
    .content { margin-left: 0; }
    .cards-grid { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="sidebar-brand-icon"><i class="bi bi-buildings-fill"></i></div>
        <div class="sidebar-brand-text">
            EMS Pro
            <small>Employee Portal</small>
        </div>
    </div>

    <div class="sidebar-user">
        <div class="user-avatar"><%= initials %></div>
        <div>
            <div class="user-name"><%= emp %></div>
            <div class="user-role">Employee</div>
        </div>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-label">Navigation</div>
        <a href="employee-dashboard.jsp" class="nav-item active">
            <i class="bi bi-speedometer2"></i> Dashboard
        </a>
        <a href="employee-profile.jsp" class="nav-item">
            <i class="bi bi-person-fill"></i> View Profile
        </a>

        <div class="nav-section-label">Self Service</div>
        <a href="apply-leave.jsp" class="nav-item">
            <i class="bi bi-calendar-plus-fill"></i> Apply Leave
        </a>
        <a href="attendance.jsp" class="nav-item">
            <i class="bi bi-calendar-check-fill"></i> Attendance
        </a>
        <a href="salary.jsp" class="nav-item">
            <i class="bi bi-cash-stack"></i> Salary Slip
        </a>

        <div class="nav-section-label">Work</div>
        <a href="projects.jsp" class="nav-item">
            <i class="bi bi-kanban-fill"></i> Projects
        </a>
        <a href="feedback.jsp" class="nav-item">
            <i class="bi bi-bar-chart-fill"></i> Performance
        </a>

        <div class="nav-divider"></div>
        <a href="index.html" class="nav-logout">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </nav>

    <div class="sidebar-footer">
        &copy; 2026 EMS Pro &mdash; Abhishek Samadhiya
    </div>
</aside>

<div class="content">

    <header class="topbar">
        <div class="topbar-left">
            <h5>Welcome back, <%= emp %> &#128075;</h5>
            <p>Here's your dashboard overview</p>
        </div>
        <div class="topbar-right">
            <div class="online-pill"><span class="pulse-dot"></span> Active</div>
            <div class="clock-pill"><i class="bi bi-clock"></i><span id="clk"></span></div>
        </div>
    </header>

    <main class="main-content">

        <div class="page-eyebrow">Self Service</div>
        <div class="page-title">Employee Dashboard</div>

        <div class="cards-grid">

            <a href="employee-profile.jsp" class="dash-card dc-profile">
                <div class="card-icon-box cib-blue"><i class="bi bi-person-fill"></i></div>
                <div class="card-name">View Profile</div>
                <div class="card-hint">Manage your personal details, contact info and account settings.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

            <a href="apply-leave.jsp" class="dash-card dc-leave">
                <div class="card-icon-box cib-green"><i class="bi bi-calendar-plus-fill"></i></div>
                <div class="card-name">Apply Leave</div>
                <div class="card-hint">Submit a leave request and track its approval status.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

            <a href="attendance.jsp" class="dash-card dc-attend">
                <div class="card-icon-box cib-violet"><i class="bi bi-calendar-check-fill"></i></div>
                <div class="card-name">View Attendance</div>
                <div class="card-hint">Check your daily punch-in records and monthly summary.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

            <a href="salary.jsp" class="dash-card dc-salary">
                <div class="card-icon-box cib-amber"><i class="bi bi-cash-stack"></i></div>
                <div class="card-name">Salary Slip</div>
                <div class="card-hint">View and download your monthly salary breakdown and payslips.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

            <a href="projects.jsp" class="dash-card dc-projects">
                <div class="card-icon-box cib-red"><i class="bi bi-kanban-fill"></i></div>
                <div class="card-name">Track Projects</div>
                <div class="card-hint">Monitor assigned tasks and project completion status.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

            <a href="feedback.jsp" class="dash-card dc-perf">
                <div class="card-icon-box cib-cyan"><i class="bi bi-bar-chart-line-fill"></i></div>
                <div class="card-name">Performance</div>
                <div class="card-hint">Check your performance reviews, ratings and feedback from HR.</div>
                <div class="card-arrow">Open <i class="bi bi-arrow-right"></i></div>
            </a>

        </div>

        <div class="quick-info">
            <div class="qi-card">
                <div class="qi-icon g"><i class="bi bi-calendar2-check-fill"></i></div>
                <div>
                    <div class="qi-val">24</div>
                    <div class="qi-lbl">Days Present This Month</div>
                </div>
            </div>
            <div class="qi-card">
                <div class="qi-icon b"><i class="bi bi-clock-fill"></i></div>
                <div>
                    <div class="qi-val">3</div>
                    <div class="qi-lbl">Pending Leave Requests</div>
                </div>
            </div>
            <div class="qi-card">
                <div class="qi-icon a"><i class="bi bi-currency-rupee"></i></div>
                <div>
                    <div class="qi-val">Paid</div>
                    <div class="qi-lbl">Last Salary Status</div>
                </div>
            </div>
        </div>

    </main>

    <footer class="page-footer">
        Employee Management System Pro &mdash; &copy; 2026 Abhishek Samadhiya
    </footer>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function tick() {
    var el = document.getElementById('clk');
    if(el) el.textContent = new Date().toLocaleTimeString('en-IN', { hour:'2-digit', minute:'2-digit', second:'2-digit' });
}
tick();
setInterval(tick, 1000);
</script>

</body>
</html>
