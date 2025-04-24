package com.clinic.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import com.clinic.util.DBUtil;

@WebServlet("/BookAppointment")
public class BookAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String date = request.getParameter("appointmentDate");
        String time = request.getParameter("appointmentTime") + ":00"; // Add seconds
        
        try (Connection conn = DBUtil.getConnection()) {
            // Check availability
            if (isSlotAvailable(conn, doctorId, date, time)) {
                // Book appointment
                String sql = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, " +
                            "start_time, end_time, status) VALUES (?, ?, ?, ?, ?, 'BOOKED')";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, patientId);
                    stmt.setInt(2, doctorId);
                    stmt.setString(3, date);
                    stmt.setString(4, time);
                    stmt.setString(5, calculateEndTime(time));
                    
                    if (stmt.executeUpdate() > 0) {
                        session.setAttribute("successMessage", "Appointment booked successfully!");
                    }
                }
            } else {
                session.setAttribute("errorMessage", "Time slot not available!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error during booking");
        }
        
        response.sendRedirect("PatientProfile");
    }

    private boolean isSlotAvailable(Connection conn, int doctorId, String date, String time) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointments " +
                     "WHERE doctor_id = ? AND appointment_date = ? AND start_time = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            stmt.setString(2, date);
            stmt.setString(3, time);
            
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) == 0;
        }
    }

    private String calculateEndTime(String startTime) {
        // Assuming 30-minute appointments
        String[] parts = startTime.split(":");
        int hour = Integer.parseInt(parts[0]);
        int minute = Integer.parseInt(parts[1]);
        minute += 30;
        if (minute >= 60) {
            hour++;
            minute -= 60;
        }
        return String.format("%02d:%02d:00", hour, minute);
    }
}
