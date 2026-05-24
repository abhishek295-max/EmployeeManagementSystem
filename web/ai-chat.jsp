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
    font-family:"Segoe UI",Tahoma,Geneva,Verdana,sans-serif;
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
    word-wrap:break-word;
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

.send-btn:hover{
    background:#086648;
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
                   onkeypress="if(event.key==='Enter') sendMessage()"
                   autofocus>

            <button type="button"
                    class="send-btn"
                    onclick="sendMessage()">
                <i class="bi bi-send-fill"></i>
            </button>

        </div>
    </div>

</div>

<script>

const API_KEY = "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";

async function sendMessage(){

    const input =
    document.getElementById("message");

    const text =
    input.value.trim();

    if(!text) return;

    const chatBox =
    document.getElementById("chatBox");

    // User Message
    const userMsg =
    document.createElement("div");

    userMsg.className = "msg user";
    userMsg.textContent = text;

    chatBox.appendChild(userMsg);

    input.value = "";

    chatBox.scrollTop =
    chatBox.scrollHeight;

    // Typing Message
    const loadingMsg =
    document.createElement("div");

    loadingMsg.className = "msg bot";
    loadingMsg.textContent =
    "Typing...";

    chatBox.appendChild(loadingMsg);

    try {

        const response =
        await fetch(
        "https://openrouter.ai/api/v1/chat/completions",
        {
            method:"POST",

            headers:{
                "Authorization":
                `Bearer ${API_KEY}`,

                "Content-Type":
                "application/json"
            },

            body:JSON.stringify({

                model:
                "openai/gpt-3.5-turbo",

                messages:[
                    {
                        role:"system",
                        content:
                        "You are EMS AI Assistant for Employee Management System."
                    },
                    {
                        role:"user",
                        content:text
                    }
                ]
            })
        });

        const data =
        await response.json();

        loadingMsg.remove();

        const reply =
        data.choices?.[0]
        ?.message?.content
        || "No response";

        const botMsg =
        document.createElement("div");

        botMsg.className =
        "msg bot";

        botMsg.textContent =
        reply;

        chatBox.appendChild(botMsg);

        chatBox.scrollTop =
        chatBox.scrollHeight;

    } catch(error){

        loadingMsg.remove();

        const botMsg =
        document.createElement("div");

        botMsg.className =
        "msg bot";

        botMsg.textContent =
        "❌ Error connecting to OpenRouter API";

        chatBox.appendChild(botMsg);
    }
}

document.addEventListener(
"DOMContentLoaded",
function(){

    const chatBox =
    document.getElementById(
    "chatBox");

    chatBox.scrollTop =
    chatBox.scrollHeight;
});

</script>

</body>
</html>