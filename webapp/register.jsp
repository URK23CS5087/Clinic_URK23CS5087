<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        
        .registration-card {
            max-width: 700px;
            margin: 2rem auto;
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .registration-card:hover {
            transform: translateY(-5px);
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            padding: 1.5rem;
            text-align: center;
            border-bottom: none;
        }
        
        .card-header h4 {
            font-weight: 600;
            letter-spacing: 0.5px;
            margin: 0;
        }
        
        .card-body {
            padding: 2.5rem;
            background-color: white;
        }
        
        .form-icon {
            color: var(--primary-color);
            font-size: 1.1rem;
            margin-right: 8px;
        }
        
        .form-label {
            font-weight: 500;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.15);
        }
        
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .alert {
            border-radius: 8px;
        }
        
        .login-link {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .login-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .input-group-text {
            background-color: white;
            border-right: none;
        }
        
        .input-with-icon {
            border-left: none;
        }
        
        .floating-label {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .floating-label label {
            position: absolute;
            top: 0.75rem;
            left: 1rem;
            color: #6c757d;
            transition: all 0.2s;
            pointer-events: none;
            background-color: white;
            padding: 0 0.25rem;
        }
        
        .floating-label input:focus + label,
        .floating-label input:not(:placeholder-shown) + label {
            top: -0.5rem;
            left: 0.75rem;
            font-size: 0.75rem;
            color: var(--primary-color);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="card registration-card">
            <div class="card-header">
                <h4 class="mb-0 text-white"><i class="bi bi-heart-pulse me-2"></i> Patient Registration</h4>
            </div>
            <div class="card-body">
                <%-- Display error message if exists --%>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <%-- Display success message if exists --%>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <form action="RegisterPatient" method="post">
                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <div class="floating-label">
                                <input type="text" class="form-control" name="firstName" id="firstName" placeholder=" " required>
                                <label for="firstName"><i class="bi bi-person form-icon"></i>First Name</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="floating-label">
                                <input type="text" class="form-control" name="lastName" id="lastName" placeholder=" " required>
                                <label for="lastName"><i class="bi bi-person form-icon"></i>Last Name</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="floating-label">
                            <input type="email" class="form-control" name="email" id="email" placeholder=" " required>
                            <label for="email"><i class="bi bi-envelope form-icon"></i>Email Address</label>
                        </div>
                    </div>
                    
                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <div class="floating-label">
                                <input type="password" class="form-control" name="password" id="password" placeholder=" " required>
                                <label for="password"><i class="bi bi-lock form-icon"></i>Password</label>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="floating-label">
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder=" " required>
                                <label for="confirmPassword"><i class="bi bi-lock form-icon"></i>Confirm Password</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-telephone form-icon"></i></span>
                            <input type="tel" class="form-control input-with-icon" name="phone" placeholder="Phone Number">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-calendar form-icon"></i></span>
                            <input type="date" class="form-control input-with-icon" name="dob">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-house form-icon"></i></span>
                            <textarea class="form-control input-with-icon" name="address" rows="2" placeholder="Address"></textarea>
                        </div>
                    </div>
                    
                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-gender-ambiguous form-icon"></i></span>
                                <select class="form-select input-with-icon" name="gender">
                                    <option value="" selected disabled>Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-droplet form-icon"></i></span>
                                <select class="form-select input-with-icon" name="bloodGroup">
                                    <option value="" selected disabled>Blood Group</option>
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="bi bi-person-check me-2"></i> Register Now
                        </button>
                    </div>
                    
                    <div class="divider">
                        <span class="divider-text">Already have an account?</span>
                    </div>
                    
                    <div class="text-center">
                        <a href="login.jsp" class="login-link">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Sign in to your account
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced client-side validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger alert-dismissible fade show';
                alertDiv.innerHTML = `
                    Passwords do not match!
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                `;
                
                const cardBody = document.querySelector('.card-body');
                cardBody.insertBefore(alertDiv, cardBody.firstChild);
                
                // Scroll to the alert
                alertDiv.scrollIntoView({ behavior: 'smooth' });
                
                // Highlight the password fields
                document.querySelector('input[name="password"]').classList.add('is-invalid');
                document.querySelector('input[name="confirmPassword"]').classList.add('is-invalid');
                
                return false;
            }
            return true;
        });
        
        // Remove invalid class when user starts typing
        document.querySelectorAll('input[name="password"], input[name="confirmPassword"]').forEach(input => {
            input.addEventListener('input', function() {
                this.classList.remove('is-invalid');
            });
        });
        
        // Add floating label functionality for all inputs
        document.querySelectorAll('.floating-label input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentNode.querySelector('label').style.color = '#4361ee';
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentNode.querySelector('label').style.color = '#6c757d';
                }
            });
        });
    </script>
</body>
</html>