<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tender Management System - Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #6c757d;
        }
        
        .navbar-custom {
            background-color: var(--primary-color);
        }
        
        .welcome-banner {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        
        .stats-row .stats-card {
    		height: 100%; /* Stretch all cards to the maximum height in the row */
		}
        .stats-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .pie-chart-container canvas {
    		max-width: 100%; /* Ensure it scales responsively */
    		max-height: 180px; /* Adjust the height to match other cards */
    		margin: 0 auto; /* Center the canvas */
		}
		
        .action-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }
        
        .stats-icon {
            font-size: 2rem;
            color: var(--primary-color);
        }
        
        .btn-custom {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            margin: 0.5rem 0;
            width: 100%;
        }
        
        .btn-custom:hover {
            background-color: #0b5ed7;
            color: white;
        }

        .modal-content {
            border-radius: 10px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="#">Tender Management System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" onclick="logout()">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <!-- Welcome Banner -->
        <div class="welcome-banner text-center">
            <h2 class="mb-2">Welcome, Administrator</h2>
            <p class="mb-0">Manage vendors, tenders, and bids efficiently with our comprehensive system.</p>
        </div>

        <!-- Statistics Cards -->
        <div class="row stats-row mb-4">
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-people stats-icon me-3"></i>
                        <div>
                            <h6 class="card-subtitle mb-1 text-muted">Total Vendors</h6>
                            <h3 class="card-title mb-0" id="pendingVendorsCount"><%= request.getAttribute("totalVendorCount") %></h3>
                        </div>
                    </div>
                </div>
            </div>
            <!--  <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-file-text stats-icon me-3"></i>
                        <div>
                            <h6 class="card-subtitle mb-1 text-muted">Active Tenders</h6>
                            <h3 class="card-title mb-0" id="activeTendersCount"><%= request.getAttribute("activeTendersCount") %></h3>
                        </div>
                    </div>
                </div>
            </div>-->
            <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-clipboard-data stats-icon me-3"></i>
                        <div>
                            <h6 class="card-subtitle mb-1 text-muted">Pending Bids</h6>
                            <h3 class="card-title mb-0" id="pendingBidsCount"><%= request.getAttribute("submittedBidsCount") %></h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
    			<div class="card stats-card">
        			<div class="card-body">
        	    		<h5 class="card-title text-center">Tenders Overview</h5>
            			<div class="pie-chart-container">
                			<canvas id="tendersChart"></canvas>
            			</div>
        			</div>
    			</div>
			</div>
		</div>	
            <!--  <div class="col-md-3 mb-3">
                <div class="card stats-card">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-check-circle stats-icon me-3"></i>
                        <div>
                            <h6 class="card-subtitle mb-1 text-muted">Completed Tenders</h6>
                            <h3 class="card-title mb-0" id="completedTendersCount">0</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>-->

        <!-- Action Cards -->
        <div class="row">
            <!-- Vendor Management -->
            <div class="col-md-6 mb-3">
                <div class="card action-card">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-people me-2"></i>Vendor Management
                        </h5>
                    </div>
                    <div class="card-body">
                        <!--  <button class="btn btn-custom" onclick="showVerifyVendors()">Verify New Vendors</button>-->
                        <button class="btn btn-custom" onclick="showAllVendors()">View All Vendors</button>
                    </div>
                </div>
            </div>

            <!-- Tender Management -->
            <div class="col-md-6 mb-3">
                <div class="card action-card">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-file-text me-2"></i>Tender Management
                        </h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-custom" onclick="showCreateTender()">Create New Tender</button>
                        <!--  <button class="btn btn-custom" onclick="showActiveTenders()">View Active Tenders</button>-->
                    </div>
                </div>
            </div>

            <!-- Bid Management -->
            <div class="col-md-6 mb-3">
                <div class="card action-card">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-clipboard-data me-2"></i>Bid Management
                        </h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-custom" onclick="showPendingBids()">Review Pending Bids</button>
                        <!--  <button class="btn btn-custom" onclick="showBidHistory()">View Bid History</button>-->
                    </div>
                </div>
            </div>

            <!-- Notice Management -->
            <div class="col-md-6 mb-3">
                <div class="card action-card">
                    <div class="card-header bg-white">
                        <h5 class="card-title mb-0">
                            <i class="bi bi-bell me-2"></i>Notice Management
                        </h5>
                    </div>
                    <div class="card-body">
                        <!--  <button class="btn btn-custom" onclick="showCreateNotice()">Release New Notice</button>-->
                        <button class="btn btn-custom" onclick="showAllNotices()">View All Notices</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script>

        // Initialize dashboard
        document.addEventListener('DOMContentLoaded', function() {
            updateDashboardCounts();
            initializeEventListeners();
        });

        // Update dashboard counts
        function updateDashboardCounts() {
            document.getElementById('pendingVendorsCount').textContent = mockData.pendingVendors.length;
            document.getElementById('activeTendersCount').textContent = '12';
            document.getElementById('pendingBidsCount').textContent = '15';
            document.getElementById('completedTendersCount').textContent = '45';
        }

        
        function showAllVendors(){
        	window.location.href = 'viewvendors.jsp'
        }
		
        function showPendingBids(){
        	window.location.href = 'bidselection.jsp';
        }
        
        function showCreateTender(){
        	window.location.href = 'newtender.jsp';
        }
        
        // Logout Function
        function logout() {
            if(confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.jsp';
            }
        }

        // Initialize tooltips and popovers
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    </script>
    <!-- Chart.js Library -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<script>
    // Retrieve data from server-side attributes
    const activeTenders = <%= request.getAttribute("activeTendersCount") %>;
    const completedTenders = <%= request.getAttribute("completedTendersCount") %>;

    // Initialize the chart
    const ctx = document.getElementById('tendersChart').getContext('2d');
    const tendersChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Active Tenders', 'Completed Tenders'],
            datasets: [{
                data: [activeTenders, completedTenders],
                backgroundColor: ['#0d6efd', '#6c757d'],
                hoverBackgroundColor: ['#0b5ed7', '#5a6268'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            // Retrieve label and value from the dataset
                            const label = tooltipItem.label || '';
                            const value = tooltipItem.raw || 0;

                            // Return label with count
                            return `${label}: ${value} tenders`;
                        }
                    }
                }
            }
        }
    });
</script>

    
</body>
</html>