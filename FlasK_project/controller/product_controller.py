from app import app   # first app is file name app.py second is variable app in that file
@app.route("/product/add") # to handle req at endpoint
def p_add():
    return "This is product add operation"