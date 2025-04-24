package com.clinic.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import com.clinic.util.DBUtil;

@WebServlet("/PatientProfile")
public class PatientProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");
        
        try (Connection conn = DBUtil.getConnection()) {
            // Load patient data
            Map<String, String> patient = loadPatientData(conn, patientId);
            session.setAttribute("patient", patient);

            // Load appointments
            List<Map<String, String>> appointments = loadAppointments(conn, patientId);
            request.setAttribute("appointments", appointments);

            // Load doctors
            List<Map<String, String>> doctors = loadDoctors(conn);
            request.setAttribute("doctors", doctors);

            request.getRequestDispatcher("PatientProfile.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Database error");
            response.sendRedirect("login.jsp");
        }
    }

    private Map<String, String> loadPatientData(Connection conn, int patientId) throws SQLException {
        String sql = "SELECT * FROM patientss WHERE patient_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Map<String, String> patient = new HashMap<>();
                // Basic Info
                patient.put("patientId", rs.getString("patient_id"));
                patient.put("firstName", rs.getString("first_name"));
                patient.put("lastName", rs.getString("last_name"));
                patient.put("email", rs.getString("email"));
                patient.put("phone", rs.getString("phone"));
                patient.put("dob", rs.getString("date_of_birth"));
                patient.put("address", rs.getString("address"));
                patient.put("gender", rs.getString("gender"));
                // Medical Info
                patient.put("bloodGroup", rs.getString("blood_group"));
                patient.put("allergies", rs.getString("allergies") != null ? 
                           rs.getString("allergies").replaceAll("\\s*,\\s*", ",") : "");
                // Emergency Contact
                patient.put("emergencyContactName", rs.getString("emergency_contact_name"));
                patient.put("emergencyContactRelation", rs.getString("emergency_contact_relation"));
                patient.put("emergencyContactPhone", rs.getString("emergency_contact_phone"));
                return patient;
            }
        }
        return null;
    }

    private List<Map<String, String>> loadAppointments(Connection conn, int patientId) throws SQLException {
        String sql = "SELECT a.*, d.name as doctor_name, d.specialization " +
                     "FROM appointments a JOIN doctorss d ON a.doctor_id = d.doctor_id " +
                     "WHERE a.patient_id = ? AND a.appointment_date >= CURDATE() " +
                     "ORDER BY a.appointment_date, a.start_time";
        
        List<Map<String, String>> appointments = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, String> appt = new HashMap<>();
                appt.put("id", rs.getString("appointment_id"));
                appt.put("date", rs.getString("appointment_date"));
                appt.put("time", rs.getString("start_time").substring(0, 5)); // HH:MM format
                appt.put("doctor", rs.getString("doctor_name"));
                appt.put("specialization", rs.getString("specialization"));
                appt.put("status", rs.getString("status"));
                appointments.add(appt);
            }
        }
        return appointments;
    }

    private List<Map<String, String>> loadDoctors(Connection conn) throws SQLException {
        String sql = "SELECT * FROM doctorss";
        List<Map<String, String>> doctorss = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, String> doctor = new HashMap<>();
                doctor.put("id", rs.getString("doctor_id"));
                doctor.put("name", rs.getString("name"));
                doctor.put("specialization", rs.getString("specialization"));
                doctorss.add(doctor);
            }
        }
        return doctorss;
    }
}