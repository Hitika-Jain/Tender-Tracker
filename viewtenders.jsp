<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Tenders</title>
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
	<h1 >Active Tenders</h1>
    <table>
        <thead>
            <tr>
                <th>Tender ID</th>
                <th>Tender Name</th>
                <th>Tender Type</th>
                <th>Location</th>
                <th>Deadline</th>
                <th>Price</th>
                <th>Description</th>
                
            </tr>
        </thead>
        <tbody>
        <% 
	try{
		String url = "jdbc:mysql://localhost:3306/tender_tracker";
        String dbUsername = "root";
        String dbPassword = "Hit@22062004";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		Statement st=con.createStatement();
            // Query to fetch active tenders
            String query = "SELECT tender_id, tender_name, tender_type, tender_price, tender_description, tender_deadline, tender_location FROM TENDERS WHERE tender_status = 'Active'";
            // ps = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
            	%>
            	<tr>
                <td><%= rs.getString("tender_id") %></td>
                <td><%= rs.getString("tender_name") %></td>
                <td><%= rs.getString("tender_type") %></td>
                <td><%= rs.getString("tender_location") %></td>
                <td><%= rs.getString("tender_deadline") %></td>
                <td><%= rs.getString("tender_price") %></td>
                <td><%= rs.getString("tender_description") %></td>
            </tr>
            <%
            }
	}
	catch (Exception e){
	
	}
        %>
        </tbody>
    </table>
    <div class="profile-footer">
        <button onclick="window.location.href='vendorHome.jsp';">Close</button>
    </div>
</body>
</html>