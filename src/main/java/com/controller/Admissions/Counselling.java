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
        	String sql = "SELECT id, APPNO, cast_no, applicant_name, gender, Admission_type, phone_no, Whatsapp_no, Attendance, Total, Seat_Allot, Special_Catg, Segment, Status_Allot " +
                    "FROM admission_form " +
                    "ORDER BY (CASE WHEN Total='AB' THEN -1 ELSE CAST(Total AS DECIMAL(10,2)) END) DESC";

            ResultSet rs = con.createStatement().executeQuery(sql);

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();

                row.put("id", safe(rs.getString("id")));
                row.put("APPNO", safe(rs.getString("APPNO")));
                row.put("cast_no", safe(rs.getString("cast_no")));
                row.put("name", safe(rs.getString("applicant_name")));
                row.put("gender", safe(rs.getString("gender")));
                row.put("Admission_type", safe(rs.getString("Admission_type")));
                row.put("phone_no", safe(rs.getString("phone_no")));
                row.put("Whatsapp_no", safe(rs.getString("Whatsapp_no")));
                row.put("Attendance", safe(rs.getString("Attendance")));
                row.put("Total", safe(rs.getString("Total")));
                row.put("Seat_Allot", safe(rs.getString("Seat_Allot")));
                row.put("Special_Catg", safe(rs.getString("Special_Catg")));
                row.put("Segment", safe(rs.getString("Segment")));
                row.put("Status_Allot", safe(rs.getString("Status_Allot")));

                list.add(row);
            }

            // 🔹 SEAT MATRIX
            String seatSql = "SELECT * FROM seat_matrix";
            ResultSet seatRs = con.createStatement().executeQuery(seatSql);

            while (seatRs.next()) {

                String cat = safe(seatRs.getString("category")).trim().toUpperCase();

                Map<String, Integer> branchMap = new HashMap<>();

                branchMap.put("ME_total", seatRs.getInt("ME"));
                branchMap.put("EE_total", seatRs.getInt("EE"));
                branchMap.put("CS_total", seatRs.getInt("CS"));
                branchMap.put("EC_total", seatRs.getInt("EC"));
                branchMap.put("CE_total", seatRs.getInt("CE"));

                branchMap.put("ME_used", 0);
                branchMap.put("EE_used", 0);
                branchMap.put("CS_used", 0);
                branchMap.put("EC_used", 0);
                branchMap.put("CE_used", 0);

                seatMap.put(cat, branchMap);
            }

            // 🔹 USED COUNT (BASED ON Segment)
            String countSql = "SELECT Seat_Allot, Segment, COUNT(*) as cnt " +
                    "FROM admission_form " +
                    "WHERE Seat_Allot IS NOT NULL " +
                    "AND Seat_Allot<>'' " +
                    "AND Status_Allot='Confirmed' " +
                    "GROUP BY Seat_Allot, Segment";

            ResultSet cntRs = con.createStatement().executeQuery(countSql);

            while (cntRs.next()) {

                String branch = safe(cntRs.getString("Seat_Allot")).trim().toUpperCase();
                String cat = safe(cntRs.getString("Segment")).trim().toUpperCase();
                int count = cntRs.getInt("cnt");

                if (!seatMap.containsKey(cat)) continue;

                Map<String, Integer> branchMap = seatMap.get(cat);
                branchMap.put(branch + "_used", count);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("data", list);
        request.setAttribute("seatMap", seatMap);

        request.getRequestDispatcher("Counselling.jsp").forward(request, response);
    }

    // ============================
    // 🔹 POST → SAFE UPDATE (NO OVER-ALLOCATION)
    // ============================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection con = DBUtil3.getConnection()) {

            String idStr = request.getParameter("id");
            String newSeat = safe(request.getParameter("Seat_Allot")).toUpperCase();
            String newSegment = safe(request.getParameter("Segment")).toUpperCase();
            String spCat = safe(request.getParameter("Special_Catg"));
            String Sallot = safe(request.getParameter("Status_Allot"));

            int id = Integer.parseInt(idStr);

            // 🔴 1. GET OLD DATA (important for edit case)
            String oldSql = "SELECT Seat_Allot, Segment FROM admission_form WHERE id=?";
            PreparedStatement psOld = con.prepareStatement(oldSql);
            psOld.setInt(1, id);
            ResultSet rsOld = psOld.executeQuery();

            String oldSeat = "";
            String oldSegment = "";

            if (rsOld.next()) {
                oldSeat = safe(rsOld.getString("Seat_Allot")).toUpperCase();
                oldSegment = safe(rsOld.getString("Segment")).toUpperCase();
            }

            // 🔴 2. GET TOTAL SEATS
            String totalSql = "SELECT " + newSeat + " FROM seat_matrix WHERE UPPER(category)=?";
            PreparedStatement psTotal = con.prepareStatement(totalSql);
            psTotal.setString(1, newSegment);
            ResultSet rsTotal = psTotal.executeQuery();

            int total = 0;
            if (rsTotal.next()) {
                total = rsTotal.getInt(1);
            }

            // 🔴 3. GET USED SEATS
            String usedSql = "SELECT COUNT(*) FROM admission_form " +
                             "WHERE Seat_Allot=? AND UPPER(Segment)=?";
            PreparedStatement psUsed = con.prepareStatement(usedSql);
            psUsed.setString(1, newSeat);
            psUsed.setString(2, newSegment);
            ResultSet rsUsed = psUsed.executeQuery();

            int used = 0;
            if (rsUsed.next()) {
                used = rsUsed.getInt(1);
            }

            // 🔴 4. HANDLE EDIT CASE (same seat → don't block)
            if (newSeat.equals(oldSeat) && newSegment.equals(oldSegment)) {
                // OK (same seat, just editing category etc.)
            } else {
                if (used >= total) {
                    response.getWriter().write("FULL");
                    return;
                }
            }

            // 🔴 5. UPDATE
            String updateSql = "UPDATE admission_form SET Seat_Allot=?, Segment=?, Special_Catg=?, Status_Allot=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(updateSql);

            ps.setString(1, newSeat);
            ps.setString(2, newSegment);
            ps.setString(3, spCat);
            ps.setString(4, Sallot);
            ps.setInt(5, id);

            ps.executeUpdate();

            response.getWriter().write("OK");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }

    // ============================
    // 🔹 SAFE METHOD
    // ============================
    private String safe(String val) {
        return val == null ? "" : val;
    }
}