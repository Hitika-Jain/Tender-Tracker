package tender;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PlaceBidServlet")
public class PlaceBidServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve tender ID from the request parameter
        int tenderId = Integer.parseInt(request.getParameter("tenderId"));
        
        // Retrieve tender details from the database
        Tender tender = getTenderFromDatabase(tenderId);
        
        // Set tender object in request attribute
        request.setAttribute("tender", tender);
        request.getRequestDispatcher("placeBid.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve vendor ID from session (assuming it's already set during login)
        Integer vendorId = (Integer) request.getSession().getAttribute("vendorId");
        if (vendorId == null) {
            response.getWriter().println("Error: Vendor not logged in.");
            return;
        }

        // Retrieve form parameters
        int tenderId = Integer.parseInt(request.getParameter("tenderId"));
        BigDecimal bidAmount = new BigDecimal(request.getParameter("bidAmount"));
        String bidProposal = request.getParameter("bidProposal");
        String bidSubmissionDate = request.getParameter("bidSubmissionDate");

        // Set bid status to "Submitted"
        String bidStatus = "Submitted";

        // Insert the bid into the BIDS table
        Connection con = null;
        PreparedStatement ps = null;

        try {
            String url = "jdbc:mysql://localhost:3306/tender_tracker";
            String user = "root";
            String password = "Hit@22062004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            // SQL query to insert a new bid
            String sql = "INSERT INTO BIDS (vendor_id, tender_id, bid_amount, bid_proposal, bid_submission_date, bid_status) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, vendorId);
            ps.setInt(2, tenderId);
            ps.setBigDecimal(3, bidAmount);
            ps.setString(4, bidProposal);
            ps.setString(5, bidSubmissionDate);
            ps.setString(6, bidStatus);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.getWriter().println("Bid placed successfully.");
            } else {
                response.getWriter().println("Error placing bid.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Helper method to fetch tender details from the database
    private Tender getTenderFromDatabase(int tenderId) {
        Tender tender = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String url = "jdbc:mysql://localhost:3306/tender_tracker";
            String user = "root";
            String password = "Hit@22062004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            // SQL query to fetch tender details by tender ID
            String sql = "SELECT tender_id, tender_name, tender_type, tender_price, tender_description, tender_deadline, tender_location FROM TENDERS WHERE tender_id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, tenderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                tender = new Tender();
                tender.setTenderId(rs.getInt("tender_id"));
                tender.setTenderName(rs.getString("tender_name"));
                tender.setTenderType(rs.getString("tender_type"));
                tender.setTenderPrice(rs.getBigDecimal("tender_price"));
                tender.setTenderDescription(rs.getString("tender_description"));
                tender.setTenderDeadline(rs.getString("tender_deadline"));
                tender.setTenderLocation(rs.getString("tender_location"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return tender;
    }
}

