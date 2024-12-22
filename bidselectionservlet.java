package tender;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class bidselectionservlet
 */
@WebServlet("/bidselectionservlet")
public class bidselectionservlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bidId = request.getParameter("selectedBidId");
        String tenderId = request.getParameter("tenderId");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tender_tracker", "root", "Hit@22062004")) {
            // Update selected bid
            String updateSelected = "UPDATE BIDS SET bid_status = 'selected' WHERE bid_id = ?";
            PreparedStatement stmt1 = conn.prepareStatement(updateSelected);
            stmt1.setInt(1, Integer.parseInt(bidId));
            stmt1.executeUpdate();

            // Update other bids
            String updateRejected = "UPDATE BIDS SET bid_status = 'rejected' WHERE tender_id = ? AND bid_id != ?";
            PreparedStatement stmt2 = conn.prepareStatement(updateRejected);
            stmt2.setInt(1, Integer.parseInt(tenderId));
            stmt2.setInt(2, Integer.parseInt(bidId));
            stmt2.executeUpdate();
            
         // Update tender status
            String updateCompleted = "UPDATE TENDERS SET tender_status = 'Completed' WHERE tender_id = ?";
            PreparedStatement stmt3 = conn.prepareStatement(updateCompleted);
            stmt3.setInt(1, Integer.parseInt(tenderId));
            stmt3.executeUpdate();

            response.sendRedirect("bidselection.jsp?tenderId=" + tenderId + "&sortOption=amount");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

