<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tender Tracker</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f4f8;
            color: #4a4a4a;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #007bff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
        }

        .navbar-brand,
        .nav-link {
            color: #ffffff !important;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .navbar-brand:hover,
        .nav-link:hover {
            color: #ffd600 !important;
        }

        .jumbotron {
            background: radial-gradient(circle, rgba(63, 81, 181, 1) 0%, rgba(33, 150, 243, 1) 100%);
            padding: 4rem;
            color: white;
            border-radius: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 2rem;
        }

        .jumbotron h1 {
            font-size: 3.5rem;
            font-weight: bold;
            line-height: 1.2;
            margin-bottom: 1.5rem;
        }

        .btn-primary {
            background-color: #ff7043;
            border: none;
            font-size: 1.2rem;
            padding: 0.75rem 2rem;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #d84315;
            transform: translateY(-3px);
        }

        .card {
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            transition: transform 0.3s ease;
            margin-top: 1.5rem;
        }

        .card:hover {
            transform: scale(1.05);
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            text-align: center;
            font-size: 1.2rem;
            padding: 1rem;
            border-radius: 15px 15px 0 0;
        }

        .card-body h5 {
            color: #1565c0;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .notice-center {
            background-color: #ffffff;
            padding: 2rem;
            margin-top: 3rem;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .tender-list-item {
            padding: 15px;
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            margin-bottom: 10px;
            border-radius: 10px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .tender-list-item:hover {
            background-color: #42a5f5;
            color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            cursor: pointer;
        }

        .footer {
            background-color: #1c1c1c;
            color: white;
            padding: 2rem 0;
            text-align: center;
        }

        .footer span {
            font-weight: 500;
        }

        .modal-header {
            background-color: #007bff;
            color: white;
        }

        .close {
            color: white;
        }

        .container {
            margin-bottom: 2rem;
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Tender Tracker</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#about">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Welcome to Tender Tracker</h1>
            <p class="lead">Efficiently manage your tenders and bids with our comprehensive system.</p>
            <hr class="my-4">
            <p>Login as an administrator or vendor to access the system features.</p>
            <a class="btn btn-primary btn-lg" href="login.jsp" role="button" data-bs-toggle="modal"
                data-bs-target="#loginModal">Login Now</a>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        Administrator
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Admin Features</h5>
                        <ul>
                            <li>Create new Vendors</li>
                            <li>View all Vendors</li>
                            <li>Create new Tenders</li>
                            <li>View all Tenders</li>
                            <li>View all Bids</li>
                            <li>Select a Bid</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        Vendor
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Vendor Features</h5>
                        <ul>
                            <li>View current Tenders</li>
                            <li>Place a Bid</li>
                            <li>View Bid status</li>
                            <li>View Bid history</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        System Benefits
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Why Use Our System?</h5>
                        <ul>
                            <li>Efficient tender management</li>
                            <li>Transparent bidding process</li>
                            <li>Easy vendor management</li>
                            <li>Secure and reliable</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="notice-center">
            <h3>Notice Center</h3>
            <div class="tender-list-item">Tender #1: Road construction for XYZ City</div>
            <div class="tender-list-item">Tender #2: Supply of Medical Equipment</div>
            <div class="tender-list-item">Tender #3: School Building Renovation</div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <span>© 2024 Tender Tracker. All rights reserved.</span>
        </div>
    </footer>

    <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm">