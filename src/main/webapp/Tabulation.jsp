<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Records</title>

<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<style>
body { font-family: Arial; background:#f4f6f9; margin:10px; }
table { width:100%; background:white; }
th,td { border:1px solid #ddd; padding:6px; font-size:12px; white-space:nowrap; }
th { background:#f3f3f3; }
.table-wrapper { overflow-x:auto; }
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<h4>SANPOLY - Admission Records</h4>

<div class="table-wrapper">
<table>
<thead>
<tr>
<th>ID</th><th>APPNO</th><th>Cast No</th><th>Name</th><th>DOB</th><th>Gender</th><th>Admission</th>

<th>Native</th><th>Taluk</th><th>District</th><th>State</th><th>Nationality</th>

<th>Religion</th><th>Category</th><th>Cast</th><th>MT</th><th>Blood</th>

<th>Father Name</th><th>F Occ</th><th>F Org</th>
<th>Mother Name</th><th>M Occ</th><th>M Org</th>

<th>Income</th><th>Postal</th><th>Permanent</th>

<th>Phone</th><th>Whatsapp</th><th>Email</th>

<th>SSLC State</th><th>Aadhar</th><th>APAAR</th>

<th>Medium</th><th>Year</th><th>Board</th><th>Total Marks</th><th>Aggr</th>
<th>Maths</th><th>Science</th>

<th>P1</th><th>P2</th><th>P3</th><th>P4</th><th>P5</th>

<!-- NEW -->
<th>CBSE/ICSE</th><th>PUC/SC</th><th>Girls</th>
<th>ET Maths</th><th>ET Science</th><th>ET Total</th>
<th>Grand Total</th>

<th>Created</th>
</tr>
</thead>
<tbody>

<%
List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("data");
if (list != null) {
    for (Map<String, Object> row : list) {
%>

<tr>
<td><%= row.get("id") %></td>
<td><%= row.get("APPNO") %></td>
<td><%= row.get("cast_no") %></td>
<td><%= row.get("applicant_name") %></td>
<td><%= row.get("date_of_birth") %></td>
<td><%= row.get("gender") %></td>
<td><%= row.get("Admission_type") %></td>



<!-- SOCIAL -->
<td><%= row.get("religion_category") %></td>
<td><%= row.get("category") %></td>
<td><%= row.get("cast") %></td>
<td><%= row.get("mother_tongue") %></td>


<!-- PARENTS -->
<td><%= row.get("father_guardian_name") %></td>
<td><%= row.get("father_occupation") %></td>
<td><%= row.get("Father_org") %></td>

<td><%= row.get("mother_name") %></td>
<td><%= row.get("mother_occupation") %></td>
<td><%= row.get("Mother_org") %></td>




<td><%= row.get("Whatsapp_no") %></td>
<td><%= row.get("email") %></td>

<!-- IDS -->
<td><%= row.get("SSLC_State") %></td>
<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("APAAR_ID") %></td>

<!-- EDUCATION -->
<td><%= row.get("medium_of_instruction") %></td>
<td><%= row.get("sscl_passing_year") %></td>
<td><%= row.get("SSLC_Board") %></td>
<td><%= row.get("SSLC_TMarks") %></td>
<td><%= row.get("SSLC_Aggr") %></td>

<td><%= row.get("marks_maths") %></td>
<td><%= row.get("marks_science") %></td>

<!-- PREFERENCES -->
<td><%= row.get("preference_1") %></td>
<td><%= row.get("preference_2") %></td>
<td><%= row.get("preference_3") %></td>
<td><%= row.get("preference_4") %></td>
<td><%= row.get("preference_5") %></td>

<!-- NEW FIELDS -->
<td><%= row.get("CBSC_ICSE") %></td>
<td><%= row.get("PUC_SC") %></td>
<td><%= row.get("GIRLS") %></td>

<td><%= row.get("ET_m") %></td>
<td><%= row.get("ET_s") %></td>
<td><%= row.get("ET_T") %></td>

<td><%= row.get("Total") %></td>


</tr>

<%
    }
}
%>

</tbody>
</table>
</div>

</body>
</html>