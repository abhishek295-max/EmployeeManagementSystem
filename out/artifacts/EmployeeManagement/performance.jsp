<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){ response.sendRedirect("hr-login.jsp"); }
String emp      = request.getParameter("employee_id");
String rdate    = request.getParameter("review_date");
String rating   = request.getParameter("rating");
String comments = request.getParameter("comments");
String reviewer = request.getParameter("reviewer");
String msg = "", msgType = "";
if(emp != null){
    try{
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO  performance_reviews (employee_id,review_date,rating,comments,reviewer) VALUES(?,?,?,?,?)"
        );
        ps.setInt(1, Integer.parseInt(emp));
        ps.setString(2, rdate);
        ps.setInt(3, Integer.parseInt(rating));
        ps.setString(4, comments);
        ps.setString(5, reviewer);
        ps.executeUpdate();
        msg = "Performance review added successfully for Employee ID " + emp;
        msgType = "success";
    } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Performance Review ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e2f4ee;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(20,190,140,0.30) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.20) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(140,70,225,0.12) 0%, transparent 50%);
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
    background: rgba(140,70,225,0.88);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(140,70,225,0.38);
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
    max-width: 1160px;
    margin: 0 auto;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(140,70,225,0.55);
    margin-bottom: 4px;
}

.page-title {
    font-size: 1.5rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin-bottom: 24px;
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

.layout {
    display: grid;
    grid-template-columns: 370px 1fr;
    gap: 24px;
    align-items: start;
}

.form-card {
    background: rgba(255,255,255,0.75);
    border: 1px solid rgba(140,70,225,0.15);
    border-radius: 16px;
    padding: 26px 24px;
    box-shadow: 0 4px 18px rgba(140,70,225,0.10);
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
    border-bottom: 1px solid rgba(140,70,225,0.10);
}

.fc-icon {
    width: 34px;
    height: 34px;
    background: rgba(140,70,225,0.12);
    border: 1px solid rgba(140,70,225,0.20);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8c46e1;
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
    border: 1px solid rgba(140,70,225,0.20);
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
    border-color: #8c46e1;
    box-shadow: 0 0 0 3px rgba(140,70,225,0.13);
    background: #fff;
}

.f-input::placeholder { color: rgba(18,40,58,0.38); }

textarea.f-input { resize: vertical; min-height: 90px; }

.rating-hint {
    font-size: 0.68rem;
    color: rgba(18,40,58,0.42);
    margin-top: -10px;
    margin-bottom: 14px;
}

.submit-btn {
    width: 100%;
    padding: 11px;
    background: rgba(140,70,225,0.88);
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
    box-shadow: 0 3px 14px rgba(140,70,225,0.30);
}

.submit-btn:hover { opacity: 0.88; transform: translateY(-1px); }

.table-card {
    background: rgba(255,255,255,0.75);
    border: 1px solid rgba(140,70,225,0.13);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(140,70,225,0.08);
}

.table-head {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(140,70,225,0.10);
}

.t-icon {
    width: 34px;
    height: 34px;
    background: rgba(140,70,225,0.12);
    border: 1px solid rgba(140,70,225,0.18);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8c46e1;
    font-size: 0.95rem;
}

.t-title { font-size: 0.92rem; font-weight: 700; color: #0e2030; }

.table-wrap { overflow-x: auto; }

table { width: 100%; border-collapse: collapse; }

thead tr {
    background: rgba(140,70,225,0.06);
    border-bottom: 1px solid rgba(140,70,225,0.10);
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
    border-bottom: 1px solid rgba(140,70,225,0.06);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(140,70,225,0.04); }

tbody td {
    padding: 12px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    vertical-align: middle;
}

.stars-wrap {
    display: flex;
    align-items: center;
    gap: 5px;
}

.rating-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.72rem;
    font-weight: 700;
}

.r-high   { background: rgba(14,160,110,0.12); color: #0a7a58; border: 1px solid rgba(14,160,110,0.22); }
.r-mid    { background: rgba(230,170,30,0.12); color: #92680a; border: 1px solid rgba(230,170,30,0.22); }
.r-low    { background: rgba(220,40,50,0.10);  color: #b91c1c; border: 1px solid rgba(220,40,50,0.18); }

.reviewer-chip {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(42,100,230,0.10);
    border: 1px solid rgba(42,100,230,0.18);
    color: #2a55cc;
    padding: 3px 10px;
    border-radius: 6px;
    font-size: 0.72rem;
    font-weight: 600;
}

.comment-cell {
    max-width: 200px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    color: rgba(18,40,58,0.58);
}

.empty-row td {
    text-align: center;
    padding: 36px;
    color: rgba(18,40,58,0.38);
    font-size: 0.83rem;
}

@media (max-width: 920px) {
    .layout { grid-template-columns: 1fr; }
    .main { padding: 20px 14px 40px; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="hr-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-graph-up-arrow"></i></div>
        Employee Management System <span class="hr-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">

    <div class="page-eyebrow">HR Panel</div>
    <div class="page-title">Performance Review</div>

    <% if(!msg.isEmpty()){ %>
    <div class="<%= msgType.equals("success") ? "alert-success" : "alert-error" %>">
        <i class="bi bi-<%= msgType.equals("success") ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
        <%= msg %>
    </div>
    <% } %>

    <div class="layout">

        <div class="form-card">
            <div class="form-card-title">
                <div class="fc-icon"><i class="bi bi-pencil-square"></i></div>
                Add Performance Review
            </div>
            <form method="post">
                <label class="f-label">Employee ID</label>
                <input type="number" name="employee_id" class="f-input" placeholder="Enter Employee ID" required>

                <label class="f-label">Review Date</label>
                <input type="date" name="review_date" class="f-input" required>

                <label class="f-label">Rating (1 ? 10)</label>
                <input type="number" name="rating" class="f-input" placeholder="e.g. 8" min="1" max="10" required>
                <div class="rating-hint">1 = Poor &nbsp;·&nbsp; 5 = Average &nbsp;·&nbsp; 10 = Excellent</div>

                <label class="f-label">Reviewer Name</label>
                <input type="text" name="reviewer" class="f-input" placeholder="Enter reviewer name" required>

                <label class="f-label">Comments</label>
                <textarea name="comments" class="f-input" placeholder="Write detailed review comments..." required></textarea>

                <button type="submit" class="submit-btn">
                    <i class="bi bi-send-fill"></i> Submit Review
                </button>
            </form>
        </div>

        <div class="table-card">
            <div class="table-head">
                <div class="t-icon"><i class="bi bi-bar-chart-fill"></i></div>
                <div class="t-title">Performance Records</div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Emp ID</th>
                            <th>Review Date</th>
                            <th>Rating</th>
                            <th>Reviewer</th>
                            <th>Comments</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean hasRows = false;
try {
    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM  performance_reviews ORDER BY review_date DESC");
    while(rs.next()){
        hasRows = true;
        int r = rs.getInt("rating");
        String rClass = r >= 8 ? "r-high" : (r >= 5 ? "r-mid" : "r-low");
        String rIcon  = r >= 8 ? "bi-star-fill" : (r >= 5 ? "bi-star-half" : "bi-star");
%>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><strong><%= rs.getInt("employee_id") %></strong></td>
                            <td><%= rs.getString("review_date") %></td>
                            <td>
                                <span class="rating-badge <%= rClass %>">
                                    <i class="bi <%= rIcon %>"></i> <%= r %> / 10
                                </span>
                            </td>
                            <td><span class="reviewer-chip"><i class="bi bi-person-fill"></i> <%= rs.getString("reviewer") %></span></td>
                            <td class="comment-cell" title="<%= rs.getString("comments") %>"><%= rs.getString("comments") %></td>
                        </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!hasRows){ %>
                        <tr class="empty-row">
                            <td colspan="6"><i class="bi bi-inbox"></i>&nbsp; No performance records found.</td>
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
