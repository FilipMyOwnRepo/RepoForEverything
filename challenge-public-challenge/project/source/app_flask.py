from flask import Flask, request, jsonify
import requests
import os

# flask framework for creating web apps
# initialize flask app
app = Flask(__name__)

ALLOWLIST_FILE = 'allowlist.txt'
DENYLIST_FILE = 'denylist.txt'

# Allow list
def load_allowlist():
    if os.path.exists(ALLOWLIST_FILE):
        with open(ALLOWLIST_FILE, 'r') as f:
            print("Load allow list")
            return set(f.read().splitlines())
    return set()

def save_allowlist(allowlist):
    with open(ALLOWLIST_FILE, 'w') as f:
        f.write('\n'.join(allowlist))
        print("Save allow list")
#----------------------------------------------
# Deny list
def load_denylist():
    if os.path.exists(DENYLIST_FILE):
        with open(DENYLIST_FILE, 'r') as f:
            return set(f.read().splitlines())
    return set()

def save_denylist(denylist):
    with open(DENYLIST_FILE, 'w') as f:
        f.write('\n'.join(denylist))
        print("Save deny list")
#----------------------------------------------

allowlist = load_allowlist()
denylist = load_denylist()

#1 Get DenyList
@app.route('/denylist', methods=['GET'])
def get_denylist():
    response = requests.get('https://urlhaus.abuse.ch/downloads/text/')
    denylist = set(response.text.splitlines())
    denylist -= allowlist # filters out
    save_denylist(denylist)
    return jsonify(list(denylist)) # json response
    print("#1 Get DenyList finished")

#2 Post AllowList
@app.route('/allowlist', methods=['POST'])
def post_allowlist():
    urls = request.json.get('urls', [])
    allowlist.update(urls) # URL in allow list
    save_allowlist(allowlist)
    return jsonify({"urls_added": urls})
    print("Post AllowList finished")

#3 Get AllowList
@app.route('/allowlist', methods=['GET'])
def get_allowlist():
    return jsonify(list(allowlist)) # all in the allow list in json
    print("Get AllowList finished")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)