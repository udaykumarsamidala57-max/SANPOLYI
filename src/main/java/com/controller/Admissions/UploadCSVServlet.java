package com.controller.Admissions;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.bean.DBUtil3;

@WebServlet("/UploadCSV")
@MultipartConfig
public class UploadCSVServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        int successCount = 0;
        int failCount = 0;

        try (Connection con = DBUtil3.getConnection()) {

            Part filePart = request.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("<h3 style='color:red;'>No file selected</h3>");
                return;
            }

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(filePart.getInputStream()));

            String sql = "INSERT INTO admission_form (" +
                    "APPNO, cast_no, applicant_name, date_of_birth, gender, Admission_type, native_place, taluk, district, state, nationality, religion_category, category, cast, mother_tongue, blood_group, father_guardian_name, father_occupation, Father_org, mother_name, mother_occupation, Mother_org, income, postal_address, permanent_address, phone_no, Whatsapp_no, email, SSLC_State, aadhar_no, APAAR_ID, medium_of_instruction, sscl_passing_year, SSLC_Board, SSLC_TMarks, marks_maths, marks_science, SSLC_Aggr, preference_1, preference_2, preference_3, preference_4, preference_5" +
                    ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            String line;
            br.readLine(); // skip header

            int batchSize = 0;

            while ((line = br.readLine()) != null) {

                try {
                    String[] data = line.split(",", -1);

                    for (int i = 0; i < 41; i++) {

                        String val = (i < data.length) ? data[i].trim() : "";

                        if (val.isEmpty()) {
                            // Set NULL based on column type
                            if (i == 3) { // date_of_birth
                                ps.setNull(i + 1, Types.DATE);
                            } else if (i == 22) { // income
                                ps.setNull(i + 1, Types.DECIMAL);
                            } else if (i == 32) { // year
                                ps.setNull(i + 1, Types.INTEGER);
                            } else if (i == 35 || i == 36) { // marks
                                ps.setNull(i + 1, Types.DECIMAL);
                            } else {
                                ps.setNull(i + 1, Types.VARCHAR);
                            }

                        } else {
                            // Convert types safely
                            try {
                                if (i == 3) {
                                    ps.setDate(i + 1, java.sql.Date.valueOf(val));
                                } else if (i == 22) {
                                    ps.setDouble(i + 1, Double.parseDouble(val));
                                } else if (i == 32) {
                                    ps.setInt(i + 1, Integer.parseInt(val));
                                } else if (i == 35 || i == 36) {
                                    ps.setDouble(i + 1, Double.parseDouble(val));
                                } else {
                                    ps.setString(i + 1, val);
                                }
                            } catch (Exception ex) {
                                // If conversion fails → set NULL
                                ps.setNull(i + 1, Types.VARCHAR);
                            }
                        }
                    }

                    ps.addBatch();
                    batchSize++;
                    successCount++;

                    if (batchSize == 100) {
                        ps.executeBatch();
                        batchSize = 0;
                    }

                } catch (Exception rowEx) {
                    failCount++;
                    System.out.println("Skipping row: " + line);
                }
            }

            ps.executeBatch();

            br.close();
            ps.close();

            response.getWriter().println("<h3 style='color:green;'>Uploaded: " + successCount + "</h3>");
            response.getWriter().println("<h3 style='color:red;'>Failed Rows: " + failCount + "</h3>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}