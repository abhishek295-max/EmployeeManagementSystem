<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String hrId = (String) session.getAttribute("hr");
if(hrId == null){ response.sendRedirect("hr-login.jsp"); return; }
String msg = "", msgType = "";
if(request.getMethod().equalsIgnoreCase("POST")){
    String uname = request.getParameter("name");
    String uemail = request.getParameter("email");
    String uphone = request.getParameter("phone");
    String udept  = request.getParameter("department");
    PreparedStatement ps = null;
    try{
        ps = con.prepareStatement("UPDATE hr SET name=?,email=?,phone=?,department=? WHERE id=?");
        ps.setString(1, uname); ps.setString(2, uemail);
        ps.setString(3, uphone); ps.setString(4, udept);
        ps.setInt(5, Integer.parseInt(hrId));
        ps.executeUpdate();
        msg = "Profile updated successfully!"; msgType = "success";
    } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
    finally{ try{ if(ps!=null) ps.close(); } catch(Exception e){} }
}
String name="", email="", phone="", dept="";
PreparedStatement ps2 = null; ResultSet rs = null;
try{
    ps2 = con.prepareStatement("SELECT * FROM hr WHERE id=?");
    ps2.setInt(1, Integer.parseInt(hrId));
    rs = ps2.executeQuery();
    if(rs.next()){ name=rs.getString("name"); email=rs.getString("email"); phone=rs.getString("phone"); dept=rs.getString("department"); }
} catch(Exception e){ out.println(e); }
finally{
    try{ if(rs!=null) rs.close(); } catch(Exception e){}
    try{ if(ps2!=null) ps2.close(); } catch(Exception e){}
}
String initials = name.isEmpty() ? "HR" : (name.trim().length() >= 2 ? name.trim().substring(0,2).toUpperCase() : name.trim().toUpperCase());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HR Profile ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e2f4ee;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(20,190,140,0.28) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(80,200,180,0.14) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
    display: flex;
    flex-direction: column;
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

.back-btn:hover { background: rgba(14,160,110,0.18); color: #0a9a6e; }

.main {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px 60px;
}

.profile-wrapper {
    width: 100%;
    max-width: 580px;
}

.avatar-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 28px;
}

.avatar-circle {
    width: 88px;
    height: 88px;
    border-radius: 50%;
    background: linear-gradient(135deg, rgba(14,160,110,0.90), rgba(20,190,150,0.80));
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    font-weight: 800;
    color: #fff;
    box-shadow: 0 6px 24px rgba(14,160,110,0.30);
    margin-bottom: 14px;
    letter-spacing: -1px;
}

.avatar-name {
    font-size: 1.25rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin-bottom: 4px;
}

.avatar-role {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.24);
    padding: 3px 13px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    color: #0a9a6e;
}

.info-strip {
    display: grid;
    grid-template-columns: repeat(3,1fr);
    gap: 1px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.14);
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 24px;
}

.info-cell {
    background: rgba(255,255,255,0.72);
    padding: 14px 16px;
    text-align: center;
}

.info-cell .ic-label {
    font-size: 0.65rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: rgba(18,40,58,0.45);
    margin-bottom: 4px;
}

.info-cell .ic-val {
    font-size: 0.82rem;
    font-weight: 600;
    color: #1a2a45;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.form-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(14,160,110,0.15);
    border-radius: 16px;
    padding: 28px 26px;
    box-shadow: 0 4px 22px rgba(14,160,110,0.10);
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

.fc-icon {
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

.form-row-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 16px;
}

.f-label {
    font-size: 0.71rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: rgba(18,40,58,0.50);
    margin-bottom: 5px;
    display: block;
}

.f-input {
    width: 100%;
    background: rgba(255,255,255,0.82);
    border: 1px solid rgba(14,160,110,0.20);
    border-radius: 9px;
    color: #12283a;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.85rem;
    padding: 10px 13px;
    margin-bottom: 16px;
    outline: none;
    transition: border-color 0.18s, box-shadow 0.18s;
}

.f-input:focus {
    border-color: #0a9a6e;
    box-shadow: 0 0 0 3px rgba(14,160,110,0.13);
    background: #fff;
}

.f-input::placeholder { color: rgba(18,40,58,0.36); }

.alert-success {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.24);
    color: #0a7a58;
    padding: 11px 14px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 600;
    margin-bottom: 18px;
}

.alert-error {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(220,40,50,0.08);
    border: 1px solid rgba(220,40,50,0.20);
    color: #b91c1c;
    padding: 11px 14px;
    border-radius: 9px;
    font-size: 0.82rem;
    font-weight: 600;
    margin-bottom: 18px;
}

.btn-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: 4px;
}

.submit-btn {
    padding: 11px;
    background: rgba(14,155,80,0.90);
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
    box-shadow: 0 3px 14px rgba(14,155,80,0.28);
}

.submit-btn:hover { opacity: 0.88; transform: translateY(-1px); }

.secondary-btn {
    padding: 11px;
    background: rgba(255,255,255,0.80);
    border: 1px solid rgba(14,160,110,0.22);
    border-radius: 9px;
    color: #0a9a6e;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 0.86rem;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    text-decoration: none;
    transition: background 0.15s;
}

.secondary-btn:hover { background: rgba(14,160,110,0.10); color: #0a9a6e; }

@media (max-width: 540px) {
    .form-row-grid { grid-template-columns: 1fr; }
    .info-strip { grid-template-columns: 1fr; }
    .btn-row { grid-template-columns: 1fr; }
    .main { padding: 24px 14px 40px; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="hr-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-people-fill"></i></div>
        Employee Management System <span class="hr-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">
    <div class="profile-wrapper">

        <div class="avatar-section">
            <div class="avatar-circle"><%= initials %></div>
            <div class="avatar-name"><%= name.isEmpty() ? "HR User" : name %></div>
            <div class="avatar-role"><i class="bi bi-people-fill"></i> Human Resources</div>
        </div>

        <div class="info-strip">
            <div class="info-cell">
                <div class="ic-label"><i class="bi bi-envelope"></i> Email</div>
                <div class="ic-val"><%= email.isEmpty() ? "?" : email %></div>
            </div>
            <div class="info-cell">
                <div class="ic-label"><i class="bi bi-telephone"></i> Phone</div>
                <div class="ic-val"><%= phone.isEmpty() ? "?" : phone %></div>
            </div>
            <div class="info-cell">
                <div class="ic-label"><i class="bi bi-building"></i> Department</div>
                <div class="ic-val"><%= dept.isEmpty() ? "?" : dept %></div>
            </div>
        </div>

        <div class="form-card">
            <div class="form-card-title">
                <div class="fc-icon"><i class="bi bi-pencil-square"></i></div>
                Edit Profile Information
            </div>

            <% if(!msg.isEmpty()){ %>
            <div class="<%= msgType.equals("success") ? "alert-success" : "alert-error" %>">
                <i class="bi bi-<%= msgType.equals("success") ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
                <%= msg %>
            </div>
            <% } %>

            <form method="post">
                <div class="form-row-grid">
                    <div>
                        <label class="f-label">Full Name</label>
                        <input type="text" name="name" class="f-input" value="<%= name %>" placeholder="Your full name" required>
                    </div>
                    <div>
                        <label class="f-label">Email Address</label>
                        <input type="email" name="email" class="f-input" value="<%= email %>" placeholder="your@email.com" required>
                    </div>
                    <div>
                        <label class="f-label">Phone Number</label>
                        <input type="text" name="phone" class="f-input" value="<%= phone %>" placeholder="+91 XXXXX XXXXX">
                    </div>
                    <div>
                        <label class="f-label">Department</label>
                        <input type="text" name="department" class="f-input" value="<%= dept %>" placeholder="e.g. Human Resources">
                    </div>
                </div>
                <div class="btn-row">
                    <button type="submit" class="submit-btn">
                        <i class="bi bi-check-circle-fill"></i> Save Changes
                    </button>
                    <a href="hr-dashboard.jsp" class="secondary-btn">
                        <i class="bi bi-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </form>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
