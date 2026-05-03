package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedReader;
import com.bean.DBUtil3;

@WebServlet("/Marks")
public class Marks extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ============================
    // 🔹 GET → LOAD TABLE DATA
    // ============================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> list = new ArrayList<>();

        try (Connection con = DBUtil3.getConnection()) {

        	String sql = "SELECT id,APPNO,cast_no, applicant_name,gender,Attendance,SSLC_Board, marks_maths, marks_science, SSLC_Aggr, " +
                    "CBSC_ICSE AS board, PUC_SC AS puc, GIRLS, ET_m, ET_s, ET_T, Total " +
                    "FROM admission_form ORDER BY APPNO ASC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, String> row = new HashMap<>();

                row.put("id", safe(rs.getString("id")));
                row.put("APPNO", safe(rs.getString("APPNO")));
                row.put("cast_no", safe(rs.getString("cast_no")));
                row.put("name", safe(rs.getString("applicant_name")));
                row.put("gender", safe(rs.getString("gender")));
                row.put("Attendance", safe(rs.getString("Attendance")));
                row.put("SSLC_Board", safe(rs.getString("SSLC_Board")));
                row.put("maths", safe(rs.getString("marks_maths")));
                row.put("science", safe(rs.getString("marks_science")));
                row.put("aggr", safe(rs.getString("SSLC_Aggr")));
                row.put("board", safe(rs.getString("board")));
                row.put("puc", safe(rs.getString("puc")));
                row.put("girls", safe(rs.getString("GIRLS")));
                row.put("ET_m", safe(rs.getString("ET_m")));
                row.put("ET_s", safe(rs.getString("ET_s")));
                row.put("ET_T", safe(rs.getString("ET_T")));
                row.put("Total", safe(rs.getString("Total")));
                

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();  // already good
            System.out.println("ERROR in GET: " + e.getMessage());
        }

        request.setAttribute("data", list);
        request.getRequestDispatcher("Marksentry.jsp").forward(request, response);
    }

    // ============================
    // 🔹 POST → UPDATE RECORD
    // ============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String contentType = request.getContentType();

        try (Connection con = DBUtil3.getConnection()) {

            String sql = "UPDATE admission_form SET " +
                    "marks_maths=?, marks_science=?, SSLC_Aggr=?, " +
                    "CBSC_ICSE=?, PUC_SC=?, GIRLS=?, Attendance=?, " +
                    "ET_m=?, ET_s=?, ET_T=?, Total=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            // ============================
            // 🔴 BULK UPDATE (JSON)
            // ============================
            if (contentType != null && contentType.contains("application/json")) {

                StringBuilder sb = new StringBuilder();
                String line;

                try (BufferedReader reader = request.getReader()) {
                    while ((line = reader.readLine()) != null) {
                        sb.append(line);
                    }
                }

                String jsonData = sb.toString();

                org.json.JSONArray arr = new org.json.JSONArray(jsonData);

                for (int i = 0; i < arr.length(); i++) {

                    org.json.JSONObject obj = arr.getJSONObject(i);

                    ps.setBigDecimal(1, getDecimal(obj.optString("maths")));
                    ps.setBigDecimal(2, getDecimal(obj.optString("science")));
                    ps.setString(3, ""); // aggregate already calculated in UI
                    ps.setString(4, safe(obj.optString("board")));
                    ps.setString(5, safe(obj.optString("puc")));
                    ps.setString(6, safe(obj.optString("girls")));
                    ps.setString(7, safe(obj.optString("Attendance")));
                    ps.setString(8, safe(obj.optString("ET_m")));
                    ps.setString(9, safe(obj.optString("ET_s")));
                    ps.setString(10, safe(obj.optString("ET_T")));
                    ps.setString(11, safe(obj.optString("Total")));
                    ps.setInt(12, Integer.parseInt(obj.getString("id")));

                    ps.addBatch();
                }

                int[] result = ps.executeBatch();
                System.out.println("Bulk updated rows: " + result.length);

                response.setStatus(HttpServletResponse.SC_OK);
                return; // 🔴 IMPORTANT: stop here
            }

            // ============================
            // 🔵 SINGLE ROW UPDATE
            // ============================

            ps.setBigDecimal(1, getDecimal(request.getParameter("maths")));
            ps.setBigDecimal(2, getDecimal(request.getParameter("science")));
            ps.setString(3, safe(request.getParameter("aggr")));
            ps.setString(4, safe(request.getParameter("board")));
            ps.setString(5, safe(request.getParameter("puc")));
            ps.setString(6, safe(request.getParameter("girls")));
            ps.setString(7, safe(request.getParameter("Attendance")));
            ps.setString(8, safe(request.getParameter("ET_m")));
            ps.setString(9, safe(request.getParameter("ET_s")));
            ps.setString(10, safe(request.getParameter("ET_T")));
            ps.setString(11, safe(request.getParameter("Total")));
            ps.setInt(12, Integer.parseInt(request.getParameter("id")));

            int rows = ps.executeUpdate();
            System.out.println("Single updated rows: " + rows);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR in POST: " + e.getMessage());
        }

        // 🔵 redirect only for single update
        response.sendRedirect("Marks");
    }

    // ============================
    // 🔹 UTIL METHODS
    // ============================

    private String safe(String val) {
        return val == null ? "" : val;
    }

    private java.math.BigDecimal getDecimal(String val) {
        try {
            if (val == null || val.trim().isEmpty()) {
                return null;
            }
            return new java.math.BigDecimal(val);
        } catch (Exception e) {
            return null;
        }
    }
}