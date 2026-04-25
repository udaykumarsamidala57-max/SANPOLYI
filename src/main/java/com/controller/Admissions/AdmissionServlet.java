package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bean.DBUtil3;

@WebServlet("/AdmissionServlet")
public class AdmissionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

        	String sql = "INSERT INTO admission_form ("
        	        + "applicant_name, date_of_birth, gender, Admission_type, "
        	        + "native_place, taluk, district, state, nationality, "
        	        + "religion_category, category, cast, mother_tongue, blood_group, "
        	        + "father_guardian_name, father_occupation, Father_org, "
        	        + "mother_name, mother_occupation, Mother_org, income, "
        	        + "postal_address, permanent_address, phone_no, Whatsapp_no, email, aadhar_no, `APAAR ID`, "
        	        + "medium_of_instruction, sscl_passing_year, SSLC_Board, SSLC_TMarks, "
        	        + "marks_maths, marks_science, "
        	        + "preference_1, preference_2, preference_3, preference_4, preference_5"
        	        + ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        	PreparedStatement ps = con.prepareStatement(sql);

        	ps.setString(1, request.getParameter("applicant_name"));
        	ps.setDate(2, Date.valueOf(request.getParameter("date_of_birth")));
        	ps.setString(3, request.getParameter("gender"));
        	ps.setString(4, request.getParameter("Admission_type"));

        	ps.setString(5, request.getParameter("native_place"));
        	ps.setString(6, request.getParameter("taluk"));
        	ps.setString(7, request.getParameter("district"));
        	ps.setString(8, request.getParameter("state"));
        	ps.setString(9, request.getParameter("nationality"));

        	ps.setString(10, request.getParameter("religion_category"));
        	ps.setString(11, request.getParameter("category"));
        	ps.setString(12, request.getParameter("cast"));
        	ps.setString(13, request.getParameter("mother_tongue"));
        	ps.setString(14, request.getParameter("blood_group"));

        	ps.setString(15, request.getParameter("father_guardian_name"));
        	ps.setString(16, request.getParameter("father_occupation"));
        	ps.setString(17, request.getParameter("Father_org"));
        	ps.setString(18, request.getParameter("mother_name"));
        	ps.setString(19, request.getParameter("mother_occupation"));
        	ps.setString(20, request.getParameter("Mother_org"));

        	ps.setDouble(21, parseDouble(request.getParameter("income")));

        	ps.setString(22, request.getParameter("postal_address"));
        	ps.setString(23, request.getParameter("permanent_address"));
        	ps.setString(24, request.getParameter("phone_no"));
        	ps.setString(25, request.getParameter("Whatsapp_no"));   // ✅ FIXED
        	ps.setString(26, request.getParameter("email"));
        	ps.setString(27, request.getParameter("aadhar_no"));
        	ps.setString(28, request.getParameter("APAAR"));

        	ps.setString(29, request.getParameter("medium_of_instruction"));
        	ps.setString(30, request.getParameter("sscl_passing_year"));

        	ps.setString(31, request.getParameter("SSLC_Board"));
        	ps.setString(32, request.getParameter("SSLC_TMarks"));

        	ps.setDouble(33, parseDouble(request.getParameter("marks_maths")));
        	ps.setDouble(34, parseDouble(request.getParameter("marks_science")));

        	ps.setString(35, request.getParameter("preference_1"));
        	ps.setString(36, request.getParameter("preference_2"));
        	ps.setString(37, request.getParameter("preference_3"));
        	ps.setString(38, request.getParameter("preference_4"));
        	ps.setString(39, request.getParameter("preference_5"));

            ps.executeUpdate();

            response.sendRedirect("enquiry_success.jsp"); // better than println

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // 🔥 helper methods (avoid crash)
    private int parseInt(String val) {
        try { return Integer.parseInt(val); } catch (Exception e) { return 0; }
    }

    private double parseDouble(String val) {
        try { return Double.parseDouble(val); } catch (Exception e) { return 0.0; }
    }
}