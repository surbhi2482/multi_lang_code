using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace VulnerableApp
{
    public class VulnerableCode
    {
        // Hard-coded credentials
        private const string PASSWORD = "admin123";
        private const string API_KEY = "sk_live_abc123xyz789";
        private const string CONNECTION_STRING = "Server=myServer;Database=myDB;User Id=sa;Password=admin123;";

        
        public void GetUser(string username)
        {
            using (SqlConnection conn = new SqlConnection(CONNECTION_STRING))
            {
                // Vulnerable: String concatenation in SQL
                string query = $"SELECT * FROM Users WHERE Username = '{username}'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
            }
        }

      
        public void ExecuteCommand(string userInput)
        {
            // Vulnerable: ProcessStartInfo with user input
            Process.Start("cmd.exe", $"/c ping {userInput}");
        }

        // Weak cryptography
        public string WeakHash(string password)
        {
            // Vulnerable: MD5 usage
            using (MD5 md5 = MD5.Create())
            {
                byte[] inputBytes = Encoding.ASCII.GetBytes(password);
                byte[] hashBytes = md5.ComputeHash(inputBytes);
                return Convert.ToHexString(hashBytes);
            }
        }

        // Path traversal
        public string ReadFile(string filename)
        {
            // Vulnerable: No path validation
            return File.ReadAllText($"C:\\data\\{filename}");
        }

        // Insecure deserialization
        public object DeserializeData(byte[] data)
        {
            // Vulnerable: BinaryFormatter
            var formatter = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
            using (var stream = new MemoryStream(data))
            {
                return formatter.Deserialize(stream);
            }
        }

        // Weak random
        public string GenerateToken()
        {
            // Vulnerable: Random for security
            Random rand = new Random();
            return rand.Next().ToString();
        }
    }
}
