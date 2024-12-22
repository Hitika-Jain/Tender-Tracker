<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Registration</title>
    <style>
        * {
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background-color: #f4f7f8;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

.form-container {
    background-color: #ffffff;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    width: 100%;
}

h2 {
    color: #007bff;
    text-align: center;
    margin-bottom: 1rem;
}

.form-row {
    margin-bottom: 1rem;
}

.form-row label {
    display: block;
    font-weight: bold;
    margin-bottom: 0.5rem;
    color: #555555;
}

.form-row input[type="text"],
.form-row input[type="password"],
.form-row input[type="number"],
.form-row input[type="email"],
.form-row select,
.form-row textarea {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #dddddd;
    border-radius: 4px;
    font-size: 1rem;
}

.form-row textarea {
    resize: vertical;
}

.form-row button {
    width: 100%;
    padding: 0.75rem;
    font-size: 1rem;
    color: #ffffff;
    background-color: #007bff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.form-row button:hover {
    background-color: #007bff;
}

.row-pair {
    display: flex;
    gap: 1rem;
}

.form-column {
    flex: 1;
}

@media (max-width: 600px) {
    .row-pair {
        flex-direction: column;
    }
}
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Vendor Registration</h2>
        <form action="VendorRegistrationServlet" method="POST">
            <div class="form-row">
                <label for="vendor_name">Vendor Name:</label>
                <input type="text" id="vendor_name" name="vendor_name" required>
            </div>
            <div class="form-row">
                <label for="vendor_password">Password (12 digits):</label>
                <input type="password" id="vendor_password" name="vendor_password" pattern="\d{12}" required>
            </div>
            <div class="form-row">
                <label for="vendor_company">Company Name:</label>
                <input type="text" id="vendor_company" name="vendor_company" required>
            </div>
            <div class="form-row">
                <label for="vendor_company_registration_no">Company Registration No:</label>
                <input type="text" id="vendor_company_registration_no" name="vendor_company_registration_no" required>
            </div>
            <div class="form-row">
                <label for="vendor_contact_details">Contact Details:</label>
                <input type="text" id="vendor_contact_details" name="vendor_contact_details" required>
            </div>
            <div class="form-row">
                <label for="vendor_email">Email:</label>
                <input type="email" id="vendor_email" name="vendor_email" required>
            </div>
            <div class="form-row row-pair">
                <div class="form-column">
                    <label for="vendor_state">State:</label>
                    <select id="vendor_state" name="vendor_state" required>
                        <option value="">Select State</option>
                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                        <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                        <option value="Assam">Assam</option>
                        <option value="Bihar">Bihar</option>
                        <!-- Add all states of India -->
                        <option value="West Bengal">West Bengal</option>
                    </select>
                </div>
                <div class="form-column">
                    <label for="vendor_city">City:</label>
                    <input type="text" id="vendor_city" name="vendor_city" required>
                </div>
            </div>
            <div class="form-row">
                <label for="vendor_turnover">Turnover:</label>
                <input type="number" id="vendor_turnover" name="vendor_turnover" min="0">
            </div>
            <div class="form-row">
                <label for="vendor_company_address">Company Address:</label>
                <textarea id="vendor_company_address" name="vendor_company_address" rows="3"></textarea>
            </div>
            <div class="form-row">
                <button type="submit">Register</button>
            </div>
        </form>
    </div>
</body>
</html>