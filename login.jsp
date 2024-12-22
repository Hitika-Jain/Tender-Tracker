<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Tender Tracker</title>
    <style>
        *{
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {
    width: 100%;
    max-width: 400px;
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    text-align: center;
}

h2 {
    color: #007bff;
}

.login-type button {
    width: 45%;
    padding: 10px;
    margin: 5px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.login-type button:hover {
    background-color: #007bff;
}

.login-form {
    margin-top: 20px;
}

.login-form h3 {
    margin: 0;
    color: #333;
}

label {
    display: block;
    margin: 10px 0 5px;
    color: #555;
}

input[type="text"],
input[type="password"],
select {
    width: 100%;
    padding: 10px;
    margin: 5px 0 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
}

button[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button[type="submit"]:hover {
    background-color: #007bff;
}
    </style>
</head>
<body>
    <div class="container">
        <h2>Login to Tender Tracker</h2>
        
        <div class="login-type">
            <button onclick="showLoginForm('admin')">Administrator Login</button>
            <button onclick="showLoginForm('vendor')">Vendor Login</button>
        </div>

        <!-- Administrator Login Form-->
        <div id="admin-login" class="login-form" style="display: none;">
            <h3>Administrator Login</h3>
            <form id="admin-form" action="AdminLoginServlet" method="post">
    			<label for="admin-username">Username</label>
    			<input type="text" id="admin-username" name="admin-username" required>
    
    			<label for="admin-password">Password (12 characters)</label>
    			<input type="password" id="admin-password" name="admin-password" minlength="12" maxlength="12" required>
    
    			<button type="submit">Login</button>
    			<p id="admin-error" style="color: red; display: none;">Wrong credentials. Please try again.</p>
		</form>
        </div>

        <!--Vendor Login Form-->
        <div id="vendor-login" class="login-form" style="display: none;">
            <h3>Vendor Login</h3>
            <form id="vendor-form" action="loginServlet" method="post">
                <label for="vendor-option">Are you a new vendor?</label>
                <select id="vendor-option" onchange="toggleRegistration()">
                    <option value="no">No</option>
                    <option value="yes">Yes</option>
                </select>
                
                <div id="existing-vendor" style="display: block;">
                    <label for="vendor-username">Username</label>
                    <input type="text" id="vendor-username" name="vendor-username" required>
                    
                    <label for="vendor-password">Password (12 characters)</label>
                    <input type="password" id="vendor-password" name="vendor-password" minlength="12" maxlength="12" required>
                    
                    <button type="submit">Login</button>
                    <% if (request.getAttribute("errorMessage") != null) { %>
    <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showLoginForm(type) {
            document.getElementById("admin-login").style.display = "none";
            document.getElementById("vendor-login").style.display = "none";
            if (type === 'admin') {
                document.getElementById("admin-login").style.display = "block";
            } else {
                document.getElementById("vendor-login").style.display = "block";
            }
        }

        function validateAdminLogin() {
        	event.preventDefault();
            const username = document.getElementById("admin-username").value;
            const password = document.getElementById("admin-password").value;

            if (username === "admin@123" && password === "Admin#123456") {
            	window.location.href = "adminhome.jsp"; 
            	// Successful login
            } else {
                document.getElementById("admin-error").style.display = "block";
                return false; // Prevent form submission
            }
        }
        
        function toggleRegistration() {
            const option = document.getElementById("vendor-option").value;
            if (option === "yes") {
                window.location.href = "VendorRegistration.jsp";
            } else {
                document.getElementById("existing-vendor").style.display = "block";
            }
        }
    </script>
</body>
</html>
    