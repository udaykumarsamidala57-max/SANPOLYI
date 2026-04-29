<%@ page import="java.sql.*, com.bean.DBUtil3" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pivot Report</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <style>
        body { background:#f4f6f9; padding:20px; }
        th { background:#002147; color:#fff; text-align:center; }
        td { text-align:center; }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<h4>Caste Prefix vs Category vs Gender (Debug Version)</h4>

<table class="table table-bordered table-sm">
    <thead>
        <tr>
            <th>Caste Prefix</th>
            <th>Dayscholar (M)</th>
            <th>Dayscholar (F)</th>
            <th>Residential (M)</th>
            <th>Residential (F)</th>
        </tr>
    </thead>
    <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBUtil3.getConnection();
        
        // Flexible SQL: Using LIKE to catch variations and trimming whitespace
        String sql = "SELECT LEFT(TRIM(cast_no), 2) AS caste_prefix, " +
                     "SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%dayscholar%' AND UPPER(TRIM(gender)) = 'M' THEN 1 ELSE 0 END) AS DS_M, " +
                     "SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%dayscholar%' AND UPPER(TRIM(gender)) = 'F' THEN 1 ELSE 0 END) AS DS_F, " +
                     "SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%residential%' AND UPPER(TRIM(gender)) = 'M' THEN 1 ELSE 0 END) AS BR_M, " +
                     "SUM(CASE WHEN LOWER(TRIM(category)) LIKE '%residential%' AND UPPER(TRIM(gender)) = 'F' THEN 1 ELSE 0 END) AS BR_F " +
                     "FROM admission_form " +
                     "GROUP BY LEFT(TRIM(cast_no), 2) " +
                     "ORDER BY caste_prefix ASC";

        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();

        boolean hasData = false;
        while(rs.next()){
            hasData = true;
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
        
        if(!hasData) {
            out.println("<tr><td colspan='5'>Query returned no data. Ensure 'admission_form' has entries.</td></tr>");
        }

    } catch(Exception e) {
        out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        if(rs!=null) rs.close();
        if(ps!=null) ps.close();
        if(con!=null) con.close();
    }
%>
    </tbody>
</table>
</body>
</html>