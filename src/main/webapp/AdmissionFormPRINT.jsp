<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String appno = request.getParameter("APPNO");
String name = request.getParameter("name");
String father = request.getParameter("father");
String phone = request.getParameter("phone");
String total = request.getParameter("total");
String branch = request.getParameter("branch");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Print Record</title>

<style>
body {
    font-family: Arial;
    padding: 20px;
}

.card {
    border: 1px solid #000;
    padding: 20px;
    width: 400px;
    margin: auto;
}

h2 {
    text-align: center;
}

.print-btn {
    margin: 20px;
    text-align: center;
}
</style>

<script>
function printPage(){
    window.print();
}
</script>

</head>

<body>

<div class="card">
    <h2>Student Details</h2>

    <p><b>Application no:</b> <%= appno %></p>
    <p><b>Name of Candidate:</b> <%= name %></p>
    <p><b>Father Name :</b> <%= father %></p>
    <p><b>Phone:</b> <%= phone %></p>
    
    <p><b>Branch Selected:</b> <%= branch %></p>
</div>

<div class="print-btn">
    <button onclick="printPage()">Print</button>
</div>

</body>
</html>