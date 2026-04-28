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
<style>

body { 
    background:#f4f6f9; 
    margin:0;
    padding:0;
}

/* Full-width container */
.container-fluid {
    padding:20px;
}

/* Box styling */
.container-box {
    background:#fff;
    padding:30px;
    border-radius:8px;
    margin-top:20px;
    width:auto;
    max-width:auto;
    overflow:hidden;
}

/* Responsive table wrapper */
.table-responsive {
    width:100%;
    overflow-x:auto;        /* horizontal scroll if needed */
}

/* Table styling */
.table {
    width:100%;
    border-collapse:collapse;
    min-width:1200px;       /* ensures columns don’t shrink too much */
}

/* Header */
.table th { 
    background:#002147; 
    color:#fff; 
    text-align:center; 
    padding:14px;
    font-size:14px;
    white-space:nowrap;     /* keep header in one line */
}

/* Cells */
.table td { 
    text-align:center; 
    padding:10px;
    white-space:nowrap;     /* prevents text breaking */
}

/* Inputs inside table */
.table input {
    width:100%;
    min-width:120px;        /* prevents too small inputs */
    padding:6px;
    text-align:center;
    box-sizing:border-box;
}

/* Optional: better hover effect */
.table tbody tr:hover {
    background:#f1f1f1;
}

/* Optional: zebra rows */
.table tbody tr:nth-child(even) {
    background:#fafafa;
}

</style>
</head>

<body>
<%@ include file="header.jsp" %>
<div class="container">
<div class="container-box">

<h3>Marks Entry </h3>

<div class="table-responsive">
<table class="table table-bordered table-sm table-hover">

<thead>
<tr>
    <th>ID</th>
    <th>App. No</th>
    <th>Catg. No</th>
    <th>Name</th>
    <th>Maths</th>
    <th>Science</th>
    <th>Aggr</th>
    <th>Board(CBSE/ICSE)</th>
    <th>PUC</th>
    <th>Girls</th>
    <th>ET Maths</th>
    <th>ET Science</th>
    <th>ET Total</th>
    <th>Grand Total</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");

if(list!=null && !list.isEmpty()){
 for(Map<String,String> row:list){

String id=row.get("id");
%>

<form method="post" action="Marks">
<tr>

<td>
    <input type="hidden" name="id" value="<%=id%>">
    <%=id%>
</td>


<td style="text-align:left;"><%=row.get("APPNO")%></td>
<td style="text-align:left;"><%=row.get("cast_no")%></td>
<td style="text-align:left;"><%=row.get("name")%></td>

<td><input name="maths" value="<%=row.get("maths")%>" class="form-control" readonly></td>
<td><input name="science" value="<%=row.get("science")%>" class="form-control" readonly></td>

<td><input name="aggr" value="<%=row.get("aggr")%>" class="form-control" readonly></td>

<% if("Office".equalsIgnoreCase(role)||"Global".equalsIgnoreCase(role)){%>
<td><input name="board" value="<%=row.get("board")%>" class="form-control calc"></td>
<td><input name="puc" value="<%=row.get("puc")%>" class="form-control calc"></td>
<td><input name="girls" value="<%=row.get("girls")%>" class="form-control calc"></td>
<%} else {%>
<td><input name="board" value="<%=row.get("board")%>" class="form-control calc" readonly></td>
<td><input name="puc" value="<%=row.get("puc")%>" class="form-control calc" readonly></td>
<td><input name="girls" value="<%=row.get("girls")%>" class="form-control calc" readonly></td>
<%} %>


<% if("Academics".equalsIgnoreCase(role)){%>
<td><input name="ET_m" value="<%=row.get("ET_m")%>" class="form-control calc"></td>
<td><input name="ET_s" value="<%=row.get("ET_s")%>" class="form-control calc"></td>
<%}else { %>
<td><input name="ET_m" value="<%=row.get("ET_m")%>" class="form-control calc" readonly></td>
<td><input name="ET_s" value="<%=row.get("ET_s")%>" class="form-control calc" readonly></td>
<%} %>

<td><input name="ET_T" value="<%=row.get("ET_T")%>" class="form-control" readonly></td>

<td><input name="Total" value="<%=row.get("Total")%>" class="form-control" readonly></td>

<td>
    <button class="btn btn-success btn-sm">Save</button>
</td>

</tr>
</form>

<% }} else { %>
<tr><td colspan="13" class="text-danger">No Records</td></tr>
<% } %>

</tbody>
</table>
</div>

</div>
</div>

<!-- ================= SCRIPT ================= -->

<script>

$(document).on('input', '.calc', function(){

let row=$(this).closest('tr');

let m=parseFloat(row.find('[name="maths"]').val())||0;
let s=parseFloat(row.find('[name="science"]').val())||0;

let board=parseFloat(row.find('[name="board"]').val())||0;
let puc=parseFloat(row.find('[name="puc"]').val())||0;
let girls=parseFloat(row.find('[name="girls"]').val())||0;

let etm=parseFloat(row.find('[name="ET_m"]').val())||0;
let ets=parseFloat(row.find('[name="ET_s"]').val())||0;

// Aggregate
let avg=(m+s)/2;
row.find('[name="aggr"]').val(avg.toFixed(2));

// ET Total
let ett=(etm+ets)/2;
row.find('[name="ET_T"]').val(ett.toFixed(2));

// Final Total
let total=(avg+ett)/2 + board + puc + girls;
row.find('[name="Total"]').val(total.toFixed(2));

});

</script>

</body>
</html>