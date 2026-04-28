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
input, textarea { margin-bottom:5px; }
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
<th>Nationality</th>
<th>Religion</th><th>Category</th><th>Cast</th><th>MT</th><th>Blood</th>
<th>Father</th><th>F Occ</th><th>F Org</th>
<th>Mother</th><th>M Occ</th><th>M Org</th>
<th>Income</th><th>Postal</th><th>Permanent</th>
<th>Phone</th><th>Whatsapp</th><th>Email</th><th>SSLC State</th>
<th>Aadhar</th><th>APAAR</th>
<th>Medium</th><th>Year</th><th>Board</th><th>Total</th><th>Aggr</th>
<th>Maths</th><th>Science</th>
<th>P1</th><th>P2</th><th>P3</th><th>P4</th><th>P5</th>
<th>Created</th><th>Action</th>
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
<td><%= row.get("Whatsapp_no") %></td>
<td><%= row.get("email") %></td>
<td><%= row.get("SSLC_State") %></td>

<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("APAAR_ID") %></td>

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
<button class="btn btn-primary btn-sm" onclick="editRecord(this)"

data-id='<%= row.get("id") %>'

data-appno='<%= row.get("APPNO") %>'
data-castno='<%= row.get("cast_no") %>'

data-name='<%= row.get("applicant_name") %>'
data-dob='<%= row.get("date_of_birth") %>'
data-gender='<%= row.get("gender") %>'
data-admission='<%= row.get("Admission_type") %>'

data-native='<%= row.get("native_place") %>'
data-taluk='<%= row.get("taluk") %>'
data-district='<%= row.get("district") %>'
data-state='<%= row.get("state") %>'
data-nationality='<%= row.get("nationality") %>'

data-religion='<%= row.get("religion_category") %>'
data-category='<%= row.get("category") %>'
data-cast='<%= row.get("cast") %>'
data-mt='<%= row.get("mother_tongue") %>'
data-blood='<%= row.get("blood_group") %>'

data-father='<%= row.get("father_guardian_name") %>'
data-focc='<%= row.get("father_occupation") %>'
data-forg='<%= row.get("Father_org") %>'

data-mother='<%= row.get("mother_name") %>'
data-mocc='<%= row.get("mother_occupation") %>'
data-morg='<%= row.get("Mother_org") %>'

data-income='<%= row.get("income") %>'

data-postal='<%= row.get("postal_address") %>'
data-permanent='<%= row.get("permanent_address") %>'

data-phone='<%= row.get("phone_no") %>'
data-whatsapp='<%= row.get("Whatsapp_no") %>'
data-email='<%= row.get("email") %>'

data-sslcstate='<%= row.get("SSLC_State") %>'

data-aadhar='<%= row.get("aadhar_no") %>'
data-apaar='<%= row.get("APAAR_ID") %>'

data-medium='<%= row.get("medium_of_instruction") %>'
data-year='<%= row.get("sscl_passing_year") %>'

data-board='<%= row.get("SSLC_Board") %>'
data-total='<%= row.get("SSLC_TMarks") %>'
data-aggr='<%= row.get("SSLC_Aggr") %>'

data-maths='<%= row.get("marks_maths") %>'
data-science='<%= row.get("marks_science") %>'

data-p1='<%= row.get("preference_1") %>'
data-p2='<%= row.get("preference_2") %>'
data-p3='<%= row.get("preference_3") %>'
data-p4='<%= row.get("preference_4") %>'
data-p5='<%= row.get("preference_5") %>'

data-created='<%= row.get("created_at") %>'

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

<!-- MODAL -->
<div class="modal fade" id="editModal">
<div class="modal-dialog modal-xl"> <!-- wider -->
<form method="post" action="AdmissionListServlet">
<div class="modal-content">

<div class="modal-header">
<h5>Edit Admission</h5>
<button type="button" class="close" data-dismiss="modal">&times;</button>
</div>

<div class="modal-body">

<input type="hidden" id="m_id" name="id">

<div class="row">

<!-- BASIC -->
<div class="col-md-4">
<label>APP NO</label>
<input id="m_appno" name="APPNO" class="form-control">
</div>

<div class="col-md-4">
<label>Cast No</label>
<input id="m_castno" name="cast_no" class="form-control">
</div>

<div class="col-md-4">
<label>Name</label>
<input id="m_name" name="applicant_name" class="form-control">
</div>

<div class="col-md-4">
<label>DOB</label>
<input type="date" id="m_dob" name="date_of_birth" class="form-control">
</div>

<div class="col-md-4">
<label>Gender</label>
<select id="m_gender" name="gender" class="form-control">
    <option value="">-- Select Gender --</option>
    <option value="M">Male</option>
    <option value="F">Female</option>
</select>
</div>

<div class="col-md-4">
<label>Admission Type</label>
<select id="m_admission" name="Admission_type" class="form-control">
    <option value="">-- Select Type --</option>
    <option value="Dayscholar">Dayscholar</option>
    <option value="Residential">Residential</option>
</select>
</div>

<!-- ADDRESS -->
<div class="col-md-4">
<label>Native</label>
<input id="m_native" name="native_place" class="form-control">
</div>

<div class="col-md-4">
<label>Taluk</label>
<input id="m_taluk" name="taluk" class="form-control">
</div>

<div class="col-md-4">
<label>District</label>
<input id="m_district" name="district" class="form-control">
</div>

<div class="col-md-4">
<label>State</label>
<input id="m_state" name="state" class="form-control">
</div>

<div class="col-md-4">
<label>Nationality</label>
<input id="m_nationality" name="nationality" class="form-control">
</div>

<!-- SOCIAL -->
<div class="col-md-4">
<label>Religion</label>
<input id="m_religion" name="religion_category" class="form-control">
</div>

<div class="col-md-4">
<label>Category</label>
<select id="m_category" name="category" class="form-control">
    <option value="">-- Select Category --</option>
    <option value="SC">SC</option>
    <option value="ST">ST</option>
    <option value="C-1">C-1</option>
    <option value="2A">2A</option>
    <option value="2B">2B</option>
    <option value="3A">3A</option>
    <option value="3B">3B</option>
    <option value="General">General</option>
</select>
</div>

<div class="col-md-4">
<label>Cast</label>
<input id="m_cast" name="cast" class="form-control">
</div>

<div class="col-md-4">
<label>Mother Tongue</label>
<input id="m_mt" name="mother_tongue" class="form-control">
</div>

<div class="col-md-4">
<label>Blood Group</label>
<input id="m_blood" name="blood_group" class="form-control">
</div>

<!-- PARENTS -->
<div class="col-md-4">
<label>Father Name</label>
<input id="m_father" name="father_guardian_name" class="form-control">
</div>

<div class="col-md-4">
<label>Father Occupation</label>
<input id="m_focc" name="father_occupation" class="form-control">
</div>

<div class="col-md-4">
<label>Father Org</label>
<input id="m_forg" name="Father_org" class="form-control">
</div>

<div class="col-md-4">
<label>Mother Name</label>
<input id="m_mother" name="mother_name" class="form-control">
</div>

<div class="col-md-4">
<label>Mother Occupation</label>
<input id="m_mocc" name="mother_occupation" class="form-control">
</div>

<div class="col-md-4">
<label>Mother Org</label>
<input id="m_morg" name="Mother_org" class="form-control">
</div>

<!-- CONTACT -->
<div class="col-md-4">
<label>Income</label>
<input id="m_income" name="income" class="form-control">
</div>

<div class="col-md-6">
<label>Postal Address</label>
<textarea id="m_postal" name="postal_address" class="form-control"></textarea>
</div>

<div class="col-md-6">
<label>Permanent Address</label>
<textarea id="m_permanent" name="permanent_address" class="form-control"></textarea>
</div>

<div class="col-md-4">
<label>Phone</label>
<input id="m_phone" name="phone_no" class="form-control">
</div>

<div class="col-md-4">
<label>Whatsapp</label>
<input id="m_whatsapp" name="Whatsapp_no" class="form-control">
</div>

<div class="col-md-4">
<label>Email</label>
<input id="m_email" name="email" class="form-control">
</div>

<div class="col-md-4">
<label>Aadhar</label>
<input id="m_aadhar" name="aadhar_no" class="form-control">
</div>

<div class="col-md-4">
<label>APAAR</label>
<input id="m_apaar" name="APAAR_ID" class="form-control">
</div>

<!-- EDUCATION -->
<div class="col-md-4">
<label>SSLC State</label>
<input id="m_sslcstate" name="SSLC_State" class="form-control">
</div>

<div class="col-md-4">
<label>Medium</label>
<input id="m_medium" name="medium_of_instruction" class="form-control">
</div>

<div class="col-md-4">
<label>Year</label>
<input id="m_year" name="sscl_passing_year" class="form-control">
</div>

<div class="col-md-4">
<label>Board</label>
<select id="m_board" name="SSLC_Board" class="form-control">
    <option value="">-- Select Board --</option>
    <option value="CBSE">CBSE</option>
    <option value="State">State</option>
    <option value="ICSE">ICSE</option>
</select>
</div>

<div class="col-md-4">
<label>Total Marks</label>
<input id="m_total" name="SSLC_TMarks" class="form-control">
</div>

<div class="col-md-4">
<label>Aggregate</label>
<input id="m_aggr" name="SSLC_Aggr" class="form-control">
</div>

<div class="col-md-4">
<label>Maths</label>
<input id="m_maths" name="marks_maths" class="form-control">
</div>

<div class="col-md-4">
<label>Science</label>
<input id="m_science" name="marks_science" class="form-control">
</div>

<!-- PREFERENCES -->
<div class="col-md-4"><label>Preference 1</label><input id="m_p1" name="preference_1" class="form-control"></div>
<div class="col-md-4"><label>Preference 2</label><input id="m_p2" name="preference_2" class="form-control"></div>
<div class="col-md-4"><label>Preference 3</label><input id="m_p3" name="preference_3" class="form-control"></div>
<div class="col-md-4"><label>Preference 4</label><input id="m_p4" name="preference_4" class="form-control"></div>
<div class="col-md-4"><label>Preference 5</label><input id="m_p5" name="preference_5" class="form-control"></div>

</div>
</div>

<div class="modal-footer">
<button type="submit" class="btn btn-success">Update</button>
</div>

</div>
</form>

</div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function editRecord(btn){
	let b=$(btn);

	// BASIC
	$('#m_id').val(b.attr('data-id'));
	$('#m_appno').val(b.attr('data-appno'));
	$('#m_castno').val(b.attr('data-castno'));

	$('#m_name').val(b.attr('data-name'));
	$('#m_dob').val(b.attr('data-dob'));
	$('#m_gender').val(b.attr('data-gender'));
	$('#m_admission').val(b.attr('data-admission'));

	// ADDRESS
	$('#m_native').val(b.attr('data-native'));
	$('#m_taluk').val(b.attr('data-taluk'));
	$('#m_district').val(b.attr('data-district'));
	$('#m_state').val(b.attr('data-state'));
	$('#m_nationality').val(b.attr('data-nationality'));

	// SOCIAL
	$('#m_religion').val(b.attr('data-religion'));
	$('#m_category').val(b.attr('data-category'));
	$('#m_cast').val(b.attr('data-cast'));
	$('#m_mt').val(b.attr('data-mt'));
	$('#m_blood').val(b.attr('data-blood'));

	// PARENTS
	$('#m_father').val(b.attr('data-father'));
	$('#m_focc').val(b.attr('data-focc'));
	$('#m_forg').val(b.attr('data-forg'));

	$('#m_mother').val(b.attr('data-mother'));
	$('#m_mocc').val(b.attr('data-mocc'));
	$('#m_morg').val(b.attr('data-morg'));

	// CONTACT
	$('#m_income').val(b.attr('data-income'));
	$('#m_postal').val(b.attr('data-postal'));
	$('#m_permanent').val(b.attr('data-permanent'));

	$('#m_phone').val(b.attr('data-phone'));
	$('#m_whatsapp').val(b.attr('data-whatsapp'));
	$('#m_email').val(b.attr('data-email'));

	$('#m_aadhar').val(b.attr('data-aadhar'));
	$('#m_apaar').val(b.attr('data-apaar'));

	// EDUCATION
	$('#m_sslcstate').val(b.attr('data-sslcstate'));
	$('#m_medium').val(b.attr('data-medium'));
	$('#m_year').val(b.attr('data-year'));

	$('#m_board').val(b.attr('data-board'));
	$('#m_total').val(b.attr('data-total'));
	$('#m_aggr').val(b.attr('data-aggr'));

	$('#m_maths').val(b.attr('data-maths'));
	$('#m_science').val(b.attr('data-science'));

	// PREFERENCES
	$('#m_p1').val(b.attr('data-p1'));
	$('#m_p2').val(b.attr('data-p2'));
	$('#m_p3').val(b.attr('data-p3'));
	$('#m_p4').val(b.attr('data-p4'));
	$('#m_p5').val(b.attr('data-p5'));

	$('#editModal').modal('show');
	}
</script>

</body>
</html>