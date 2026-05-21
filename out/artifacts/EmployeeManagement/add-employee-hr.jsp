<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
String msg = "", msgType = "";
if(request.getMethod().equalsIgnoreCase("POST")){
    try {
        int userId   = Integer.parseInt(request.getParameter("user_id"));
        String name  = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        int dept     = Integer.parseInt(request.getParameter("department"));
        String job   = request.getParameter("job_title");
        String hire  = request.getParameter("hire_date");
        double sal   = Double.parseDouble(request.getParameter("salary"));
        String addr  = request.getParameter("address");
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO employees(user_id,name,email,phone,gender,department_id,job_title,hire_date,salary,address) VALUES(?,?,?,?,?,?,?,?,?,?)"
        );
        ps.setInt(1,userId); ps.setString(2,name); ps.setString(3,email);
        ps.setString(4,phone); ps.setString(5,gender); ps.setInt(6,dept);
        ps.setString(7,job); ps.setString(8,hire); ps.setDouble(9,sal); ps.setString(10,addr);
        int i = ps.executeUpdate();
        msg = i > 0 ? "Employee \"" + name + "\" added successfully!" : "Failed to add employee.";
        msgType = i > 0 ? "success" : "error";
    } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Employee ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #e2f4ee;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(20,190,140,0.28) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(80,200,180,0.13) 0%, transparent 50%);
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
    justify-content: center;
    padding: 36px 20px 56px;
}

.form-wrapper {
    width: 100%;
    max-width: 680px;
}

.page-eyebrow {
    font-size: 0.67rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.8px;
    color: rgba(14,140,100,0.55);
    margin-bottom: 4px;
    text-align: center;
}

.page-title {
    font-size: 1.45rem;
    font-weight: 800;
    color: #0e2030;
    letter-spacing: -0.3px;
    margin-bottom: 22px;
    text-align: center;
}

.alert-success {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(14,160,110,0.10);
    border: 1px solid rgba(14,160,110,0.24);
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

.form-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(14,160,110,0.15);
    border-radius: 18px;
    padding: 30px 28px;
    box-shadow: 0 4px 22px rgba(14,160,110,0.10);
}

.section-divider {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 22px 0 16px;
}

.section-divider-line {
    flex: 1;
    height: 1px;
    background: rgba(14,160,110,0.14);
}

.section-label {
    display: flex;
    align-items: center;
    gap: 7px;
    font-size: 0.68rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.4px;
    color: rgba(14,140,100,0.60);
    white-space: nowrap;
}

.section-label i { font-size: 0.8rem; }

.two-col {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 16px;
}

.three-col {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
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
    margin-bottom: 14px;
    outline: none;
    transition: border-color 0.18s, box-shadow 0.18s;
    appearance: none;
}

.f-input:focus {
    border-color: #0a9a6e;
    box-shadow: 0 0 0 3px rgba(14,160,110,0.13);
    background: #fff;
}

.f-input::placeholder { color: rgba(18,40,58,0.36); }

select.f-input {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%230a9a6e' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 13px center;
    cursor: pointer;
}

textarea.f-input {
    resize: vertical;
    min-height: 85px;
}

.btn-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: 6px;
}

.submit-btn {
    padding: 12px;
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
    padding: 12px;
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

@media (max-width: 580px) {
    .two-col, .three-col { grid-template-columns: 1fr; }
    .btn-row { grid-template-columns: 1fr; }
    .form-card { padding: 22px 18px; }
    .main { padding: 22px 14px 40px; }
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
    <div class="form-wrapper">

        <div class="page-eyebrow">HR Panel</div>
        <div class="page-title">Add New Employee</div>

        <% if(!msg.isEmpty()){ %>
        <div class="<%= msgType.equals("success") ? "alert-success" : "alert-error" %>">
            <i class="bi bi-<%= msgType.equals("success") ? "check-circle-fill" : "exclamation-circle-fill" %>"></i>
            <%= msg %>
        </div>
        <% } %>

        <div class="form-card">
            <form method="post">

                <div class="section-divider">
                    <div class="section-divider-line"></div>
                    <div class="section-label"><i class="bi bi-person-fill"></i> Account & Identity</div>
                    <div class="section-divider-line"></div>
                </div>

                <div class="two-col">
                    <div>
                        <label class="f-label">User ID</label>
                        <input type="number" name="user_id" class="f-input" placeholder="Enter User ID" required>
                    </div>
                    <div>
                        <label class="f-label">Full Name</label>
                        <input type="text" name="name" class="f-input" placeholder="e.g. Ravi Sharma" required>
                    </div>
                </div>

                <div class="section-divider">
                    <div class="section-divider-line"></div>
                    <div class="section-label"><i class="bi bi-envelope-fill"></i> Contact Details</div>
                    <div class="section-divider-line"></div>
                </div>

                <div class="two-col">
                    <div>
                        <label class="f-label">Email Address</label>
                        <input type="email" name="email" class="f-input" placeholder="ravi@company.com" required>
                    </div>
                    <div>
                        <label class="f-label">Phone Number</label>
                        <input type="text" name="phone" class="f-input" placeholder="+91 XXXXX XXXXX" required>
                    </div>
                </div>

                <div class="section-divider">
                    <div class="section-divider-line"></div>
                    <div class="section-label"><i class="bi bi-briefcase-fill"></i> Employment Details</div>
                    <div class="section-divider-line"></div>
                </div>

                <div class="three-col">
                    <div>
                        <label class="f-label">Gender</label>
                        <select name="gender" class="f-input" required>
                            <option value="">Select</option>
                            <option>Male</option>
                            <option>Female</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div>
                        <label class="f-label">Department</label>
                        <select name="department" class="f-input" required>
                            <option value="">Select</option>
                            <%
                            try{
                                ResultSet rs = con.createStatement().executeQuery("SELECT * FROM departments ORDER BY name");
                                while(rs.next()){
                            %>
                            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
                            <% } } catch(Exception e){ out.println(e); } %>
                        </select>
                    </div>
                    <div>
                        <label class="f-label">Job Title</label>
                        <input type="text" name="job_title" class="f-input" placeholder="e.g. Developer" required>
                    </div>
                </div>

                <div class="two-col">
                    <div>
                        <label class="f-label">Hire Date</label>
                        <input type="date" name="hire_date" class="f-input" required>
                    </div>
                    <div>
                        <label class="f-label">Salary (?)</label>
                        <input type="number" name="salary" class="f-input" placeholder="e.g. 35000" step="0.01" required>
                    </div>
                </div>

                <div class="section-divider">
                    <div class="section-divider-line"></div>
                    <div class="section-label"><i class="bi bi-geo-alt-fill"></i> Address</div>
                    <div class="section-divider-line"></div>
                </div>

                <label class="f-label">Full Address</label>
                <textarea name="address" class="f-input" placeholder="Enter complete residential address..." required></textarea>

                <div class="btn-row">
                    <button type="submit" class="submit-btn">
                        <i class="bi bi-person-plus-fill"></i> Add Employee
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
