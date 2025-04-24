package com.clinic.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import com.clinic.util.DBUtil;

@WebServlet("/Appointments")
public class AppointmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");
        
        try (Connection conn = DBUtil.getConnection()) {
            // Get upcoming appointments
            String sql = "SELECT a.*, d.name as doctor_name, d.specialization " +
                         "FROM appointments a JOIN doctorss d ON a.doctor_id = d.doctor_id " +
                         "WHERE a.patient_id = ? AND a.appointment_date >= CURDATE() " +
                         "ORDER BY a.appointment_date, a.start_time";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, patientId);
                ResultSet rs = stmt.executeQuery();
                
                List<Map<String, String>> appointments = new ArrayList<>();
                while (rs.next()) {
                    Map<String, String> appt = new HashMap<>();
                    appt.put("id", rs.getString("appointment_id"));
                    appt.put("date", rs.getString("appointment_date"));
                    appt.put("time", rs.getString("start_time"));
                    appt.put("doctor", rs.getString("doctor_name"));
                    appt.put("specialization", rs.getString("specialization"));
                    appt.put("status", rs.getString("status"));
                    appointments.add(appt);
                }
                request.setAttribute("appointments", appointments);
            }
            
            // Get available doctors for booking
            sql = "SELECT * FROM doctorss";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                
                List<Map<String, String>> doctors = new ArrayList<>();
                while (rs.next()) {
                    Map<String, String> doctor = new HashMap<>();
                    doctor.put("id", rs.getString("doctor_id"));
                    doctor.put("name", rs.getString("name"));
                    doctor.put("specialization", rs.getString("specialization"));
                    doctors.add(doctor);
                }
                request.setAttribute("doctors", doctors);
            }
            
            request.getRequestDispatcher("patientDashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error loading appointments");
            response.sendRedirect("patientDashboard.jsp");
        }
    }
}