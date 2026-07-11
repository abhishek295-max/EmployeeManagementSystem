<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){ response.sendRedirect("hr-login.jsp"); }
String lid = request.getParameter("id");
String action = request.getParameter("action");
String msg = "";
String msgType = "";
if(lid != null && action != null){
    try{
        PreparedStatement ps = con.prepareStatement("UPDATE leave_requests SET status=? WHERE id=?");
        ps.setString(1, action);
        ps.setInt(2, Integer.parseInt(lid));
        ps.executeUpdate();
        msg = "Leave request " + action + " successfully.";
        msgType = action.equals("Approved") ? "success" : "error";
    } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Leave Management ? EMS Pro</title>
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

.back-btn:hover { background: rgba(14,160,110,0.18); color: #0a9a6e; }

.main {
    padding: 32px 28px 52px;
    max-width: 1200px;
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
    margin-bottom: 22px;
}

.alert-success {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.25);
    color: #0a7a58;
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 0.83rem;
    font-weight: 600;
    margin-bottom: 20px;
}

.alert-error {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(220,40,50,0.08);
    border: 1px solid rgba(220,40,50,0.20);
    color: #b91c1c;
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 0.83rem;
    font-weight: 600;
    margin-bottom: 20px;
}

.summary-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    margin-bottom: 24px;
}

.sum-card {
    background: rgba(255,255,255,0.72);
    border: 1px solid rgba(14,160,110,0.14);
    border-radius: 13px;
    padding: 18px 20px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 12px rgba(14,160,110,0.08);
}

.sum-icon {
    width: 42px;
    height: 42px;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    flex-shrink: 0;
}

.si-orange  { background: rgba(230,120,30,0.12);  color: #e6781e; border: 1px solid rgba(230,120,30,0.20); }
.si-green   { background: rgba(14,160,110,0.12);  color: #0a9a6e; border: 1px solid rgba(14,160,110,0.20); }
.si-red     { background: rgba(220,40,50,0.12);   color: #dc2832; border: 1px solid rgba(220,40,50,0.20); }
.si-blue    { background: rgba(42,100,230,0.12);  color: #2a64e6; border: 1px solid rgba(42,100,230,0.20); }

.sum-info .sv { font-size: 1.6rem; font-weight: 800; color: #0e2030; line-height: 1; }
.sum-info .sl { font-size: 0.68rem; font-weight: 600; color: rgba(18,40,58,0.48); text-transform: uppercase; letter-spacing: 0.8px; margin-top: 3px; }

.table-card {
    background: rgba(255,255,255,0.75);
    border: 1px solid rgba(14,160,110,0.14);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(14,160,110,0.08);
}

.table-head {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(14,160,110,0.12);
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

.t-title { font-size: 0.92rem; font-weight: 700; color: #0e2030; }

.table-wrap { overflow-x: auto; }

table { width: 100%; border-collapse: collapse; }

thead tr {
    background: rgba(14,160,110,0.07);
    border-bottom: 1px solid rgba(14,160,110,0.12);
}

thead th {
    padding: 11px 16px;
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.9px;
    color: rgba(18,40,58,0.48);
    text-align: left;
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid rgba(14,160,110,0.07);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(14,160,110,0.04); }

tbody td {
    padding: 12px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    vertical-align: middle;
}

.leave-type-chip {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 6px;
    font-size: 0.7rem;
    font-weight: 600;
    background: rgba(42,100,230,0.10);
    color: #2a55cc;
    border: 1px solid rgba(42,100,230,0.18);
}

.badge-pending {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background: rgba(230,170,30,0.12);
    border: 1px solid rgba(230,170,30,0.25);
    color: #92680a;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
}

.badge-approved {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.22);
    color: #0a7a58;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
}

.badge-rejected {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background: rgba(220,40,50,0.10);
    border: 1px solid rgba(220,40,50,0.20);
    color: #b91c1c;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.68rem;
    font-weight: 700;
}

.action-link {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 5px 12px;
    border-radius: 7px;
    font-size: 0.72rem;
    font-weight: 700;
    text-decoration: none;
    transition: opacity 0.15s;
    margin-right: 5px;
}

.action-link:hover { opacity: 0.82; }

.btn-approve {
    background: rgba(14,160,110,0.14);
    border: 1px solid rgba(14,160,110,0.28);
    color: #0a7a58;
}

.btn-reject {
    background: rgba(220,40,50,0.10);
    border: 1px solid rgba(220,40,50,0.22);
    color: #b91c1c;
}

.done-label {
    font-size: 0.72rem;
    color: rgba(18,40,58,0.35);
    font-weight: 500;
}

.empty-row td {
    text-align: center;
    padding: 36px;
    color: rgba(18,40,58,0.38);
    font-size: 0.83rem;
}

@media (max-width: 900px) {
    .summary-row { grid-template-columns: repeat(2,1fr); }
    .main { padding: 20px 14px 40px; }
}

@media (max-width: 500px) {
    .summary-row { grid-template-columns: 1fr; }
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

    <div class="page-eyebrow">HR Panel</div>
    <div class="page-title">Leave Management</div>

    <% if(!msg.isEmpty()){ %>
    <div class="<%= msgType.equals("success") ? "alert-success" : "alert-error" %>">
        <i class="bi bi-<%= msgType.equals("success") ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
        <%= msg %>
    </div>
    <% } %>

<%
int totalLeaves = 0, pendingCount = 0, approvedCount = 0, rejectedCount = 0;
try {
    ResultSet rc = con.createStatement().executeQuery("SELECT COUNT(*) FROM leave_requests");
    if(rc.next()) totalLeaves = rc.getInt(1);
    ResultSet rp = con.createStatement().executeQuery("SELECT COUNT(*) FROM leave_requests WHERE status='Pending'");
    if(rp.next()) pendingCount = rp.getInt(1);
    ResultSet ra = con.createStatement().executeQuery("SELECT COUNT(*) FROM leave_requests WHERE status='Approved'");
    if(ra.next()) approvedCount = ra.getInt(1);
    ResultSet rr = con.createStatement().executeQuery("SELECT COUNT(*) FROM leave_requests WHERE status='Rejected'");
    if(rr.next()) rejectedCount = rr.getInt(1);
} catch(Exception e){}
%>

    <div class="summary-row">
        <div class="sum-card">
            <div class="sum-icon si-blue"><i class="bi bi-calendar3"></i></div>
            <div class="sum-info"><div class="sv"><%= totalLeaves %></div><div class="sl">Total Requests</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-orange"><i class="bi bi-hourglass-split"></i></div>
            <div class="sum-info"><div class="sv"><%= pendingCount %></div><div class="sl">Pending</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-green"><i class="bi bi-check-circle-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= approvedCount %></div><div class="sl">Approved</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-red"><i class="bi bi-x-circle-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= rejectedCount %></div><div class="sl">Rejected</div></div>
        </div>
    </div>

    <div class="table-card">
        <div class="table-head">
            <div class="t-icon"><i class="bi bi-list-check"></i></div>
            <div class="t-title">Leave Requests</div>
        </div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Emp ID</th>
                        <th>Leave Type</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Applied On</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
<%
boolean hasRows = false;
try {
    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM leave_requests ORDER BY applied_on DESC");
    while(rs.next()){
        hasRows = true;
        String rowStatus = rs.getString("status");
        String badgeClass = "badge-pending";
        String dotIcon = "bi-circle-fill";
        if("Approved".equalsIgnoreCase(rowStatus)){ badgeClass = "badge-approved"; dotIcon = "bi-check-circle-fill"; }
        else if("Rejected".equalsIgnoreCase(rowStatus)){ badgeClass = "badge-rejected"; dotIcon = "bi-x-circle-fill"; }
%>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><strong><%= rs.getInt("employee_id") %></strong></td>
                        <td><span class="leave-type-chip"><%= rs.getString("leave_type") %></span></td>
                        <td><%= rs.getString("start_date") %></td>
                        <td><%= rs.getString("end_date") %></td>
                        <td style="max-width:180px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" title="<%= rs.getString("reason") %>"><%= rs.getString("reason") %></td>
                        <td><span class="<%= badgeClass %>"><i class="bi <%= dotIcon %>"></i> <%= rowStatus %></span></td>
                        <td><%= rs.getString("applied_on") %></td>
                        <td>
                            <% if("Pending".equalsIgnoreCase(rowStatus)){ %>
                            <a href="leave-management.jsp?id=<%= rs.getInt("id") %>&action=Approved" class="action-link btn-approve">
                                <i class="bi bi-check-lg"></i> Approve
                            </a>
                            <a href="leave-management.jsp?id=<%= rs.getInt("id") %>&action=Rejected" class="action-link btn-reject">
                                <i class="bi bi-x-lg"></i> Reject
                            </a>
                            <% } else { %>
                            <span class="done-label"><i class="bi bi-check2-all"></i> Done</span>
                            <% } %>
                        </td>
                    </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!hasRows){ %>
                    <tr class="empty-row">
                        <td colspan="9"><i class="bi bi-inbox"></i>&nbsp; No leave requests found.</td>
                    </tr>
<% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
