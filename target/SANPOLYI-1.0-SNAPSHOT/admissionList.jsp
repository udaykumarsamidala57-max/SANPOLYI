<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admission Records</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        /* Keep your existing CSS here */
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f4f6f9; }
        .container { width: 95%; margin: 30px auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .header { background: #002147; color: white; padding: 15px 30px; font-size: 22px; font-weight: bold; }
    </style>
</head>
<body>

<div class="header">SANPOLY</div>
<div class="container">
    <div class="title">Admission Records</div>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>ID</th><th>Name</th><th>DOB</th><th>Gender</th><th>Phone</th><th>Email</th><th>Actions</th>
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
            <td><%= row.get("phone_no") %></td>
            <td><%= row.get("email") %></td>
            <td>
                <button class="btn btn-primary btn-sm" onclick="editRecord(this)" 
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
                    data-mother-tongue='<%= row.get("mother_tongue") %>'
                    data-blood='<%= row.get("blood_group") %>'
                    data-father='<%= row.get("father_guardian_name") %>'
                    data-mother='<%= row.get("mother_name") %>'
                    data-occupation='<%= row.get("occupation") %>'
                    data-income='<%= row.get("income") %>'
                    data-postal='<%= row.get("postal_address") %>'
                    data-permanent='<%= row.get("permanent_address") %>'
                    data-phone='<%= row.get("phone_no") %>'
                    data-email='<%= row.get("email") %>'
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
        <% } } %>
        </tbody>
    </table>
</div>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <form method="post" action="AdmissionListServlet">
            <div class="modal-content">
                <div class="modal-header"><h5>Edit Admission</h5></div>
                <div class="modal-body">
                    <input type="hidden" name="id" id="m_id">
                    <div class="row">
                        <div class="col-md-6"><label>Name</label><input type="text" name="applicant_name" id="m_name" class="form-control"></div>
                        <div class="col-md-6"><label>Phone</label><input type="text" name="phone_no" id="m_phone" class="form-control"></div>
                        <div class="col-md-6"><label>Email</label><input type="text" name="email" id="m_email" class="form-control"></div>
                        <div class="col-md-6"><label>Aadhaar</label><input type="text" name="aadhar_no" value="[Redacted]" class="form-control" readonly></div>
                    </div>
                </div>
                <div class="modal-footer"><button type="submit" class="btn btn-success">Update</button></div>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function editRecord(btn) {
    const b = $(btn);
    $('#m_id').val(b.data('id'));
    $('#m_name').val(b.data('name'));
    $('#m_phone').val(b.data('phone'));
    $('#m_email').val(b.data('email'));
    $('#editModal').modal('show');
}
</script>
</body>
</html>