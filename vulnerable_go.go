package main

import (
	"crypto/md5"
	"database/sql"
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"math/rand"
	"os"
	"os/exec"

	_ "github.com/lib/pq"
)

// Hard-coded credentials
const (
	PASSWORD     = "admin123"
	APIKEY       = "sk_live_abc123xyz789"
	DBCONNECTION = "postgres://user:password@localhost/dbname?sslmode=disable"
)

// SQL Injection
func getUser(username string) error {
	db, err := sql.Open("postgres", DBCONNECTION)
	if err != nil {
		return err
	}
	defer db.Close()

	// Vulnerable: String concatenation in SQL
	query := fmt.Sprintf("SELECT * FROM users WHERE username = '%s'", username)
	rows, err := db.Query(query)
	if err != nil {
		return err
	}
	defer rows.Close()

	return nil
}

// Command injection
func runCommand(userInput string) error {
	// Vulnerable: exec.Command with user input
	cmd := exec.Command("sh", "-c", fmt.Sprintf("ls -la %s", userInput))
	output, err := cmd.CombinedOutput()
	if err != nil {
		return err
	}
	fmt.Println(string(output))
	return nil
}

// Weak cryptography
func weakHash(password string) string {
	// Vulnerable: MD5 usage
	hasher := md5.New()
	hasher.Write([]byte(password))
	return hex.EncodeToString(hasher.Sum(nil))
}

// Path traversal
func readFile(filename string) (string, error) {
	// Vulnerable: No path validation
	data, err := ioutil.ReadFile(fmt.Sprintf("/var/data/%s", filename))
	if err != nil {
		return "", err
	}
	return string(data), nil
}

// Insecure random
func generateToken() string {
	// Vulnerable: math/rand for security
	return fmt.Sprintf("%d", rand.Int())
}

// Hardcoded secret in environment
func setEnv() {
	// Vulnerable: Hardcoded secret
	os.Setenv("SECRET_KEY", "my-secret-key-12345")
}

func main() {
	fmt.Println("Vulnerable Go application")
}
