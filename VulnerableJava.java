import java.sql.*;
import java.util.Scanner;

public class VulnerableJava {
    // SQL Injection vulnerability
    public void searchUser(String username) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db", "user", "pass");
            Statement stmt = conn.createStatement();
            // Vulnerable: Direct string concatenation in SQL query
            String query = "SELECT * FROM users WHERE username = '" + username + "'";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                System.out.println(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Hard-coded credentials
    private static final String PASSWORD = "admin123";
    private static final String API_KEY = "sk_live_abc123xyz789";
    
    // Weak cryptography
    public String weakHash(String input) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(input.getBytes());
            return new String(hash);
        } catch (Exception e) {
            return null;
        }
    }
    
    // Command injection
    public void executeCommand(String userInput) {
        try {
            Runtime.getRuntime().exec("ls -la " + userInput);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
