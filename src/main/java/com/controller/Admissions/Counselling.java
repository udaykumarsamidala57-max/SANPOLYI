package com.controller.Admissions;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.bean.DBUtil3;

@WebServlet("/Counselling")
public class Counselling extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ============================
    // 🔹 GET → LOAD TABLE DATA
    // ============================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> list = new ArrayList<>();
        Map<String, Map<String, Integer>> seatMap = new HashMap<>();

        try (Connection con = DBUtil3.getConnection()) {

            // 🔹 STUDENT DATA
            String sql = "SELECT id, APPNO, cast_no, applicant_name, gender,phone_no,Whatsapp_no, Attendance, Total, Seat_Allot, Special_Catg " +
                         "FROM admission_form " +
                         "ORDER BY (CASE WHEN Total='AB' THEN -1 ELSE CAST(Total AS DECIMAL(10,2)) END) DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();

                row.put("id", safe(rs.getString("id")));
                row.put("APPNO", safe(rs.getString("APPNO")));
                row.put("cast_no", safe(rs.getString("cast_no")));
                row.put("name", safe(rs.getString("applicant_name")));
                row.put("gender", safe(rs.getString("gender")));
                row.put("phone_no", safe(rs.getString("phone_no")));
                row.put("Whatsapp_no", safe(rs.getString("Whatsapp_no")));
                row.put("Attendance", safe(rs.getString("Attendance")));
                row.put("Total", safe(rs.getString("Total")));
                row.put("Seat_Allot", safe(rs.getString("Seat_Allot")));
                row.put("Special_Catg", safe(rs.getString("Special_Catg")));

                list.add(row);
            }

            // ============================
            // 🔹 SEAT MATRIX (TOTAL)
            // ============================
            String seatSql = "SELECT * FROM seat_matrix";
            ResultSet seatRs = con.createStatement().executeQuery(seatSql);

            while (seatRs.next()) {
                String cat = safe(seatRs.getString("category")).trim();

                Map<String, Integer> branchMap = new HashMap<>();

                branchMap.put("ME_total", seatRs.getInt("ME"));
                branchMap.put("EE_total", seatRs.getInt("EE"));
                branchMap.put("CS_total", seatRs.getInt("CS"));
                branchMap.put("EC_total", seatRs.getInt("EC"));
                branchMap.put("CE_total", seatRs.getInt("CE"));

                // initialize used = 0
                branchMap.put("ME_used", 0);
                branchMap.put("EE_used", 0);
                branchMap.put("CS_used", 0);
                branchMap.put("EC_used", 0);
                branchMap.put("CE_used", 0);

                seatMap.put(cat, branchMap);
            }

            // ============================
            // 🔹 ALREADY ALLOTTED COUNT
            // 🔥 USING cast_no FIRST 2 LETTERS
            // ============================
            String countSql = "SELECT Seat_Allot, " +
                              "TRIM(SUBSTRING(cast_no,1,2)) as category, " +
                              "COUNT(*) as cnt " +
                              "FROM admission_form " +
                              "WHERE Seat_Allot IS NOT NULL AND Seat_Allot<>'' " +
                              "GROUP BY Seat_Allot, TRIM(SUBSTRING(cast_no,1,2))";

            ResultSet cntRs = con.createStatement().executeQuery(countSql);

            while (cntRs.next()) {

                String branch = safe(cntRs.getString("Seat_Allot")).trim();
                String cat = safe(cntRs.getString("category")).trim();
                int count = cntRs.getInt("cnt");

                if (!seatMap.containsKey(cat)) continue;

                Map<String, Integer> branchMap = seatMap.get(cat);

                String key = branch + "_used";

                branchMap.put(key, branchMap.getOrDefault(key, 0) + count);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        request.setAttribute("seatMap", seatMap);

        request.getRequestDispatcher("Counselling.jsp").forward(request, response);
    }

    // ============================
    // 🔹 POST → UPDATE DATA
    // ============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

            String sql = "UPDATE admission_form SET " +
                         "Seat_Allot=?, Special_Catg=? " +
                         "WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, safe(request.getParameter("Seat_Allot")));
            ps.setString(2, safe(request.getParameter("Special_Catg")));
            ps.setInt(3, Integer.parseInt(request.getParameter("id")));

            int rows = ps.executeUpdate();
            System.out.println("Updated rows: " + rows);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR in POST: " + e.getMessage());
        }

        response.sendRedirect("Counselling");
    }

    // ============================
    // 🔹 SAFE METHOD
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