<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String role = (String) sess.getAttribute("role");
String User = (String) sess.getAttribute("username");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Marks Entry</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
body { background:#f4f6f9; }
.table{
width :90%;
 margin: 0 auto;
}
.table th { background:#002147; color:#fff; text-align:center; }
.table td { text-align:center; }
input { text-align:center;  }
</style>
</head>

<body>
<%@ include file="header.jsp" %>

<h3>Marks Entry </h3>

<div class="table-responsive">
<table class="table table-bordered table-sm table-hover">

<thead>
<tr>
    <th>ID</th>
    <th>App. No</th>
    <th>Catg. No</th>
    <th>Name</th>
    <th>Gender</th>
    <th>Board</th>
    <th>Maths</th>
    <th>Science</th>
    <th>Aggregate</th>
    <th>Board(CBSE/ICSE)</th>
    <th>PUC</th>
    <th>Girls</th>
    <th>Present/Absent</th>
    <th>ET Maths</th>
    <th>ET Science</th>
    <th>ET Avg.</th>
    <th>Grand Total</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");
int i = 1;
if(list!=null && !list.isEmpty()){
 for(Map<String,String> row:list){

String id=row.get("id");
%>

<form method="post" action="Marks">
<tr>
<input type="hidden" name="id" value="<%=id%>">

<td><%= i++ %></td>

<td style="text-align:left;"><%=row.get("APPNO")%></td>
<td style="text-align:left;"><%=row.get("cast_no")%></td>
<td style="text-align:left;"><%=row.get("name")%></td>
<td style="text-align:left;"><%=row.get("gender")%></td>

<td style="text-align:left;"><%=row.get("SSLC_Board")%></td>

<td><input name="maths" value="<%=row.get("maths")%>" class="form-control" readonly></td>
<td><input name="science" value="<%=row.get("science")%>" class="form-control" readonly></td>

<td><input name="aggr" class="form-control" readonly></td>

<% if("Office".equalsIgnoreCase(role)||"Global".equalsIgnoreCase(role)){%>
<td><input name="board" value="<%=row.get("board")%>" class="form-control calc editable" disabled></td>
<td><input name="puc" value="<%=row.get("puc")%>" class="form-control calc editable" disabled></td>
<td><input name="girls" value="<%=row.get("girls")%>" class="form-control calc editable" disabled></td>
<%} else {%>
<td><input name="board" value="<%=row.get("board")%>" class="form-control calc" readonly></td>
<td><input name="puc" value="<%=row.get("puc")%>" class="form-control calc" readonly></td>
<td><input name="girls" value="<%=row.get("girls")%>" class="form-control calc" readonly></td>
<%} %>

<% if("Academics".equalsIgnoreCase(role)||"Global".equalsIgnoreCase(role)){%>
<td>
    <select name="Attendance" class="form-control editable" disabled>
        <option value="P" <%= "P".equals(row.get("Attendance")) ? "selected" : "" %>>P</option>
        <option value="AB" <%= "AB".equals(row.get("Attendance")) ? "selected" : "" %>>AB</option>
    </select>
</td>
<td><input name="ET_m" value="<%=row.get("ET_m")%>" class="form-control calc editable" disabled></td>
<td><input name="ET_s" value="<%=row.get("ET_s")%>" class="form-control calc editable" disabled></td>
<%}else { %>
<td>
    <select name="Attendance" class="form-control editable" disabled>
        <option value="P" <%= "P".equals(row.get("Attendance")) ? "selected" : "" %>>P</option>
        <option value="AB" <%= "AB".equals(row.get("Attendance")) ? "selected" : "" %>>AB</option>
    </select>
</td>
<td><input name="ET_m" value="<%=row.get("ET_m")%>" class="form-control calc" readonly></td>
<td><input name="ET_s" value="<%=row.get("ET_s")%>" class="form-control calc" readonly></td>
<%} %>

<td><input name="ET_T" value="<%=row.get("ET_T")%>" class="form-control" readonly></td>
<td><input name="Total" value="<%=row.get("Total")%>" class="form-control" readonly></td>

<td>
    <button type="button" class="btn btn-primary btn-sm editBtn">Edit</button>
    <button type="button" class="btn btn-success btn-sm saveBtn" style="display:none;">Save</button>
</td>

</tr>
</form>

<% }} else { %>
<tr><td colspan="18" class="text-danger">No Records</td></tr>
<% } %>

</tbody>
</table>
</div>

<!-- ================= SCRIPT ================= -->

<script>

// 🔹 CALCULATION (UNCHANGED)
function calculateRow(row){

    let attendance = row.find('[name="Attendance"]').val();

    let m = parseFloat(row.find('[name="maths"]').val()) || 0;
    let s = parseFloat(row.find('[name="science"]').val()) || 0;

    let board = parseFloat(row.find('[name="board"]').val()) || 0;
    let puc = parseFloat(row.find('[name="puc"]').val()) || 0;
    let girls = parseFloat(row.find('[name="girls"]').val()) || 0;

    let etm = parseFloat(row.find('[name="ET_m"]').val()) || 0;
    let ets = parseFloat(row.find('[name="ET_s"]').val()) || 0;

    let avg = (m + s) / 2;
    row.find('[name="aggr"]').val(avg.toFixed(2));

    let ett = (etm + ets) / 2;
    row.find('[name="ET_T"]').val(ett.toFixed(2));

    if(attendance === "AB"){
        row.find('[name="Total"]').val("AB");
        return;
    }

    let total = (avg + ett) /2 + board + puc + girls;
    row.find('[name="Total"]').val(total.toFixed(2));
}


// 🔹 EDIT CLICK (UNCHANGED)
$(document).on('click', '.editBtn', function () {
    let row = $(this).closest('tr');

    row.find('.editable').prop('disabled', false);

    row.find('.editBtn').hide();
    row.find('.saveBtn').show();
});


// 🔥 SAVE USING CLICK (NO FORM SUBMIT)
$(document).on('click', '.saveBtn', function () {

    let row = $(this).closest('tr');

    let data = {
        id: row.find('[name="id"]').val(),
        maths: row.find('[name="maths"]').val(),
        science: row.find('[name="science"]').val(),
        board: row.find('[name="board"]').val(),
        puc: row.find('[name="puc"]').val(),
        girls: row.find('[name="girls"]').val(),
        Attendance: row.find('[name="Attendance"]').val(),
        ET_m: row.find('[name="ET_m"]').val(),
        ET_s: row.find('[name="ET_s"]').val(),
        ET_T: row.find('[name="ET_T"]').val(),
        Total: row.find('[name="Total"]').val()
    };

    $.ajax({
        url: "Marks",
        type: "POST",
        data: data,

        success: function (res) {

            row.find('.editable').prop('disabled', true);
            row.find('.editBtn').show();
            row.find('.saveBtn').hide();

            // optional
            // alert("Saved");

        },
        error: function () {
            alert("Error saving data");
        }
    });

});


// 🔹 CALC TRIGGER (UNCHANGED)
$(document).on('input', '.calc', function(){
    let row = $(this).closest('tr');
    calculateRow(row);
});


// 🔹 LOAD CALC (UNCHANGED)
$(document).ready(function(){
    $('tbody tr').each(function(){
        calculateRow($(this));

        let row = $(this);
        let attendance = row.find('[name="Attendance"]').val();

        if(attendance === "AB"){
            row.find('[name="ET_m"], [name="ET_s"]').val(0).prop('disabled', true);
            row.find('[name="Total"]').val("AB");
        }
    });
});


// 🔹 Attendance change (UNCHANGED)
$(document).on('change', '[name="Attendance"]', function () {
    let row = $(this).closest('tr');
    let val = $(this).val();

    if (val === 'AB') {
        row.find('[name="ET_m"], [name="ET_s"]').val(0).prop('disabled', true);
    } else {
        row.find('[name="ET_m"], [name="ET_s"]').prop('disabled', false);
    }

    calculateRow(row);
});

</script>

</body>
</html>