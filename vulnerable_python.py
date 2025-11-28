import os
import pickle
import subprocess
import hashlib

 
def search_user(username):
    import sqlite3
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    # Vulnerable: String formatting in SQL
    query = f"SELECT * FROM users WHERE username = '{username}'"
    cursor.execute(query)
    return cursor.fetchall()

 
API_KEY = "sk_live_abc123xyz789"
PASSWORD = "admin123"
SECRET_TOKEN = "ghp_abc123xyz789"

 
def run_command(user_input):
    # Vulnerable: Shell=True with user input
    os.system(f"ls -la {user_input}")
    subprocess.call(f"ping -c 1 {user_input}", shell=True)

# Insecure deserialization
def load_data(data):
    # Vulnerable: Pickle with untrusted data
    return pickle.loads(data)

# Weak cryptography
def weak_hash(password):
    # Vulnerable: Using MD5
    return hashlib.md5(password.encode()).hexdigest()

# Path traversal
def read_file(filename):
    # Vulnerable: No path validation
    with open(f"/var/data/{filename}", 'r') as f:
        return f.read()

# eval() usage
def calculate(expression):
    # Vulnerable: eval with user input
    return eval(expression)
