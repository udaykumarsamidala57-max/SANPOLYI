package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.Date;
import com.bean.DBUtil3;

@WebServlet("/GiveAdmission")
public class Admission extends HttpServlet {

    // ========================= GET =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection con = DBUtil3.getConnection()) {

        	String sql = "SELECT * FROM admission_form WHERE TRIM(Status_Allot) = 'Confirmed'";

        	if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
        	    sql += " AND DATE(created_at) BETWEEN ? AND ?";
        	}

        	sql += " ORDER BY Seat_Allot ASC, CAST(Total AS DECIMAL(10,2)) DESC";
                    
                   
                    
                    
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

                // Address
                row.put("native_place", rs.getString("native_place"));
                row.put("taluk", rs.getString("taluk"));
                row.put("district", rs.getString("district"));
                row.put("state", rs.getString("state"));
                row.put("nationality", rs.getString("nationality"));

                // Social
                row.put("religion_category", rs.getString("religion_category"));
                row.put("category", rs.getString("category"));
                row.put("cast", rs.getString("cast"));
                row.put("mother_tongue", rs.getString("mother_tongue"));
                row.put("blood_group", rs.getString("blood_group"));

                // Parents
                row.put("father_guardian_name", rs.getString("father_guardian_name"));
                row.put("father_occupation", rs.getString("father_occupation"));
                row.put("Father_org", rs.getString("Father_org"));

                row.put("mother_name", rs.getString("mother_name"));
                row.put("mother_occupation", rs.getString("mother_occupation"));
                row.put("Mother_org", rs.getString("Mother_org"));

                // Contact
                row.put("income", rs.getBigDecimal("income"));
                row.put("postal_address", rs.getString("postal_address"));
                row.put("permanent_address", rs.getString("permanent_address"));
                row.put("phone_no", rs.getString("phone_no"));
                row.put("Whatsapp_no", rs.getString("Whatsapp_no"));
                row.put("Attendance", rs.getString("Attendance"));
                row.put("email", rs.getString("email"));

                // IDs
                row.put("SSLC_State", rs.getString("SSLC_State"));
                row.put("aadhar_no", rs.getString("aadhar_no"));
                row.put("APAAR_ID", rs.getString("APAAR_ID"));

                // Education
                row.put("medium_of_instruction", rs.getString("medium_of_instruction"));
                row.put("sscl_passing_year", rs.getString("sscl_passing_year"));
                row.put("SSLC_Board", rs.getString("SSLC_Board"));
                row.put("SSLC_TMarks", rs.getString("SSLC_TMarks"));
                row.put("SSLC_Aggr", rs.getString("SSLC_Aggr"));

                row.put("marks_maths", rs.getBigDecimal("marks_maths"));
                row.put("marks_science", rs.getBigDecimal("marks_science"));

                // Preferences
                row.put("preference_1", rs.getString("preference_1"));
                row.put("preference_2", rs.getString("preference_2"));
                row.put("preference_3", rs.getString("preference_3"));
                row.put("preference_4", rs.getString("preference_4"));
                row.put("preference_5", rs.getString("preference_5"));

                // Extra Fields (NEW)
                row.put("CBSC_ICSE", rs.getString("CBSC_ICSE"));
                row.put("PUC_SC", rs.getString("PUC_SC"));
                row.put("GIRLS", rs.getString("GIRLS"));

                row.put("ET_m", rs.getString("ET_m"));
                row.put("ET_s", rs.getString("ET_s"));
                row.put("ET_T", rs.getString("ET_T"));

                row.put("Total", rs.getString("Total"));
                row.put("Seat_Allot", rs.getString("Seat_Allot"));
                row.put("Special_Catg", rs.getString("Special_Catg"));
                row.put("Segment", rs.getString("Segment"));
                row.put("Admitted_Status", rs.getString("Admitted_Status"));
                // Timestamp
                row.put("created_at", rs.getTimestamp("created_at"));

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        request.getRequestDispatcher("Admission.jsp").forward(request, response);
   
    }

    


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

            String idStr = request.getParameter("id");
            String status = request.getParameter("status"); // ✅ correct param

            int id = Integer.parseInt(idStr);

            String updateSql = "UPDATE admission_form SET Admitted_Status=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(updateSql);

            ps.setString(1, status); // ✅ only 2 params
            ps.setInt(2, id);

            ps.executeUpdate();

            response.getWriter().write("OK");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }

}
