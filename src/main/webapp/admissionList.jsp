<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Records</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    margin: 10px;
}

/* Header */
.header {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
}

/* Header row */
th {
    background: #f3f3f3;
    color: #333;
    font-weight: 600;
    padding: 8px;
    border: 1px solid #ddd;
    font-size: 13px;
}

/* Data row */
td {
    padding: 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}

/* Hover effect */
tr:hover {
    background: #f9f9f9;
}

/* Button */
button {
    padding: 4px 8px;
    font-size: 12px;
    background: #0070d2;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background: #005fb2;
}

/* Scroll */
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
<th>ID</th>
<th>Name</th>
<th>DOB</th>
<th>Gender</th>
<th>Native</th>
<th>Taluk</th>
<th>District</th>
<th>State</th>
<th>Nationality</th>
<th>Religion</th>
<th>Category</th>
<th>Mother Tongue</th>
<th>Blood Group</th>
<th>Father</th>
<th>Mother</th>
<th>Occupation</th>
<th>Income</th>
<th>Postal Address</th>
<th>Permanent Address</th>
<th>Phone</th>
<th>Email</th>
<th>Aadhar</th>
<th>Medium</th>
<th>SSLC Year</th>
<th>Maths</th>
<th>Science</th>
<th>Pref1</th>
<th>Pref2</th>
<th>Pref3</th>
<th>Pref4</th>
<th>Pref5</th>
<th>Created</th>
<th>Action</th>
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
data-native='<%= row.get("native_place") %>'
data-taluk='<%= row.get("taluk") %>'
data-district='<%= row.get("district") %>'
data-state='<%= row.get("state") %>'
data-nationality='<%= row.get("nationality") %>'
data-religion='<%= row.get("religion_category") %>'
data-category='<%= row.get("category") %>'
data-mt='<%= row.get("mother_tongue") %>'
data-blood='<%= row.get("blood_group") %>'
data-father='<%= row.get("father_guardian_name") %>'
data-mother='<%= row.get("mother_name") %>'
data-occupation='<%= row.get("occupation") %>'
data-income='<%= row.get("income") %>'
data-postal='<%= row.get("postal_address") %>'
data-permanent='<%= row.get("permanent_address") %>'
data-phone='<%= row.get("phone_no") %>'
data-email='<%= row.get("email") %>'
data-aadhar='<%= row.get("aadhar_no") %>'
data-medium='<%= row.get("medium_of_instruction") %>'
data-sscl='<%= row.get("sscl_passing_year") %>'
data-maths='<%= row.get("marks_maths") %>'
data-science='<%= row.get("marks_science") %>'
data-p1='<%= row.get("preference_1") %>'
data-p2='<%= row.get("preference_2") %>'
data-p3='<%= row.get("preference_3") %>'
data-p4='<%= row.get("preference_4") %>'
data-p5='<%= row.get("preference_5") %>'

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

<!-- Modal (UNCHANGED) -->
<!-- keep your existing modal code here -->

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script>
function editRecord(btn) {
let b = $(btn);

$('#m_id').val(b.data('id'));
$('#m_name').val(b.data('name'));
$('#m_dob').val(b.data('dob'));
$('#m_gender').val(b.data('gender'));
$('#m_phone').val(b.data('phone'));
$('#m_email').val(b.data('email'));
$('#m_district').val(b.data('district'));
$('#m_state').val(b.data('state'));
$('#m_nationality').val(b.data('nationality'));
$('#m_religion').val(b.data('religion'));
$('#m_category').val(b.data('category'));
$('#m_mt').val(b.data('mt'));
$('#m_blood').val(b.data('blood'));
$('#m_father').val(b.data('father'));
$('#m_mother').val(b.data('mother'));
$('#m_occupation').val(b.data('occupation'));
$('#m_income').val(b.data('income'));
$('#m_postal').val(b.data('postal'));
$('#m_permanent').val(b.data('permanent'));
$('#m_medium').val(b.data('medium'));
$('#m_sscl').val(b.data('sscl'));
$('#m_maths').val(b.data('maths'));
$('#m_science').val(b.data('science'));
$('#m_p1').val(b.data('p1'));
$('#m_p2').val(b.data('p2'));
$('#m_p3').val(b.data('p3'));
$('#m_p4').val(b.data('p4'));
$('#m_p5').val(b.data('p5'));

$('#editModal').show();
}
</script>

</body>
</html>