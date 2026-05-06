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
<title>Seat Allotment Report</title>

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
    
    <button class="btn btn-success btn-sm" onclick="downloadExcel()">Download Excel</button>
</div>

<div id="exportArea" class="table-wrapper">

<%
List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("data");

if(list == null || list.isEmpty()){
%>
    <h3 style="color:red;">No Data Found</h3>
<%
    return;
}

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

<% if (!isGiven) { %>
    <button class="btn btn-sm btn-primary"
        id="btn_<%= val(row.get("id")) %>"
        onclick="saveStatus('<%= val(row.get("id")) %>')">
        Save
    </button>
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
    let button = document.getElementById("btn_" + id);

    let status = select.value;

    if (!status) {
        alert("Please select status");
        return;
    }

    fetch("<%= request.getContextPath() %>/GiveAdmission", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "id=" + id + "&status=" + encodeURIComponent(status)
    })
    .then(res => res.text())
    .then(data => {

        if (data.trim() === "OK") {
            alert("Updated successfully");

            // ✅ Disable after Admission Given
            if (status === "Admission Given") {
                select.disabled = true;
                button.disabled = true;
                button.classList.remove("btn-primary");
                button.classList.add("btn-success");
                button.innerText = "Locked";
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