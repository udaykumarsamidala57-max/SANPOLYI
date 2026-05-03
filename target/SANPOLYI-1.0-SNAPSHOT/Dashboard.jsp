<%@ page import="java.sql.*, com.bean.DBUtil3" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pivot Dashboard</title>

<link rel="stylesheet"
 href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    background:#eef2f6;
    padding:20px;
    font-family:'Segoe UI';
}
.main-container {
    width:80%;
    margin:auto;
}
.card-box {
    background:#fff;
    padding:18px;
    border-radius:10px;
    box-shadow:0 3px 10px rgba(0,0,0,0.08);
    margin-bottom:20px;
    transition:0.2s;
}
.card-box:hover {
    transform: translateY(-2px);
}
.table {
    font-size:13px;
}
th {
    background:#1b3a57;
    color:#fff;
    text-align:center;
    position:sticky;
    top:0;
}
td {
    text-align:center;
    vertical-align:middle;
    padding:6px;
}
.table-hover tbody tr:hover {
    background:#f5f9fc;
}
.total-row {
    font-weight:bold;
    background:#dee2e6;
}
h4 {
    font-weight:600;
    color:#1b3a57;
    margin-bottom:15px;
}
.chart-container {
    width:90%;
    height:300px;
    margin:auto;
}
</style>
</head>

<body>

<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<%@ include file="header.jsp" %>

<div class="main-container">

<div class="card-box">

<h4>Category vs Gender</h4>

<div class="table-responsive">

<table class="table table-bordered table-hover table-sm">

<thead>
<tr>
<th rowspan="2">Category</th>
<th colspan="2">Dayscholar</th>
<th colspan="2">Residential</th>
<th rowspan="2">Total</th>
</tr>
<tr>
<th>M</th><th>F</th>
<th>M</th><th>F</th>
</tr>
</thead>

<tbody>

<%
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

int tDSM=0, tDSF=0, tBRM=0, tBRF=0;
int grandTotal = 0;

StringBuilder labels = new StringBuilder();
StringBuilder dsData = new StringBuilder();
StringBuilder rsData = new StringBuilder();

try{
    con=DBUtil3.getConnection();

    String sql =
    "SELECT LEFT(TRIM(cast_no),2) AS caste_prefix," +
    " SUM(CASE WHEN LOWER(TRIM(Admission_type)) LIKE '%day%' " +
    " AND UPPER(TRIM(gender)) IN ('M','MALE') THEN 1 ELSE 0 END) AS DS_M," +
    " SUM(CASE WHEN LOWER(TRIM(Admission_type)) LIKE '%day%' " +
    " AND UPPER(TRIM(gender)) IN ('F','FEMALE') THEN 1 ELSE 0 END) AS DS_F," +
    " SUM(CASE WHEN LOWER(TRIM(Admission_type)) LIKE '%res%' " +
    " AND UPPER(TRIM(gender)) IN ('M','MALE') THEN 1 ELSE 0 END) AS BR_M," +
    " SUM(CASE WHEN LOWER(TRIM(Admission_type)) LIKE '%res%' " +
    " AND UPPER(TRIM(gender)) IN ('F','FEMALE') THEN 1 ELSE 0 END) AS BR_F" +
    " FROM admission_form " +
    " WHERE cast_no IS NOT NULL AND cast_no<>'' " +
    " GROUP BY caste_prefix ORDER BY caste_prefix";

    ps=con.prepareStatement(sql);
    rs=ps.executeQuery();

    boolean hasData=false;

    while(rs.next()){
        hasData=true;

        String caste = rs.getString("caste_prefix");

        int dsm = rs.getInt("DS_M");
        int dsf = rs.getInt("DS_F");
        int brm = rs.getInt("BR_M");
        int brf = rs.getInt("BR_F");

        int rowTotal = dsm + dsf + brm + brf;

        tDSM+=dsm; 
        tDSF+=dsf; 
        tBRM+=brm; 
        tBRF+=brf;
        grandTotal += rowTotal;

        labels.append("'").append(caste).append("',");
        dsData.append(dsm+dsf).append(",");
        rsData.append(brm+brf).append(",");
%>

<tr>
<td><%=caste%></td>
<td><%=dsm%></td>
<td><%=dsf%></td>
<td><%=brm%></td>
<td><%=brf%></td>
<td><b><%=rowTotal%></b></td>
</tr>

<%
    }

    if(!hasData){
%>
<tr>
<td colspan="6" class="text-danger text-center font-weight-bold">
    No Data Found
</td>
</tr>
<%
    }
%>

<tr class="total-row">
<td><b>Grand Total</b></td>
<td><b><%=tDSM%></b></td>
<td><b><%=tDSF%></b></td>
<td><b><%=tBRM%></b></td>
<td><b><%=tBRF%></b></td>
<td style="background:#1b3a57; color:#fff; font-size:15px;">
<b><%=grandTotal%></b>
</td>
</tr>

<%
}catch(Exception e){
%>
<tr>
<td colspan="6" class="text-danger text-center">
    <%=e.getMessage()%>
</td>
</tr>
<%
} finally{
    if(rs!=null) rs.close();
    if(ps!=null) ps.close();
    if(con!=null) con.close();
}
%>

</tbody>
</table>

</div>
</div>

<div class="card-box">
<h4>Category Distribution</h4>

<div class="chart-container">
<canvas id="myChart"></canvas>
</div>

</div>

</div>

<script>

let ctx = document.getElementById('myChart').getContext('2d');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: [<%=labels.toString()%>],
        datasets: [
            {
                label: 'Dayscholars',
                data: [<%=dsData.toString()%>],
                backgroundColor: '#4e73df'
            },
            {
                label: 'Residential',
                data: [<%=rsData.toString()%>],
                backgroundColor: '#1cc88a'
            }
        ]
    },
    options: {
        responsive:true,
        maintainAspectRatio:false,
        plugins: {
            legend: {
                labels: {
                    font: {
                        size:12
                    }
                }
            }
        },
        scales: {
            y: {
                beginAtZero:true,
                ticks: {
                    stepSize:1
                }
            }
        }
    }
});

</script>

</body>
</html>