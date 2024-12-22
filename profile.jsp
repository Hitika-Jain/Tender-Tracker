<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Profile - Tender Management System</title>
    <style>
        /* General Reset and Body Styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* Main Container */
        .profile-container {
            width: 90%;
            max-width: 900px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }

        /* Header Section */
        .profile-header {
            background-color: #007bff;
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }

        .profile-header img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            border: 3px solid #ffffff;
        }

        .profile-header h1 {
            margin-top: 10px;
            font-size: 24px;
        }

        .profile-header p {
            font-size: 14px;
            margin: 5px 0;
        }

        /* Profile Content */
        .profile-content {
            padding: 20px;
        }

        /* Basic Info and Contact Sections */
        .profile-section {
            margin-bottom: 20px;
        }

        .profile-section h2 {
            font-size: 18px;
            color: #333;
            margin-bottom: 10px;
            border-bottom: 2px solid #e8e8e8;
            padding-bottom: 5px;
        }

        .info-item, .contact-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 14px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-item span, .contact-item span {
            color: #555;
        }

        /* Tender History Section */
        .tender-history table {
            width: 100%;
            border-collapse: collapse;
        }

        .tender-history th, .tender-history td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        .tender-history th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .tender-history td {
            font-size: 14px;
        }

        /* Rating Section */
        .rating {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
            font-size: 16px;
        }

        .rating span {
            color: #ffb400;
        }

        /* Button */
        .profile-footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f8f8;
        }

        .profile-footer button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .profile-footer button:hover {
            background-color: #007bff;
        }
    </style>
</head>
<body>

<div class="profile-container">
    <!-- Header Section -->
    <div class="profile-header">
        <img src="https://th.bing.com/th/id/OIP.0yE5-Tkjv1iwMkZTwC8QQwAAAA?rs=1&pid=ImgDetMain" alt="Vendor Profile Photo">
        <h1>Vendor Name</h1>
        <p>Specialized in Quality Product Delivery</p>
    </div>

    <!-- Profile Content -->
    <div class="profile-content">
        <!-- Basic Info Section -->
        <div class="profile-section">
            <h2>Basic Information</h2>
            <div class="info-item"><strong>Company Name:</strong> <%= session.getAttribute("vendorCompany") %></div>
            <div class="info-item"><strong>Company Registration No:</strong> <%= session.getAttribute("vendorCompanyRegistrationNo") %></div>
            <div class="info-item"><strong>Company Address:</strong>  <%= session.getAttribute("vendorCompanyAddress") %></div>
        </div>
        
        <!-- Contact Information Section -->
        <div class="profile-section">
            <h2>Contact Information</h2>
            <div class="contact-item"><strong>Email:</strong> <%= session.getAttribute("vendorEmail") %></div>
            <div class="contact-item"><strong>Phone:</strong> <%= session.getAttribute("vendorContactDetails") %></div>
            <!-- <div class="contact-item"><strong>Website:</strong> <span><a href="#">www.example.com</a></span></div>
        </div> -->

        <!-- Tender History Section -->
        <div class="profile-section tender-history">
            <!-- <h2>Tender History</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tender ID</th>
                        <th>Title</th>
                        <th>Status</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>T-101</td>
                        <td>Building Project</td>
                        <td>Completed</td>
                        <td>$500,000</td>
                    </tr>
                    <tr>
                        <td>T-102</td>
                        <td>Infrastructure Development</td>
                        <td>In Progress</td>
                        <td>$1,200,000</td>
                    </tr>
                    <tr>
                        <td>T-103</td>
                        <td>Road Maintenance</td>
                        <td>Bid Submitted</td>
                        <td>$300,000</td>
                    </tr> 
                </tbody> 
            </table>-->
        </div>

        <!-- Rating Section -->
        <div class="profile-section">
            <h2>Rating</h2>
            <div class="rating">
                <span>⭐⭐⭐⭐☆</span> (4/5 based on 35 reviews)
            </div>
        </div>
    </div>

    <!-- Profile Footer with Action Button -->
    <div class="profile-footer">
        <button onclick="window.location.href='vendorHome.jsp';">Close</button>
    </div>
</div>

</body>
</html>