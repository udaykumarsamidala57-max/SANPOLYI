<%@ page import="java.io.*,java.sql.*,java.util.*" %>
<%@ page import="com.bean.DBUtil3" %>

<!DOCTYPE html>

<html>
<head>
    <title>Bulk Upload Admissions</title>
</head>
<body>

<h2>Upload CSV File</h2>

<form method="post" action="UploadCSV" enctype="multipart/form-data">
    <input type="file" name="file" required>
    <input type="submit" value="Upload">
</form>



</body>
</html>
