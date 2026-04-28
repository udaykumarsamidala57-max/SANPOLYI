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
        	        + "APPNO, cast_no, applicant_name, date_of_birth, gender, Admission_type, "
        	        + "native_place, taluk, district, state, nationality, "
        	        + "religion_category, category, cast, mother_tongue, blood_group, "
        	        + "father_guardian_name, father_occupation, Father_org, "
        	        + "mother_name, mother_occupation, Mother_org, income, "
        	        + "postal_address, permanent_address, phone_no, Whatsapp_no, email, "
        	        + "SSLC_State, aadhar_no, APAAR_ID, "
        	        + "medium_of_instruction, sscl_passing_year, SSLC_Board, SSLC_TMarks, "
        	        + "marks_maths, marks_science, SSLC_Aggr, "
        	        + "preference_1, preference_2, preference_3, preference_4, preference_5"
        	        + ") VALUES ("
        	        + "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?"
        	        + ")";
            PreparedStatement ps = con.prepareStatement(sql);

            int i = 1;

            ps.setString(i++, getVal(request, "APPNO"));
            ps.setString(i++, getVal(request, "cast_no"));
            ps.setString(i++, getVal(request, "applicant_name"));
            ps.setDate(i++, parseDate(request.getParameter("date_of_birth")));
            ps.setString(i++, getVal(request, "gender"));
            ps.setString(i++, getVal(request, "Admission_type"));

            ps.setString(i++, getVal(request, "native_place"));
            ps.setString(i++, getVal(request, "taluk"));
            ps.setString(i++, getVal(request, "district"));
            ps.setString(i++, getVal(request, "state"));
            ps.setString(i++, getVal(request, "nationality"));

            ps.setString(i++, getVal(request, "religion_category"));
            ps.setString(i++, getVal(request, "category"));
            ps.setString(i++, getVal(request, "cast"));
            ps.setString(i++, getVal(request, "mother_tongue"));
            ps.setString(i++, getVal(request, "blood_group"));

            ps.setString(i++, getVal(request, "father_guardian_name"));
            ps.setString(i++, getVal(request, "father_occupation"));
            ps.setString(i++, getVal(request, "Father_org"));

            ps.setString(i++, getVal(request, "mother_name"));
            ps.setString(i++, getVal(request, "mother_occupation"));
            ps.setString(i++, getVal(request, "Mother_org"));

            ps.setDouble(i++, parseDouble(request.getParameter("income")));

            ps.setString(i++, getVal(request, "postal_address"));
            ps.setString(i++, getVal(request, "permanent_address"));
            ps.setString(i++, getVal(request, "phone_no"));
            ps.setString(i++, getVal(request, "Whatsapp_no"));
            ps.setString(i++, getVal(request, "email"));

            ps.setString(i++, getVal(request, "SSLC_State"));
            ps.setString(i++, getVal(request, "aadhar_no"));
            ps.setString(i++, getVal(request, "APAAR_ID"));

            ps.setString(i++, getVal(request, "medium_of_instruction"));
            ps.setInt(i++, parseInt(request.getParameter("sscl_passing_year")));
            ps.setString(i++, getVal(request, "SSLC_Board"));
            ps.setString(i++, getVal(request, "SSLC_TMarks"));

            ps.setDouble(i++, parseDouble(request.getParameter("marks_maths")));
            ps.setDouble(i++, parseDouble(request.getParameter("marks_science")));

            ps.setString(i++, getVal(request, "SSLC_Aggr"));

            ps.setString(i++, getVal(request, "preference_1"));
            ps.setString(i++, getVal(request, "preference_2"));
            ps.setString(i++, getVal(request, "preference_3"));
            ps.setString(i++, getVal(request, "preference_4"));
            ps.setString(i++, getVal(request, "preference_5"));

          

            ps.executeUpdate();

            response.sendRedirect("enquiry_success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String getVal(HttpServletRequest req, String field) {
        String val = req.getParameter(field);
        return (val == null || val.trim().isEmpty()) ? null : val.trim();
    }

    private Date parseDate(String val) {
        try {
            return (val == null || val.isEmpty()) ? null : Date.valueOf(val);
        } catch (Exception e) {
            return null;
        }
    }

    private double parseDouble(String val) {
        try {
            return (val == null || val.isEmpty()) ? 0.0 : Double.parseDouble(val);
        } catch (Exception e) {
            return 0.0;
        }
    }
    private int parseInt(String val) {
        try {
            return (val == null || val.trim().isEmpty()) ? 0 : Integer.parseInt(val);
        } catch (Exception e) {
            return 0;
        }
    }
}
