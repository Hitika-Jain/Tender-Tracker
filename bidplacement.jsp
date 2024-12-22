<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Active Tenders</title>
    <style>
    	h1{color: #007bff; text-align: center;}
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

        /* Modal Popup */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal input, .modal textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <h1 >Place a bid</h1>
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
                <th>Action</th> <!-- New column for Place Bid -->
            </tr>
        </thead>
        <tbody>
        <% 
            try {
                String url = "jdbc:mysql://localhost:3306/tender_tracker";
                String dbUsername = "root";
                String dbPassword = "Hit@22062004";
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
                Statement st = con.createStatement();
                // Query to fetch active tenders
                String query = "SELECT tender_id, tender_name, tender_type, tender_price, tender_description, tender_deadline, tender_location FROM TENDERS WHERE tender_status = 'Active'";
                ResultSet rs = st.executeQuery(query);
                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("tender_id") %></td>
                <td><%= rs.getString("tender_name") %></td>
                <td><%= rs.getString("tender_type") %></td>
                <td><%= rs.getString("tender_location") %></td>
                <td><%= rs.getString("tender_deadline") %></td>
                <td><%= rs.getString("tender_price") %></td>
                <td><%= rs.getString("tender_description") %></td>
                <td>
                    <button style="background-color: #007bff; color: white;" onclick="openBidForm(<%= rs.getInt("tender_id") %>)">Bid</button>
                </td>
            </tr>
            <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

    <!-- Modal for Place Bid Form -->
    <div id="bidModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeBidForm()">&times;</span>
            <h3>Place Your Bid</h3>
            <form action="PlaceBidServlet" method="POST">
                <input type="hidden" id="tenderId" name="tenderId">
                <label for="bidAmount">Bid Amount:</label>
                <input type="number" id="bidAmount" name="bidAmount" step="0.01" required>

                <label for="bidProposal">Bid Proposal:</label>
                <textarea id="bidProposal" name="bidProposal" rows="4" required></textarea>

                <label for="bidSubmissionDate">Submission Date:</label>
                <input type="date" id="bidSubmissionDate" name="bidSubmissionDate" required>

                <button type="submit">Submit Bid</button>
            </form>
        </div>
    </div>

    <div class="profile-footer">
        <button onclick="window.location.href='vendorHome.jsp';">Close</button>
    </div>

    <script>
        // Open the modal and set the tender ID in the form
        function openBidForm(tenderId) {
            document.getElementById('tenderId').value = tenderId;
            document.getElementById('bidModal').style.display = "block";
        }

        // Close the modal
        function closeBidForm() {
            document.getElementById('bidModal').style.display = "none";
        }
    </script>
</body>
</html>

    