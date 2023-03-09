from flask import Flask
app = Flask(__name__)

@app.route('/')
def base_function():
    flask_web_site = 'https://a2c.bitbucket.io/flask/'
    return f'This is the base route to start flask, pal! See {flask_web_site}'

# other apis
