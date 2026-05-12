<%@ page import="java.util.*" %>

<%! 
    public String val(Object o) {
        return (o == null) ? "" : o.toString();
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admissions Report</title>

<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String role = (String) sess.getAttribute("role");
String user = (String) sess.getAttribute("username");
if (!"Global".equalsIgnoreCase(role)) {
    out.println("<h3 style='color:red;text-align:center;'>Access Denied!</h3>");
    return;
}
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<style>
body {
    font-family: 'Segoe UI', Arial;
    background:#f4f6f9;
    margin:15px;
}

.branch-card {
    background:#fff;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
    margin-bottom:25px;
    padding:10px;
}

.branch-title{
    background: linear-gradient(90deg,#002147,#004080);
    color:white;
    padding:10px;
    font-weight:600;
    border-radius:8px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.badge-box span{
    margin-left:8px;
    font-size:18px;
}

table {
    width:100%;
    table-layout: fixed;
}

th,td {
    border:1px solid #e0e0e0;
    padding:4px;
    font-size:13px;
    text-align:center;
    white-space:nowrap;
}

th {
    background:#f1f3f6;
}

tbody tr:nth-child(even){
    background:#fafafa;
}

tbody tr:hover{
    background:#e6f2ff;
}

.col-rank{width:60px;}
.col-app{width:80px;}
.col-cast{width:80px;}
.col-name{width:180px;}
.col-gender{width:60px;}
.col-adm{width:120px;}
.col-father{width:180px;}
.col-occ{width:150px;}
.col-phone{width:100px;}
.col-total{width:80px;}
.col-branch{width:80px;}
.col-status{width:120px;}
.table-wrapper { overflow-x:auto; }

</style>

<script>
function downloadExcel() {
    let content = document.getElementById("exportArea").innerHTML;

    let blob = new Blob([content], { type: "application/vnd.ms-excel" });
    let url = URL.createObjectURL(blob);

    let a = document.createElement("a");
    a.href = url;
    a.download = "Seat_Allotment_Report.xls";
    a.click();

    URL.revokeObjectURL(url);
}
</script>

</head>

<body>

<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-3">

    <button class="btn btn-success btn-sm"
            onclick="downloadExcel()">
        Download Excel
    </button>

</div>

<%
List<Map<String, Object>> list =
(List<Map<String, Object>>) request.getAttribute("data");

if(list == null || list.isEmpty()){
%>

<h3 style="color:red;">No Data Found</h3>

<%
    return;
}

int overallTotal = 0;
int overallResidential = 0;
int overallDayScholar = 0;

int overallME = 0;
int overallEE = 0;
int overallCS = 0;
int overallEC = 0;
int overallCE = 0;
%>
<%
for(Map<String,Object> r : list){

    String adm =
    val(r.get("Admitted_Status"))
    .trim()
    .toUpperCase();

    // ONLY ADMISSION GIVEN
    if(adm.contains("ADMISSION GIVEN")){

        overallTotal++;

        String type =
        val(r.get("Admission_type"))
        .trim()
        .toLowerCase();

        if(type.contains("residential")){
            overallResidential++;
        }

        if(type.contains("day")){
            overallDayScholar++;
        }

        String br =
        val(r.get("Seat_Allot"))
        .trim()
        .toUpperCase();

        if(br.equals("ME")){
            overallME++;
        }
        else if(br.equals("EE")){
            overallEE++;
        }
        else if(br.equals("CS")){
            overallCS++;
        }
        else if(br.equals("EC")){
            overallEC++;
        }
        else if(br.equals("CE")){
            overallCE++;
        }
    }
}
%>

<!-- OVERALL SUMMARY -->

<!-- OVERALL SUMMARY -->

<div class="container-fluid mb-4">

    <div class="row">

        <!-- Percentage -->
        <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body text-center">

                    <h6>Admission %</h6>

                    <h2 style="color:#002147;font-weight:bold;">
                        <%= String.format("%.2f", (overallTotal / 270.0) * 100) %>%
                    </h2>

                </div>
            </div>
        </div>

        <!-- Total -->
        <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body text-center">

                    <h6>Total Admissions</h6>

                    <h2 style="color:#002147;font-weight:bold;">
                        <%=overallTotal%> / 270
                    </h2>

                </div>
            </div>
        </div>

        <!-- Residential -->
        <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body text-center">

                    <h6>Residential</h6>

                    <h2 style="color:green;font-weight:bold;">
                        <%=overallResidential%> / 138
                    </h2>

                </div>
            </div>
        </div>

        <!-- Day Scholar -->
        <div class="col-lg-2 col-md-4 col-sm-6 mb-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body text-center">

                    <h6>Day Scholar</h6>

                    <h2 style="color:#007bff;font-weight:bold;">
                        <%=overallDayScholar%> / 132
                    </h2>

                </div>
            </div>
        </div>

        <!-- Branch Wise -->
        <div class="col-lg-4 col-md-8 col-sm-12 mb-3">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body text-center">

                    <h6 class="mb-3">Branch Wise</h6>

                    <div class="d-flex flex-wrap justify-content-center">

                        <span class="badge badge-primary m-1 p-2">
                            ME : <%=overallME%> / 60
                            <br><br>
                            <%=String.format("%.2f", (overallME / 60.0) * 100)%>%
                        </span>

                        <span class="badge badge-success m-1 p-2">
                            EE : <%=overallEE%> / 60
                            <br><br>
                            <%=String.format("%.2f", (overallEE / 60.0) * 100)%>%
                        </span>

                        <span class="badge badge-warning m-1 p-2">
                            CS : <%=overallCS%> / 60
                            <br><br>
                            <%=String.format("%.2f", (overallCS / 60.0) * 100)%>%
                        </span>

                        <span class="badge badge-danger m-1 p-2">
                            EC : <%=overallEC%> / 60
                            <br><br>
                            <%=String.format("%.2f", (overallEC / 60.0) * 100)%>%
                        </span>

                        <span class="badge badge-dark m-1 p-2">
                            CE : <%=overallCE%> / 30 <br><br>
                            <%=String.format("%.2f", (overallCE / 30.0) * 100)%>%
                        </span>

                    </div>

                </div>
            </div>
        </div>

    </div>

</div>





<div id="exportArea" class="table-wrapper">

<%


// ✅ GROUP BY BRANCH
Map<String, List<Map<String,Object>>> grouped = new LinkedHashMap<>();

for(Map<String,Object> row : list){
    String branch = val(row.get("Seat_Allot"));

    if(branch.trim().isEmpty()){
        branch = "Not Allotted";
    }

    grouped.computeIfAbsent(branch, k -> new ArrayList<>()).add(row);
}

// ✅ LOOP BRANCHES
for(String branch : grouped.keySet()){

    List<Map<String,Object>> students = grouped.get(branch);

    // ✅ COUNT Admission Types
    int residential = 0;
    int dayScholar = 0;
    int SC = 0;
    int ST = 0;
    int EQ = 0;
    int MQ = 0;
    int OS = 0;
    int GM = 0;
    int Total = 0;
    
    for(Map<String,Object> r : students){
        String type = val(r.get("Admission_type")).toLowerCase();
        String seg = val(r.get("Segment")).toUpperCase();
        String adm = val(r.get("Admitted_Status")).toUpperCase();
       
        if(adm.contains("ADMISSION GIVEN")){
        	 Total++;
        if(seg.contains("SC")){
        	SC++;
        } else if(seg.contains("ST")){
        	ST++;
        } else if(seg.contains("EQ")){
        	EQ++;
        } else if(seg.contains("MQ")){
        	MQ++;
        }else if(seg.contains("OS")){
        	OS++;
        }else if(seg.contains("GM")){
        	GM++;
        }

        if(type.contains("residential")){
            residential++;
        } else if(type.contains("day")){
            dayScholar++;
        }
        
        }
    }
    
 

    // ✅ SORT BY TOTAL DESC
    students.sort((a,b)->{
        try{
            double t1 = Double.parseDouble(val(a.get("Total")));
            double t2 = Double.parseDouble(val(b.get("Total")));
            return Double.compare(t2, t1);
        }catch(Exception e){
            return 0;
        }
    });
%>

<div class="branch-card">

    <div class="branch-title">
        <div><b>Branch:</b> <%= branch %></div>

        <div class="badge-box">
            <span class="badge badge-light">Total: <%= Total %></span>
            <span class="badge badge-success">Residential: <%= residential %></span>
            <span class="badge badge-primary">Day Scholar: <%= dayScholar %></span>
            <span class="badge badge-light">GM: <%= GM %></span>
            <span class="badge badge-light">SC: <%= SC %></span>
            <span class="badge badge-light">ST: <%= ST %></span>
            <span class="badge badge-light">EQ: <%= EQ %></span>
            <span class="badge badge-light">MQ: <%= MQ %></span>
            <span class="badge badge-light">OS: <%= OS %></span>
        </div>
    </div>

    <table class="table table-sm">

    <thead>
    <tr>
        <th class="col-rank">S.No</th>
        <th class="col-app">APPNO</th>
      
        <th class="col-name">Name</th>
        
        
        <th class="col-father">Father Name</th>

        <th class="col-phone">Phone</th>
        
        <th class="col-total">Total</th>
        <th class="col-branch">Branch</th>
        <th class="col-branch">Category</th>
        <th class="col-branch">Special Catg</th>
      <th class="col-status">Admission Status</th>
      <th class="col-status">Date</th>
      <th class="col-status">Action</th>
    </tr>
    </thead>

    <tbody>

<%
int rank = 1;

for(Map<String,Object> row : students){
%>

<tr>
    <td><%= rank++ %></td>
    <td><%= val(row.get("APPNO")) %><br><%= val(row.get("cast_no")) %></td>
    
    <td style="text-align:left;"><%= val(row.get("applicant_name")) %> (<%= val(row.get("gender")) %>)<br><%= val(row.get("Admission_type")) %></td>

   
    <td style="text-align:left;"><%= val(row.get("father_guardian_name")) %><br><%= val(row.get("father_occupation")) %></td>
   
    <td><%= val(row.get("phone_no")) %><br><%= val(row.get("Whatsapp_no")) %></td>
   
    <td><b><%= val(row.get("Total")) %></b></td>
    <td><%= val(row.get("Seat_Allot")) %></td>
    <td><%= val(row.get("Segment")) %></td>
    <td><%= val(row.get("Special_Catg")) %></td>
   <td>
<%
    String currentStatus = val(row.get("Admitted_Status"));
    boolean isGiven = "Admission Given".equals(currentStatus);
%>

<select id="status_<%= val(row.get("id")) %>"
        <%= isGiven ? "disabled" : "" %>>
    
    <option value="">Select</option>

    <option value="Admission Given"
        <%= "Admission Given".equals(currentStatus) ? "selected" : "" %>>
        Admission Given
    </option>

    <option value="Pending"
        <%= "Pending".equals(currentStatus) ? "selected" : "" %>>
        Pending
    </option>
</select>

</td>
<td>
<input type="date"
       id="date_<%= row.get("id") %>"
       class="form-control form-control-sm mt-1"
       <%= isGiven ? "disabled" : "" %>
       value="<%= val(row.get("Admitted_date")).length() >= 10 
                ? val(row.get("Admitted_date")).substring(0,10) 
                : "" %>">
                </td>
                <td>
<% if (!isGiven) { %>
<% if("VENKATESH".equalsIgnoreCase(user)) {%>
    <button class="btn btn-sm btn-primary mt-1"
        id="btn_<%= row.get("id") %>"
        onclick="saveStatus('<%= row.get("id") %>')">
        Save
    </button>
    <% }else { %>
    Access Restricted
    <% } %>
 <% } else { %>
   Access Restricted
 <% } %>


</td>
  




</tr>

<%
}
%>

    </tbody>
    </table>

</div>

<%
} // end branch loop
%>

</div>

</body>
<script>
function saveStatus(id) {

    let select = document.getElementById("status_" + id);
    let dateInput = document.getElementById("date_" + id);
    let button = document.getElementById("btn_" + id);

    let status = select.value;
    let ad_date = dateInput.value;

    if (!status) {
        alert("Please select status");
        return;
    }

    if (status === "Admission Given" && !ad_date) {
        alert("Please select admission date");
        return;
    }

    fetch("<%= request.getContextPath() %>/GiveAdmission", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "id=" + id 
            + "&status=" + encodeURIComponent(status)
            + "&ad_date=" + encodeURIComponent(ad_date)
    })
    .then(res => res.text())
    .then(data => {

        if (data.trim() === "OK") {

            alert("Updated successfully");

            if (status === "Admission Given") {
                select.disabled = true;
                dateInput.disabled = true;

                if (button) button.style.display = "none";

                select.insertAdjacentHTML("afterend",
                    '<span class="badge badge-success ml-2"></span>');
            }

        } else {
            alert("Update failed: " + data);
        }
    })
    .catch(err => {
        console.error(err);
        alert("Error occurred");
    });
}
</script>
</html>