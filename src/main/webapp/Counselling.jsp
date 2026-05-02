<%@ page import="java.util.*" %>
<!DOCTYPE html>

<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Counselling - Seat Allotment</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style>
body { background:#f4f6f9; }

/* TITLE */
h3 {
    text-align:center;
    margin:12px 0;
    font-weight:600;
}

/* MAIN TABLE BOX */
.main-box {
    background:#fff;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
    padding:8px;
    height:88vh;
    overflow:auto;
}

/* STICKY HEADER */
thead th {
    position: sticky;
    top: 0;
    z-index: 2;
}

/* TABLE */
.table {
    table-layout: fixed;
    width:100%;
}

.table th {
    background:#002147;
    color:#fff;
    text-align:center;
    font-size:13px;
}

.table td {
    text-align:center;
    font-size:13px;
}

/* COLUMN WIDTH CONTROL */
.col-id { width:5%; }
.col-app { width:12%; }
.col-name { width:28%; text-align:left; }
.col-total { width:8%; }
.col-seat { width:15%; }
.col-cat { width:15%; }
.col-action { width:12%; }

/* NAME */
.name-cell {
     text-align:left !important;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

/* SELECT FULL WIDTH */
select {
    width:100%;
}

/* DASHBOARD */
.dashboard {
    height:88vh;
    overflow-y:auto;
}

/* GRID (RESPONSIVE FOR BIG SCREENS) */
.dashboard-grid {
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:10px;
}

@media (min-width:1400px){
    .dashboard-grid{
        grid-template-columns:repeat(3,1fr);
    }
}

/* CARD */
.branch-box{
    background:#fff;
    border-radius:10px;
    padding:8px;
    box-shadow:0 2px 6px rgba(0,0,0,0.1);
}

/* STATUS */
.full { color:red; font-weight:bold; }
.available { color:green; font-weight:bold; }

/* BUTTON */
.btn-sm { padding:3px 8px; font-size:12px; }

</style>
</head>

<body>

<%@ include file="header.jsp" %>

<h3>Seat Allotment (Counselling)</h3>

<div class="container-fluid">
<div class="row">

<!-- LEFT SIDE -->
<div class="col-lg-8">
<div class="main-box">

<table class="table table-bordered table-sm table-hover">

<thead>
<tr>
    <th class="col-id">Rank</th>
    <th class="col-app">App</th>
    <th class="col-name">Name</th>
    <th class="col-total">Total</th>
    <th class="col-seat">Seat</th>
    <th class="col-cat">Category</th>
    <th class="col-action">Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");
int i = 1;

for(Map<String,String> row:list){
%>

<tr data-id="<%=row.get("id")%>">

<td><%=i++%></td>

<td>
    <%=row.get("APPNO")%><br>
    <small><%=row.get("cast_no")%></small>
</td>

<td class="name-cell" title="<%=row.get("name")%>" >
    <b><%=row.get("name")%> (<%=row.get("gender")%>)</b>
</td>

<td><b><%=row.get("Total")%></b></td>

<td>
<select class="form-control seat editable" disabled>
<option value="">Select</option>
<option value="ME" <%= "ME".equals(row.get("Seat_Allot"))?"selected":"" %>>ME</option>
<option value="EE" <%= "EE".equals(row.get("Seat_Allot"))?"selected":"" %>>EE</option>
<option value="CS" <%= "CS".equals(row.get("Seat_Allot"))?"selected":"" %>>CS</option>
<option value="EC" <%= "EC".equals(row.get("Seat_Allot"))?"selected":"" %>>EC</option>
<option value="CE" <%= "CE".equals(row.get("Seat_Allot"))?"selected":"" %>>CE</option>
</select>
</td>

<td>
<select class="form-control cat editable" disabled>
<option value="">Select</option>
<option value="General" <%= "General".equals(row.get("Special_Catg"))?"selected":"" %>>General</option>
<option value="Arjas" <%= "Arjas".equals(row.get("Special_Catg"))?"selected":"" %>>Arjas</option>
<option value="SMIORE" <%= "SMIORE".equals(row.get("Special_Catg"))?"selected":"" %>>SMIORE</option>
<option value="SVPS" <%= "SVPS".equals(row.get("Special_Catg"))?"selected":"" %>>SVPS</option>
</select>
</td>

<td>
<button class="btn btn-primary btn-sm editBtn">Edit</button>
<button class="btn btn-success btn-sm saveBtn" style="display:none;">Save</button>
</td>

</tr>

<% } %>

</tbody>
</table>

</div>
</div>

<!-- RIGHT SIDE -->
<div class="col-lg-4">
<div class="dashboard">

<h5 class="text-center mb-2">Seat Availability</h5>

<div class="dashboard-grid">

<%
Map<String, Map<String,Integer>> seatMap =
(Map<String, Map<String,Integer>>)request.getAttribute("seatMap");

String[] branches = {"ME","EE","CS","EC","CE"};

for(String br : branches){
%>

<div class="branch-box">

<b><%=br%></b>

<table class="table table-sm">
<tr><th>Cat</th><th>F</th><th>T</th></tr>

<%
for(String cat : seatMap.keySet()){
Map<String,Integer> b = seatMap.get(cat);

int total = b.getOrDefault(br+"_total",0);
int used = b.getOrDefault(br+"_used",0);
String cls = (used>=total)?"full":"available";
%>

<tr>
<td><%=cat%></td>
<td class="<%=cls%>"><%=used%></td>
<td><%=total%></td>
</tr>

<% } %>

</table>

</div>

<% } %>

</div>

</div>
</div>

</div>
</div>

<!-- AJAX SCRIPT -->

<script>

// EDIT
$(document).on('click','.editBtn',function(){
    let row=$(this).closest('tr');
    row.find('.editable').prop('disabled',false);
    row.find('.editBtn').hide();
    row.find('.saveBtn').show();
});

// SAVE (AJAX)
$(document).on('click','.saveBtn',function(){

    let row=$(this).closest('tr');

    let id=row.data('id');
    let seat=row.find('.seat').val();
    let cat=row.find('.cat').val();

    $.ajax({
        url:'Counselling',
        method:'POST',
        data:{
            id:id,
            Seat_Allot:seat,
            Special_Catg:cat
        },
        success:function(){

            row.find('.editable').prop('disabled',true);
            row.find('.editBtn').show();
            row.find('.saveBtn').hide();

            // 🔥 OPTIONAL: update dashboard via AJAX later
        }
    });

});

</script>

</body>
</html>