<%@ page import="java.sql.*" %>
<%@ page import="com.bean.DBUtil3" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pivot Report</title>

<link rel="stylesheet"
 href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<style>
body { background:#f4f6f9; padding:20px; }
th { background:#002147; color:#fff; text-align:center; }
td { text-align:center; }
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

<h4>Caste Prefix vs Category vs Gender</h4>

<table class="table table-bordered table-sm">

<thead>
<tr>
<th rowspan="2">Caste Prefix</th>
<th colspan="2">Dayscholars</th>
<th colspan="2">Boarders</th>
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

// Totals
int tDSM=0, tDSF=0, tBRM=0, tBRF=0;

try{
    con=DBUtil3.getConnection();

    String sql = 
    "SELECT LEFT(cast_no,2) AS caste_prefix," +

    " SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%day%' " +
    " AND LOWER(TRIM(gender)) IN ('male','m') THEN 1 ELSE 0 END) AS DS_M," +

    " SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%day%' " +
    " AND LOWER(TRIM(gender)) IN ('female','f') THEN 1 ELSE 0 END) AS DS_F," +

    " SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%board%' " +
    " AND LOWER(TRIM(gender)) IN ('male','m') THEN 1 ELSE 0 END) AS BR_M," +

    " SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%board%' " +
    " AND LOWER(TRIM(gender)) IN ('female','f') THEN 1 ELSE 0 END) AS BR_F" +

    " FROM admission_form " +
    " WHERE cast_no IS NOT NULL AND cast_no <> '' " +
    " GROUP BY caste_prefix ORDER BY caste_prefix";

    ps=con.prepareStatement(sql);
    rs=ps.executeQuery();

    while(rs.next()){

        int dsm = rs.getInt("DS_M");
        int dsf = rs.getInt("DS_F");
        int brm = rs.getInt("BR_M");
        int brf = rs.getInt("BR_F");

        tDSM += dsm;
        tDSF += dsf;
        tBRM += brm;
        tBRF += brf;
%>

<tr>
<td><%= rs.getString("caste_prefix") %></td>
<td><%= dsm %></td>
<td><%= dsf %></td>
<td><%= brm %></td>
<td><%= brf %></td>
</tr>

<%
    }
%>

<!-- ✅ TOTAL ROW -->
<tr style="font-weight:bold; background:#e9ecef;">
<td>Total</td>
<td><%= tDSM %></td>
<td><%= tDSF %></td>
<td><%= tBRM %></td>
<td><%= tBRF %></td>
</tr>

<%
}catch(Exception e){
%>
<tr>
<td colspan="5" class="text-danger">
Error: <%= e.getMessage() %>
</td>
</tr>
<%
} finally{
    if(rs!=null) try{rs.close();}catch(Exception e){}
    if(ps!=null) try{ps.close();}catch(Exception e){}
    if(con!=null) try{con.close();}catch(Exception e){}
}
%>

</tbody>
</table>

</body>
</html>