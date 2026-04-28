package com.controller.Admissions;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.apache.commons.csv.*;

import com.bean.DBUtil3;

@WebServlet("/UploadCSV")
@MultipartConfig
public class UploadCSVServlet extends HttpServlet {

    private static final int TOTAL_COLUMNS = 50;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        int successCount = 0;
        int failCount = 0;

        try (Connection con = DBUtil3.getConnection()) {

            con.setAutoCommit(false);

            Part filePart = request.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("<h3 style='color:red;'>No file selected</h3>");
                return;
            }

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(filePart.getInputStream()));

            CSVParser parser = new CSVParser(reader,
                    CSVFormat.DEFAULT
                            .withFirstRecordAsHeader()
                            .withIgnoreEmptyLines()
                            .withTrim());

            String sql = "INSERT INTO admission_form (" +
                    "APPNO, cast_no, applicant_name, date_of_birth, gender, Admission_type, " +
                    "native_place, taluk, district, state, nationality, religion_category, " +
                    "category, cast, mother_tongue, blood_group, father_guardian_name, " +
                    "father_occupation, Father_org, mother_name, mother_occupation, Mother_org, " +
                    "income, postal_address, permanent_address, phone_no, Whatsapp_no, email, " +
                    "SSLC_State, aadhar_no, APAAR_ID, medium_of_instruction, sscl_passing_year, " +
                    "SSLC_Board, SSLC_TMarks, marks_maths, marks_science, SSLC_Aggr, " +
                    "preference_1, preference_2, preference_3, preference_4, preference_5, " +
                    "CBSC_ICSE, PUC_SC, GIRLS, ET_m, ET_s, ET_T, Total,Segment" +
                    ") VALUES (" +
                    "?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?" +
                    ")";

            PreparedStatement ps = con.prepareStatement(sql);

            int batchSize = 0;

            for (CSVRecord record : parser) {

                try {

                    if (record.size() != TOTAL_COLUMNS) {
                        failCount++;
                        System.out.println("Column mismatch: " + record);
                        continue;
                    }

                    for (int i = 0; i < TOTAL_COLUMNS; i++) {

                        String val = record.get(i).trim();

                        if (val.isEmpty()) {
                            setNull(ps, i);
                        } else {
                            setValue(ps, i, val);
                        }
                    }

                    ps.addBatch();
                    successCount++;
                    batchSize++;

                    if (batchSize == 100) {
                        ps.executeBatch();
                        con.commit();
                        batchSize = 0;
                    }

                } catch (Exception e) {
                    failCount++;
                    System.out.println("Error row: " + record);
                    e.printStackTrace();
                }
            }

            ps.executeBatch();
            con.commit();

            parser.close();
            ps.close();

            response.getWriter().println("<h3 style='color:green;'>Uploaded: " + successCount + "</h3>");
            response.getWriter().println("<h3 style='color:red;'>Failed: " + failCount + "</h3>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }

    // ===== TYPE HANDLING =====

    private void setNull(PreparedStatement ps, int i) throws SQLException {

        if (i == 3) // date_of_birth
            ps.setNull(i + 1, Types.DATE);

        else if (i == 22 || i == 35 || i == 36) // income, maths, science
            ps.setNull(i + 1, Types.DECIMAL);

        else if (i == 32) // passing year
            ps.setNull(i + 1, Types.INTEGER);

        else
            ps.setNull(i + 1, Types.VARCHAR);
    }

    private void setValue(PreparedStatement ps, int i, String val) throws SQLException {

        try {

            if (i == 3) { // date_of_birth
                ps.setDate(i + 1, java.sql.Date.valueOf(val));
            }

            else if (i == 22 || i == 35 || i == 36) {
                ps.setDouble(i + 1, Double.parseDouble(val.replace(",", "")));
            }

            else if (i == 32) {
                ps.setInt(i + 1, Integer.parseInt(val));
            }

            else {
                ps.setString(i + 1, val);
            }

        } catch (Exception e) {
            System.out.println("Data format issue at column " + i + " value=" + val);
            throw e;
        }
    }
}