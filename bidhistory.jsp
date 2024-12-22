<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %> 
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bid History</title>
    <style>
        h1 {color: #007bff; text-align: center;}
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; text-align: left; border: 1px solid #ddd; }
        th { background-color: #007bff; }
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
            background-color: #007bff;
        }
    </style>
</head>
<body>
    <h1>Bid History</h1>
    <table>
        <thead>
            <tr>
                <th>Bid ID</th>
                <th>Tender Name</th>
                <th>Tender Type</th>
                <th>Location</th>
                <th>Deadline</th>
                <th>Price</th>
                <th>Description</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <% 
        // Use the session to get vendorId
        //HttpSession session = request.getSession(false); // Get session without creating a new one if it doesn't exist
        Integer vendorId = (Integer)request.getSession().getAttribute("vendorId"); // Retrieve vendorId from session

        if (vendorId != null) {
            try {
                // Database connection
                String url = "jdbc:mysql://localhost:3306/tender_tracker";
                String dbUsername = "root";
                String dbPassword = "Hit@22062004";
                Class.forName("com.mysql.cj.jdbc.Driver"); // Updated driver for MySQL 8+
                Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
                Statement st = con.createStatement();

                // Query to fetch bids placed by the vendor (use the vendorId retrieved from session)
                String query = "SELECT b.bid_id, t.tender_name, t.tender_type, t.tender_location, t.tender_deadline, " +
                               "t.tender_price, t.tender_description, b.bid_status " +
                               "FROM BIDS b " +
                               "JOIN TENDERS t ON b.tender_id = t.tender_id " +
                               "WHERE b.vendor_id = ?";
                               
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setInt(1, vendorId); // Set the vendorId to the query
                
                ResultSet rs = stmt.executeQuery();
                
                while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("bid_id") %></td>
                        <td><%= rs.getString("tender_name") %></td>
                        <td><%= rs.getString("tender_type") %></td>
                        <td><%= rs.getString("tender_location") %></td>
                        <td><%= rs.getString("tender_deadline") %></td>
                        <td><%= rs.getBigDecimal("tender_price") %></td>
                        <td><%= rs.getString("tender_description") %></td>
                        <td><%= rs.getString("bid_status") %></td>
                    </tr>
                    <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            }
        } else {
            out.println("You are not logged in. Please log in first.");
        }
        %>
        </tbody>
    </table>
    <div class="profile-footer">
        <button onclick="window.location.href='vendorHome.jsp';">Close</button>
    </div>
</body>
</html>



