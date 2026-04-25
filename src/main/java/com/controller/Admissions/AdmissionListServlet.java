package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bean.DBUtil3;

@WebServlet("/AdmissionListServlet")
public class AdmissionListServlet extends HttpServlet {
	
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String fromDate = request.getParameter("fromDate");
	    String toDate = request.getParameter("toDate");

	    List<Map<String, Object>> list = new ArrayList<>();

	    try (Connection con = DBUtil3.getConnection()) {

	        String sql = "SELECT *, `APAAR ID` AS apaar_id FROM admission_form WHERE 1=1";

	        PreparedStatement ps;

	        if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
	            sql += " AND DATE(created_at) BETWEEN ? AND ?";
	            ps = con.prepareStatement(sql);
	            ps.setString(1, fromDate);
	            ps.setString(2, toDate);
	        } else {
	            ps = con.prepareStatement(sql);
	        }

	        try (ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {

	                Map<String, Object> row = new HashMap<>();

	                row.put("id", rs.getInt("id"));
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

	                row.put("income", rs.getDouble("income"));

	                row.put("postal_address", rs.getString("postal_address"));
	                row.put("permanent_address", rs.getString("permanent_address"));

	                row.put("phone_no", rs.getString("phone_no"));
	                row.put("email", rs.getString("email"));
	                row.put("aadhar_no", rs.getString("aadhar_no"));
	                row.put("apaar_id", rs.getString("apaar_id")); // ✅ alias used

	                row.put("medium_of_instruction", rs.getString("medium_of_instruction"));
	                row.put("sscl_passing_year", rs.getString("sscl_passing_year"));

	                row.put("SSLC_Board", rs.getString("SSLC_Board"));
	                row.put("SSLC_TMarks", rs.getString("SSLC_TMarks"));

	                row.put("marks_maths", rs.getDouble("marks_maths"));
	                row.put("marks_science", rs.getDouble("marks_science"));

	                row.put("preference_1", rs.getString("preference_1"));
	                row.put("preference_2", rs.getString("preference_2"));
	                row.put("preference_3", rs.getString("preference_3"));
	                row.put("preference_4", rs.getString("preference_4"));
	                row.put("preference_5", rs.getString("preference_5"));

	                row.put("created_at", rs.getTimestamp("created_at"));

	                list.add(row);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    request.setAttribute("data", list);
	    RequestDispatcher rd = request.getRequestDispatcher("admissionList.jsp");
	    rd.forward(request, response);
	}
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try (Connection con = DBUtil3.getConnection()) {
            String sql = "UPDATE admission_form SET applicant_name=?, date_of_birth=?, gender=?, native_place=?, taluk=?, district=?, state=?, nationality=?, religion_category=?, category=?, mother_tongue=?, blood_group=?, father_guardian_name=?, mother_name=?, occupation=?, income=?, postal_address=?, permanent_address=?, phone_no=?, email=?, aadhar_no=?, medium_of_instruction=?, sscl_passing_year=?, marks_maths=?, marks_science=?, preference_1=?, preference_2=?, preference_3=?, preference_4=?, preference_5=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, request.getParameter("applicant_name"));
            ps.setDate(2, java.sql.Date.valueOf(request.getParameter("date_of_birth")));
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
            ps.setDouble(16, Double.parseDouble(request.getParameter("income")));
            ps.setString(17, request.getParameter("postal_address"));
            ps.setString(18, request.getParameter("permanent_address"));
            ps.setString(19, request.getParameter("phone_no"));
            ps.setString(20, request.getParameter("email"));
            ps.setString(21, "[Redacted]"); // Aadhaar masked for security
            ps.setString(22, request.getParameter("medium_of_instruction"));
            ps.setInt(23, Integer.parseInt(request.getParameter("sscl_passing_year")));
            ps.setDouble(24, Double.parseDouble(request.getParameter("marks_maths")));
            ps.setDouble(25, Double.parseDouble(request.getParameter("marks_science")));
            ps.setString(26, request.getParameter("preference_1"));
            ps.setString(27, request.getParameter("preference_2"));
            ps.setString(28, request.getParameter("preference_3"));
            ps.setString(29, request.getParameter("preference_4"));
            ps.setString(30, request.getParameter("preference_5"));
            ps.setString(31, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        response.sendRedirect("AdmissionListServlet");
    }
}