<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat,tender.bids, tender.heapsort" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bid Analysis</title>
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        input, select, button {
            margin: 10px;
            padding: 5px;
        }
    </style>
</head>
<body>
    <h2 align="center">Bid Analysis for Selected Tender</h2>
    <form method="GET">
        <label for="tenderId">Select Tender ID:</label>
        <input type="text" name="tenderId" id="tenderId" required>
        <label for="sortOption">Sort By:</label>
        <select name="sortOption" id="sortOption">
            <option value="amount">Bid Amount</option>
            <option value="date">Submission Date</option>
        </select>
        <button type="submit">View Bids</button>
    </form>
    <%
        String tenderId = request.getParameter("tenderId");
        String sortOption = request.getParameter("sortOption");
        if (tenderId != null && sortOption != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            List<bids> bidList = new ArrayList<>();

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tender_tracker", "root", "Hit@22062004");

                // Fetch bids for the specified tender
                String query = "SELECT * FROM BIDS WHERE tender_id = ?";
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(tenderId));
                rs = stmt.executeQuery();

                while (rs.next()) {
                    bidList.add(new bids(
                        rs.getInt("bid_id"),
                        rs.getInt("vendor_id"),
                        rs.getInt("tender_id"),
                        rs.getBigDecimal("bid_amount"),
                        rs.getString("bid_proposal"),
                        rs.getDate("bid_submission_date"),
                        rs.getString("bid_status")
                    ));
                }

                // Sort the bids using HeapSort
                if ("amount".equals(sortOption)) {
                    heapsort.sortByAmount(bidList);
                } else {
                    heapsort.sortByDate(bidList);
                }
        %>
        <table>
            <tr>
                <th>Bid ID</th>
                <th>Vendor ID</th>
                <th>Bid Amount</th>
                <th>Submission Date</th>
                <th>Bid Status</th>
            </tr>
            <% for (bids bid : bidList) { %>
            <tr>
                <td><%= bid.getBidId() %></td>
                <td><%= bid.getVendorId() %></td>
                <td><%= bid.getBidAmount() %></td>
                <td><%= new SimpleDateFormat("yyyy-MM-dd").format(bid.getSubmissionDate()) %></td>
                <td><%= bid.getBidStatus() %></td>
            </tr>
            <% } %>
        </table>

        <!-- Form to select a bid -->
        <form method="POST" action="bidselectionservlet">
            <label for="selectedBidId">Enter Bid ID to Select:</label>
            <input type="text" name="selectedBidId" id="selectedBidId" required>
            <input type="hidden" name="tenderId" value="<%= tenderId %>">
            <button type="submit">Select Bid</button>
        </form>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
        %>
</body>
</html>