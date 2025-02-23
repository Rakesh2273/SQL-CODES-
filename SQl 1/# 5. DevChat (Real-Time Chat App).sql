# Backend (Django)
## views.py
from django.shortcuts import render

def chat_room(request):
    return render(request, 'chat_room.html')

# Frontend
## templates/chat_room.html
<!DOCTYPE html>
<html>
<head>
    <title>DevChat</title>
</head>
<body>
    <h1>Welcome to DevChat</h1>
    <div id="chat-box"></div>
    <input type="text" placeholder="Type your message here">
    <button>Send</button>
</body>
</html>
