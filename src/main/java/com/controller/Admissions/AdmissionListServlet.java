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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        List<Map<String, Object>> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DBUtil3.getConnection();

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
                row.put("applicant_name", rs.getString("applicant_name"));
                row.put("date_of_birth", rs.getDate("date_of_birth"));
                row.put("gender", rs.getString("gender"));
                row.put("native_place", rs.getString("native_place"));
                row.put("taluk", rs.getString("taluk"));
                row.put("district", rs.getString("district"));
                row.put("state", rs.getString("state"));
                row.put("nationality", rs.getString("nationality"));
                row.put("religion_category", rs.getString("religion_category"));
                row.put("category", rs.getString("category"));
                row.put("mother_tongue", rs.getString("mother_tongue"));
                row.put("blood_group", rs.getString("blood_group"));
                row.put("father_guardian_name", rs.getString("father_guardian_name"));
                row.put("mother_name", rs.getString("mother_name"));
                row.put("occupation", rs.getString("occupation"));
                row.put("income", rs.getDouble("income"));
                row.put("postal_address", rs.getString("postal_address"));
                row.put("permanent_address", rs.getString("permanent_address"));
                row.put("phone_no", rs.getString("phone_no"));
                row.put("email", rs.getString("email"));
                row.put("aadhar_no", rs.getString("aadhar_no"));
                row.put("medium_of_instruction", rs.getString("medium_of_instruction"));
                row.put("sscl_passing_year", rs.getInt("sscl_passing_year"));
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

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        RequestDispatcher rd = request.getRequestDispatcher("admissionList.jsp");
        rd.forward(request, response);
    }
}