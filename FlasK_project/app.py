from flask import Flask
 #Flask is class, flask is package
app=Flask(__name__)
@app.route("/") # to handle req at endpoint
def welcome():
    return "Hello world!"

@app.route("/home") # to handle req at endpoint
def home():
    return "This is home"

from controller import *