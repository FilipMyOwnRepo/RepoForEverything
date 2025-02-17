from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import requests
import os

ALLOWLIST_FILE = 'allowlist.txt'
DENYLIST_FILE = 'denylist.txt'
# ----------------------------------------------
# Allow list
class Allowlist:
    # Inicialize the allowlist
    def __init__(self):
        self.allowlist = self.load_allowlist()

    def load_allowlist(self):
        if os.path.exists(ALLOWLIST_FILE):
            with open(ALLOWLIST_FILE, 'r') as f:
                print("Load allow list")
                return set(f.read().splitlines())
        return set()

    def save_allowlist(self):
        with open(ALLOWLIST_FILE, 'w') as f:
            f.write('\n'.join(self.allowlist))
            print("Save allow list")

    def add_urls(self, urls):
        self.allowlist.update(urls)
        self.save_allowlist()
        print("URLs added")

    def get_urls(self):
        return list(self.allowlist)
# ----------------------------------------------
# Deny list
class Denylist:
    # Inicialize the denylist
    def __init__(self, allowlist):
        self.allowlist = allowlist
        self.denylist = self.load_denylist()

    def load_denylist(self):
        if os.path.exists(DENYLIST_FILE):
            with open(DENYLIST_FILE, 'r') as f:
                print("Load deny list")
                return set(f.read().splitlines())
        return set()

    def save_denylist(self):
        with open(DENYLIST_FILE, 'w') as f:
            f.write('\n'.join(self.denylist))
            print("Save deny list")

    def update_denylist(self):
        response = requests.get('https://urlhaus.abuse.ch/downloads/text/')
        self.denylist = set(response.text.splitlines())
        self.denylist -= self.allowlist.get_urls()
        self.save_denylist()

    def get_urls(self):
        return list(self.denylist)
# ----------------------------------------------
class RequestHandler(BaseHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        self.allowlist = Allowlist()
        self.denylist = Denylist(self.allowlist)
        super().__init__(*args, **kwargs)

    def do_GET(self):
        if self.path == '/denylist':
            self.handle_get_denylist()
        elif self.path == '/allowlist':
            self.handle_get_allowlist()
        else:
            self.send_response(404)
            self.end_headers()

    def do_POST(self):
        if self.path == '/allowlist':
            self.handle_post_allowlist()
            print("POST deny list")
        else:
            self.send_response(404)
            self.end_headers()

    def handle_get_denylist(self):
        self.denylist.update_denylist()
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(self.denylist.get_urls()).encode())

    def handle_post_allowlist(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        data = json.loads(post_data)
        urls = data.get('urls', [])
        self.allowlist.add_urls(urls)
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps({"urls_added": urls}).encode())

    def handle_get_allowlist(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(self.allowlist.get_urls()).encode())

def run(server_class=HTTPServer, handler_class=RequestHandler, port=80):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting httpd server on port {port}')
    httpd.serve_forever()

if __name__ == '__main__':
    run()