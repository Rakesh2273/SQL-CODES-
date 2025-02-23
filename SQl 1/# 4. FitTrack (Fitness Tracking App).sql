## main.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Exercise(BaseModel):
    name: str
    duration: int

exercises = []

@app.post('/log-exercise')
def log_exercise(exercise: Exercise):
    exercises.append(exercise)
    return {"message": "Exercise logged successfully!"}

@app.get('/exercises')
def get_exercises():
    return exercises
