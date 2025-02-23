## app.py
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///recipes.db'
db = SQLAlchemy(app)

class Recipe(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(300))
    ingredients = db.Column(db.Text)

@app.route('/')
def index():
    recipes = Recipe.query.all()
    return render_template('index.html', recipes=recipes)

@app.route('/add', methods=['GET', 'POST'])
def add_recipe():
    if request.method == 'POST':
        new_recipe = Recipe(
            title=request.form['title'],
            description=request.form['description'],
            ingredients=request.form['ingredients']
        )
        db.session.add(new_recipe)
        db.session.commit()
        return redirect(url_for('index'))
    return render_template('add_recipe.html')

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)

## templates/index.html
<!DOCTYPE html>
<html>
<head>
    <title>RecipeBook</title>
</head>
<body>
    <h1>RecipeBook</h1>
    <a href="/add">Add New Recipe</a>
    <ul>
        {% for recipe in recipes %}
            <li>{{ recipe.title }} - {{ recipe.description }}</li>
        {% endfor %}
    </ul>
</body>
</html>

## templates/add_recipe.html
<!DOCTYPE html>
<html>
<head>
    <title>Add Recipe</title>
</head>
<body>
    <h1>Add a New Recipe</h1>
    <form method="post">
        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required><br>

        <label for="description">Description:</label>
        <input type="text" name="description" id="description"><br>

        <label for="ingredients">Ingredients:</label>
        <textarea name="ingredients" id="ingredients"></textarea><br>

        <button type="submit">Add Recipe</button>
    </form>
</body>
</html>
