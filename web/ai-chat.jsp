<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AI Chat</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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

    <div class="chat-box" id="chatBox" role="log" aria-live="polite">
        <div class="msg bot">👋 Hello! I am EMS AI Assistant. Ask me anything.</div>
    </div>

    <div class="input-area">
        <div class="input-group">
            <input type="text"
                   id="message"
                   class="form-control"
                   placeholder="Type message..."
                   onkeypress="if(event.key==='Enter') sendMessage()"
                   aria-label="Message input"
                   autofocus>

            <button type="button" class="send-btn" onclick="sendMessage()" aria-label="Send message">
                <i class="bi bi-send-fill"></i>
            </button>
        </div>
    </div>

</div>

<script>
function sendMessage(){
    const input = document.getElementById("message");
    const text = input.value.trim();
    if(!text) return;

    const chatBox = document.getElementById("chatBox");

    // create user message element (use textContent to avoid HTML injection)
    const userMsg = document.createElement('div');
    userMsg.className = 'msg user';
    userMsg.textContent = text;
    chatBox.appendChild(userMsg);

    // clear and focus
    input.value = '';
    input.focus();

    // scroll to bottom for user's message
    chatBox.scrollTop = chatBox.scrollHeight;

    // simulate AI typing and generate a reply
    setTimeout(()=>{
        const reply = generateReply(text);

        const botMsg = document.createElement('div');
        botMsg.className = 'msg bot';
        botMsg.textContent = reply;
        chatBox.appendChild(botMsg);

        // scroll after bot reply
        chatBox.scrollTop = chatBox.scrollHeight;
    }, 700);
}

// Simple reply generator - keep logic in one place
function generateReply(text){
    const msg = text.toLowerCase();
    if(msg.includes('hello') || msg.includes('hi')){
        return 'Hello 👋 How can I help you?';
    }
    if(msg.includes('leave')){
        return 'You can apply leave from the HR panel (HR -> Leave Management).';
    }
    if(msg.includes('salary') || msg.includes('pay')){
        return 'Salary details are available in the Payroll section.';
    }
    if(msg.includes('attendance') || msg.includes('present')){
        return 'Attendance reports are available on your dashboard.';
    }
    return "Sorry, I don't understand that yet 🤖";
}

// keep chat scrolled to bottom on initial load
document.addEventListener('DOMContentLoaded', function(){
    const cb = document.getElementById('chatBox');
    if(cb) cb.scrollTop = cb.scrollHeight;
});
</script>

</body>
</html>