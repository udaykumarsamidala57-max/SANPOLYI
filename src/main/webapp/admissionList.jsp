<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Records</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f4f6f9;
}

/* Header */
.header {
    background: #002147;
    color: white;
    padding: 15px 30px;
    font-size: 22px;
    font-weight: bold;
}

/* Container */
.container {
    width: 95%;
    margin: 30px auto;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Title */
.title {
    font-size: 20px;
    margin-bottom: 15px;
    color: #002147;
}

/* Filter Form */
.filter-form {
    margin-bottom: 20px;
}

.filter-form input,
.filter-form button {
    padding: 8px 10px;
    margin-right: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.filter-form button {
    background: #002147;
    color: white;
    border: none;
    cursor: pointer;
}

.filter-form button:hover {
    background: #004080;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
}

th {
    background: #002147;
    color: white;
    padding: 10px;
    text-align: left;
}

td {
    padding: 8px;
    border-bottom: 1px solid #ddd;
}

tr:nth-child(even) {
    background: #f9f9f9;
}

tr:hover {
    background: #eef3ff;
}

/* Responsive */
@media screen and (max-width: 768px) {
    table {
        font-size: 12px;
    }
}
</style>

</head>

<body>

<div class="header">
    🎓 University Admission Management System
</div>

<div class="container">

<div class="title">Admission Records</div>

<form class="filter-form" method="get" action="AdmissionListServlet">
    From: <input type="date" name="fromDate">
    To: <input type="date" name="toDate">
    <button type="submit">Filter</button>
</form>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>DOB</th>
<th>Gender</th>
<th>Native</th>
<th>Taluk</th>
<th>District</th>
<th>State</th>
<th>Phone</th>
<th>Email</th>
<th>Aadhar</th>
<th>Maths</th>
<th>Science</th>
<th>Pref1</th>
<th>Pref2</th>
<th>Pref3</th>
<th>Pref4</th>
<th>Pref5</th>
<th>Created</th>
</tr>

<%
List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("data");

if (list != null && !list.isEmpty()) {
    for (Map<String, Object> row : list) {
%>

<tr>
<td><%= row.get("id") %></td>
<td><%= row.get("applicant_name") %></td>
<td><%= row.get("date_of_birth") %></td>
<td><%= row.get("gender") %></td>
<td><%= row.get("native_place") %></td>
<td><%= row.get("taluk") %></td>
<td><%= row.get("district") %></td>
<td><%= row.get("state") %></td>
<td><%= row.get("phone_no") %></td>
<td><%= row.get("email") %></td>
<td><%= row.get("aadhar_no") %></td>
<td><%= row.get("marks_maths") %></td>
<td><%= row.get("marks_science") %></td>
<td><%= row.get("preference_1") %></td>
<td><%= row.get("preference_2") %></td>
<td><%= row.get("preference_3") %></td>
<td><%= row.get("preference_4") %></td>
<td><%= row.get("preference_5") %></td>
<td><%= row.get("created_at") %></td>
</tr>

<%
    }
} else {
%>
<tr>
<td colspan="19" style="text-align:center;">No Records Found</td>
</tr>
<%
}
%>

</table>

</div>

</body>
</html>