<%@ page import="java.util.*" %>

<%! 
    public String val(Object o) {
        return (o == null) ? "" : o.toString();
    }
%>

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

<script>
function downloadExcel() {
    let table = document.getElementById("dataTable");
    let html = table.outerHTML;

    let blob = new Blob([html], { type: "application/vnd.ms-excel" });
    let url = URL.createObjectURL(blob);

    let a = document.createElement("a");
    a.href = url;
    a.download = "Admission_Records.xls";
    a.click();

    URL.revokeObjectURL(url);
}
</script>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-2">
    <h4>SANPOLY - Tabulation</h4>
    <button class="btn btn-success btn-sm" onclick="downloadExcel()">Download Excel</button>
</div>

<div class="table-wrapper">

<table id="dataTable" class="table table-bordered table-sm">

<thead>
<tr>
<th>ID</th><th>APPNO</th><th>Cast No</th><th>Name</th><th>DOB</th><th>Gender</th><th>Admission</th>

<th>Religion</th><th>Category</th><th>Cast</th><th>Mother Tongue</th>

<th>Father Name</th><th>F Occupation</th><th>F Org</th>
<th>Mother Name</th><th>M Occupation</th><th>M Org</th>

<th>Whatsapp</th><th>Email</th>

<th>SSLC State</th><th>Aadhar</th><th>APAAR</th>

<th>Medium</th><th>Year</th><th>Board</th>
<th>Total Marks</th><th>Aggregate</th>
<th>Maths</th><th>Science</th>

<th>P1</th><th>P2</th><th>P3</th><th>P4</th><th>P5</th>

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
<td><%= val(row.get("id")) %></td>
<td><%= val(row.get("APPNO")) %></td>
<td><%= val(row.get("cast_no")) %></td>
<td><%= val(row.get("applicant_name")) %></td>
<td><%= val(row.get("date_of_birth")) %></td>
<td><%= val(row.get("gender")) %></td>
<td><%= val(row.get("Admission_type")) %></td>

<td><%= val(row.get("religion_category")) %></td>
<td><%= val(row.get("category")) %></td>
<td><%= val(row.get("cast")) %></td>
<td><%= val(row.get("mother_tongue")) %></td>

<td><%= val(row.get("father_guardian_name")) %></td>
<td><%= val(row.get("father_occupation")) %></td>
<td><%= val(row.get("Father_org")) %></td>

<td><%= val(row.get("mother_name")) %></td>
<td><%= val(row.get("mother_occupation")) %></td>
<td><%= val(row.get("Mother_org")) %></td>

<td><%= val(row.get("Whatsapp_no")) %></td>
<td><%= val(row.get("email")) %></td>

<td><%= val(row.get("SSLC_State")) %></td>
<td><%= val(row.get("aadhar_no")) %></td>
<td><%= val(row.get("APAAR_ID")) %></td>

<td><%= val(row.get("medium_of_instruction")) %></td>
<td><%= val(row.get("sscl_passing_year")) %></td>
<td><%= val(row.get("SSLC_Board")) %></td>
<td><%= val(row.get("SSLC_TMarks")) %></td>
<td><%= val(row.get("SSLC_Aggr")) %></td>

<td><%= val(row.get("marks_maths")) %></td>
<td><%= val(row.get("marks_science")) %></td>

<td><%= val(row.get("preference_1")) %></td>
<td><%= val(row.get("preference_2")) %></td>
<td><%= val(row.get("preference_3")) %></td>
<td><%= val(row.get("preference_4")) %></td>
<td><%= val(row.get("preference_5")) %></td>

<td><%= val(row.get("CBSC_ICSE")) %></td>
<td><%= val(row.get("PUC_SC")) %></td>
<td><%= val(row.get("GIRLS")) %></td>

<td><%= val(row.get("ET_m")) %></td>
<td><%= val(row.get("ET_s")) %></td>
<td><%= val(row.get("ET_T")) %></td>

<td><%= val(row.get("Total")) %></td>

<td><%= val(row.get("created_at")) %></td>
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