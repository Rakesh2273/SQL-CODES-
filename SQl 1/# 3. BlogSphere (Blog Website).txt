## app.py
from flask import Flask, render_template, request

app = Flask(__name__)

posts = [
    {"title": "First Post", "content": "This is the first post."},
    {"title": "Second Post", "content": "This is the second post."}
]

@app.route('/')
def home():
    return render_template('index.html', posts=posts)

if __name__ == '__main__':
    app.run(debug=True)

# Frontend
## templates/index.html
<!DOCTYPE html>
<html>
<head>
    <title>BlogSphere</title>
</head>
<body>
    <h1>Welcome to BlogSphere</h1>
    {% for post in posts %}
        <h2>{{ post.title }}</h2>
        <p>{{ post.content }}</p>
    {% endfor %}
</body>
</html>
