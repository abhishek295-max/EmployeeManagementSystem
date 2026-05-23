<%@ page import="java.io.*, java.net.*, org.json.*" %>

<%
request.setCharacterEncoding("UTF-8");

String question = request.getParameter("question");
String aiResponse = "";
String errorMessage = "";

if(question != null && !question.trim().isEmpty()) {

    try {

        // ========= API KEY =========
        String apiKey =
        System.getenv("OPENROUTER_API_KEY");

        // Fallback API key
        if(apiKey == null || apiKey.trim().isEmpty()) {

            apiKey =
            "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";
        }

        // ========= API URL =========
        URL url = new URL(
        "https://openrouter.ai/api/v1/chat/completions");

        HttpURLConnection conn =
        (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        conn.setRequestProperty(
        "Content-Type",
        "application/json");

        conn.setRequestProperty(
        "Authorization",
        "Bearer " + apiKey);

        conn.setRequestProperty(
        "HTTP-Referer",
        "https://employee-management.onrender.com");

        conn.setRequestProperty(
        "X-Title",
        "Employee Management System");

        // ========= JSON BODY =========
        JSONObject body =
        new JSONObject();

        body.put(
        "model",
        "openai/gpt-oss-120b");

        JSONArray messages =
        new JSONArray();

        // SYSTEM PROMPT
        JSONObject system =
        new JSONObject();

        system.put(
        "role",
        "system");

        system.put(
        "content",

        "You are an intelligent HR assistant for an Employee Management System. "
        +
        "Help with payroll, attendance, leave management, HR policy, employee performance, warning letters, reports, emails and professional communication. "
        +
        "Always answer professionally and clearly.");

        // USER QUESTION
        JSONObject user =
        new JSONObject();

        user.put(
        "role",
        "user");

        user.put(
        "content",
        question);

        messages.put(system);
        messages.put(user);

        body.put(
        "messages",
        messages);

        // ========= SEND REQUEST =========
        OutputStream os =
        conn.getOutputStream();

        os.write(
        body.toString()
        .getBytes("UTF-8"));

        os.flush();
        os.close();

        // ========= RESPONSE =========
        int responseCode =
        conn.getResponseCode();

        BufferedReader br;

        if(responseCode == 200){

            br =
            new BufferedReader(
            new InputStreamReader(
            conn.getInputStream(),
            "UTF-8"));

        } else {

            br =
            new BufferedReader(
            new InputStreamReader(
            conn.getErrorStream(),
            "UTF-8"));
        }

        String line;

        StringBuilder responseStr =
        new StringBuilder();

        while((line =
        br.readLine()) != null){

            responseStr.append(line);
        }

        br.close();

        JSONObject json =
        new JSONObject(
        responseStr.toString());

        if(json.has("choices")) {

            aiResponse =
            json.getJSONArray("choices")
            .getJSONObject(0)
            .getJSONObject("message")
            .getString("content");

        } else {

            errorMessage =
            responseStr.toString();
        }

    } catch(Exception e) {

        errorMessage =
        e.toString();
    }
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width,
initial-scale=1.0">

<title>AI HR Assistant</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{
background:#e7f5ee;
font-family:'Segoe UI';
padding:40px;
}

.chat-container{
max-width:900px;
margin:auto;
background:#fff;
border-radius:25px;
padding:35px;
box-shadow:
0 10px 35px rgba(0,0,0,0.08);
}

.heading{
font-size:35px;
font-weight:800;
color:#0a7a58;
margin-bottom:5px;
}

.sub-heading{
font-size:15px;
color:#666;
margin-bottom:25px;
}

textarea{
width:100%;
height:160px;
border-radius:15px;
padding:18px;
font-size:16px;
border:1px solid #ddd;
outline:none;
resize:none;
transition:0.3s;
}

textarea:focus{
border-color:#0a7a58;
box-shadow:
0 0 10px rgba(10,122,88,0.15);
}

.ask-btn{
background:#0a7a58;
color:#fff;
border:none;
padding:14px 30px;
font-size:17px;
font-weight:600;
border-radius:12px;
margin-top:18px;
transition:0.3s;
}

.ask-btn:hover{
background:#08684a;
}

.response-box{
margin-top:35px;
background:#f8f8f8;
padding:25px;
border-radius:18px;
border-left:6px solid #0a7a58;
}

.response-title{
font-size:22px;
font-weight:700;
color:#0a7a58;
margin-bottom:12px;
}

.error-box{
margin-top:25px;
background:#ffeaea;
padding:20px;
border-radius:12px;
color:#d10000;
border-left:5px solid red;
}

.examples{
margin-top:25px;
}

.example-chip{
display:inline-block;
background:#eaf6f1;
padding:8px 15px;
border-radius:25px;
margin:5px;
font-size:14px;
border:1px solid #cde7dc;
}

</style>

</head>

<body>

<div class="chat-container">

<div class="heading">
AI HR Assistant
</div>

<div class="sub-heading">
Ask anything about payroll, attendance,
leave management, warning letters,
emails, reports and employees.
</div>

<form method="post">

<textarea
name="question"
placeholder=
"Ask something...

Example:
Generate warning letter for low attendance

OR

Write professional HR email"
required><%= question != null ? question : "" %></textarea>

<br>

<button
type="submit"
class="ask-btn">

Ask AI
</button>

</form>

<div class="examples">

<div class="example-chip">
Generate salary slip
</div>

<div class="example-chip">
Write warning letter
</div>

<div class="example-chip">
Attendance report summary
</div>

<div class="example-chip">
Leave approval email
</div>

</div>

<%
if(!aiResponse.isEmpty()){
%>

<div class="response-box">

<div class="response-title">
AI Response
</div>

<div style="line-height:1.9;">
<%= aiResponse.replace("\n","<br>") %>
</div>

</div>

<%
}
%>

<%
if(!errorMessage.isEmpty()){
%>

<div class="error-box">

<b>Error:</b>

<br><br>

<%= errorMessage %>

</div>

<%
}
%>

</div>

</body>
</html>