from bottle import route, run, template

@route('/hello/<name>')
def index(name):
    bottle_web_site = 'https://bottlepy.org/docs/dev/'
    return template('<b>Hello {{name}}</b>! <p>See {{web}}</p>', name=name, web=bottle_web_site)

run(host='0.0.0.0', port=8080)
