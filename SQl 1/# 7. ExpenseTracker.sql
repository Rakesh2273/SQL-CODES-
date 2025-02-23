## main.py
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///expenses.db'
db = SQLAlchemy(app)

class Expense(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    item = db.Column(db.String(100))
    amount = db.Column(db.Float)

@app.route('/')
def index():
    expenses = Expense.query.all()
    total_expenses = sum(exp.amount for exp in expenses)
    return render_template('index.html', expenses=expenses, total_expenses=total_expenses)

@app.route('/add', methods=['POST'])
def add_expense():
    item = request.form['item']
    amount = float(request.form['amount'])
    new_expense = Expense(item=item, amount=amount)
    db.session.add(new_expense)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)

## templates/index.html
<!DOCTYPE html>
<html>
<head>
    <title>ExpenseTracker</title>
</head>
<body>
    <h1>Expense Tracker</h1>
    <form method="post" action="/add">
        <label for="item">Item:</label>
        <input type="text" name="item" id="item" required><br>

        <label for="amount">Amount:</label>
        <input type="number" step="0.01" name="amount" id="amount" required><br>

        <button type="submit">Add Expense</button>
    </form>

    <h2>Total Expenses: {{ total_expenses }}</h2>
    <ul>
        {% for expense in expenses %}
            <li>{{ expense.item }} - ${{ expense.amount }}</li>
        {% endfor %}
    </ul>
</body>
</html>
