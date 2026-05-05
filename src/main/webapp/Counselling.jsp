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
    font-size:12px;
    text-align:center;
    vertical-align:middle;
}

thead th {
    position:sticky;
    top:0;
    z-index:2;
}

.col-rank { width:4%; }
.col-app  { width:8%; }
.col-name { width:20%; }
.col-total{ width:6%; }
.col-branch{ width:8%; }
.col-seg  { width:8%; }
.col-sp   { width:13%; }
.col-act  { width:6%; }

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
    display:block;   /* 🔥 key change */
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
     margin-bottom: 12px;
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


/*Waiting row*/


.wait-row td {
   
    border-top: 1px solid #e0e0e0;
    border-bottom: 1px solid #e0e0e0;
}

/* Left curve */
.wait-row td:first-child {
    border-left: 10px solid #02A0EB;
    border-top-left-radius: 12px;
    border-bottom-left-radius: 12px;
}

/* Right curve */
.wait-row td:last-child {
    border-top-right-radius: 12px;
    border-bottom-right-radius: 12px;
}


/* Smooth feel */
.wait-row td {
    transition: all 0.2s ease;
}
.wait-row {
    background-color: #D2EBF7;   /* soft green */
    border-left: 4px solid #28a745;
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
List<Map<String,String>> lists = (List<Map<String,String>>)request.getAttribute("data");

// ✅ COUNT LOGIC HERE
int dayScholarCount = 0;
int residentialCount = 0;
int RM = 0;
int RF = 0;
int T = 0;
for(Map<String,String> r : lists){   // 🔥 use different variable name

    String status = val(r.get("Status_Allot"));
    String admissionType = val(r.get("Admission_type"));
    String gender = val(r.get("gender"));
    String Total = val(r.get("Confirmed"));

    if("Confirmed".equalsIgnoreCase(status)){
    	     T++;
        if("Dayscholar".equalsIgnoreCase(admissionType)){
            dayScholarCount++;
            
        }else if("Residential".equalsIgnoreCase(admissionType)){
            residentialCount++;
            if("F".equalsIgnoreCase(gender)){
            	RF++;
            }
            else{
            	RM++;
            }
        }
    }
}


%>





<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");
int i = 1;

for(Map<String,String> row:list){
%>

<tr data-id="<%= row.get("id") %>" 
class="<%= 
    "Confirmed".equalsIgnoreCase(val(row.get("Status_Allot"))) ? "confirmed-row" : 
    "Widthdrawn".equalsIgnoreCase(val(row.get("Status_Allot"))) ? "rej-row" : 
    	"Waiting List".equalsIgnoreCase(val(row.get("Status_Allot"))) ? "wait-row" : 
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
<option value="Cancelled" <%= "Cancelled".equals(row.get("Status_Allot"))?"selected":"" %>>Cancelled</option>
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
<div class="alert alert-info text-center" style="font-size:14px; border-radius:8px;">

    <b>All Branches Seats Filled Status</b><br>

    Total: <span style="color:#8C1E03;"><%=T%></span> / 270 |
    Day Scholar: <span style="color:#8C1E03;"><%=dayScholarCount%></span> / 132 |
    Residential: <span style="color:#8C1E03;"><%=residentialCount%></span> / 138 <br>

    Girls: <span style="color:#8C1E03;"><%=RF%></span> / 33 |
    Boys: <span style="color:#8C1E03;"><%=RM%></span> / 105

</div>
<div class="dashboard-grid">

<%
Map<String, Map<String,Integer>> seatMap =
(Map<String, Map<String,Integer>>)request.getAttribute("seatMap");

String[] branches = {"ME","EE","CS","EC","CE"};

for(String br : branches){
%>
<script>
let dayScholarCount = <%=dayScholarCount%>;
let residentialCount = <%=residentialCount%>;
let RF = <%=RF%>;   // girls
let RM = <%=RM%>;   // boys
</script>

<div class="branch-box">	

<b><%=br%></b>

<table class="table table-sm">
<tr>
    <th>Cat</th>
    <th>Adm / Cap</th>
    
    <th>Vac</th>
    <th>WL</th>   <!-- NEW -->
    <th>CL</th>
    
</tr>

<%
int grandUsed = 0;
int grandWL = 0;     // ✅ NEW
int grandTotal = 0;
int grandcan = 0;

for(String cat : seatMap.keySet()){
    Map<String,Integer> b = seatMap.get(cat);

    int total = b.getOrDefault(br+"_total",0);
    int used  = b.getOrDefault(br+"_used",0);
    int wl    = b.getOrDefault(br+"_wl",0);   // ✅ NEW
    int cl = b.getOrDefault(br+"_cl",0);
    grandUsed += used;
    grandWL   += wl;      // ✅ NEW
    grandTotal += total;
    grandcan += cl;
    String cls = (used >= total) ? "full" : "available";
%>

<tr>
<td><%=cat%></td>

<td class="<%= (used>=total)?"full":"available" %>"><%=used%> / <%=total%></td>
<td><%=total-used%></td>
<td style="color:#02A0EB;font-weight:bold;"><%=wl%></td>
<td style="color:#02A0EB;font-weight:bold;"><%=cl%></td>

</tr>

<% } %>

<!-- 🔥 GRAND TOTAL ROW -->
<tr style="font-weight:bold; background:#f1f1f1;">
    <td>Total</td>
    <td class="<%= (grandUsed>=grandTotal) ? "full" : "available" %>">
        <%=grandUsed%> / <%=grandTotal%></td>
  
    <td><%=grandTotal-grandUsed%></td>
    <td style="color:#02A0EB;font-weight:bold;">
        <%=grandWL%>   <!-- ✅ FIX -->
    </td>
    <td><%=grandcan%></td>
    
    
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

int catIndex = 0;

for(String cat : seatMap.keySet()){

    if(catIndex++ > 0){
        json.append(",");   // ✅ add comma between categories
    }

    json.append("\"").append(cat).append("\":{");

    Map<String,Integer> b = seatMap.get(cat);

    json.append("\"ME_total\":").append(b.get("ME_total")).append(",");
    json.append("\"ME_used\":").append(b.get("ME_used")).append(",");
    json.append("\"ME_wl\":").append(b.get("ME_wl")).append(",");
    json.append("\"ME_cl\":").append(b.get("ME_cl")).append(",");

    json.append("\"EE_total\":").append(b.get("EE_total")).append(",");
    json.append("\"EE_used\":").append(b.get("EE_used")).append(",");
    json.append("\"EE_wl\":").append(b.get("EE_wl")).append(",");
    json.append("\"EE_cl\":").append(b.get("EE_cl")).append(",");

    json.append("\"CS_total\":").append(b.get("CS_total")).append(",");
    json.append("\"CS_used\":").append(b.get("CS_used")).append(",");
    json.append("\"CS_wl\":").append(b.get("CS_wl")).append(",");
    json.append("\"CS_cl\":").append(b.get("CS_cl")).append(",");

    json.append("\"EC_total\":").append(b.get("EC_total")).append(",");
    json.append("\"EC_used\":").append(b.get("EC_used")).append(",");
    json.append("\"EC_wl\":").append(b.get("EC_wl")).append(",");
    json.append("\"EC_cl\":").append(b.get("EC_cl")).append(",");

    json.append("\"CE_total\":").append(b.get("CE_total")).append(",");
    json.append("\"CE_used\":").append(b.get("CE_used")).append(",");
    json.append("\"CE_wl\":").append(b.get("CE_wl")).append(",");;   // ✅ LAST FIELD → NO COMMA
    json.append("\"CE_Cl\":").append(b.get("CE_Cl"));
    

    json.append("}");
}

json.append("}");
%>
<!-- 🔥 PASS SEAT MAP TO JS -->


<!-- AJAX WITH VALIDATION -->

<script>
let seatMap = <%= json.toString() %>;

//==========================
// EDIT BUTTON
//==========================
$(document).on('click', '.editBtn', function () {
    let row = $(this).closest('tr');

    row.find('.editable').prop('disabled', false);
    row.find('.editBtn').hide();
    row.find('.saveBtn').show();
});


//==========================
// SAVE BUTTON
//==========================
$(document).on('click', '.saveBtn', function () {

    let row = $(this).closest('tr');

    let branch = row.find('.seat').val();
    let segment = row.find('.segment').val();
    let spcat = row.find('.spcat').val();
    let statusRaw = row.find('.status').val() || "";

    let status = statusRaw.trim().toLowerCase();

    // ==========================
    // 1. EMPTY → CLEAR
    // ==========================
    if (!branch || !segment) {

        saveData(row, "", "", spcat, statusRaw);
        return;
    }

    // ==========================
    // 2. WAITING LIST
    // ==========================
   
    if (status === "waiting list") {

        saveData(row, branch, segment, spcat, "Waiting List");
        return;
    }
    if (status === "cancelled") {

        saveData(row, branch, segment, spcat, "Cancelled");
        return;
    }

    // ==========================
    // 3. VALIDATION (CONFIRMED)
    // ==========================
    let catMap = seatMap[segment];

    if (catMap) {
        let used = catMap[branch + "_used"] || 0;
        let total = catMap[branch + "_total"] || 0;

        if (used >= total) {
            alert("Seats not available for selected category");
            return;
        }
    }

    // ==========================
    // 4. SAVE CONFIRMED
    // ==========================
    saveData(row, branch, segment, spcat, "Confirmed");

});


//==========================
// COMMON SAVE FUNCTION
//==========================
function saveData(row, branch, segment, spcat, status) {

    $.ajax({
        url: 'Counselling',
        method: 'POST',
        data: {
            id: row.data('id'),
            Seat_Allot: branch,
            Segment: segment,
            Special_Catg: spcat,
            Status_Allot: status
        },

        success: function (res) {

            // ==========================
            // UI UPDATE (NO RELOAD)
            // ==========================

            // disable fields again
            row.find('.editable').prop('disabled', true);
            row.find('.editBtn').show();
            row.find('.saveBtn').hide();

            // remove all status classes
            row.removeClass('confirmed-row rej-row wait-row');

            // apply new class
            if (status === "Confirmed") {
                row.addClass('confirmed-row');
            } else if (status === "Widthdrawn") {
                row.addClass('rej-row');
            } else if (status === "Waiting List") {
                row.addClass('wait-row');
            }

            // ==========================
            // UPDATE SEAT MAP (LIVE)
            // ==========================
            if (segment && branch) {

                if (!seatMap[segment]) {
                    seatMap[segment] = {};
                }

                let keyUsed = branch + "_used";
                let keyWL = branch + "_wl";

                seatMap[segment][keyUsed] = seatMap[segment][keyUsed] || 0;
                seatMap[segment][keyWL] = seatMap[segment][keyWL] || 0;

                if (status === "Confirmed") {
                    seatMap[segment][keyUsed]++;
                }

                if (status === "Waiting List") {
                    seatMap[segment][keyWL]++;
                }
            }

            // ==========================
            // OPTIONAL: UPDATE DASHBOARD UI
            // ==========================
            // (You can enhance later if needed)

        },

        error: function () {
            alert("Error while saving data");
        }
    });
}
</script>

</body>
</html>