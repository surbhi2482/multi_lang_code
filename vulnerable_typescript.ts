import * as crypto from 'crypto';
import * as fs from 'fs';
import { exec } from 'child_process';
import * as sqlite3 from 'sqlite3';

// SQL Injection vulnerability
function getUserByName(username: string): void {
    const db = new sqlite3.Database('users.db');
    // Vulnerable: String concatenation in SQL
    const query: string = `SELECT * FROM users WHERE username = '${username}'`;
    db.all(query, (err, rows) => {
        console.log(rows);
    });
}

// Hard-coded credentials
const API_KEY: string = "sk_live_abc123xyz789";
const PASSWORD: string = "admin123";
const SECRET_TOKEN: string = "ghp_abc123xyz789";

// Command injection
function runCommand(userInput: string): void {
    // Vulnerable: Executing shell command with user input
    exec(`ls -la ${userInput}`, (error, stdout, stderr) => {
        console.log(stdout);
    });
}

// eval() usage
function calculate(expression: string): any {
    // Vulnerable: eval with user input
    return eval(expression);
}

// XSS vulnerability
function renderUserInput(input: string): void {
    // Vulnerable: innerHTML with unsanitized input
    const element = document.getElementById('output');
    if (element) {
        element.innerHTML = input;
    }
}

// Weak cryptography
function weakHash(password: string): string {
    // Vulnerable: MD5 usage
    return crypto.createHash('md5').update(password).digest('hex');
}

// Path traversal
function readFile(filename: string): string {
    // Vulnerable: No path validation
    return fs.readFileSync(`/var/data/${filename}`, 'utf8');
}

// Insecure random
function generateToken(): string {
    // Vulnerable: Math.random() for security
    return Math.random().toString(36).substring(7);
}
