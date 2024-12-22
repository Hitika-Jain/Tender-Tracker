<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="tender.AESdecryption"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Vendors</title>
    <style>
        h1 {text-align: center;}
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; text-align: left; border: 1px solid #ddd; }
        th { background-color: #007bff; color: #fff; }
        .profile-footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f8f8;
        }
        .profile-footer button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .profile-footer button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Registered Vendors</h1>
    <table>
        <thead>
            <tr>
                <th>Vendor ID</th>
                <th>Name</th>
                <th>Company</th>
                <th>Contact No.</th>
                <th>Email</th>
                <th>State</th>
                <th>Address</th>
            </tr>
        </thead>
        <tbody>
        <%
        try {
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/tender_tracker";
            String dbUsername = "root";
            String dbPassword = "Hit@22062004";

            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
            Statement st = con.createStatement();

            // Query to fetch vendor details
            String query = "SELECT vendor_id, vendor_name, vendor_company, vendor_contact_details, vendor_email, vendor_state, vendor_company_address FROM VENDORS";
            ResultSet rs = st.executeQuery(query);

            // Secret key for decryption
            String secretKey = "SecretAESKey1234"; // 16-byte key
            
            // Loop through the result set
            while (rs.next()) {
                String encryptedContact = rs.getString("vendor_contact_details");
                String decryptedContact = "Decryption Error"; // Default value
                
                // Decrypt contact number
                try {
                    decryptedContact = AESdecryption.decryptAES(encryptedContact, secretKey);
                } catch (Exception e) {
                    e.printStackTrace();
                }
        %>
            <tr>
                <td><%= rs.getString("vendor_id") %></td>
                <td><%= rs.getString("vendor_name") %></td>
                <td><%= rs.getString("vendor_company") %></td>
                <td><%= decryptedContact %></td>
                <td><%= rs.getString("vendor_email") %></td>
                <td><%= rs.getString("vendor_state") %></td>
                <td><%= rs.getString("vendor_company_address") %></td>
            </tr>
        <%
            }
            // Close resources
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='7' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
            e.printStackTrace();
        }
        %>
        </tbody>
    </table>
    <div class="profile-footer">
        <button onclick="window.location.href='adminhome.jsp';">Close</button>
    </div>
</body>
</html>


