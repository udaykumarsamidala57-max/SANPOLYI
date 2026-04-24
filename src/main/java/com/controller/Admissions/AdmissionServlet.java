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

            String sql = "INSERT INTO admission_form "
                    + "(applicant_name, date_of_birth, gender, native_place, taluk, district, state, nationality, "
                    + "religion_category, category, mother_tongue, blood_group, father_guardian_name, mother_name, "
                    + "occupation, income, postal_address, permanent_address, phone_no, email, aadhar_no, "
                    + "medium_of_instruction, sscl_passing_year, marks_maths, marks_science, "
                    + "preference_1, preference_2, preference_3, preference_4, preference_5) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, request.getParameter("applicant_name"));
            ps.setDate(2, Date.valueOf(request.getParameter("date_of_birth"))); // FIXED
            ps.setString(3, request.getParameter("gender"));
            ps.setString(4, request.getParameter("native_place"));
            ps.setString(5, request.getParameter("taluk"));
            ps.setString(6, request.getParameter("district"));
            ps.setString(7, request.getParameter("state"));
            ps.setString(8, request.getParameter("nationality"));
            ps.setString(9, request.getParameter("religion_category"));
            ps.setString(10, request.getParameter("category"));
            ps.setString(11, request.getParameter("mother_tongue"));
            ps.setString(12, request.getParameter("blood_group"));
            ps.setString(13, request.getParameter("father_guardian_name"));
            ps.setString(14, request.getParameter("mother_name"));
            ps.setString(15, request.getParameter("occupation"));

            ps.setDouble(16, parseDouble(request.getParameter("income"))); // SAFE
            ps.setString(17, request.getParameter("postal_address"));
            ps.setString(18, request.getParameter("permanent_address"));
            ps.setString(19, request.getParameter("phone_no"));
            ps.setString(20, request.getParameter("email"));
            ps.setString(21, request.getParameter("aadhar_no"));
            ps.setString(22, request.getParameter("medium_of_instruction"));

            ps.setInt(23, parseInt(request.getParameter("sscl_passing_year"))); // SAFE
            ps.setDouble(24, parseDouble(request.getParameter("marks_maths")));
            ps.setDouble(25, parseDouble(request.getParameter("marks_science")));

            ps.setString(26, request.getParameter("preference_1"));
            ps.setString(27, request.getParameter("preference_2"));
            ps.setString(28, request.getParameter("preference_3"));
            ps.setString(29, request.getParameter("preference_4"));
            ps.setString(30, request.getParameter("preference_5"));

            ps.executeUpdate();

            response.sendRedirect("success.jsp"); // better than println

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