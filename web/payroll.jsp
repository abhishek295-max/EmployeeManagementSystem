<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){ response.sendRedirect("hr-login.jsp"); }
String emp    = request.getParameter("employee_id");
String base   = request.getParameter("base_salary");
String bonus  = request.getParameter("bonus");
String deduct = request.getParameter("deductions");
String pdate  = request.getParameter("payment_date");
String msg = "", msgType = "";
double netSalary = 0;
if(emp != null){
    try{
        double b  = Double.parseDouble(base);
        double bo = Double.parseDouble(bonus);
        double d  = Double.parseDouble(deduct);
        netSalary = b + bo - d;
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO salary_records(employee_id,base_salary,bonus,deductions,net_salary,payment_date) VALUES(?,?,?,?,?,?)"
        );
        ps.setInt(1, Integer.parseInt(emp));
        ps.setDouble(2, b); ps.setDouble(3, bo);
        ps.setDouble(4, d); ps.setDouble(5, netSalary);
        ps.setString(6, pdate);
        ps.executeUpdate();
        msg = "Payroll processed! Net Salary for Employee ID " + emp + " = ?" + String.format("%.2f", netSalary);
        msgType = "success";
    } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payroll Management ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #eaf4e2;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(14,190,100,0.28) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(20,190,140,0.14) 0%, transparent 50%),
        radial-gradient(ellipse 40% 40% at 90% 10%,  rgba(255,180,30,0.10) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
}

.topbar {
    background: rgba(255,255,255,0.82);
    border-bottom: 1px solid rgba(14,190,100,0.18);
    backdrop-filter: blur(14px);
    padding: 12px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 16px rgba(14,190,100,0.10);
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
    background: rgba(14,155,80,0.90);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(14,155,80,0.38);
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
    color: rgba(14,155,80,0.55);
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
    align-items: flex-start;
    gap: 10px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.25);
    color: #0a7a58;
    padding: 13px 16px;
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
    grid-template-columns: repeat(4,1fr);
    gap: 16px;
    margin-bottom: 24px;
}

.sum-card {
    background: rgba(255,255,255,0.72);
    border: 1px solid rgba(14,190,100,0.14);
    border-radius: 13px;
    padding: 18px 20px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 12px rgba(14,190,100,0.08);
}

.sum-icon {
    width: 44px;
    height: 44px;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.15rem;
    flex-shrink: 0;
}

.si-g  { background: rgba(14,160,110,0.12); color: #0a9a6e; border: 1px solid rgba(14,160,110,0.20); }
.si-b  { background: rgba(42,100,230,0.12); color: #2a64e6; border: 1px solid rgba(42,100,230,0.20); }
.si-a  { background: rgba(230,170,30,0.12); color: #b8860b; border: 1px solid rgba(230,170,30,0.20); }
.si-r  { background: rgba(220,40,50,0.10);  color: #dc2832; border: 1px solid rgba(220,40,50,0.18); }

.sum-info .sv { font-size: 1.45rem; font-weight: 800; color: #0e2030; line-height: 1; }
.sum-info .sl { font-size: 0.67rem; font-weight: 600; color: rgba(18,40,58,0.46); text-transform: uppercase; letter-spacing: 0.8px; margin-top: 3px; }

.layout {
    display: grid;
    grid-template-columns: 370px 1fr;
    gap: 24px;
    align-items: start;
}

.form-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(14,190,100,0.16);
    border-radius: 16px;
    padding: 26px 24px;
    box-shadow: 0 4px 18px rgba(14,190,100,0.10);
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
    border-bottom: 1px solid rgba(14,190,100,0.12);
}

.fc-icon {
    width: 34px;
    height: 34px;
    background: rgba(14,155,80,0.12);
    border: 1px solid rgba(14,155,80,0.22);
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
    color: rgba(18,40,58,0.50);
    margin-bottom: 5px;
    display: block;
}

.f-input {
    width: 100%;
    background: rgba(255,255,255,0.82);
    border: 1px solid rgba(14,190,100,0.20);
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
    box-shadow: 0 0 0 3px rgba(14,160,110,0.13);
    background: #fff;
}

.f-input::placeholder { color: rgba(18,40,58,0.36); }

.calc-preview {
    background: rgba(14,155,80,0.07);
    border: 1px solid rgba(14,155,80,0.16);
    border-radius: 10px;
    padding: 14px 16px;
    margin-bottom: 16px;
}

.calc-row {
    display: flex;
    justify-content: space-between;
    font-size: 0.78rem;
    color: rgba(18,40,58,0.55);
    padding: 3px 0;
}

.calc-row.net {
    border-top: 1px dashed rgba(14,155,80,0.25);
    margin-top: 6px;
    padding-top: 8px;
    font-size: 0.88rem;
    font-weight: 700;
    color: #0a7a58;
}

.submit-btn {
    width: 100%;
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
    box-shadow: 0 3px 14px rgba(14,155,80,0.30);
}

.submit-btn:hover { opacity: 0.88; transform: translateY(-1px); }

.table-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(14,190,100,0.13);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(14,190,100,0.08);
}

.table-head {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(14,190,100,0.10);
}

.t-icon {
    width: 34px;
    height: 34px;
    background: rgba(14,155,80,0.12);
    border: 1px solid rgba(14,155,80,0.18);
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
    background: rgba(14,190,100,0.06);
    border-bottom: 1px solid rgba(14,190,100,0.10);
}

thead th {
    padding: 11px 16px;
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.9px;
    color: rgba(18,40,58,0.46);
    text-align: left;
    white-space: nowrap;
}

tbody tr {
    border-bottom: 1px solid rgba(14,190,100,0.06);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(14,190,100,0.04); }

tbody td {
    padding: 12px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    vertical-align: middle;
}

.amount {
    font-size: 0.82rem;
    font-weight: 600;
    font-variant-numeric: tabular-nums;
}

.net-amount {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.22);
    color: #0a7a58;
    padding: 4px 10px;
    border-radius: 7px;
    font-size: 0.8rem;
    font-weight: 700;
}

.bonus-chip {
    color: #b8860b;
    font-weight: 600;
}

.deduct-chip {
    color: #b91c1c;
    font-weight: 600;
}

.empty-row td {
    text-align: center;
    padding: 36px;
    color: rgba(18,40,58,0.38);
    font-size: 0.83rem;
}

@media (max-width: 960px) {
    .layout { grid-template-columns: 1fr; }
    .summary-row { grid-template-columns: repeat(2,1fr); }
    .main { padding: 20px 14px 40px; }
}

@media (max-width: 480px) {
    .summary-row { grid-template-columns: 1fr; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="hr-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-cash-stack"></i></div>
        EMS Pro <span class="hr-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">

    <div class="page-eyebrow">HR Panel</div>
    <div class="page-title">Payroll Management</div>

    <% if(!msg.isEmpty()){ %>
    <div class="<%= msgType.equals("success") ? "alert-success" : "alert-error" %>">
        <i class="bi bi-<%= msgType.equals("success") ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
        <%= msg %>
    </div>
    <% } %>

<%
double totalNet = 0, totalBase = 0, totalBonus = 0, totalDeduct = 0;
int totalRecords = 0;
try {
    ResultSet rs2 = con.createStatement().executeQuery(
        "SELECT COUNT(*), SUM(base_salary), SUM(bonus), SUM(deductions), SUM(net_salary) FROM salary_records"
    );
    if(rs2.next()){
        totalRecords = rs2.getInt(1);
        totalBase    = rs2.getDouble(2);
        totalBonus   = rs2.getDouble(3);
        totalDeduct  = rs2.getDouble(4);
        totalNet     = rs2.getDouble(5);
    }
} catch(Exception e){}
%>

    <div class="summary-row">
        <div class="sum-card">
            <div class="sum-icon si-b"><i class="bi bi-people-fill"></i></div>
            <div class="sum-info">
                <div class="sv"><%= totalRecords %></div>
                <div class="sl">Total Records</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-g"><i class="bi bi-currency-rupee"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", totalBase) %></div>
                <div class="sl">Total Base</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-a"><i class="bi bi-gift-fill"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", totalBonus) %></div>
                <div class="sl">Total Bonus</div>
            </div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-r"><i class="bi bi-wallet2"></i></div>
            <div class="sum-info">
                <div class="sv">&#8377;<%= String.format("%.0f", totalNet) %></div>
                <div class="sl">Total Net Paid</div>
            </div>
        </div>
    </div>

    <div class="layout">

        <div class="form-card">
            <div class="form-card-title">
                <div class="fc-icon"><i class="bi bi-receipt"></i></div>
                Process Salary
            </div>
            <form method="post">
                <label class="f-label">Employee ID</label>
                <input type="number" name="employee_id" class="f-input" placeholder="Enter Employee ID" required>

                <label class="f-label">Base Salary (?)</label>
                <input type="number" name="base_salary" class="f-input" placeholder="e.g. 35000" step="0.01" required>

                <label class="f-label">Bonus (?)</label>
                <input type="number" name="bonus" class="f-input" placeholder="e.g. 5000" step="0.01" required>

                <label class="f-label">Deductions (?)</label>
                <input type="number" name="deductions" class="f-input" placeholder="e.g. 2000" step="0.01" required>

                <div class="calc-preview">
                    <div class="calc-row"><span>Base Salary</span><span>? ?</span></div>
                    <div class="calc-row"><span>+ Bonus</span><span>? ?</span></div>
                    <div class="calc-row"><span>? Deductions</span><span>? ?</span></div>
                    <div class="calc-row net"><span><i class="bi bi-calculator"></i> Net Salary</span><span>? ?</span></div>
                </div>

                <label class="f-label">Payment Date</label>
                <input type="date" name="payment_date" class="f-input" required>

                <button type="submit" class="submit-btn">
                    <i class="bi bi-send-fill"></i> Process Payroll
                </button>
            </form>
        </div>

        <div class="table-card">
            <div class="table-head">
                <div class="t-icon"><i class="bi bi-table"></i></div>
                <div class="t-title">Salary Records</div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Emp ID</th>
                            <th>Base Salary</th>
                            <th>Bonus</th>
                            <th>Deductions</th>
                            <th>Net Salary</th>
                            <th>Payment Date</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean hasRows = false;
try {
    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM salary_records ORDER BY payment_date DESC");
    while(rs.next()){
        hasRows = true;
%>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><strong><%= rs.getInt("employee_id") %></strong></td>
                            <td class="amount">&#8377;<%= String.format("%.2f", rs.getDouble("base_salary")) %></td>
                            <td class="amount bonus-chip">+&#8377;<%= String.format("%.2f", rs.getDouble("bonus")) %></td>
                            <td class="amount deduct-chip">-&#8377;<%= String.format("%.2f", rs.getDouble("deductions")) %></td>
                            <td>
                                <span class="net-amount">
                                    <i class="bi bi-currency-rupee"></i>
                                    <%= String.format("%.2f", rs.getDouble("net_salary")) %>
                                </span>
                            </td>
                            <td><%= rs.getString("payment_date") %></td>
                        </tr>
<% } } catch(Exception e){ out.println(e); } %>
<% if(!hasRows){ %>
                        <tr class="empty-row">
                            <td colspan="7"><i class="bi bi-inbox"></i>&nbsp; No salary records found.</td>
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
