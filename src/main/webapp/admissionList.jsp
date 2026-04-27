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
th,td { border:1px solid #ddd; padding:6px; font-size:12px; }
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
<th>ID</th>
<th>Name</th>
<th>DOB</th>
<th>Gender</th>
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

<td>
<button onclick="editRecord(this)"

data-id='<%= row.get("id") %>'
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
data-mt='<%= row.get("mother_tongue") %>'
data-blood='<%= row.get("blood_group") %>'

data-father='<%= row.get("father_guardian_name") %>'
data-foccupation='<%= row.get("father_occupation") %>'
data-forg='<%= row.get("Father_org") %>'

data-mother='<%= row.get("mother_name") %>'
data-moccupation='<%= row.get("mother_occupation") %>'
data-morg='<%= row.get("Mother_org") %>'

data-income='<%= row.get("income") %>'

data-postal='<%= row.get("postal_address") %>'
data-permanent='<%= row.get("permanent_address") %>'

data-phone='<%= row.get("phone_no") %>'
data-whatsapp='<%= row.get("Whatsapp_no") %>'
data-email='<%= row.get("email") %>'
data-aadhar='<%= row.get("aadhar_no") %>'
data-apaar='<%= row.get("APAAR_ID") %>'

data-medium='<%= row.get("medium_of_instruction") %>'
data-sscl='<%= row.get("sscl_passing_year") %>'
data-board='<%= row.get("SSLC_Board") %>'
data-tmarks='<%= row.get("SSLC_TMarks") %>'

data-maths='<%= row.get("marks_maths") %>'
data-science='<%= row.get("marks_science") %>'

data-p1='<%= row.get("preference_1") %>'
data-p2='<%= row.get("preference_2") %>'
data-p3='<%= row.get("preference_3") %>'
data-p4='<%= row.get("preference_4") %>'
data-p5='<%= row.get("preference_5") %>'

class="btn btn-primary btn-sm"
>
Edit
</button>
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

<input class="form-control col-md-6" name="applicant_name" id="m_name" placeholder="Name">
<input class="form-control col-md-6" type="date" name="date_of_birth" id="m_dob">

<input class="form-control col-md-6" name="gender" id="m_gender" placeholder="Gender">
<input class="form-control col-md-6" name="Admission_type" id="m_admission" placeholder="Admission Type">

<input class="form-control col-md-6" name="native_place" id="m_native" placeholder="Native">
<input class="form-control col-md-6" name="taluk" id="m_taluk" placeholder="Taluk">

<input class="form-control col-md-6" name="district" id="m_district" placeholder="District">
<input class="form-control col-md-6" name="state" id="m_state" placeholder="State">

<input class="form-control col-md-6" name="nationality" id="m_nationality" placeholder="Nationality">
<input class="form-control col-md-6" name="religion_category" id="m_religion" placeholder="Religion">

<input class="form-control col-md-6" name="category" id="m_category" placeholder="Category">
<input class="form-control col-md-6" name="mother_tongue" id="m_mt" placeholder="Mother Tongue">

<input class="form-control col-md-6" name="blood_group" id="m_blood" placeholder="Blood Group">

<input class="form-control col-md-6" name="father_guardian_name" id="m_father" placeholder="Father">
<input class="form-control col-md-6" name="father_occupation" id="m_foccupation" placeholder="Father Occupation">

<input class="form-control col-md-6" name="Father_org" id="m_forg" placeholder="Father Org">

<input class="form-control col-md-6" name="mother_name" id="m_mother" placeholder="Mother">
<input class="form-control col-md-6" name="mother_occupation" id="m_moccupation" placeholder="Mother Occupation">

<input class="form-control col-md-6" name="Mother_org" id="m_morg" placeholder="Mother Org">

<input class="form-control col-md-6" name="income" id="m_income" placeholder="Income">

<textarea class="form-control col-md-6" name="postal_address" id="m_postal"></textarea>
<textarea class="form-control col-md-6" name="permanent_address" id="m_permanent"></textarea>

<input class="form-control col-md-6" name="phone_no" id="m_phone">
<input class="form-control col-md-6" name="Whatsapp_no" id="m_whatsapp">

<input class="form-control col-md-6" name="email" id="m_email">
<input class="form-control col-md-6" name="aadhar_no" id="m_aadhar">

<input class="form-control col-md-6" name="APAAR_ID" id="m_apaar">

<input class="form-control col-md-6" name="medium_of_instruction" id="m_medium">
<input class="form-control col-md-6" name="sscl_passing_year" id="m_sscl">

<input class="form-control col-md-6" name="SSLC_Board" id="m_board">
<input class="form-control col-md-6" name="SSLC_TMarks" id="m_tmarks">

<input class="form-control col-md-6" name="marks_maths" id="m_maths">
<input class="form-control col-md-6" name="marks_science" id="m_science">

<input class="form-control col-md-6" name="preference_1" id="m_p1">
<input class="form-control col-md-6" name="preference_2" id="m_p2">

<input class="form-control col-md-6" name="preference_3" id="m_p3">
<input class="form-control col-md-6" name="preference_4" id="m_p4">

<input class="form-control col-md-6" name="preference_5" id="m_p5">

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

$('#m_id').val(b.data('id'));
$('#m_name').val(b.data('name'));
$('#m_dob').val(b.data('dob'));
$('#m_gender').val(b.data('gender'));
$('#m_admission').val(b.data('admission'));

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
$('#m_foccupation').val(b.data('foccupation'));
$('#m_forg').val(b.data('forg'));

$('#m_mother').val(b.data('mother'));
$('#m_moccupation').val(b.data('moccupation'));
$('#m_morg').val(b.data('morg'));

$('#m_income').val(b.data('income'));

$('#m_postal').val(b.data('postal'));
$('#m_permanent').val(b.data('permanent'));

$('#m_phone').val(b.data('phone'));
$('#m_whatsapp').val(b.data('whatsapp'));
$('#m_email').val(b.data('email'));
$('#m_aadhar').val(b.data('aadhar'));
$('#m_apaar').val(b.data('apaar'));

$('#m_medium').val(b.data('medium'));
$('#m_sscl').val(b.data('sscl'));
$('#m_board').val(b.data('board'));
$('#m_tmarks').val(b.data('tmarks'));

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