// SQL Injection vulnerabilities
const sqlite3 = require('sqlite3');

function getUserByName(username) {
    const db = new sqlite3.Database('users.db');
    // Vulnerable: String concatenation in SQL
    const query = `SELECT * FROM users WHERE username = '${username}'`;
    db.all(query, (err, rows) => {
        console.log(rows);
    });
}

// Hard-coded credentials
const API_KEY = "sk_live_abc123xyz789";
const PASSWORD = "admin123";
const SECRET_TOKEN = "ghp_abc123xyz789";

// Command injection
const { exec } = require('child_process');

function runCommand(userInput) {
    // Vulnerable: Executing shell command with user input
    exec(`ls -la ${userInput}`, (error, stdout, stderr) => {
        console.log(stdout);
    });
}

// eval() usage
function calculate(expression) {
    // Vulnerable: eval with user input
    return eval(expression);
}

// XSS vulnerability
function renderUserInput(input) {
    // Vulnerable: innerHTML with unsanitized input
    document.getElementById('output').innerHTML = input;
}

// Weak cryptography
const crypto = require('crypto');

function weakHash(password) {
    // Vulnerable: MD5 usage
    return crypto.createHash('md5').update(password).digest('hex');
}

// Path traversal
const fs = require('fs');

function readFile(filename) {
    // Vulnerable: No path validation
    return fs.readFileSync(`/var/data/${filename}`, 'utf8');
}

// Insecure random
function generateToken() {
    // Vulnerable: Math.random() for security
    return Math.random().toString(36).substring(7);
}
