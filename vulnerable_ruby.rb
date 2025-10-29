require 'digest'
require 'yaml'

# Hard-coded credentials
API_KEY = "sk_live_abc123xyz789"
PASSWORD = "admin123"
SECRET_TOKEN = "ghp_abc123xyz789"

# SQL Injection
def get_user_by_name(username)
  require 'sqlite3'
  db = SQLite3::Database.new 'users.db'
  
  # Vulnerable: String interpolation in SQL
  query = "SELECT * FROM users WHERE username = '#{username}'"
  db.execute(query)
end

# Command injection
def run_command(user_input)
  # Vulnerable: system with user input
  system("ls -la #{user_input}")
  
  # Vulnerable: backticks with user input
  `ping -c 1 #{user_input}`
end

# eval() usage
def calculate(expression)
  # Vulnerable: eval with user input
  eval(expression)
end

# Insecure deserialization
def load_yaml_data(data)
  # Vulnerable: YAML.load with untrusted data
  YAML.load(data)
end

# Weak cryptography
def weak_hash(password)
  # Vulnerable: MD5 usage
  Digest::MD5.hexdigest(password)
end

# Path traversal
def read_file(filename)
  # Vulnerable: No path validation
  File.read("/var/data/#{filename}")
end

# Open redirect
def redirect_to_url(url)
  # Vulnerable: redirect without validation
  redirect_to url
end

# Mass assignment
def update_user(params)
  # Vulnerable: Mass assignment
  user = User.find(params[:id])
  user.update_attributes(params[:user])
end
