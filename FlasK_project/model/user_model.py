import mysql.connector
class user_model:
    def __init__(self):
        try:
            #connection establish
            con= mysql.connector.connect(host="localhost",user="root",password="1234Ab@cd",database="flask_db")
            print("Connection successful")
        except:
            print("some eror")
    def user_getall_model(self):
        #business logic
        return "This is user_getall_model"