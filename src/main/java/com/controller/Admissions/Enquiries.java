package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.Date;
import com.bean.DBUtil3;

@WebServlet("/Enquiries")
public class Enquiries extends HttpServlet {

    // ========================= GET =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection con = DBUtil3.getConnection()) {

            String sql = "SELECT * FROM admission_form WHERE 1=1";

            PreparedStatement ps;

            if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
                sql += " AND DATE(created_at) BETWEEN ? AND ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, fromDate);
                ps.setString(2, toDate);
            } else {
                ps = con.prepareStatement(sql);
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
        request.getRequestDispatcher("Enquiries.jsp").forward(request, response);
   
    }

    // ========================= POST (UPDATE) =========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try (Connection con = DBUtil3.getConnection()) {

        	String sql = "UPDATE admission_form SET " +
        	        "APPNO=?, cast_no=?, applicant_name=?, date_of_birth=?, gender=?, Admission_type=?, " +

        	        "father_guardian_name=?, father_occupation=?, Father_org=?, " +
        	        "mother_name=?, mother_occupation=?, Mother_org=?, " +

        	        "income=?, phone_no=?, Whatsapp_no=?, email=?, " +

        	        "SSLC_State=?, aadhar_no=?, APAAR_ID=?, " +

        	        "medium_of_instruction=?, sscl_passing_year=?, SSLC_Board=?, SSLC_TMarks=?, SSLC_Aggr=?, " +
        	        "marks_maths=?, marks_science=?, " +

        	        "preference_1=?, preference_2=?, preference_3=?, preference_4=?, preference_5=? " +

        	        "WHERE id=?";

        	PreparedStatement ps = con.prepareStatement(sql);
        	int i = 1;

        	// BASIC
        	ps.setString(i++, request.getParameter("APPNO"));
        	ps.setString(i++, request.getParameter("cast_no"));
        	ps.setString(i++, request.getParameter("applicant_name"));

        	// DATE
        	String dob = request.getParameter("date_of_birth");
        	if (dob != null && !dob.isEmpty())
        	    ps.setDate(i++, Date.valueOf(dob));
        	else
        	    ps.setNull(i++, Types.DATE);

        	ps.setString(i++, request.getParameter("gender"));
        	ps.setString(i++, request.getParameter("Admission_type"));

        	// PARENTS
        	ps.setString(i++, request.getParameter("father_guardian_name"));
        	ps.setString(i++, request.getParameter("father_occupation"));
        	ps.setString(i++, request.getParameter("Father_org"));

        	ps.setString(i++, request.getParameter("mother_name"));
        	ps.setString(i++, request.getParameter("mother_occupation"));
        	ps.setString(i++, request.getParameter("Mother_org"));

        	// CONTACT
        	ps.setObject(i++, parseDouble(request.getParameter("income")), Types.DECIMAL);
        	ps.setString(i++, request.getParameter("phone_no"));
        	ps.setString(i++, request.getParameter("Whatsapp_no"));
        	ps.setString(i++, request.getParameter("email"));

        	// EDUCATION
        	ps.setString(i++, request.getParameter("SSLC_State"));
        	ps.setString(i++, request.getParameter("aadhar_no"));
        	ps.setString(i++, request.getParameter("APAAR_ID"));

        	ps.setString(i++, request.getParameter("medium_of_instruction"));
        	ps.setObject(i++, parseInt(request.getParameter("sscl_passing_year")), Types.INTEGER);

        	ps.setString(i++, request.getParameter("SSLC_Board"));
        	ps.setString(i++, request.getParameter("SSLC_TMarks"));
        	ps.setString(i++, request.getParameter("SSLC_Aggr"));

        	ps.setObject(i++, parseDouble(request.getParameter("marks_maths")), Types.DECIMAL);
        	ps.setObject(i++, parseDouble(request.getParameter("marks_science")), Types.DECIMAL);

        	// PREFERENCES
        	ps.setString(i++, request.getParameter("preference_1"));
        	ps.setString(i++, request.getParameter("preference_2"));
        	ps.setString(i++, request.getParameter("preference_3"));
        	ps.setString(i++, request.getParameter("preference_4"));
        	ps.setString(i++, request.getParameter("preference_5"));

        	// WHERE
        	ps.setInt(i++, Integer.parseInt(request.getParameter("id")));

            int rows = ps.executeUpdate();
            System.out.println("UPDATED ROWS: " + rows);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdmissionListServlet");
    }

    // ========================= HELPERS =========================

    private Double parseDouble(String val) {
        try {
            if (val == null || val.trim().isEmpty()) return null;
            return Double.parseDouble(val);
        } catch (Exception e) {
            return null;
        }
    }

    private Integer parseInt(String val) {
        try {
            if (val == null || val.trim().isEmpty()) return null;
            return Integer.parseInt(val);
        } catch (Exception e) {
            return null;
        }
    }
}