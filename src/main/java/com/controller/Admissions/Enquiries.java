package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.Date;
import java.util.*;

import com.bean.DBUtil3;

@WebServlet("/Enquiries")
public class Enquiries extends HttpServlet {

    // ========================= GET =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> list = new ArrayList<>();

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        try (Connection con = DBUtil3.getConnection()) {

            StringBuilder sql = new StringBuilder("SELECT * FROM admission_form WHERE 1=1");

            if (isValid(fromDate) && isValid(toDate)) {
                sql.append(" AND DATE(created_at) BETWEEN ? AND ?");
            }

            PreparedStatement ps = con.prepareStatement(sql.toString());

            if (isValid(fromDate) && isValid(toDate)) {
                ps.setDate(1, Date.valueOf(fromDate));
                ps.setDate(2, Date.valueOf(toDate));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();

                row.put("id", rs.getInt("id"));
                row.put("APPNO", rs.getString("APPNO"));
                row.put("cast_no", rs.getString("cast_no"));
                row.put("applicant_name", rs.getString("applicant_name"));
                row.put("date_of_birth", rs.getDate("date_of_birth"));
                row.put("gender", rs.getString("gender"));
                row.put("Admission_type", rs.getString("Admission_type"));

                row.put("native_place", rs.getString("native_place"));
                row.put("taluk", rs.getString("taluk"));
                row.put("district", rs.getString("district"));
                row.put("state", rs.getString("state"));
                row.put("nationality", rs.getString("nationality"));

                row.put("religion_category", rs.getString("religion_category"));
                row.put("category", rs.getString("category"));
                row.put("cast", rs.getString("cast"));
                row.put("mother_tongue", rs.getString("mother_tongue"));
                row.put("blood_group", rs.getString("blood_group"));

                row.put("father_guardian_name", rs.getString("father_guardian_name"));
                row.put("father_occupation", rs.getString("father_occupation"));
                row.put("Father_org", rs.getString("Father_org"));

                row.put("mother_name", rs.getString("mother_name"));
                row.put("mother_occupation", rs.getString("mother_occupation"));
                row.put("Mother_org", rs.getString("Mother_org"));

                row.put("income", rs.getBigDecimal("income"));

                row.put("postal_address", rs.getString("postal_address"));
                row.put("permanent_address", rs.getString("permanent_address"));

                row.put("phone_no", rs.getString("phone_no"));
                row.put("Whatsapp_no", rs.getString("Whatsapp_no"));
                row.put("email", rs.getString("email"));

                row.put("SSLC_State", rs.getString("SSLC_State"));
                row.put("aadhar_no", rs.getString("aadhar_no"));
                row.put("APAAR_ID", rs.getString("APAAR_ID"));

                row.put("medium_of_instruction", rs.getString("medium_of_instruction"));
                row.put("sscl_passing_year", rs.getString("sscl_passing_year"));

                row.put("SSLC_Board", rs.getString("SSLC_Board"));
                row.put("SSLC_TMarks", rs.getString("SSLC_TMarks"));
                row.put("SSLC_Aggr", rs.getString("SSLC_Aggr"));

                row.put("marks_maths", rs.getBigDecimal("marks_maths"));
                row.put("marks_science", rs.getBigDecimal("marks_science"));

                row.put("preference_1", rs.getString("preference_1"));
                row.put("preference_2", rs.getString("preference_2"));
                row.put("preference_3", rs.getString("preference_3"));
                row.put("preference_4", rs.getString("preference_4"));
                row.put("preference_5", rs.getString("preference_5"));

                row.put("created_at", rs.getTimestamp("created_at"));

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        response.sendRedirect("Enquiries.jsp");
    }

    // ========================= POST (UPDATE) =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

            String sql = "UPDATE admission_form SET "
                    + "APPNO=?, cast_no=?, applicant_name=?, date_of_birth=?, gender=?, Admission_type=?, "
                    + "native_place=?, taluk=?, district=?, state=?, nationality=?, "
                    + "religion_category=?, category=?, cast=?, mother_tongue=?, blood_group=?, "
                    + "father_guardian_name=?, father_occupation=?, Father_org=?, "
                    + "mother_name=?, mother_occupation=?, Mother_org=?, "
                    + "income=?, postal_address=?, permanent_address=?, "
                    + "phone_no=?, Whatsapp_no=?, email=?, SSLC_State=?, "
                    + "aadhar_no=?, APAAR_ID=?, "
                    + "medium_of_instruction=?, sscl_passing_year=?, SSLC_Board=?, SSLC_TMarks=?, SSLC_Aggr=?, "
                    + "marks_maths=?, marks_science=?, "
                    + "preference_1=?, preference_2=?, preference_3=?, preference_4=?, preference_5=? "
                    + "WHERE id=?";

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

            ps.setObject(i++, parseDouble(request.getParameter("income")), Types.DECIMAL);

            ps.setString(i++, getVal(request, "postal_address"));
            ps.setString(i++, getVal(request, "permanent_address"));
            ps.setString(i++, getVal(request, "phone_no"));
            ps.setString(i++, getVal(request, "Whatsapp_no"));
            ps.setString(i++, getVal(request, "email"));
            ps.setString(i++, getVal(request, "SSLC_State"));

            ps.setString(i++, getVal(request, "aadhar_no"));
            ps.setString(i++, getVal(request, "APAAR_ID"));

            ps.setString(i++, getVal(request, "medium_of_instruction"));

            // YEAR FIX
            ps.setObject(i++, parseInt(request.getParameter("sscl_passing_year")), Types.INTEGER);

            ps.setString(i++, getVal(request, "SSLC_Board"));
            ps.setString(i++, getVal(request, "SSLC_TMarks"));
            ps.setString(i++, getVal(request, "SSLC_Aggr"));

            ps.setObject(i++, parseDouble(request.getParameter("marks_maths")), Types.DECIMAL);
            ps.setObject(i++, parseDouble(request.getParameter("marks_science")), Types.DECIMAL);

            ps.setString(i++, getVal(request, "preference_1"));
            ps.setString(i++, getVal(request, "preference_2"));
            ps.setString(i++, getVal(request, "preference_3"));
            ps.setString(i++, getVal(request, "preference_4"));
            ps.setString(i++, getVal(request, "preference_5"));

            ps.setInt(i++, Integer.parseInt(request.getParameter("id")));

            int rows = ps.executeUpdate();
            System.out.println("UPDATED ROWS: " + rows);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdmissionListServlet");
    }

    // ========================= HELPERS =========================

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

    private Double parseDouble(String val) {
        try {
            return (val == null || val.trim().isEmpty()) ? null : Double.parseDouble(val);
        } catch (Exception e) {
            return null;
        }
    }

    private Integer parseInt(String val) {
        try {
            return (val == null || val.trim().isEmpty()) ? null : Integer.parseInt(val);
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isValid(String val) {
        return val != null && !val.trim().isEmpty();
    }
}