package tender;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/newtenderServlet")
public class newtenderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tenderName = request.getParameter("tenderName");
        String tenderType = request.getParameter("tenderType");
        BigDecimal tenderPrice = new BigDecimal(request.getParameter("tenderPrice"));
        String tenderDescription = request.getParameter("tenderDescription");
        String tenderDeadline = request.getParameter("tenderDeadline");
        String tenderLocation = request.getParameter("tenderLocation");

        // Set the status to 'Active' without asking in the form
        String tenderStatus = "Active";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Database connection
            String url = "jdbc:mysql://localhost:3306/tender_tracker";
            String user = "root";
            String password = "Hit@22062004";
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);

            // Insert query with status set to 'Active'
            String sql = "INSERT INTO TENDERS (tender_name, tender_type, tender_price, tender_description, tender_deadline, tender_location, tender_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, tenderName);
            ps.setString(2, tenderType);
            ps.setBigDecimal(3, tenderPrice);
            ps.setString(4, tenderDescription);
            ps.setString(5, tenderDeadline);
            ps.setString(6, tenderLocation);
            ps.setString(7, tenderStatus); // Always set to Active

            int rows = ps.executeUpdate();
            if (rows > 0) {
                request.setAttribute("message", "Tender added successfully.");
            } else {
                request.setAttribute("message", "Error adding tender.");
            }

            // Forward the request back to the JSP page
            request.getRequestDispatcher("newtender.jsp").forward(request, response);
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
}
