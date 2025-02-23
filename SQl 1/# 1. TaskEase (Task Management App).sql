from flask import Flask, request, jsonify, render_template
from datetime import datetime
import sqlite3

app = Flask(__name__)

# Database setup
def init_db():
    conn = sqlite3.connect('task_manager.db')
    cursor = conn.cursor()
    cursor.execute('''CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        due_date TEXT,
        status TEXT
    )''')
    conn.commit()
    conn.close()

init_db()

# Route to display all tasks
@app.route('/')
def index():
    conn = sqlite3.connect('task_manager.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM tasks')
    tasks = cursor.fetchall()
    conn.close()
    return render_template('index.html', tasks=tasks)

# Route to add a task
@app.route('/add_task', methods=['POST'])
def add_task():
    title = request.form['title']
    description = request.form['description']
    due_date = request.form['due_date']
    status = 'Pending'

    conn = sqlite3.connect('task_manager.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO tasks (title, description, due_date, status) VALUES (?, ?, ?, ?)',
                   (title, description, due_date, status))
    conn.commit()
    conn.close()
    return 'Task added successfully!'

# Route to update task status
@app.route('/update_status/<int:task_id>', methods=['POST'])
def update_status(task_id):
    new_status = request.form['status']

    conn = sqlite3.connect('task_manager.db')
    cursor = conn.cursor()
    cursor.execute('UPDATE tasks SET status = ? WHERE id = ?', (new_status, task_id))
    conn.commit()
    conn.close()
    return 'Task status updated successfully!'

if __name__ == '__main__':
    app.run(debug=True)
