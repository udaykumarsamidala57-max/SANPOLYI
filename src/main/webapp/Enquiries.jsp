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
h4 { margin-bottom:15px; }

.table-wrapper { overflow-x:auto; }

table { width:100%; background:white; border-collapse:collapse; }

th, td {
    border:1px solid #ddd;
    padding:6px;
    font-size:12px;
    white-space:nowrap;
    text-align:left;
}

th {
    background:#f3f3f3;
    font-weight:bold;
}

input, textarea, select {
    margin-bottom:5px;
}

.modal-body {
    max-height:70vh;
    overflow-y:auto;
}
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

String dob = (row.get("date_of_birth") != null) ? row.get("date_of_birth").toString() : "";
%>

<tr>

<td><%= row.get("id") %></td>
<td><%= row.get("APPNO") %></td>
<td><%= row.get("cast_no") %></td>
<td><%= row.get("applicant_name") %></td>
<td><%= dob %></td>
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
<td><%= row.get("Whatsapp_no") %></td>
<td><%= row.get("email") %></td>
<td><%= row.get("SSLC_State") %></td>

<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("APAAR_ID") %></td>

<td><%= row.get("medium_of_instruction") %></td>
<td><%= row.get("sscl_passing_year") %></td>
<td><%= row.get("SSLC_Board") %></td>
<td><%= row.get("SSLC_TMarks") %></td>
<td><%= row.get("SSLC_Aggr") %></td>

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
data-dob='<%= dob %>'
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

<!-- ================= EDIT MODAL ================= -->
<div class="modal fade" id="editModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <form method="post" action="Enquiries">

        <div class="modal-header">
          <h5 class="modal-title">Edit Admission</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <div class="modal-body">

          <input type="hidden" id="m_id" name="id">

          <div class="row">

            <!-- EXISTING FIELDS (NO CHANGE) -->

            <div class="col-md-3">
              <label>App No</label>
              <input type="text" class="form-control" id="m_appno" name="APPNO">
            </div>

            <div class="col-md-3">
              <label>Cast No</label>
              <input type="text" class="form-control" id="m_castno" name="cast_no">
            </div>

            <div class="col-md-6">
              <label>Name</label>
              <input type="text" class="form-control" id="m_name" name="applicant_name">
            </div>

            <div class="col-md-4">
              <label>DOB</label>
              <input type="date" class="form-control" id="m_dob" name="date_of_birth">
            </div>

            <div class="col-md-4">
              <label>Gender</label>
              <input type="text" class="form-control" id="m_gender" name="gender">
            </div>

            <div class="col-md-4">
              <label>Admission</label>
              <input type="text" class="form-control" id="m_admission" name="Admission_type">
            </div>

            <!-- ✅ ADD THESE MISSING FIELDS -->

            <div class="col-md-6">
              <label>Postal Address</label>
              <textarea class="form-control" id="m_postal" name="postal_address"></textarea>
            </div>

            <div class="col-md-6">
              <label>Permanent Address</label>
              <textarea class="form-control" id="m_permanent" name="permanent_address"></textarea>
            </div>

            <div class="col-md-4">
              <label>Total Marks</label>
              <input type="text" class="form-control" id="m_total" name="SSLC_TMarks">
            </div>

            <div class="col-md-4">
              <label>Aggregate</label>
              <input type="text" class="form-control" id="m_aggr" name="SSLC_Aggr">
            </div>

            <div class="col-md-4">
              <label>Maths</label>
              <input type="text" class="form-control" id="m_maths" name="marks_maths">
            </div>

            <div class="col-md-4">
              <label>Science</label>
              <input type="text" class="form-control" id="m_science" name="marks_science">
            </div>

            <!-- Preferences -->
            <div class="col-md-4">
              <label>Preference 1</label>
              <input type="text" class="form-control" id="m_p1" name="preference_1">
            </div>

            <div class="col-md-4">
              <label>Preference 2</label>
              <input type="text" class="form-control" id="m_p2" name="preference_2">
            </div>

            <div class="col-md-4">
              <label>Preference 3</label>
              <input type="text" class="form-control" id="m_p3" name="preference_3">
            </div>

            <div class="col-md-4">
              <label>Preference 4</label>
              <input type="text" class="form-control" id="m_p4" name="preference_4">
            </div>

            <div class="col-md-4">
              <label>Preference 5</label>
              <input type="text" class="form-control" id="m_p5" name="preference_5">
            </div>

          </div>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Update</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>

      </form>

    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function editRecord(btn){
	let b=$(btn);

	$('#m_id').val(b.data('id'));
	$('#m_appno').val(b.data('appno'));
	$('#m_castno').val(b.data('castno'));
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
	$('#m_cast').val(b.data('cast'));
	$('#m_mt').val(b.data('mt'));
	$('#m_blood').val(b.data('blood'));

	$('#m_father').val(b.data('father'));
	$('#m_focc').val(b.data('focc'));
	$('#m_forg').val(b.data('forg'));

	$('#m_mother').val(b.data('mother'));
	$('#m_mocc').val(b.data('mocc'));
	$('#m_morg').val(b.data('morg'));

	$('#m_income').val(b.data('income'));
	$('#m_postal').val(b.data('postal'));
	$('#m_permanent').val(b.data('permanent'));

	$('#m_phone').val(b.data('phone'));
	$('#m_whatsapp').val(b.data('whatsapp'));
	$('#m_email').val(b.data('email'));

	$('#m_aadhar').val(b.data('aadhar'));
	$('#m_apaar').val(b.data('apaar'));

	$('#m_sslcstate').val(b.data('sslcstate'));
	$('#m_medium').val(b.data('medium'));
	$('#m_year').val(b.data('year'));

	$('#m_board').val(b.data('board'));
	$('#m_total').val(b.data('total'));
	$('#m_aggr').val(b.data('aggr'));

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