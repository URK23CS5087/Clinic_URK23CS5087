package com.clinic.controller;

import java.io.IOException;
import java.sql.*;

import com.clinic.util.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginPatient")
public class LoginPatient extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT patient_id FROM patientss WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("patientId", rs.getInt("patient_id"));
                response.sendRedirect("PatientProfile"); // Redirect to profile servlet
            } else {
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    private void updateLastLogin(Connection conn, int patientId) throws SQLException {
        String sql = "UPDATE patientss SET last_login = NOW() WHERE patient_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, patientId);
        pstmt.executeUpdate();
    }
}