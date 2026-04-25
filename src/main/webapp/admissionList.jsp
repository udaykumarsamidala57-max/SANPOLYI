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
<%@ include file="header.jsp" %>
<div class="header">SANPOLY - Admission Records</div>

<div class="table-wrapper">
<table>
<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>DOB</th>
<th>Gender</th>
<th>Admission Type</th>

<th>Native</th>
<th>Taluk</th>
<th>District</th>
<th>State</th>
<th>Nationality</th>

<th>Religion</th>
<th>Category</th>
<th>Cast</th>
<th>Mother Tongue</th>
<th>Blood Group</th>

<th>Father</th>
<th>Father Occupation</th>
<th>Father Org</th>

<th>Mother</th>
<th>Mother Occupation</th>
<th>Mother Org</th>

<th>Income</th>

<th>Postal Address</th>
<th>Permanent Address</th>

<th>Phone</th>
<th>Email</th>
<th>Aadhar</th>
<th>APAAR ID</th>

<th>Medium</th>
<th>SSLC Year</th>
<th>SSLC Board</th>
<th>SSLC Total Marks</th>

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
<tr>
<td><%= row.get("id") %></td>
<td><%= row.get("applicant_name") %></td>
<td><%= row.get("date_of_birth") %></td>
<td><%= row.get("gender") %></td>
<td><%= row.get("Admission_type") %></td>

<td><%= row.get("native_place") %></td>
<td><%= row.get("taluk") %></td>
<td><%= row.get("district") %></td>
<td><%= row.get("state") %></td>
<td><%= row.get("nationality") %></td>

<td><%= row.get("religion_category") %></td>
<td><%= row.get("category") %></td>
<td><%= row.get("cast") %></td>
<td><%= row.get("mother_tongue") %></td>
<td><%= row.get("blood_group") %></td>

<td><%= row.get("father_guardian_name") %></td>
<td><%= row.get("father_occupation") %></td>
<td><%= row.get("Father_org") %></td>

<td><%= row.get("mother_name") %></td>
<td><%= row.get("mother_occupation") %></td>
<td><%= row.get("Mother_org") %></td>

<td><%= row.get("income") %></td>

<td><%= row.get("postal_address") %></td>
<td><%= row.get("permanent_address") %></td>

<td><%= row.get("phone_no") %></td>
<td><%= row.get("email") %></td>
<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("apaar_id") %></td>

<td><%= row.get("medium_of_instruction") %></td>
<td><%= row.get("sscl_passing_year") %></td>

<td><%= row.get("SSLC_Board") %></td>
<td><%= row.get("SSLC_TMarks") %></td>

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
<div class="modal-dialog modal-lg">
<form method="post" action="AdmissionListServlet">

<div class="modal-content">

<div class="modal-header">
<h5>Edit Admission</h5>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>

<div class="modal-body">

<input type="hidden" name="id" id="m_id">

<div class="row">

<div class="col-md-6">
<label>Name</label>
<input name="applicant_name" id="m_name" class="form-control">
</div>

<div class="col-md-6">
<label>DOB</label>
<input type="date" name="date_of_birth" id="m_dob" class="form-control">
</div>

<div class="col-md-6">
<label>Gender</label>
<input name="gender" id="m_gender" class="form-control">
</div>

<div class="col-md-6">
<label>Native Place</label>
<input name="native_place" id="m_native" class="form-control">
</div>

<div class="col-md-6">
<label>Taluk</label>
<input name="taluk" id="m_taluk" class="form-control">
</div>

<div class="col-md-6">
<label>District</label>
<input name="district" id="m_district" class="form-control">
</div>

<div class="col-md-6">
<label>State</label>
<input name="state" id="m_state" class="form-control">
</div>

<div class="col-md-6">
<label>Nationality</label>
<input name="nationality" id="m_nationality" class="form-control">
</div>

<div class="col-md-6">
<label>Religion</label>
<input name="religion_category" id="m_religion" class="form-control">
</div>

<div class="col-md-6">
<label>Category</label>
<input name="category" id="m_category" class="form-control">
</div>

<div class="col-md-6">
<label>Mother Tongue</label>
<input name="mother_tongue" id="m_mt" class="form-control">
</div>

<div class="col-md-6">
<label>Blood Group</label>
<input name="blood_group" id="m_blood" class="form-control">
</div>

<div class="col-md-6">
<label>Father</label>
<input name="father_guardian_name" id="m_father" class="form-control">
</div>

<div class="col-md-6">
<label>Mother</label>
<input name="mother_name" id="m_mother" class="form-control">
</div>

<div class="col-md-6">
<label>Occupation</label>
<input name="occupation" id="m_occupation" class="form-control">
</div>

<div class="col-md-6">
<label>Income</label>
<input name="income" id="m_income" class="form-control">
</div>

<div class="col-md-6">
<label>Postal Address</label>
<textarea name="postal_address" id="m_postal" class="form-control"></textarea>
</div>

<div class="col-md-6">
<label>Permanent Address</label>
<textarea name="permanent_address" id="m_permanent" class="form-control"></textarea>
</div>

<div class="col-md-6">
<label>Phone</label>
<input name="phone_no" id="m_phone" class="form-control">
</div>

<div class="col-md-6">
<label>Email</label>
<input name="email" id="m_email" class="form-control">
</div>

<div class="col-md-6">
<label>Aadhar</label>
<input name="aadhar_no" id="m_aadhar" class="form-control">
</div>

<div class="col-md-6">
<label>Medium</label>
<input name="medium_of_instruction" id="m_medium" class="form-control">
</div>

<div class="col-md-6">
<label>SSLC Year</label>
<input name="sscl_passing_year" id="m_sscl" class="form-control">
</div>

<div class="col-md-6">
<label>Maths</label>
<input name="marks_maths" id="m_maths" class="form-control">
</div>

<div class="col-md-6">
<label>Science</label>
<input name="marks_science" id="m_science" class="form-control">
</div>

<div class="col-md-6">
<label>Preference 1</label>
<input name="preference_1" id="m_p1" class="form-control">
</div>

<div class="col-md-6">
<label>Preference 2</label>
<input name="preference_2" id="m_p2" class="form-control">
</div>

<div class="col-md-6">
<label>Preference 3</label>
<input name="preference_3" id="m_p3" class="form-control">
</div>

<div class="col-md-6">
<label>Preference 4</label>
<input name="preference_4" id="m_p4" class="form-control">
</div>

<div class="col-md-6">
<label>Preference 5</label>
<input name="preference_5" id="m_p5" class="form-control">
</div>

</div>

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

	$('#m_native').val(b.data('native'));
	$('#m_taluk').val(b.data('taluk'));
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

	$('#m_phone').val(b.data('phone'));
	$('#m_email').val(b.data('email'));
	$('#m_aadhar').val(b.data('aadhar'));

	$('#m_medium').val(b.data('medium'));
	$('#m_sscl').val(b.data('sscl'));

	$('#m_maths').val(b.data('maths'));
	$('#m_science').val(b.data('science'));

	$('#m_p1').val(b.data('p1'));
	$('#m_p2').val(b.data('p2'));
	$('#m_p3').val(b.data('p3'));
	$('#m_p4').val(b.data('p4'));
	$('#m_p5').val(b.data('p5'));

	$('#editModal').modal('show');
	}
</script>

</body>
</html>