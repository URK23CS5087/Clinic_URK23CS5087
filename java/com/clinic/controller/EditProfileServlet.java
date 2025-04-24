package com.clinic.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Map;
import com.clinic.util.DBUtil;

@WebServlet("/EditProfile")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");
        
        // Get and sanitize parameters
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
        String bloodGroup = request.getParameter("bloodGroup") != null ? request.getParameter("bloodGroup").trim() : "";
        String allergies = request.getParameter("allergies") != null ? 
                         request.getParameter("allergies").trim().replaceAll("\\s*,\\s*", ",") : "";
        String emergencyContactName = request.getParameter("emergencyContactName") != null ? 
                                    request.getParameter("emergencyContactName").trim() : "";
        String emergencyContactRelation = request.getParameter("emergencyContactRelation") != null ? 
                                        request.getParameter("emergencyContactRelation").trim() : "";
        String emergencyContactPhone = request.getParameter("emergencyContactPhone") != null ? 
                                     request.getParameter("emergencyContactPhone").trim() : "";

        // Validate required fields
        if (phone.isEmpty() || address.isEmpty()) {
            session.setAttribute("errorMessage", "Phone and Address are required");
            response.sendRedirect(request.getContextPath() + "/editProfile.jsp");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(true); // Ensure auto-commit is enabled
            
            String sql = "UPDATE patientss SET phone=?, address=?, blood_group=?, allergies=?, " +
                        "emergency_contact_name=?, emergency_contact_relation=?, " +
                        "emergency_contact_phone=?, last_updated=CURRENT_TIMESTAMP " +
                        "WHERE patient_id=?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, phone);
                stmt.setString(2, address);
                stmt.setString(3, bloodGroup);
                stmt.setString(4, allergies);
                stmt.setString(5, emergencyContactName);
                stmt.setString(6, emergencyContactRelation);
                stmt.setString(7, emergencyContactPhone);
                stmt.setInt(8, patientId);

                int rowsUpdated = stmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    updateSessionData(session, phone, address, bloodGroup, allergies,
                                    emergencyContactName, emergencyContactRelation,
                                    emergencyContactPhone);
                    session.setAttribute("successMessage", "Profile updated successfully!");
                } else {
                    session.setAttribute("errorMessage", "No changes were made");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/PatientProfile");
    }

    private void updateSessionData(HttpSession session, String phone, String address,
                                 String bloodGroup, String allergies,
                                 String emergencyContactName, 
                                 String emergencyContactRelation,
                                 String emergencyContactPhone) {
        @SuppressWarnings("unchecked")
        Map<String, String> patient = (Map<String, String>) session.getAttribute("patient");
        if (patient != null) {
            patient.put("phone", phone);
            patient.put("address", address);
            patient.put("bloodGroup", bloodGroup);
            patient.put("allergies", allergies);
            patient.put("emergencyContactName", emergencyContactName);
            patient.put("emergencyContactRelation", emergencyContactRelation);
            patient.put("emergencyContactPhone", emergencyContactPhone);
        }
    }
}