package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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

            // ✅ Use alias for problem columns
            String sql = "SELECT id, applicant_name, marks_maths, marks_science, SSLC_Aggr, " +
                         "`CBSC/ICSE` AS board, `PUC SCI` AS puc, GIRLS, ET " +
                         "FROM admission_form ORDER BY id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, String> row = new HashMap<>();

                row.put("id", safe(rs.getString("id")));
                row.put("name", safe(rs.getString("applicant_name")));
                row.put("maths", safe(rs.getString("marks_maths")));
                row.put("science", safe(rs.getString("marks_science")));
                row.put("aggr", safe(rs.getString("SSLC_Aggr")));
                row.put("board", safe(rs.getString("board")));
                row.put("puc", safe(rs.getString("puc")));
                row.put("girls", safe(rs.getString("GIRLS")));
                row.put("et", safe(rs.getString("ET")));

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        request.getRequestDispatcher("admission_list.jsp").forward(request, response);
    }

    // ============================
    // 🔹 POST → UPDATE RECORD
    // ============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

            String sql = "UPDATE admission_form SET " +
                    "marks_maths=?, marks_science=?, SSLC_Aggr=?, " +
                    "`CBSC/ICSE`=?, `PUC SCI`=?, GIRLS=?, ET=? " +
                    "WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setBigDecimal(1, getDecimal(request.getParameter("maths")));
            ps.setBigDecimal(2, getDecimal(request.getParameter("science")));
            ps.setString(3, safe(request.getParameter("aggr")));
            ps.setString(4, safe(request.getParameter("board")));
            ps.setString(5, safe(request.getParameter("puc")));
            ps.setString(6, safe(request.getParameter("girls")));
            ps.setString(7, safe(request.getParameter("et")));
            ps.setInt(8, Integer.parseInt(request.getParameter("id")));

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdmissionServlet");
    }

    // ============================
    // 🔹 UTIL METHODS
    // ============================

    // Null-safe string
    private String safe(String val) {
        return val == null ? "" : val;
    }

    // Convert to BigDecimal safely
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