<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tender Tracker</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    /* Navbar Styles */
    .navbar {
      background-color: #007bff;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: white;
    }
    .navbar-brand, .nav-link {
      color: #fff !important;
    }
    .navbar-toggler-icon {
      background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3e%3cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    /* Jumbotron Styles */
    .jumbotron {
    margin-top: 1.5rem;
      background: linear-gradient(135deg, #0088ff, #0055cc);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            text-align: center;
     margin-bottom: 2rem;
    }

    /* Card Styles */
    .card-header {
      background-color: #007bff;
      color: #fff;
    }
    .card-body {
      background-color: #f8f9fa;
    }

    /* Button Styles */
    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
    }
    .btn-primary:hover {
      background-color: #0056b3;
      border-color: #004a99;
    }

    /* Overlay Styles */
    .overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 1000;
    }
    .overlay-content {
      background-color: #fff;
      padding: 20px;
      border-radius: 5px;
      max-width: 80%;
    }

    /* Tender Details Overlay */
    #tenderDetailsOverlay .overlay-content {
      max-width: 600px;
    }

    /* Bid Status Overlay */
    #bidStatusOverlay .overlay-content {
      max-width: 400px;
    }

    /* Bid History Overlay */
    #bidHistoryOverlay .overlay-content {
      max-width: 800px;
    }

    /* Create Bid Overlay */
    #createBidOverlay .overlay-content {
      max-width: 600px;
    }

    /* Notification Styles */
    .notification {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background-color: #28a745;
      color: #fff;
      padding: 10px 20px;
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
      display: none;
      z-index: 1100;
    }

    /* Loading Spinner Styles */
    .loading-spinner {
      border: 4px solid #f3f3f3;
      border-top: 4px solid #3498db;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      animation: spin 2s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <nav class="navbar navbar-expand-lg">
      <a class="navbar-brand" href="#">Tender Tracker</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="#">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="profile.jsp">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Contact</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="login.jsp">Logout</a>
          </li>
        </ul>
      </div>
    </nav>

    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4">Welcome, <%= session.getAttribute("vendorName") %></h1>
        <p class="lead">Manage your tenders and bids efficiently with our comprehensive system.</p>
      </div>
    </div>

    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Active Tenders</div>
            <div class="card-body">
              <p>View all current available tenders.</p>
              <form action="viewtenders.jsp">
              <button type="submit" class="btn btn-primary">View Active Tenders</button>
              </form>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Bid Status</div>
            <div class="card-body">
              <p>Track the status of your submitted bids.</p>
              <a href="#" class="btn btn-primary" onclick="showBidStatusOverlay()">Check Status</a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Place a Bid</div>
            <div class="card-body">
              <p>Submit a new bid for an active tender.</p>
              <a href="#" class="btn btn-primary" onclick="showCreateBidOverlay()">Create Bid</a>
            </div>
          </div>
        </div>
        <!-- <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Bid History</div>
            <div class="card-body">
              <p>Review your complete bidding history and performance.</p>
              <p>Total Bids: 27</p>
              <a href="#" class="btn btn-primary" onclick="showBidHistoryOverlay()">View History</a>
            </div>
          </div>
        </div>-->
      </div>

      <!--  <div class="row">
        
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Tender Notifications</div>
            <div class="card-body">
              <p>Stay up-to-date with the latest tender opportunities.</p>
              <div class="form-group">
                <input type="email" class="form-control" id="notificationEmail" placeholder="Enter email">
              </div>
              <button class="btn btn-primary" onclick="subscribeToNotifications()">Subscribe</button>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card mb-4">
            <div class="card-header">Tender Analytics</div>
            <div class="card-body">
              <p>Analyze your bidding performance and trends.</p>
              <a href="#" class="btn btn-primary" onclick="showTenderAnalyticsOverlay()">View Analytics</a>
            </div>
          </div>
        </div>
      </div>-->
    </div>

    <!-- Tender Details Overlay 
    <div class="overlay" id="tenderDetailsOverlay">
      <div class="overlay-content">
        <h3>Tender Details</h3>
        <p>Tender ID: 12345</p>
        <p>Tender Title: Supply of Office Furniture</p>
        <p>Tender Description: The company is looking for a supplier to provide a range of office furniture, including desks, chairs, and storage units.</p>
        <p>Closing Date: 2023-06-30</p>
        <button class="btn btn-primary" onclick="closeTenderDetailsOverlay()">Close</button>
      </div>
    </div>-->

    <!-- Bid Status Overlay -->
    <div class="overlay" id="bidStatusOverlay">
      <div class="overlay-content">
        <h3>Bid Status</h3>
        <p>Tender ID: 12345</p>
        <p>Bid Status: Pending</p>
        <p>Bid Price: $10,000</p>
        <p>Delivery Timeline: 30 days</p>
        <button class="btn btn-primary" onclick="closeBidStatusOverlay()">Close</button>
      </div>
    </div>

    <!-- Bid History Overlay -->
    <div class="overlay" id="bidHistoryOverlay">
      <div class="overlay-content">
        <h3>Bid History</h3>
        <table class="table">
          <thead>
            <tr>
              <th>Tender</th>
              <th>Bid Price</th>
              <th>Delivery Timeline</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Tender 1</td>
              <td>$5,000</td>
              <td>30 days</td>
              <td>Selected</td>
            </tr>
            <tr>
              <td>Tender 2</td>
              <td>$4,500</td>
              <td>45 days</td>
              <td>Not Selected</td>
            </tr>
            <tr>
              <td>Tender 3</td>
              <td>$6,200</td>
              <td>20 days</td>
              <td>Pending</td>
            </tr>
          </tbody>
        </table>
        <button class="btn btn-primary" onclick="closeBidHistoryOverlay()">Close</button>
      </div>
    </div>

    <!-- Create Bid Overlay -->
    <div class="overlay" id="createBidOverlay">
      <div class="overlay-content">
        <h3>Create Bid</h3>
        <form>
          <div class="form-group">
            <label for="tenderSelect">Select Tender</label>
            <select class="form-control" id="tenderSelect">
              <option>Tender 1</option>
              <option>Tender 2</option>
              <option>Tender 3</option>
            </select>
          </div>
          <div class="form-group">
            <label for="bidPrice">Bid Price</label>
            <input type="number" class="form-control" id="bidPrice" placeholder="Enter bid price">
          </div>
          <div class="form-group">
            <label for="deliveryTimeline">Delivery Timeline</label>
            <input type="text" class="form-control" id="deliveryTimeline" placeholder="Enter delivery timeline">
          </div>
          <button type="submit" class="btn btn-primary" onclick="submitBid()">Submit Bid</button>
          <button class="btn btn-secondary" onclick="closeCreateBidOverlay()">Cancel</button>
        </form>
      </div>
    </div>

    <!-- Tender Analytics Overlay -->
    <div class="overlay" id="tenderAnalyticsOverlay">
      <div class="overlay-content">
        <h3>Tender Analytics</h3>
        <div id="tenderAnalyticsChart"></div>
        <button class="btn btn-primary" onclick="closeTenderAnalyticsOverlay()">Close</button>
      </div>
    </div>

    <!-- Notification -->
    <div class="notification" id="notification">
      <span id="notificationMessage"></span>
    </div>

    <script>
      function showTenderDetailsOverlay() {
        document.getElementById("tenderDetailsOverlay").style.display = "flex";
      }

      function closeTenderDetailsOverlay() {
        document.getElementById("tenderDetailsOverlay").style.display = "none";
      }

      function showBidStatusOverlay() {
    	  window.location.href = "bidhistory.jsp";
      }

      function closeBidStatusOverlay() {
        document.getElementById("bidStatusOverlay").style.display = "none";
      }

      function showBidHistoryOverlay() {
        document.getElementById("bidHistoryOverlay").style.display = "flex";
      }

      function closeBidHistoryOverlay() {
        document.getElementById("bidHistoryOverlay").style.display = "none";
      }

      function showCreateBidOverlay() {
    	  window.location.href = "bidplacement.jsp";
      }

      function closeCreateBidOverlay() {
        document.getElementById("createBidOverlay").style.display = "none";
      }

      function showTenderAnalyticsOverlay() {
        document.getElementById("tenderAnalyticsOverlay").style.display = "flex";
        loadTenderAnalytics();
      }

      function closeTenderAnalyticsOverlay() {
        document.getElementById("tenderAnalyticsOverlay").style.display = "none";
      }

      function subscribeToNotifications() {
        const email = document.getElementById("notificationEmail").value;
        if (email) {
          showNotification("Subscribed to tender notifications!");
        } else {
          showNotification("Please enter an email address.");
        }
      }

      function submitBid() {
        showNotification("Bid submitted successfully!");
        closeCreateBidOverlay();
      }

      function showNotification(message) {
        const notification = document.getElementById("notification");
        document.getElementById("notificationMessage").textContent = message;
        notification.style.display = "block";
        setTimeout(() => {
          notification.style.display = "none";
        }, 3000);
      }

      function loadTenderAnalytics() {
        // Simulate loading analytics data
        const chartContainer = document.getElementById("tenderAnalyticsChart");
        chartContainer.innerHTML = "";
        const loadingSpinner = document.createElement("div");
        loadingSpinner.classList.add("loading-spinner");
        chartContainer.appendChild(loadingSpinner);

        // Simulate asynchronous data loading
        setTimeout(() => {
          chartContainer.innerHTML = "<p>Analytics chart will be displayed here.</p>";
          loadingSpinner.remove();
        }, 2000);
      }
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>