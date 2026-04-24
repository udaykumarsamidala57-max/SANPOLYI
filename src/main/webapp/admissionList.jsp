<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Records</title>
</head>

<body>

<h2>Admission Records</h2>

<form method="get" action="AdmissionListServlet">
    From: <input type="date" name="fromDate">
    To: <input type="date" name="toDate">
    <button type="submit">Filter</button>
</form>

<br>

<table border="1" cellpadding="5">
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

if (list != null) {
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
}
%>

</table>

</body>
</html>