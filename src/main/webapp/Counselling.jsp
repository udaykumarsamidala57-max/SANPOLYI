<%@ page import="java.util.*" %>

<!DOCTYPE html>

<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String role = (String) sess.getAttribute("role");
if (!"Global".equalsIgnoreCase(role)) {
    out.println("<h3 style='color:red;text-align:center;'>Access Denied!</h3>");
    return;
}
%>
<%! 
    public String val(Object o) {
        return (o == null) ? "" : o.toString();
    }
%>
<html>
<head>
<meta charset="UTF-8">
<title>Counselling - Seat Allotment</title>

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<style>

body { background:#f4f6f9; }

h3 {
    text-align:center;
    margin:10px 0;
    font-weight:600;
}

.main-box {
    background:#fff;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
    padding:8px;
    height:88vh;
    overflow:auto;
}

.table {
    table-layout:fixed;
    width:100%;
    margin:0;
}

.table th {
    background:#002147;
    color:#fff;
    font-size:13px;
    text-align:center;
}

.table td {
    font-size:13px;
    text-align:center;
    vertical-align:middle;
}

thead th {
    position:sticky;
    top:0;
    z-index:2;
}

.col-rank { width:5%; }
.col-app  { width:8%; }
.col-name { width:20%; }
.col-total{ width:6%; }
.col-branch{ width:12%; }
.col-seg  { width:10%; }
.col-sp   { width:13%; }
.col-act  { width:8%; }

.name-cell {
    text-align:left !important;
    white-space:nowrap;
    overflow:hidden;
    text-overflow:ellipsis;
}

select {
    width:100%;
    font-size:12px;
}

.dashboard {
    height:88vh;
    overflow-y:auto;
}

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

.branch-box{
    background:#fff;
    border-radius:10px;
    padding:8px;
    box-shadow:0 2px 6px rgba(0,0,0,0.1);
}

.full { color:red; font-weight:bold; }
.available { color:green; font-weight:bold; }

.btn-sm { padding:3px 8px; font-size:12px; }

.confirmed-row {
    background-color: #edf7ed;   /* soft green */
    border-left: 4px solid #28a745;
    transition: all 0.2s ease;
}

table {
    border-collapse: separate;
    border-spacing: 0 8px; /* vertical gap between rows */
}

/* Row base */
.confirmed-row td {
   
    border-top: 1px solid #e0e0e0;
    border-bottom: 1px solid #e0e0e0;
}

/* Left curve */
.confirmed-row td:first-child {
    border-left: 10px solid #28a745;
    border-top-left-radius: 12px;
    border-bottom-left-radius: 12px;
}

/* Right curve */
.confirmed-row td:last-child {
    border-top-right-radius: 12px;
    border-bottom-right-radius: 12px;
}


/* Smooth feel */
.confirmed-row td {
    transition: all 0.2s ease;
}



/*rejected row*/


.rej-row td {
   
    border-top: 1px solid #e0e0e0;
    border-bottom: 1px solid #e0e0e0;
}

/* Left curve */
.rej-row td:first-child {
    border-left: 10px solid red;
    border-top-left-radius: 12px;
    border-bottom-left-radius: 12px;
}

/* Right curve */
.rej-row td:last-child {
    border-top-right-radius: 12px;
    border-bottom-right-radius: 12px;
}


/* Smooth feel */
.rej-row td {
    transition: all 0.2s ease;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>




<div class="container-fluid">
<div class="row">

<!-- LEFT TABLE -->
<div class="col-lg-8">
<div class="main-box">

<table class="table table-bordered table-hover table-sm">

<thead>
<tr>
    <th class="col-rank">Rank</th>
    <th class="col-app">Catg./App</th>
    <th class="col-name">Name</th>
    <th class="col-total">Total</th>
    <th class="col-branch">Branch</th>
    <th class="col-seg">Category</th>
    <th class="col-sp">Spcl Cat</th>.
    <th class="col-sp">Allt. Status</th>
    <th class="col-act">Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");
int i = 1;

for(Map<String,String> row:list){
%>

<tr data-id="<%= row.get("id") %>" 
class="<%= 
    "Confirmed".equalsIgnoreCase(val(row.get("Status_Allot"))) ? "confirmed-row" : 
    "Widthdrawn".equalsIgnoreCase(val(row.get("Status_Allot"))) ? "rej-row" : 
    "" 
%>">

<td><%=i++%></td>

<td>
    <%=row.get("APPNO")%><br>
    <small><%=row.get("cast_no")%></small>
</td>

<td class="name-cell" title="<%=row.get("name")%>">
    <b><%=row.get("name")%> (<%=row.get("gender")%>)</b><br>
    <%=row.get("phone_no")%>,<%=row.get("Whatsapp_no")%><br>
    <%=row.get("Admission_type")%><br>
    <%=row.get("preference_1")%> |<%=row.get("preference_2")%>| <%=row.get("preference_3")%>| <%=row.get("preference_4")%>| <%=row.get("preference_5")%>
    
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

<select class="form-control segment editable" disabled>
<option value="">Select</option>
<option value="GM" <%= "GM".equals(row.get("Segment"))?"selected":"" %>>GM</option>
<option value="SC" <%= "SC".equals(row.get("Segment"))?"selected":"" %>>SC</option>
<option value="ST" <%= "ST".equals(row.get("Segment"))?"selected":"" %>>ST</option>
<option value="OS" <%= "OS".equals(row.get("Segment"))?"selected":"" %>>OS</option>
<option value="MQ" <%= "MQ".equals(row.get("Segment"))?"selected":"" %>>MQ</option>
<option value="EQ" <%= "EQ".equals(row.get("Segment"))?"selected":"" %>>EQ</option>
</select>
</td>

<td>
<select class="form-control spcat editable" disabled>
<option value="">Select</option>
<option value="General" <%= "General".equals(row.get("Special_Catg"))?"selected":"" %>>General</option>
<option value="Arjas" <%= "Arjas".equals(row.get("Special_Catg"))?"selected":"" %>>Arjas</option>
<option value="SMIORE" <%= "SMIORE".equals(row.get("Special_Catg"))?"selected":"" %>>SMIORE</option>
<option value="SVPS" <%= "SVPS".equals(row.get("Special_Catg"))?"selected":"" %>>SVPS</option>
<option value="SC" <%= "SC".equals(row.get("Special_Catg"))?"selected":"" %>>SC</option>
<option value="ST" <%= "ST".equals(row.get("Special_Catg"))?"selected":"" %>>ST</option>
</select>
</td>

<td>
<select class="form-control status editable" disabled>
<option value="">Select</option>
<option value="Confirmed" <%= "Confirmed".equals(row.get("Status_Allot"))?"selected":"" %>>Confirmed</option>
<option value="Waiting List" <%= "Waiting List".equals(row.get("Status_Allot"))?"selected":"" %>>Waiting List</option>
<option value="Widthdrawn" <%= "Widthdrawn".equals(row.get("Status_Allot"))?"selected":"" %>>Widthdrawn</option>
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

<!-- RIGHT DASHBOARD (UNCHANGED) -->

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
<tr><th>Cat</th><th>Used</th><th>Total</th></tr>

<%
int grandUsed = 0;
int grandTotal = 0;

for(String cat : seatMap.keySet()){
    Map<String,Integer> b = seatMap.get(cat);

    int total = b.getOrDefault(br+"_total",0);
    int used = b.getOrDefault(br+"_used",0);

    grandUsed += used;
    grandTotal += total;

    String cls = (used>=total)?"full":"available";
%>

<tr>
<td><%=cat%></td>
<td class="<%=cls%>"><%=used%></td>
<td><%=total%></td>
</tr>

<% } %>

<!-- 🔥 GRAND TOTAL ROW -->
<tr style="font-weight:bold; background:#f1f1f1;">
    <td>Total</td>
    <td class="<%= (grandUsed>=grandTotal) ? "full" : "available" %>">
        <%=grandUsed%>
    </td>
    <td><%=grandTotal%></td>
</tr>

</table>

</div>

<% } %>

</div>
</div>
</div>

</div>
</div>
<%
StringBuilder json = new StringBuilder("{");

for(String cat : seatMap.keySet()){
    json.append("\"").append(cat).append("\":{");

    Map<String,Integer> b = seatMap.get(cat);

    json.append("\"ME_total\":").append(b.get("ME_total")).append(",");
    json.append("\"ME_used\":").append(b.get("ME_used")).append(",");

    json.append("\"EE_total\":").append(b.get("EE_total")).append(",");
    json.append("\"EE_used\":").append(b.get("EE_used")).append(",");

    json.append("\"CS_total\":").append(b.get("CS_total")).append(",");
    json.append("\"CS_used\":").append(b.get("CS_used")).append(",");

    json.append("\"EC_total\":").append(b.get("EC_total")).append(",");
    json.append("\"EC_used\":").append(b.get("EC_used")).append(",");

    json.append("\"CE_total\":").append(b.get("CE_total")).append(",");
    json.append("\"CE_used\":").append(b.get("CE_used"));

    json.append("},");
}

// remove last comma
if(json.charAt(json.length()-1)==','){
    json.deleteCharAt(json.length()-1);
}

json.append("}");
%>
<!-- 🔥 PASS SEAT MAP TO JS -->
<script>
let seatMap = <%= json.toString() %>;
</script>

<!-- AJAX WITH VALIDATION -->

<script>

// EDIT
$(document).on('click','.editBtn',function(){
    let row=$(this).closest('tr');
    row.find('.editable').prop('disabled',false);
    row.find('.editBtn').hide();
    row.find('.saveBtn').show();
});

// SAVE WITH VALIDATION
$(document).on('click','.saveBtn',function(){

    let row=$(this).closest('tr');

    let branch = row.find('.seat').val();
    let segment = row.find('.segment').val();
    let status = row.find('.status').val();   // ✅ NEW

    let catMap = seatMap[segment];

    if(catMap){
        let used = catMap[branch+"_used"] || 0;
        let total = catMap[branch+"_total"] || 0;

        if(used >= total){
            alert("Seats not available for selected category");
            return;
        }
    }

    $.ajax({
        url:'Counselling',
        method:'POST',
        data:{
            id:row.data('id'),
            Seat_Allot:branch,
            Segment:segment,
            Special_Catg:row.find('.spcat').val(),
            Status_Allot:status   // ✅ FIXED
        },
        success:function(res){

            if(res==="FULL"){
                alert("Seats already full!");
                return;
            }

            location.reload();
        }
    });

});

</script>

</body>
</html>