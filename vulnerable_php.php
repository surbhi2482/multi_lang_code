<?php

// Hard-coded credentials
define('DB_PASSWORD', 'admin123');
define('API_KEY', 'sk_live_abc123xyz789');
define('SECRET_TOKEN', 'ghp_abc123xyz789');

// SQL Injection
function getUserByName($username) {
    $conn = new mysqli("localhost", "root", DB_PASSWORD, "testdb");
    
    // Vulnerable: String concatenation in SQL
    $query = "SELECT * FROM users WHERE username = '$username'";
    $result = $conn->query($query);
    
    return $result->fetch_all(MYSQLI_ASSOC);
}

// Command injection
function executeCommand($userInput) {
    // Vulnerable: shell_exec with user input
    $output = shell_exec("ls -la " . $userInput);
    echo $output;
}

// eval() usage
function calculate($expression) {
    // Vulnerable: eval with user input
    return eval("return " . $expression . ";");
}

// XSS vulnerability
function renderUserInput($input) {
    // Vulnerable: echo without sanitization
    echo "<div>" . $input . "</div>";
}

// Weak cryptography
function weakHash($password) {
    // Vulnerable: MD5 usage
    return md5($password);
}

// Path traversal
function readFile($filename) {
    // Vulnerable: No path validation
    return file_get_contents("/var/data/" . $filename);
}

// File inclusion
function loadTemplate($template) {
    // Vulnerable: include with user input
    include("/templates/" . $template . ".php");
}

// Insecure deserialization
function loadData($data) {
    // Vulnerable: unserialize with untrusted data
    return unserialize($data);
}

// Weak random
function generateToken() {
    // Vulnerable: rand() for security
    return md5(rand());
}

?>
