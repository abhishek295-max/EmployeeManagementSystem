<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="db.jsp" %>
<%@ page import="javax.servlet.http.Part" %>
<%
String hr = (String) session.getAttribute("hr");
if(hr == null){ response.sendRedirect("hr-login.jsp"); return; }
String msg = "", msgType = "";
if(request.getMethod().equalsIgnoreCase("POST")){
    String empId   = request.getParameter("employee_id");
    String docName = request.getParameter("document_name");
    Part filePart  = request.getPart("file");
    if(filePart != null && filePart.getSize() > 0){
        PreparedStatement ps = null;
        try{
            InputStream fileContent = filePart.getInputStream();
            String origName = filePart.getSubmittedFileName();
            ps = con.prepareStatement(
                "INSERT INTO documents(employee_id,document_name,file_data,uploaded_at) VALUES(?,?,?,NOW())"
            );
            ps.setInt(1, Integer.parseInt(empId));
            ps.setString(2, docName);
            ps.setBlob(3, fileContent);
            ps.executeUpdate();
            msg = "Document \"" + docName + "\" uploaded successfully for Employee ID " + empId;
            msgType = "success";
        } catch(Exception e){ msg = "Error: " + e.getMessage(); msgType = "error"; }
        finally{ try{ if(ps!=null) ps.close(); } catch(Exception e){} }
    } else { msg = "Please select a file before uploading."; msgType = "warn"; }
}
String fileId = request.getParameter("fileId");
if(fileId != null){
    PreparedStatement ps = null; ResultSet rs = null;
    try{
        ps = con.prepareStatement("SELECT file_data FROM documents WHERE id=?");
        ps.setInt(1, Integer.parseInt(fileId));
        rs = ps.executeQuery();
        if(rs.next()){
            Blob blob = rs.getBlob("file_data");
            byte[] data = blob.getBytes(1, (int) blob.length());
            response.setContentType("application/octet-stream");
            response.getOutputStream().write(data);
            return;
        }
    } catch(Exception e){ out.println(e); }
    finally{
        try{ if(rs!=null) rs.close(); } catch(Exception e){}
        try{ if(ps!=null) ps.close(); } catch(Exception e){}
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Documents Management ? EMS Pro</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #f0eafa;
    background-image:
        radial-gradient(ellipse 75% 60% at 0% 0%,    rgba(150,60,220,0.22) 0%, transparent 55%),
        radial-gradient(ellipse 60% 50% at 100% 100%, rgba(42,100,230,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 50% 45% at 55% 5%,   rgba(200,120,255,0.12) 0%, transparent 50%),
        radial-gradient(ellipse 40% 40% at 5% 100%,  rgba(14,160,110,0.10) 0%, transparent 50%);
    min-height: 100vh;
    color: #12283a;
}

.topbar {
    background: rgba(255,255,255,0.82);
    border-bottom: 1px solid rgba(150,60,220,0.16);
    backdrop-filter: blur(14px);
    padding: 12px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 99;
    box-shadow: 0 2px 16px rgba(150,60,220,0.10);
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
    background: rgba(140,50,210,0.88);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
    color: #fff;
    box-shadow: 0 2px 14px rgba(140,50,210,0.36);
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
    background: rgba(140,50,210,0.10);
    border: 1px solid rgba(140,50,210,0.20);
    color: #8c32d2;
    padding: 7px 15px;
    border-radius: 8px;
    font-size: 0.78rem;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.15s;
}

.back-btn:hover { background: rgba(140,50,210,0.18); color: #8c32d2; }

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
    color: rgba(140,50,210,0.52);
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

.alert-warn {
    display: flex;
    align-items: center;
    gap: 9px;
    background: rgba(230,170,30,0.10);
    border: 1px solid rgba(230,170,30,0.24);
    color: #92680a;
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 0.83rem;
    font-weight: 600;
    margin-bottom: 20px;
}

.summary-row {
    display: grid;
    grid-template-columns: repeat(3,1fr);
    gap: 16px;
    margin-bottom: 24px;
}

.sum-card {
    background: rgba(255,255,255,0.72);
    border: 1px solid rgba(150,60,220,0.13);
    border-radius: 13px;
    padding: 18px 20px;
    display: flex;
    align-items: center;
    gap: 14px;
    box-shadow: 0 2px 12px rgba(150,60,220,0.08);
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

.si-v { background: rgba(140,50,210,0.12); color: #8c32d2; border: 1px solid rgba(140,50,210,0.20); }
.si-b { background: rgba(42,100,230,0.12);  color: #2a64e6; border: 1px solid rgba(42,100,230,0.20); }
.si-g { background: rgba(14,160,110,0.12);  color: #0a9a6e; border: 1px solid rgba(14,160,110,0.20); }

.sum-info .sv { font-size: 1.55rem; font-weight: 800; color: #0e2030; line-height: 1; }
.sum-info .sl { font-size: 0.67rem; font-weight: 600; color: rgba(18,40,58,0.46); text-transform: uppercase; letter-spacing: 0.8px; margin-top: 3px; }

.layout {
    display: grid;
    grid-template-columns: 360px 1fr;
    gap: 24px;
    align-items: start;
}

.form-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(150,60,220,0.15);
    border-radius: 16px;
    padding: 26px 24px;
    box-shadow: 0 4px 18px rgba(150,60,220,0.10);
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
    border-bottom: 1px solid rgba(150,60,220,0.10);
}

.fc-icon {
    width: 34px;
    height: 34px;
    background: rgba(140,50,210,0.12);
    border: 1px solid rgba(140,50,210,0.20);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8c32d2;
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
    border: 1px solid rgba(150,60,220,0.18);
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
    border-color: #8c32d2;
    box-shadow: 0 0 0 3px rgba(140,50,210,0.13);
    background: #fff;
}

.f-input::placeholder { color: rgba(18,40,58,0.36); }

.file-zone {
    width: 100%;
    background: rgba(140,50,210,0.05);
    border: 2px dashed rgba(140,50,210,0.28);
    border-radius: 10px;
    padding: 22px 16px;
    text-align: center;
    cursor: pointer;
    margin-bottom: 16px;
    transition: border-color 0.15s, background 0.15s;
    position: relative;
}

.file-zone:hover {
    border-color: rgba(140,50,210,0.50);
    background: rgba(140,50,210,0.08);
}

.file-zone input[type="file"] {
    position: absolute;
    inset: 0;
    opacity: 0;
    cursor: pointer;
    width: 100%;
    height: 100%;
}

.file-zone-icon { font-size: 1.6rem; color: rgba(140,50,210,0.55); margin-bottom: 6px; }
.file-zone-text { font-size: 0.78rem; color: rgba(18,40,58,0.48); }
.file-zone-hint { font-size: 0.68rem; color: rgba(18,40,58,0.35); margin-top: 4px; }

.submit-btn {
    width: 100%;
    padding: 11px;
    background: rgba(140,50,210,0.88);
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
    box-shadow: 0 3px 14px rgba(140,50,210,0.28);
}

.submit-btn:hover { opacity: 0.88; transform: translateY(-1px); }

.table-card {
    background: rgba(255,255,255,0.76);
    border: 1px solid rgba(150,60,220,0.13);
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 18px rgba(150,60,220,0.08);
}

.table-head {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 18px 22px;
    border-bottom: 1px solid rgba(150,60,220,0.10);
}

.t-icon {
    width: 34px;
    height: 34px;
    background: rgba(140,50,210,0.12);
    border: 1px solid rgba(140,50,210,0.18);
    border-radius: 9px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #8c32d2;
    font-size: 0.95rem;
}

.t-title { font-size: 0.92rem; font-weight: 700; color: #0e2030; }

.table-wrap { overflow-x: auto; }

table { width: 100%; border-collapse: collapse; }

thead tr {
    background: rgba(150,60,220,0.06);
    border-bottom: 1px solid rgba(150,60,220,0.10);
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
    border-bottom: 1px solid rgba(150,60,220,0.06);
    transition: background 0.12s;
}

tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: rgba(150,60,220,0.04); }

tbody td {
    padding: 12px 16px;
    font-size: 0.82rem;
    color: #1a2a45;
    vertical-align: middle;
}

.doc-name-cell {
    display: flex;
    align-items: center;
    gap: 9px;
}

.doc-file-icon {
    width: 32px;
    height: 32px;
    background: rgba(140,50,210,0.10);
    border: 1px solid rgba(140,50,210,0.18);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.9rem;
    color: #8c32d2;
    flex-shrink: 0;
}

.doc-title { font-size: 0.82rem; font-weight: 600; color: #1a2a45; }

.download-btn {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    background: rgba(14,160,110,0.12);
    border: 1px solid rgba(14,160,110,0.24);
    color: #0a7a58;
    padding: 5px 13px;
    border-radius: 7px;
    font-size: 0.74rem;
    font-weight: 700;
    text-decoration: none;
    transition: background 0.15s, color 0.15s;
}

.download-btn:hover {
    background: rgba(14,160,110,0.22);
    color: #065f46;
}

.date-text {
    font-size: 0.76rem;
    color: rgba(18,40,58,0.48);
}

.empty-row td {
    text-align: center;
    padding: 36px;
    color: rgba(18,40,58,0.38);
    font-size: 0.83rem;
}

@media (max-width: 960px) {
    .layout { grid-template-columns: 1fr; }
    .summary-row { grid-template-columns: 1fr; }
    .main { padding: 20px 14px 40px; }
}
</style>
</head>
<body>

<header class="topbar">
    <a href="hr-dashboard.jsp" class="brand">
        <div class="brand-icon"><i class="bi bi-folder-fill"></i></div>
        Employee Management System <span class="hr-badge">HR</span>
    </a>
    <a href="hr-dashboard.jsp" class="back-btn">
        <i class="bi bi-arrow-left"></i> Back to Dashboard
    </a>
</header>

<div class="main">

    <div class="page-eyebrow">HR Panel</div>
    <div class="page-title">Documents Management</div>

    <% if(!msg.isEmpty()){ %>
    <div class="<%=
        msgType.equals("success") ? "alert-success" :
        msgType.equals("warn")    ? "alert-warn"    : "alert-error"
    %>">
        <i class="bi bi-<%=
            msgType.equals("success") ? "check-circle-fill" :
            msgType.equals("warn")    ? "exclamation-triangle-fill" : "exclamation-circle-fill"
        %>"></i>
        <%= msg %>
    </div>
    <% } %>

<%
int totalDocs = 0, totalEmps = 0;
String lastUpload = "?";
try {
    ResultSet rc = con.createStatement().executeQuery("SELECT COUNT(*), COUNT(DISTINCT employee_id) FROM documents");
    if(rc.next()){ totalDocs = rc.getInt(1); totalEmps = rc.getInt(2); }
    ResultSet rl = con.createStatement().executeQuery("SELECT uploaded_at FROM documents ORDER BY uploaded_at DESC LIMIT 1");
    if(rl.next()) lastUpload = rl.getTimestamp("uploaded_at").toString().substring(0,10);
} catch(Exception e){}
%>

    <div class="summary-row">
        <div class="sum-card">
            <div class="sum-icon si-v"><i class="bi bi-file-earmark-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= totalDocs %></div><div class="sl">Total Documents</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-b"><i class="bi bi-people-fill"></i></div>
            <div class="sum-info"><div class="sv"><%= totalEmps %></div><div class="sl">Employees with Docs</div></div>
        </div>
        <div class="sum-card">
            <div class="sum-icon si-g"><i class="bi bi-clock-history"></i></div>
            <div class="sum-info"><div class="sv" style="font-size:1.1rem;"><%= lastUpload %></div><div class="sl">Last Upload</div></div>
        </div>
    </div>

    <div class="layout">

        <div class="form-card">
            <div class="form-card-title">
                <div class="fc-icon"><i class="bi bi-cloud-upload-fill"></i></div>
                Upload Document
            </div>
            <form method="post" enctype="multipart/form-data">
                <label class="f-label">Employee ID</label>
                <input type="number" name="employee_id" class="f-input" placeholder="Enter Employee ID" required>

                <label class="f-label">Document Name</label>
                <input type="text" name="document_name" class="f-input" placeholder="e.g. Offer Letter, Aadhar Card" required>

                <label class="f-label">Select File</label>
                <div class="file-zone">
                    <input type="file" name="file" required>
                    <div class="file-zone-icon"><i class="bi bi-cloud-arrow-up-fill"></i></div>
                    <div class="file-zone-text">Click to browse or drag & drop</div>
                    <div class="file-zone-hint">PDF, DOC, PNG, JPG ? Max 10MB</div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="bi bi-upload"></i> Upload Document
                </button>
            </form>
        </div>

        <div class="table-card">
            <div class="table-head">
                <div class="t-icon"><i class="bi bi-folder2-open"></i></div>
                <div class="t-title">Documents List</div>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Emp ID</th>
                            <th>Document Name</th>
                            <th>Download</th>
                            <th>Uploaded On</th>
                        </tr>
                    </thead>
                    <tbody>
<%
boolean hasRows = false;
PreparedStatement ps2 = null;
ResultSet rs2 = null;
try {
    ps2 = con.prepareStatement(
        "SELECT id,employee_id,document_name,uploaded_at FROM documents ORDER BY uploaded_at DESC"
    );
    rs2 = ps2.executeQuery();
    while(rs2.next()){
        hasRows = true;
%>
                        <tr>
                            <td><%= rs2.getInt("id") %></td>
                            <td><strong><%= rs2.getInt("employee_id") %></strong></td>
                            <td>
                                <div class="doc-name-cell">
                                    <div class="doc-file-icon"><i class="bi bi-file-earmark-text-fill"></i></div>
                                    <div class="doc-title"><%= rs2.getString("document_name") %></div>
                                </div>
                            </td>
                            <td>
                                <a href="documents.jsp?fileId=<%= rs2.getInt("id") %>" class="download-btn">
                                    <i class="bi bi-download"></i> Download
                                </a>
                            </td>
                            <td class="date-text">
                                <i class="bi bi-calendar3" style="margin-right:4px;"></i>
                                <%= rs2.getTimestamp("uploaded_at").toString().substring(0,16) %>
                            </td>
                        </tr>
<% } } catch(Exception e){ out.println(e); }
finally{
    try{ if(rs2!=null) rs2.close(); } catch(Exception e){}
    try{ if(ps2!=null) ps2.close(); } catch(Exception e){}
}
%>
<% if(!hasRows){ %>
                        <tr class="empty-row">
                            <td colspan="5"><i class="bi bi-inbox"></i>&nbsp; No documents uploaded yet.</td>
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
