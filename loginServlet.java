package tender;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class loginServlet
 */


@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // AES Secret Key (16 bytes)
    private static final String AES_SECRET_KEY = "SecretAESKey1234"; 

    // AES Decryption Method
    private String decryptAES(String encryptedData) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec keySpec = new SecretKeySpec(AES_SECRET_KEY.getBytes("UTF-8"), "AES");
        cipher.init(Cipher.DECRYPT_MODE, keySpec);
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedData);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes, "UTF-8");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("vendor-username");
        String password = request.getParameter("vendor-password");
        boolean isValid = false;

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tender_tracker", "root", "Hit@22062004");

            // Query to fetch vendor details based on username
            String query = "SELECT * FROM VENDORS WHERE vendor_name = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();
            String hashedPasswordFromDB = null;

            // Vendor Details
            String vendorCompany = null;
            String vendorCompanyRegistrationNo = null;
            String vendorContactDetails = null;
            String vendorEmail = null;
            String vendorState = null;
            String vendorCity = null;
            Long vendorTurnover = null;
            String vendorCompanyAddress = null;
            int vendorId = 0;

            if (rs.next()) {
                // Get data from result set
                hashedPasswordFromDB = rs.getString("vendor_password");
                vendorId = rs.getInt("vendor_id");
                vendorCompany = rs.getString("vendor_company");
                vendorCompanyRegistrationNo = rs.getString("vendor_company_registration_no");
                vendorContactDetails = rs.getString("vendor_contact_details");
                vendorEmail = rs.getString("vendor_email");
                vendorState = rs.getString("vendor_state");
                vendorCity = rs.getString("vendor_city");
                vendorTurnover = rs.getLong("vendor_turnover");
                vendorCompanyAddress = rs.getString("vendor_company_address");
            }

            // Validate password
            if (hashedPasswordFromDB != null && BCrypt.checkpw(password, hashedPasswordFromDB)) {
                isValid = true;

                // Decrypt contact details
                String decryptedContactDetails = decryptAES(vendorContactDetails);

                // Store vendor details in session
                HttpSession session = request.getSession();
                session.setAttribute("vendorId", vendorId);
                session.setAttribute("vendorName", username);
                session.setAttribute("vendorCompany", vendorCompany);
                session.setAttribute("vendorCompanyRegistrationNo", vendorCompanyRegistrationNo);
                session.setAttribute("vendorContactDetails", decryptedContactDetails);
                session.setAttribute("vendorEmail", vendorEmail);
                session.setAttribute("vendorState", vendorState);
                session.setAttribute("vendorCity", vendorCity);
                session.setAttribute("vendorTurnover", vendorTurnover);
                session.setAttribute("vendorCompanyAddress", vendorCompanyAddress);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isValid) {
            // Redirect to homepage.jsp
            response.sendRedirect("vendorHome.jsp");
        } else {
            // Failed login - send error message back to login.jsp
            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

