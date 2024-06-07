from app import app   # first app is file name app.py second is variable app in that file
@app.route("/pcat/addnew") # to handle req at endpoint
def pcat_addnew():
    return "This is product category addnew operation"