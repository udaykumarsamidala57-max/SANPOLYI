<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Records</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<style>
body {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    margin: 10px;
}
.header {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}
th {
    background: #f3f3f3;
    padding: 8px;
    border: 1px solid #ddd;
    font-size: 13px;
}
td {
    padding: 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
tr:hover {
    background: #f9f9f9;
}
button {
    padding: 4px 8px;
    font-size: 12px;
    background: #0070d2;
    color: white;
    border: none;
}
.table-wrapper {
    overflow-x: auto;
}
</style>

</head>
<body>

<div class="header">SANPOLY - Admission Records</div>

<div class="table-wrapper">
<table>
<thead>
<tr>
<th>ID</th><th>Name</th><th>DOB</th><th>Gender</th><th>Native</th>
<th>Taluk</th><th>District</th><th>State</th><th>Nationality</th>
<th>Religion</th><th>Category</th><th>Mother Tongue</th><th>Blood Group</th>
<th>Father</th><th>Mother</th><th>Occupation</th><th>Income</th>
<th>Postal Address</th><th>Permanent Address</th><th>Phone</th><th>Email</th>
<th>Aadhar</th><th>Medium</th><th>SSLC Year</th><th>Maths</th>
<th>Science</th><th>Pref1</th><th>Pref2</th><th>Pref3</th>
<th>Pref4</th><th>Pref5</th><th>Created</th><th>Action</th>
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
<td><%= row.get("applicant_name") %></td>
<td><%= row.get("date_of_birth") %></td>
<td><%= row.get("gender") %></td>
<td><%= row.get("native_place") %></td>
<td><%= row.get("taluk") %></td>
<td><%= row.get("district") %></td>
<td><%= row.get("state") %></td>
<td><%= row.get("nationality") %></td>
<td><%= row.get("religion_category") %></td>
<td><%= row.get("category") %></td>
<td><%= row.get("mother_tongue") %></td>
<td><%= row.get("blood_group") %></td>
<td><%= row.get("father_guardian_name") %></td>
<td><%= row.get("mother_name") %></td>
<td><%= row.get("occupation") %></td>
<td><%= row.get("income") %></td>
<td><%= row.get("postal_address") %></td>
<td><%= row.get("permanent_address") %></td>
<td><%= row.get("phone_no") %></td>
<td><%= row.get("email") %></td>
<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("medium_of_instruction") %></td>
<td><%= row.get("sscl_passing_year") %></td>
<td><%= row.get("marks_maths") %></td>
<td><%= row.get("marks_science") %></td>
<td><%= row.get("preference_1") %></td>
<td><%= row.get("preference_2") %></td>
<td><%= row.get("preference_3") %></td>
<td><%= row.get("preference_4") %></td>
<td><%= row.get("preference_5") %></td>
<td><%= row.get("created_at") %></td>

<td>
<button onclick="editRecord(this)"
data-id='<%= row.get("id") %>'
data-name='<%= row.get("applicant_name") %>'
data-dob='<%= row.get("date_of_birth") %>'
data-gender='<%= row.get("gender") %>'
data-phone='<%= row.get("phone_no") %>'
data-email='<%= row.get("email") %>'
>Edit</button>
</td>

</tr>

<%
}
}
%>
</tbody>
</table>
</div>

<!-- ✅ WORKING MODAL -->
<div class="modal fade" id="editModal">
<div class="modal-dialog">
<form method="post" action="AdmissionListServlet">
<div class="modal-content">

<div class="modal-header">
<h5>Edit Record</h5>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>

<div class="modal-body">
<input type="hidden" name="id" id="m_id">

<label>Name</label>
<input name="applicant_name" id="m_name" class="form-control">

<label>DOB</label>
<input type="date" name="date_of_birth" id="m_dob" class="form-control">

<label>Gender</label>
<input name="gender" id="m_gender" class="form-control">

<label>Phone</label>
<input name="phone_no" id="m_phone" class="form-control">

<label>Email</label>
<input name="email" id="m_email" class="form-control">
</div>

<div class="modal-footer">
<button type="submit" class="btn btn-success">Update</button>
</div>

</div>
</form>
</div>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function editRecord(btn){
let b=$(btn);

$('#m_id').val(b.data('id'));
$('#m_name').val(b.data('name'));
$('#m_dob').val(b.data('dob'));
$('#m_gender').val(b.data('gender'));
$('#m_phone').val(b.data('phone'));
$('#m_email').val(b.data('email'));

$('#editModal').modal('show');
}
</script>

</body>
</html>