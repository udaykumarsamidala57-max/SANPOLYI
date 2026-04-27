<%@ page import="java.io.*,java.sql.*,java.util.*" %>
<%@ page import="com.bean.DBUtil3" %>

<!DOCTYPE html>

<html>
<head>
    <title>Bulk Upload Admissions</title>
</head>
<body>

<h2>Upload CSV File</h2>

<form method="post" enctype="multipart/form-data">
    <input type="file" name="file" required>
    <input type="submit" value="Upload">
</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {
try {
Part filePart = request.getPart("file");
BufferedReader br = new BufferedReader(new InputStreamReader(filePart.getInputStream()));


    String line;
    int count = 0;

    Connection con = DBUtil3.getConnection();

    String sql = "INSERT INTO admission_form (APPNO,cast_no, applicant_name, date_of_birth, gender, Admission_type, native_place, taluk, district, state, nationality, religion_category, category, cast, mother_tongue, blood_group, father_guardian_name, father_occupation, Father_org, mother_name, mother_occupation, Mother_org, income, postal_address, permanent_address, phone_no, Whatsapp_no, email, SSLC_State, aadhar_no, APAAR_ID, medium_of_instruction, sscl_passing_year, SSLC_Board, SSLC_TMarks, marks_maths, marks_science,SSLC_Aggr, preference_1, preference_2, preference_3, preference_4, preference_5) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    PreparedStatement ps = con.prepareStatement(sql);

    br.readLine(); // skip header

    while((line = br.readLine()) != null) {

        String[] data = line.split(",", -1); // KEEP EMPTY VALUES

        for(int i=0; i<41; i++) {
            String val = (i < data.length) ? data[i].trim() : "";

            if(val.equals("")) {
                ps.setNull(i+1, Types.VARCHAR);
            } else {
                if(i == 2) // date_of_birth
                    ps.setDate(i+1, java.sql.Date.valueOf(val));
                else if(i == 21) // income
                    ps.setDouble(i+1, Double.parseDouble(val));
                else if(i == 31) // year
                    ps.setInt(i+1, Integer.parseInt(val));
                else if(i == 34 || i == 35) // marks
                    ps.setDouble(i+1, Double.parseDouble(val));
                else
                    ps.setString(i+1, val);
            }
        }

        ps.executeUpdate();
        count++;
    }

    out.println("<h3 style='color:green;'>Uploaded Successfully: "+count+" records</h3>");

} catch(Exception e) {
    out.println("<h3 style='color:red;'>Error: "+e.getMessage()+"</h3>");
    e.printStackTrace();
}


}
%>

</body>
</html>
