#!/bin/bash

# Hard-coded credentials
PASSWORD="admin123"
API_KEY="sk_live_abc123xyz789"
SECRET_TOKEN="ghp_abc123xyz789"

# Command injection
run_command() {
    USER_INPUT=$1
    # Vulnerable: eval with user input
    eval "ls -la $USER_INPUT"
}

# Another command injection
process_file() {
    FILENAME=$1
    # Vulnerable: No input validation
    cat /var/data/$FILENAME
}

# Weak permissions
create_file() {
    # Vulnerable: World-writable file
    touch /tmp/sensitive_data.txt
    chmod 777 /tmp/sensitive_data.txt
}

# SQL injection in shell
query_database() {
    USERNAME=$1
    # Vulnerable: String concatenation in SQL
    mysql -u root -p$PASSWORD -e "SELECT * FROM users WHERE username='$USERNAME'"
}

# Curl without SSL verification
fetch_data() {
    URL=$1
    # Vulnerable: --insecure flag
    curl --insecure $URL
}

# Weak random
generate_token() {
    # Vulnerable: RANDOM for security
    echo $RANDOM
}

# Hardcoded path
BACKUP_DIR="/backup"
LOG_FILE="/var/log/app.log"

# Main execution
if [ $# -eq 0 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

# Vulnerable: eval on user input
eval "$@"
