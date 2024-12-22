package tender;

/**
 * Servlet implementation class AdminLoginServlet
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("admin-username");
        String password = request.getParameter("admin-password");
        
        // Database connection settings
        String jdbcUrl = "jdbc:mysql://localhost:3306/tender_tracker";
        String dbUsername = "root";
        String dbPassword = "Hit@22062004";
        
        // Hardcoded credentials for simplicity, you can replace this with your own logic
        if (username.equals("admin@123") && password.equals("Admin#123456")) {
            // Successful login, retrieve data for dashboard
            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword)) {
                // Corrected SQL query
                String tenderCountsQuery = "SELECT " +
                                           "  (SELECT COUNT(*) FROM TENDERS WHERE tender_status = 'Active') AS active_tenders_count, " +
                                           "  (SELECT COUNT(*) FROM TENDERS WHERE tender_status = 'Completed') AS completed_tenders_count, " +
                                           "  (SELECT COUNT(*) FROM BIDS WHERE bid_status = 'Submitted') AS submitted_bids_count, " +
                                           "  (SELECT COUNT(*) FROM VENDORS) AS total_vendor_count";

                try (PreparedStatement ps = conn.prepareStatement(tenderCountsQuery)) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        int activeTendersCount = rs.getInt("active_tenders_count");
                        int completedTendersCount = rs.getInt("completed_tenders_count");
                        int submittedBidsCount = rs.getInt("submitted_bids_count");
                        int totalVendorCount = rs.getInt("total_vendor_count");
                        
                        // Store the counts as request attributes
                        request.setAttribute("activeTendersCount", activeTendersCount);
                        request.setAttribute("completedTendersCount", completedTendersCount);
                        request.setAttribute("submittedBidsCount", submittedBidsCount);
                        request.setAttribute("totalVendorCount", totalVendorCount);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // Redirect to admin home page
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminhome.jsp");
            dispatcher.forward(request, response);

        } else {
            // Invalid credentials, send error message back
            request.setAttribute("errorMessage", "Invalid Username or Password.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}


