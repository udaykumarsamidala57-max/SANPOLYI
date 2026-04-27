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

        try {
            Part filePart = request.getPart("file");
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(filePart.getInputStream()));

            String line;
            int count = 0;

            Connection con = DBUtil3.getConnection();

            String sql = "INSERT INTO admission_form VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            br.readLine(); // skip header

            while ((line = br.readLine()) != null) {

                String[] data = line.split(",", -1);

                for (int i = 0; i < 41; i++) {
                    String val = (i < data.length) ? data[i].trim() : "";

                    if (val.equals("")) {
                        ps.setNull(i + 1, Types.VARCHAR);
                    } else {
                        ps.setString(i + 1, val); // simplify first
                    }
                }

                ps.executeUpdate();
                count++;
            }

            response.getWriter().println("Uploaded: " + count);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}