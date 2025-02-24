from flask import Flask, request, jsonify, render_template_string

app = Flask(__name__)

@app.route('/links')
def links():
    with open('list.txt', 'r') as file:
        links = file.readlines()
    return render_template_string('''
        <!doctype html>
        <html lang="en">
          <head>
            <meta charset="utf-8">
            <title>Links</title>
          </head>
          <body>
            <h1>Links</h1>
            <ul>
              {% for link in links %}
                <li><a href="{{ link.strip() }}">{{ link.strip() }}</a></li>
              {% endfor %}
            </ul>
          </body>
        </html>
    ''', links=links)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)