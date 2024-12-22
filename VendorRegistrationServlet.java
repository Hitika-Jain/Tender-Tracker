package tender;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/VendorRegistrationServlet")
public class VendorRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // AES Secret Key (must be 16 characters)
    private static final String SECRET_KEY = "SecretAESKey1234";

    // Encrypt data using AES
    private String encryptAES(String data) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        byte[] encryptedBytes = cipher.doFinal(data.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String vendorName = request.getParameter("vendor_name");
        String vendorPassword = request.getParameter("vendor_password");
        String vendorCompany = request.getParameter("vendor_company");
        String vendorCompanyRegNo = request.getParameter("vendor_company_registration_no");
        String vendorContactDetails = request.getParameter("vendor_contact_details");
        String vendorEmail = request.getParameter("vendor_email");
        String vendorState = request.getParameter("vendor_state");
        String vendorCity = request.getParameter("vendor_city");
        String vendorTurnover = request.getParameter("vendor_turnover");
        String vendorCompanyAddress = request.getParameter("vendor_company_address");

        try {
            // Hash password using BCrypt
            String hashedPassword = BCrypt.hashpw(vendorPassword, BCrypt.gensalt());

            // Encrypt contact details using AES
            String encryptedContactDetails = encryptAES(vendorContactDetails);

            // Insert data into the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tender_tracker", "root", "Hit@22062004");

            String sql = "INSERT INTO VENDORS (vendor_name, vendor_password, vendor_company, vendor_company_registration_no, vendor_contact_details, vendor_email, vendor_state, vendor_city, vendor_turnover, vendor_company_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, vendorName);
            stmt.setString(2, hashedPassword);
            stmt.setString(3, vendorCompany);
            stmt.setString(4, vendorCompanyRegNo);
            stmt.setString(5, encryptedContactDetails);
            stmt.setString(6, vendorEmail);
            stmt.setString(7, vendorState);
            stmt.setString(8, vendorCity);
            stmt.setString(9, vendorTurnover != null && !vendorTurnover.isEmpty() ? vendorTurnover : null);
            stmt.setString(10, vendorCompanyAddress);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                out.println("<h3>Vendor registration successful!</h3>");
                response.sendRedirect("login.jsp");
            } else {
                out.println("<h3>Registration failed. Please try again.</h3>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }
}

