package com.clinic.controller;

import java.io.IOException;
import java.sql.*;
import com.clinic.util.DBUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterPatient")
public class RegisterPatient extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get all form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String bloodGroup = request.getParameter("bloodGroup");
        
        // Basic validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (firstName == null || firstName.isEmpty() || 
            email == null || email.isEmpty() ||
            password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Required fields are missing");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            
            // Check if email exists
            String checkSql = "SELECT email FROM patientss WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("errorMessage", "Email already registered");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            // Insert new patient
            String insertSql = "INSERT INTO patientss (first_name, last_name, email, password, " +
                             "phone, date_of_birth, address, gender, blood_group) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, phone);
            pstmt.setString(6, dob);
            pstmt.setString(7, address);
            pstmt.setString(8, gender);
            pstmt.setString(9, bloodGroup);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                // Registration successful - redirect to login with success message
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "System error: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}