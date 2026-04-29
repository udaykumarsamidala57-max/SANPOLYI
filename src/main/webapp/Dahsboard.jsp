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

try{
    con=DBUtil3.getConnection();

    String sql = "SELECT LEFT(cast_no,2) AS caste_prefix," +
                 " SUM(CASE WHEN category='Dayscholars' AND gender='Male' THEN 1 ELSE 0 END) AS DS_M," +
                 " SUM(CASE WHEN category='Dayscholars' AND gender='Female' THEN 1 ELSE 0 END) AS DS_F," +
                 " SUM(CASE WHEN category='Boarders' AND gender='Male' THEN 1 ELSE 0 END) AS BR_M," +
                 " SUM(CASE WHEN category='Boarders' AND gender='Female' THEN 1 ELSE 0 END) AS BR_F" +
                 " FROM admission_form GROUP BY caste_prefix ORDER BY caste_prefix";

    ps=con.prepareStatement(sql);
    rs=ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%= rs.getString("caste_prefix") %></td>
<td><%= rs.getInt("DS_M") %></td>
<td><%= rs.getInt("DS_F") %></td>
<td><%= rs.getInt("BR_M") %></td>
<td><%= rs.getInt("BR_F") %></td>
</tr>

<%
    }

}catch(Exception e){
%>
<tr><td colspan="5" class="text-danger"><%= e.getMessage() %></td></tr>
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