<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClinicPro | Patient Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3a0ca3;
            --accent-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: var(--dark-color);
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 0 0 30px 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            padding: 2rem 0;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }
        
        .login-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--accent-color), rgba(255,255,255,0.5));
        }
        
        .login-card {
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: none;
            overflow: hidden;
            transition: transform 0.3s ease;
            background-color: white;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
        }
        
        .card-body {
            padding: 2.5rem;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .input-group-text {
            background-color: white;
            border-right: none;
            color: var(--primary-color);
        }
        
        .form-control {
            border-left: none;
            padding: 0.75rem 1rem;
            border-radius: 0 8px 8px 0 !important;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
            border-color: #ced4da;
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(67, 97, 238, 0.3);
        }
        
        .forgot-link {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .forgot-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .register-link {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .register-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .alert {
            border-radius: 8px;
            border-left: 4px solid var(--error-color);
        }
        
        .alert-success {
            border-left-color: var(--success-color);
        }
        
        footer {
            background-color: white;
            box-shadow: 0 -5px 15px rgba(0, 0, 0, 0.03);
            margin-top: 3rem;
            padding: 1.5rem 0;
        }
        
        .brand-logo {
            font-weight: 700;
            letter-spacing: 1px;
        }
        
        .brand-logo i {
            color: var(--accent-color);
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
        }
        
        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .divider-text {
            padding: 0 1rem;
            color: #6c757d;
            font-size: 0.875rem;
        }
        
        /* Animation for header */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .login-header {
            animation: fadeIn 0.6s ease-out;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .login-header {
                border-radius: 0 0 20px 20px;
                padding: 1.5rem 0;
            }
            
            .card-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="login-header">
        <div class="container text-center">
            <h1 class="display-5 fw-bold mb-2 brand-logo">
                <i class="bi bi-heart-pulse"></i> ClinicPro
            </h1>
            <p class="lead mb-0">Your Health, Our Priority</p>
        </div>
    </header>

    <!-- Login Form -->
    <main class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card login-card">
                    <div class="card-body">
                        <h3 class="mb-4 text-center">Patient Login</h3>
                        
                        <%-- Display error message if exists --%>
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <%-- Display success message if exists (for logout, password change, etc.) --%>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show">
                                <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <form action="LoginPatient" method="post">
                            <div class="mb-4">
                                <label for="email" class="form-label">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="Enter your email" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Enter your password" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                                    <label class="form-check-label" for="rememberMe">Remember me</label>
                                </div>
                                <a href="forgot-password.jsp" class="forgot-link">Forgot password?</a>
                            </div>
                            
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-login text-white btn-lg">
                                    <i class="bi bi-box-arrow-in-right me-2"></i> Login
                                </button>
                            </div>
                            
                            <div class="divider">
                                <span class="divider-text">New to ClinicPro?</span>
                            </div>
                            
                            <div class="text-center">
                                <p>Don't have an account? <a href="register.jsp" class="register-link">Create one now</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p class="mb-0 text-muted">
                &copy; 2023 ClinicPro | Patient Portal. All rights reserved.
            </p>
            <p class="mb-0 text-muted small mt-2">
                <a href="#" class="text-muted text-decoration-none">Terms of Service</a> | 
                <a href="#" class="text-muted text-decoration-none">Privacy Policy</a>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        });
        
        // Add animation to form elements
        document.querySelectorAll('.form-control').forEach((input, index) => {
            input.style.opacity = '0';
            input.style.transform = 'translateY(10px)';
            input.style.transition = `opacity 0.3s ease ${index * 0.1}s, transform 0.3s ease ${index * 0.1}s`;
            
            setTimeout(() => {
                input.style.opacity = '1';
                input.style.transform = 'translateY(0)';
            }, 100);
        });
        
        // Focus on email field when page loads
        window.onload = function() {
            document.getElementById('email').focus();
        };
    </script>
</body>
</html>