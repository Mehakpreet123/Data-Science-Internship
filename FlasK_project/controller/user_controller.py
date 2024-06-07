from app import app 
 # first app is file name app.py second is variable app in that file
from model.user_model import user_model
obj=user_model()
@app.route("/user/getall") # to handle req at endpoint

def user_getall_controller():
    return obj.user_getall_model()