<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Profile | ClinicPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a6cf7;
            --secondary-color: #2541b2;
            --accent-color: #ff6b9d;
            --light-color: #f8f9fa;
            --dark-color: #2d3748;
            --success-color: #2ecc71;
            --info-color: #3498db;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --gray-light: #edf2f7;
            --gray-medium: #e2e8f0;
            --text-muted: #718096;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7ff;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 4px 20px rgba(74, 108, 247, 0.2);
            padding: 0.8rem 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
            font-size: 1.3rem;
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 16px 16px 0 0;
            padding: 2.5rem 2rem;
            position: relative;
            overflow: hidden;
        }
        
        .profile-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--accent-color), rgba(255,255,255,0.5));
        }
        
        .profile-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 15px 40px rgba(74, 108, 247, 0.1);
            margin-bottom: 2.5rem;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: white;
        }
        
        .profile-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(74, 108, 247, 0.15);
        }
        
        .info-section {
            border-left: 4px solid var(--primary-color);
            padding: 1.5rem;
            margin-bottom: 2rem;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.03);
        }
        
        .info-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-value {
            color: var(--dark-color);
            font-weight: 400;
            font-size: 1.05rem;
            padding-left: 1rem;
            border-left: 2px solid var(--gray-medium);
            margin-left: 0.5rem;
        }
        
        .btn-edit {
            background: linear-gradient(135deg, var(--accent-color), #ff4785);
            border: none;
            border-radius: 50px;
            padding: 0.7rem 1.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(255, 107, 157, 0.3);
        }
        
        .btn-edit:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 107, 157, 0.4);
        }
        
        .allergy-badge {
            display: inline-block;
            background-color: white;
            color: var(--danger-color);
            padding: 0.4rem 0.9rem;
            margin: 0.3rem;
            border-radius: 50px;
            font-size: 0.8rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #fee2e2;
            transition: all 0.2s ease;
        }
        
        .allergy-badge:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .appointment-card {
            border-radius: 12px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            background-color: white;
            padding: 1.5rem;
        }
        
        .appointment-card:hover {
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transform: translateY(-5px);
        }
        
        .badge-status {
            padding: 0.5rem 0.9rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }
        
        .badge-booked {
            background-color: rgba(74, 108, 247, 0.1);
            color: var(--primary-color);
        }
        
        .badge-completed {
            background-color: rgba(46, 204, 113, 0.1);
            color: var(--success-color);
        }
        
        .badge-cancelled {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger-color);
        }
        
        .section-title {
            position: relative;
            padding-bottom: 0.8rem;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 4px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 4px;
        }
        
        .avatar-container {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3.5rem;
            font-weight: 600;
            margin: -70px auto 1.5rem;
            box-shadow: 0 10px 30px rgba(74, 108, 247, 0.3);
            border: 5px solid white;
        }
        
        .btn-book {
            background: linear-gradient(135deg, var(--accent-color), #ff4785);
            border: none;
            border-radius: 50px;
            padding: 0.8rem 2rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            box-shadow: 0 5px 20px rgba(255, 107, 157, 0.3);
            transition: all 0.3s ease;
        }
        
        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(255, 107, 157, 0.4);
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.8rem 1.2rem;
            border: 1px solid var(--gray-medium);
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(74, 108, 247, 0.15);
        }
        
        .action-btn {
            border-radius: 50px;
            padding: 0.5rem 1.2rem;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
        }
        
        .doctor-avatar {
            width: 40px;
            height: 40px;
            background-color: rgba(74, 108, 247, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-weight: 600;
            margin-right: 0.8rem;
        }
        
        .empty-state {
            padding: 3rem 0;
            text-align: center;
            color: var(--text-muted);
        }
        
        .empty-state-icon {
            font-size: 3rem;
            color: var(--gray-medium);
            margin-bottom: 1rem;
        }
        
        .container-main {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }
        
        .nav-user {
            display: flex;
            align-items: center;
        }
        
        .nav-user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 0.8rem;
        }
        
        .nav-user-name {
            font-weight: 500;
            color: white;
            margin-right: 1rem;
        }
        
        @media (max-width: 768px) {
            .avatar-container {
                width: 100px;
                height: 100px;
                font-size: 2.5rem;
                margin: -50px auto 1rem;
            }
            
            .profile-header {
                padding: 1.5rem 1rem;
            }
            
            .info-section {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-main">
            <a class="navbar-brand d-flex align-items-center" href="PatientProfile">
                <i class="bi bi-heart-pulse me-2"></i>
                <span>ClinicPro</span>
            </a>
            
            <div class="nav-user">
                <div class="nav-user-avatar">
                    ${patient.firstName.charAt(0)}${patient.lastName.charAt(0)}
                </div>
                <span class="nav-user-name">${patient.firstName}</span>
                <a class="btn btn-outline-light btn-sm" href="LogoutPatient">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="container-main py-4">
        <!-- Notifications -->
        <div class="row mb-4">
            <div class="col-12">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="row">
            <!-- Profile Section -->
            <div class="col-lg-4 mb-4">
                <div class="card profile-card h-100">
                    <div class="profile-header text-center">
                        <div class="avatar-container">
                            ${patient.firstName.charAt(0)}${patient.lastName.charAt(0)}
                        </div>
                        <h3 class="mb-1">${patient.firstName} ${patient.lastName}</h3>
                        <p class="mb-0 opacity-75">Patient ID: ${patient.id}</p>
                    </div>
                    
                    <div class="card-body">
                        <div class="d-flex justify-content-end mb-4">
                            <a href="EditProfile" class="btn btn-edit text-white">
                                <i class="bi bi-pencil-square me-1"></i>Edit Profile
                            </a>
                        </div>
                        
                        <!-- Personal Information -->
                        <div class="info-section">
                            <h5 class="section-title">
                                <i class="bi bi-person-vcard me-2"></i>Personal Details
                            </h5>
                            
                            <div class="mb-3">
                                <div class="info-label">Full Name</div>
                                <div class="info-value">${patient.firstName} ${patient.lastName}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Date of Birth</div>
                                <div class="info-value">${patient.dob}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Email</div>
                                <div class="info-value">${patient.email}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Phone</div>
                                <div class="info-value">${patient.phone}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Address</div>
                                <div class="info-value">${patient.address}</div>
                            </div>
                        </div>
                        
                        <!-- Medical Information -->
                        <div class="info-section">
                            <h5 class="section-title">
                                <i class="bi bi-heart-pulse me-2"></i>Medical Info
                            </h5>
                            
                            <div class="mb-3">
                                <div class="info-label">Blood Group</div>
                                <div class="info-value">${patient.bloodGroup}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Allergies</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty patient.allergies}">
                                            <c:forEach items="${patient.allergies.split(',')}" var="allergy">
                                                <span class="allergy-badge">
                                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                                    ${allergy.trim()}
                                                </span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">None recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Emergency Contact -->
                        <div class="info-section">
                            <h5 class="section-title">
                                <i class="bi bi-telephone-plus me-2"></i>Emergency Contact
                            </h5>
                            
                            <div class="mb-3">
                                <div class="info-label">Name</div>
                                <div class="info-value">${patient.emergencyContactName}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Relationship</div>
                                <div class="info-value">${patient.emergencyContactRelation}</div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="info-label">Phone</div>
                                <div class="info-value">${patient.emergencyContactPhone}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Appointments Section -->
            <div class="col-lg-8">
                <!-- Upcoming Appointments -->
                <div class="card profile-card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="section-title mb-0">
                                <i class="bi bi-calendar2-week me-2"></i>My Appointments
                            </h5>
                            <span class="badge bg-light text-dark">
                                ${not empty appointments ? appointments.size() : 0} ${not empty appointments && appointments.size() == 1 ? 'Appointment' : 'Appointments'}
                            </span>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty appointments}">
                                <div class="row">
                                    <c:forEach items="${appointments}" var="appt">
                                        <div class="col-12 mb-3">
                                            <div class="appointment-card">
                                                <div class="row align-items-center">
                                                    <div class="col-md-3">
                                                        <div class="d-flex align-items-center">
                                                            <div class="doctor-avatar">
                                                                ${appt.doctor.charAt(0)}
                                                            </div>
                                                            <div>
                                                                <h6 class="mb-0">Dr. ${appt.doctor}</h6>
                                                                <small class="text-muted">${appt.specialization}</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="text-md-center">
                                                            <div class="text-primary fw-bold">${appt.date}</div>
                                                            <div class="text-muted small">${appt.time}</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <span class="badge-status ${appt.status == 'BOOKED' ? 'badge-booked' : 
                                                                 appt.status == 'CANCELLED' ? 'badge-cancelled' : 'badge-completed'}">
                                                            <c:choose>
                                                                <c:when test="${appt.status == 'BOOKED'}">
                                                                    <i class="bi bi-clock-history me-1"></i>
                                                                </c:when>
                                                                <c:when test="${appt.status == 'CANCELLED'}">
                                                                    <i class="bi bi-x-circle me-1"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="bi bi-check-circle me-1"></i>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            ${appt.status}
                                                        </span>
                                                    </div>
                                                    <div class="col-md-3 text-md-end mt-2 mt-md-0">
                                                        <c:if test="${appt.status == 'BOOKED'}">
                                                            <a href="CancelAppointment?id=${appt.id}" 
                                                               class="btn btn-sm btn-outline-danger action-btn"
                                                               onclick="return confirm('Are you sure you want to cancel this appointment?')">
                                                                <i class="bi bi-x-lg me-1"></i>Cancel
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <div class="empty-state-icon">
                                        <i class="bi bi-calendar-x"></i>
                                    </div>
                                    <h5 class="mb-2">No Appointments</h5>
                                    <p class="text-muted">You don't have any upcoming appointments scheduled.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Book New Appointment -->
                <div class="card profile-card">
                    <div class="card-body">
                        <h5 class="section-title mb-4">
                            <i class="bi bi-plus-circle me-2"></i>Book New Appointment
                        </h5>
                        
                        <form action="BookAppointment" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Select Doctor</label>
                                    <select class="form-select" name="doctorId" required>
                                        <option value="">Choose a doctor...</option>
                                        <c:forEach items="${doctors}" var="doc">
                                            <option value="${doc.id}">Dr. ${doc.name} (${doc.specialization})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">Appointment Date</label>
                                    <input type="date" class="form-control" name="appointmentDate" 
                                           min="<%= java.time.LocalDate.now().plusDays(1) %>" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fw-semibold">Preferred Time</label>
                                    <select class="form-select" name="appointmentTime" required>
                                        <option value="">Select time...</option>
                                        <option value="09:00">9:00 AM</option>
                                        <option value="09:30">9:30 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="10:30">10:30 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="11:30">11:30 AM</option>
                                        <option value="14:00">2:00 PM</option>
                                        <option value="14:30">2:30 PM</option>
                                        <option value="15:00">3:00 PM</option>
                                    </select>
                                </div>
                                <div class="col-12 text-center mt-3">
                                    <button type="submit" class="btn btn-book text-white">
                                        <i class="bi bi-calendar-plus me-1"></i> Book Appointment
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation with better UX
        document.querySelector('form').addEventListener('submit', function(e) {
            const doctorSelect = this.querySelector('[name="doctorId"]');
            if (doctorSelect.value === "") {
                e.preventDefault();
                doctorSelect.focus();
                
                // Create and show a custom toast notification
                const toast = document.createElement('div');
                toast.className = 'position-fixed bottom-0 end-0 p-3';
                toast.style.zIndex = '11';
                
                const toastInner = document.createElement('div');
                toastInner.className = 'toast show align-items-center text-white bg-danger border-0';
                toastInner.role = 'alert';
                toastInner.setAttribute('aria-live', 'assertive');
                toastInner.setAttribute('aria-atomic', 'true');
                
                toastInner.innerHTML = `
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>Please select a doctor
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                `;
                
                toast.appendChild(toastInner);
                document.body.appendChild(toast);
                
                // Auto-remove after 3 seconds
                setTimeout(() => {
                    toast.remove();
                }, 3000);
            }
        });
        
        // Add smooth scrolling to all links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        // Add animation to form elements when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.profile-card, .appointment-card, .info-section');
            elements.forEach((el, index) => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                el.style.transition = `opacity 0.5s ease ${index * 0.1}s, transform 0.5s ease ${index * 0.1}s`;
                
                setTimeout(() => {
                    el.style.opacity = '1';
                    el.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>