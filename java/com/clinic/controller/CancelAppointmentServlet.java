package com.clinic.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import com.clinic.util.DBUtil;

@WebServlet("/CancelAppointment")
public class CancelAppointmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentId = Integer.parseInt(request.getParameter("id"));
        int patientId = (int) session.getAttribute("patientId");
        
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE appointments SET status = 'CANCELLED' " +
                         "WHERE appointment_id = ? AND patient_id = ? AND status = 'BOOKED'";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, appointmentId);
                stmt.setInt(2, patientId);
                
                if (stmt.executeUpdate() > 0) {
                    session.setAttribute("successMessage", "Appointment cancelled successfully");
                } else {
                    session.setAttribute("errorMessage", "Could not cancel appointment");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error during cancellation");
        }
        
        response.sendRedirect("PatientProfile");
    }
}