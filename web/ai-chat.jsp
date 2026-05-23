<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI Chat</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:Segoe UI,sans-serif;
    background:#f5f5f5;
}

.chat-container{
    height:100vh;
    display:flex;
    flex-direction:column;
}

.header{
    background:linear-gradient(135deg,#0a7a58,#2a64e6);
    color:white;
    padding:15px 20px;
    display:flex;
    align-items:center;
    gap:10px;
}

.header i{
    font-size:28px;
}

.chat-box{
    flex:1;
    overflow-y:auto;
    padding:20px;
    background:#eef7f4;
}

.msg{
    max-width:75%;
    padding:12px 16px;
    margin:10px 0;
    border-radius:15px;
    font-size:15px;
}

.user{
    background:#0a7a58;
    color:white;
    margin-left:auto;
    border-bottom-right-radius:5px;
}

.bot{
    background:white;
    border:1px solid #ddd;
    border-bottom-left-radius:5px;
}

.input-area{
    padding:15px;
    background:white;
    border-top:1px solid #ddd;
}

.input-group{
    border-radius:50px;
    overflow:hidden;
}

.form-control{
    border:none;
    background:#f1f3f5;
}

.form-control:focus{
    box-shadow:none;
}

.send-btn{
    background:#0a7a58;
    color:white;
    border:none;
    width:60px;
}
</style>
</head>
<body>

<div class="chat-container">

    <div class="header">
        <i class="bi bi-robot"></i>
        <div>
            <h5 class="mb-0">EMS AI Assistant</h5>
            <small>Online</small>
        </div>
    </div>

    <div class="chat-box" id="chatBox">
        <div class="msg bot">
            👋 Hello! I am EMS AI Assistant. Ask me anything.
        </div>
    </div>

    <div class="input-area">
        <div class="input-group">
            <input type="text"
                   id="message"
                   class="form-control"
                   placeholder="Type message..."
                   onkeypress="if(event.key==='Enter') sendMessage()">

            <button class="send-btn" onclick="sendMessage()">
                <i class="bi bi-send-fill"></i>
            </button>
        </div>
    </div>

</div>

<script>
function sendMessage(){

    const input = document.getElementById("message");
    const text = input.value.trim();

    if(text === "") return;

    const chatBox = document.getElementById("chatBox");

    // user message
    chatBox.innerHTML += `
        <div class="msg user">${text}</div>
    `;

    input.value = "";

    // fake AI typing
    setTimeout(()=>{

        let reply = "";

        const msg = text.toLowerCase();

        if(msg.includes("hello") || msg.includes("hi")){
            reply = "Hello 👋 How can I help you?";
        }
        else if(msg.includes("leave")){
            reply = "You can apply leave from HR panel.";
        }
        else if(msg.includes("salary")){
            reply = "Salary details are available in payroll section.";
        }
        else if(msg.includes("attendance")){
            reply = "Attendance reports are available in dashboard.";
        }
        else{
            reply = "Sorry, I don't understand that yet 🤖";
        }

        chatBox.innerHTML += `
            <div class="msg bot">${reply}</div>
        `;

        chatBox.scrollTop = chatBox.scrollHeight;

    },800);

    chatBox.scrollTop = chatBox.scrollHeight;
}
</script>

</body>
</html>