<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Tender</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            color: #007bff;
        }
        form label {
            display: block;
            margin: 10px 0 5px;
            color: #333;
        }
        form input[type="text"],
        form input[type="number"],
        form input[type="date"],
        form textarea {
            width: 100%;
            padding: 0.4rem;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .form-group input {
            width: 48%;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn-group button {
            width: 48%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Tender</h2>
        <form action="newtenderServlet" method="POST">
            <label for="tenderName">Tender Name:</label>
            <input type="text" id="tenderName" name="tenderName" required>

            <label for="tenderType">Tender Type:</label>
            <input type="text" id="tenderType" name="tenderType">

            <div class="form-group">
                <div>
                    <label for="tenderPrice">Tender Price:</label>
                    <input type="number" id="tenderPrice" name="tenderPrice" step="0.01" required>
                </div>
                <div>
                    <label for="tenderDeadline">Deadline:</label>
                    <input type="date" id="tenderDeadline" name="tenderDeadline" required>
                </div>
            </div>

            <label for="tenderDescription">Description:</label>
            <textarea id="tenderDescription" name="tenderDescription" rows="4"></textarea>

            <label for="tenderLocation">Location:</label>
            <input type="text" id="tenderLocation" name="tenderLocation" required>

            <!-- Status input removed, will be set as Active in servlet -->

            <button type="submit">Add Tender</button>
        
        <%-- Display Success Message --%>
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div style="text-align: center; color: green; margin-top: 20px;">
                <p><%= message %></p>
            </div>
        <% 
            }
        %>

        <div class="btn-group">
            <button type="reset">Reset</button>
            <button onclick="window.location.href='adminhome.jsp';">Close</button>
        </div>
        </form>
    </div>
</body>
</html>

