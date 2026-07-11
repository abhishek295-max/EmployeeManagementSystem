<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String loginError = "";
if(username != null && password != null){
    try {
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM users WHERE username=? AND password=? AND role='admin'"
        );
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            session.setAttribute("admin", username);
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            loginError = "Invalid username or password. Please try again.";
        }
    } catch(Exception e){
        loginError = "System error: " + e.getMessage();
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
html { scroll-behavior: smooth; }

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #eef2ff;
    background-image:
        radial-gradient(ellipse 80% 65% at 0% 0%,   rgba(59,108,246,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 65% 55% at 100% 100%, rgba(99,60,220,0.12) 0%, transparent 55%),
        radial-gradient(ellipse 55% 50% at 55% 5%,   rgba(37,99,235,0.08) 0%, transparent 55%),
        radial-gradient(ellipse 40% 40% at 0% 100%,  rgba(14,155,130,0.06) 0%, transparent 50%);
    min-height: 100vh;
    color: #1a2040;
    display: flex;
    flex-direction: column;
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
    box-shadow: 0 2px 12px rgba(59,108,246,0.32);
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

.nav-links {
    display: flex;
    align-items: center;
    gap: 2px;
    list-style: none;
}

.nav-links li a {
    display: flex;
    align-items: center;
    gap: 5px;
    padding: 7px 13px;
    border-radius: 8px;
    font-size: 0.81rem;
    font-weight: 500;
    color: rgba(30,50,120,0.50);
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
}

.nav-links li a:hover { background: rgba(59,108,246,0.08); color: #3b6cf6; }
.nav-links li a.active { background: rgba(59,108,246,0.10); color: #3b6cf6; }

.nav-right {
    display: flex;
    align-items: center;
    gap: 10px;
}

.clock-box {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(255,255,255,0.68);
    border: 1px solid rgba(59,108,246,0.14);
    padding: 4px 12px;
    border-radius: 8px;
    font-size: 0.75rem;
    font-weight: 600;
    color: rgba(30,45,120,0.58);
    font-variant-numeric: tabular-nums;
    box-shadow: 0 1px 6px rgba(59,108,246,0.06);
}

.online-pill {
    display: flex;
    align-items: center;
    gap: 6px;
    background: rgba(10,150,100,0.08);
    border: 1px solid rgba(10,150,100,0.20);
    padding: 4px 12px;
    border-radius: 30px;
    font-size: 0.68rem;
    font-weight: 600;
    color: #059669;
}

.pulse-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #10b981;
    animation: pulse 2s infinite;
}

@keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.2} }

.main-area {
    position: relative;
    z-index: 2;
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 48px 20px 64px;
}

.login-wrapper {
    width: 100%;
    max-width: 440px;
}

.login-top {
    text-align: center;
    margin-bottom: 28px;
}

.login-avatar {
    width: 64px;
    height: 64px;
    border-radius: 18px;
    background: linear-gradient(135deg, rgba(59,108,246,0.90), rgba(45,85,214,0.85));
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.6rem;
    color: #fff;
    margin: 0 auto 16px;
    box-shadow: 0 4px 22px rgba(59,108,246,0.28);
}

.login-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(59,108,246,0.55);
    margin-bottom: 6px;
}

.login-title {
    font-size: 1.6rem;
    font-weight: 800;
    color: #0e1830;
    letter-spacing: -0.4px;
    margin-bottom: 6px;
}

.login-subtitle {
    font-size: 0.83rem;
    color: rgba(30,50,120,0.48);
}

.login-card {
    background: rgba(255,255,255,0.86);
    border: 1px solid rgba(59,108,246,0.13);
    border-radius: 20px;
    padding: 32px 30px;
    box-shadow: 0 6px 32px rgba(59,108,246,0.10);
    position: relative;
    overflow: hidden;
}

.login-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    background: linear-gradient(90deg, #3b6cf6, #60a5fa);
}

.alert-error {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(220,38,38,0.07);
    border: 1px solid rgba(220,38,38,0.18);
    color: #b91c1c;
    padding: 11px 14px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 600;
    margin-bottom: 20px;
}

.perm-chips {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    margin-bottom: 22px;
}

.perm-chip {
    font-size: 0.62rem;
    font-weight: 600;
    padding: 3px 9px;
    border-radius: 6px;
    background: rgba(59,108,246,0.08);
    border: 1px solid rgba(59,108,246,0.15);
    color: #3b6cf6;
}

.f-label {
    font-size: 0.71rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: rgba(30,50,120,0.50);
    margin-bottom: 5px;
    display: block;
}

.input-wrap {
    position: relative;
    margin-bottom: 16px;
}

.input-icon {
    position: absolute;
    left: 13px;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(59,108,246,0.40);
    font-size: 0.9rem;
    pointer-events: none;
}

.f-input {
    width: 100%;
    background: rgba(255,255,255,0.85);
    border: 1px solid rgba(59,108,246,0.16);
    border-radius: 9px;
    color: #1a2040;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.86rem;
    padding: 11px 13px 11px 36px;
    outline: none;
    transition: border-color 0.18s, box-shadow 0.18s;
}

.f-input:focus {
    border-color: #3b6cf6;
    box-shadow: 0 0 0 3px rgba(59,108,246,0.12);
    background: #fff;
}

.f-input::placeholder { color: rgba(30,50,120,0.32); }

.pw-wrap { position: relative; }
.pw-wrap .f-input { padding-right: 40px; }

.toggle-pw {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    color: rgba(59,108,246,0.38);
    cursor: pointer;
    font-size: 0.95rem;
    padding: 0;
    transition: color 0.15s;
}

.toggle-pw:hover { color: #3b6cf6; }

.form-footer-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
    font-size: 0.76rem;
}

.form-footer-row label {
    display: flex;
    align-items: center;
    gap: 7px;
    color: rgba(30,50,120,0.52);
    cursor: pointer;
}

.form-footer-row a {
    color: #3b6cf6;
    text-decoration: none;
    font-weight: 600;
    transition: opacity 0.15s;
}

.form-footer-row a:hover { opacity: 0.75; text-decoration: underline; }

.login-btn {
    width: 100%;
    padding: 12px;
    background: #3b6cf6;
    border: none;
    border-radius: 9px;
    color: #fff;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.88rem;
    font-weight: 700;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    transition: background 0.15s, transform 0.15s, box-shadow 0.15s;
    box-shadow: 0 3px 14px rgba(59,108,246,0.28);
}

.login-btn:hover {
    background: #4f80ff;
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(59,108,246,0.34);
}

.divider {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 0.72rem;
    color: rgba(30,50,120,0.36);
    margin: 18px 0;
}

.divider::before, .divider::after {
    content: '';
    flex: 1;
    height: 1px;
    background: rgba(59,108,246,0.10);
}

.security-note {
    display: flex;
    align-items: center;
    gap: 8px;
    background: rgba(59,108,246,0.05);
    border: 1px solid rgba(59,108,246,0.11);
    border-radius: 8px;
    padding: 10px 13px;
    font-size: 0.74rem;
    color: rgba(30,50,120,0.52);
}

.security-note i { color: #3b6cf6; font-size: 0.85rem; flex-shrink: 0; }

.back-link {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    margin-top: 20px;
    font-size: 0.78rem;
    color: rgba(30,50,120,0.44);
    text-decoration: none;
    transition: color 0.15s;
}

.back-link:hover { color: #3b6cf6; }

.site-footer {
    position: relative;
    z-index: 2;
    background: rgba(255,255,255,0.60);
    border-top: 1px solid rgba(59,108,246,0.09);
    text-align: center;
    padding: 13px 20px;
    font-size: 0.72rem;
    color: rgba(30,50,120,0.34);
}

@media (max-width: 520px) {
    .topbar { padding: 0 16px; }
    .nav-links { display: none; }
    .login-card { padding: 26px 20px; }
    .main-area { padding: 32px 14px 48px; }
}
</style>
</head>
<body>

<div class="grid-bg"></div>

<header class="topbar">
    <a href="index.html" class="brand">
        <div class="brand-icon"><i class="bi bi-buildings-fill"></i></div>
        <div class="brand-name">
            Employee Management System
            <small>Enterprise Platform</small>
        </div>
    </a>

    <ul class="nav-links">
        <li><a href="index.html"><i class="bi bi-house-fill"></i> Home</a></li>
        <li><a href="admin-login.jsp" class="active"><i class="bi bi-shield-lock-fill"></i> Admin</a></li>
        <li><a href="hr-login.jsp"><i class="bi bi-people-fill"></i> HR</a></li>
        <li><a href="employee-login.jsp"><i class="bi bi-person-badge-fill"></i> Employee</a></li>
    </ul>

    <div class="nav-right">
        <div class="online-pill"><span class="pulse-dot"></span> Online</div>
        <div class="clock-box"><i class="bi bi-clock"></i><span id="clk"></span></div>
    </div>
</header>

<div class="main-area">
    <div class="login-wrapper">

        <div class="login-top">
            <div class="login-avatar"><i class="bi bi-shield-lock-fill"></i></div>
            <div class="login-eyebrow">Restricted Access</div>
            <div class="login-title">Admin Portal Login</div>
            <div class="login-subtitle">Sign in to access the administration dashboard</div>
        </div>

        <div class="login-card">

            <% if(!loginError.isEmpty()){ %>
            <div class="alert-error">
                <i class="bi bi-exclamation-circle-fill"></i>
                <%= loginError %>
            </div>
            <% } %>

            <div class="perm-chips">
                <span class="perm-chip"><i class="bi bi-shield-lock me-1"></i>System Config</span>
                <span class="perm-chip"><i class="bi bi-people me-1"></i>User Mgmt</span>
                <span class="perm-chip"><i class="bi bi-journal-text me-1"></i>Audit Logs</span>
                <span class="perm-chip"><i class="bi bi-diagram-3 me-1"></i>Full Access</span>
            </div>

            <form method="post">
                <label class="f-label">Admin Username</label>
                <div class="input-wrap">
                    <i class="bi bi-person-fill input-icon"></i>
                    <input
                        type="text"
                        name="username"
                        class="f-input"
                        placeholder="Enter admin username"
                        value="<%= username != null ? username : "" %>"
                        autocomplete="username"
                        required
                    >
                </div>

                <label class="f-label">Password</label>
                <div class="input-wrap pw-wrap">
                    <i class="bi bi-lock-fill input-icon"></i>
                    <input
                        type="password"
                        name="password"
                        class="f-input"
                        id="pwField"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required
                    >
                    <button type="button" class="toggle-pw" onclick="togglePw()">
                        <i class="bi bi-eye" id="pwIcon"></i>
                    </button>
                </div>

                <div class="form-footer-row">
                    <label>
                        <input type="checkbox" style="accent-color:#3b6cf6;"> Remember me
                    </label>
                    <a href="admin-forgot-password.jsp">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn">
                    <i class="bi bi-shield-lock-fill"></i> Sign In to Admin Panel
                </button>
            </form>

            <div class="divider">secured with 2FA monitoring</div>

            <div class="security-note">
                <i class="bi bi-info-circle-fill"></i>
                All admin sessions are encrypted, monitored, and logged for security compliance.
            </div>
        </div>

        <a href="index.html" class="back-link">
            <i class="bi bi-arrow-left"></i> Back to Home
        </a>

    </div>
</div>

<footer class="site-footer">
    &copy; 2026 Employee Management System &mdash; Built by <strong style="color:rgba(30,50,160,0.52);">Abhishek Samadhiya</strong>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function togglePw() {
    var f = document.getElementById('pwField');
    var i = document.getElementById('pwIcon');
    if(f.type === 'password'){ f.type = 'text'; i.className = 'bi bi-eye-slash'; }
    else { f.type = 'password'; i.className = 'bi bi-eye'; }
}
function tick() {
    var el = document.getElementById('clk');
    if(el) el.textContent = new Date().toLocaleTimeString('en-IN', { hour:'2-digit', minute:'2-digit', second:'2-digit' });
}
tick();
setInterval(tick, 1000);
</script>

</body>
</html>
