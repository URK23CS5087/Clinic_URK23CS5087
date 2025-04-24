<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClinicPro | Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .welcome-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 0 0 20px 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .action-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="welcome-header py-5">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-3">
                <i class="bi bi-heart-pulse"></i> ClinicPro
            </h1>
            <p class="lead">Patient Portal</p>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container my-auto">
        <div class="row justify-content-center">
            <div class="col-md-5 mb-4">
                <a href="register.jsp" class="text-decoration-none">
                    <div class="card action-card h-100 text-white bg-primary">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-person-plus display-4 mb-3"></i>
                            <h2 class="h3">New Patient</h2>
                            <p class="mb-0">Register for an account</p>
                        </div>
                    </div>
                </a>
            </div>
            
            <div class="col-md-5 mb-4">
                <a href="login.jsp" class="text-decoration-none">
                    <div class="card action-card h-100 text-white bg-success">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-box-arrow-in-right display-4 mb-3"></i>
                            <h2 class="h3">Existing Patient</h2>
                            <p class="mb-0">Login to your account</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-light py-3 mt-auto">
        <div class="container text-center">
            <p class="mb-0 text-muted">
                &copy; 2023 ClinicPro | Simple Patient Portal
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>