<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
        }
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .profile-card {
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }
        .section-title {
            border-left: 4px solid var(--secondary-color);
            padding-left: 10px;
        }
        /* Allergy Styles */
        .allergy-badge {
            display: inline-block;
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 4px 10px;
            margin: 2px;
            border-radius: 15px;
            font-size: 0.85rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .allergy-input-group {
            position: relative;
        }
        .allergy-input-group .btn-add {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: var(--secondary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .allergy-input-group .btn-add:hover {
            background: var(--primary-color);
        }
        .allergies-container {
            min-height: 40px;
            border: 1px dashed #ddd;
            border-radius: 5px;
            padding: 5px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
        <div class="container">
            <a class="navbar-brand" href="patientDashboard.jsp">
                <i class="bi bi-heart-pulse me-2"></i>ClinicPro
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card profile-card mb-5">
                    <div class="card-header text-white">
                        <h4><i class="bi bi-pencil-square me-2"></i>Edit Profile</h4>
                    </div>
                    
                    <div class="card-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger">${errorMessage}</div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success">${successMessage}</div>
                        </c:if>
                        
                        <form action="EditProfile" method="post" id="profileForm">
                            <!-- Personal Information -->
                            <h5 class="mb-3 section-title">Personal Information</h5>
                            <div class="row mb-3">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="phone" 
                                           value="${patient.phone}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Address <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="address" 
                                           value="${patient.address}" required>
                                </div>
                            </div>
                            
                            <!-- Medical Information -->
                            <h5 class="mb-3 section-title">Medical Information</h5>
                            <div class="row mb-3">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Blood Group</label>
                                    <select class="form-select" name="bloodGroup">
                                        <option value="">Select Blood Group</option>
                                        <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                        <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                                    </select>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Allergies</label>
                                    <div class="allergy-input-group">
                                        <input type="text" class="form-control" id="newAllergy" 
                                               placeholder="Add allergy (e.g., Peanuts)">
                                        <button type="button" class="btn-add" id="addAllergyBtn">
                                            <i class="bi bi-plus"></i>
                                        </button>
                                    </div>
                                    <div class="allergies-container" id="allergiesTags">
                                        <!-- Existing allergies will appear here as badges -->
                                    </div>
                                    <input type="hidden" name="allergies" id="allergiesInput" 
                                           value="${patient.allergies}">
                                    <small class="text-muted">Add multiple allergies one by one</small>
                                </div>
                            </div>
                            
                            <!-- Emergency Contact -->
                            <h5 class="mb-3 section-title">Emergency Contact</h5>
                            <div class="row mb-3">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" name="emergencyContactName" 
                                           value="${patient.emergencyContactName}">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Relationship</label>
                                    <input type="text" class="form-control" name="emergencyContactRelation" 
                                           value="${patient.emergencyContactRelation}">
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="text" class="form-control" name="emergencyContactPhone" 
                                           value="${patient.emergencyContactPhone}">
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-between mt-4">
                                <a href="PatientProfile" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-circle me-1"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i> Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const allergiesInput = document.getElementById('allergiesInput');
            const allergiesTags = document.getElementById('allergiesTags');
            const newAllergyInput = document.getElementById('newAllergy');
            const addAllergyBtn = document.getElementById('addAllergyBtn');
            const profileForm = document.getElementById('profileForm');
            
            // Initialize with existing allergies
            function initializeAllergies() {
                if (allergiesInput.value) {
                    const allergies = allergiesInput.value.split(',');
                    allergies.forEach(allergy => {
                        const trimmedAllergy = allergy.trim();
                        if (trimmedAllergy) {
                            addAllergyTag(trimmedAllergy);
                        }
                    });
                }
            }
            
            // Add new allergy
            function addAllergy() {
                const allergy = newAllergyInput.value.trim();
                if (allergy) {
                    if (!isDuplicateAllergy(allergy)) {
                        addAllergyTag(allergy);
                        newAllergyInput.value = '';
                        updateHiddenInput();
                    } else {
                        alert('This allergy is already added');
                    }
                }
            }
            
            // Check for duplicate allergies
            function isDuplicateAllergy(allergy) {
                const tags = allergiesTags.querySelectorAll('.allergy-badge');
                return Array.from(tags).some(tag => 
                    tag.textContent.toLowerCase() === allergy.toLowerCase()
                );
            }
            
            // Add allergy tag to display
            function addAllergyTag(allergy) {
                const tag = document.createElement('span');
                tag.className = 'allergy-badge';
                tag.innerHTML = `${allergy} <span class="ms-2" style="cursor:pointer">&times;</span>`;
                tag.querySelector('span').addEventListener('click', function() {
                    tag.remove();
                    updateHiddenInput();
                });
                allergiesTags.appendChild(tag);
            }
            
            // Update hidden input value
            function updateHiddenInput() {
                const tags = allergiesTags.querySelectorAll('.allergy-badge');
                const allergies = Array.from(tags).map(tag => 
                    tag.textContent.replace('×', '').trim()
                );
                allergiesInput.value = allergies.join(',');
            }
            
            // Form validation
            profileForm.addEventListener('submit', function(e) {
                const requiredFields = profileForm.querySelectorAll('[required]');
                let isValid = true;
                
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        field.classList.add('is-invalid');
                        isValid = false;
                    } else {
                        field.classList.remove('is-invalid');
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    alert('Please fill all required fields');
                }
            });
            
            // Initialize
            initializeAllergies();
            addAllergyBtn.addEventListener('click', addAllergy);
            newAllergyInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    addAllergy();
                }
            });
        });
    </script>
</body>
</html>