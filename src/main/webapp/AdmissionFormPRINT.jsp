<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String appno = request.getParameter("APPNO");
String name = request.getParameter("name");
String father = request.getParameter("father");
String phone = request.getParameter("phone");
String branch = request.getParameter("branch");
String Segment = request.getParameter("Segment");
String Admission_t  = request.getParameter("Admission_type");
String gender = request.getParameter("gender");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seat Allotment Slip</title>

<style>

/* ===== A5 FULL PAGE ===== */
@page {
    size: A5 portrait;
    margin: 8mm;
}

body {
    font-family: Arial, sans-serif;
    margin: 0;
}

/* FULL HEIGHT CARD */
.card {
    height: 100%;
    border: 2px solid #000;
    padding: 18px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* ===== HEADER ===== */

.header {
    text-align: center;
}

.college-name {
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 1px;
}

.location {
    font-size: 13px;
    margin-top: 2px;
}

.divider {
    border-top: 2px solid #000;
    margin: 8px 0;
}

.title {
    font-size: 17px;
    font-weight: 600;
}

.year {
    font-size: 12px;
    margin-top: 2px;
}

/* ===== INFO GRID ===== */

.info-grid {
    margin-top: 15px;
    border-top: 1px solid #000;
}

.row {
    display: flex;
    border-bottom: 1px solid #000;
}

.label {
    width: 40%;
    padding: 10px;
    font-weight: bold;
    border-right: 1px solid #000;
}

.value {
    width: 60%;
    padding: 10px;
}

/* ===== FOOTER ===== */

.footer {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-top: 20px;
}

/* LEFT FOOTER TEXT */
.note {
    font-size: 11px;
    width: 55%;
}

/* SIGNATURE */
.signature {
    text-align: center;
}

.signature-line {
    width: 140px;
    border-top: 1px solid #000;
    margin-top: 40px;
}

/* PRINT BUTTON */
.print-btn {
    text-align: center;
    margin-top: 10px;
}

@media print {
    .print-btn {
        display: none;
    }
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

    <!-- ===== HEADER ===== -->
    <div class="header">
        <div class="college-name">SANDUR POLYTECHNIC</div>
        <div class="location">Yeshwantnagar</div>

        <div class="divider"></div>

        <div class="title">SEAT ALLOTMENT SLIP</div>
        <div class="year">Academic Year 2026–27</div>
    </div>

    <!-- ===== DETAILS GRID ===== -->
    <div class="info-grid">

        <div class="row">
            <div class="label">Application No</div>
            <div class="value"><%= appno %></div>
        </div>

        <div class="row">
            <div class="label">Candidate Name</div>
            <div class="value"><%= name %></div>
        </div>

        <div class="row">
            <div class="label">Gender</div>
            <div class="value"><%= gender %></div>
        </div>

        <div class="row">
            <div class="label">Father Name</div>
            <div class="value"><%= father %></div>
        </div>

        <div class="row">
            <div class="label">Phone Number</div>
            <div class="value"><%= phone %></div>
        </div>

        <div class="row">
            <div class="label">Branch Allotted</div>
            <div class="value"><b><%= branch %></b></div>
        </div>

        <div class="row">
            <div class="label">Category</div>
            <div class="value"><%= Segment %></div>
        </div>

        <div class="row">
            <div class="label">Admission Type</div>
            <div class="value"><%= Admission_t %></div>
        </div>

    </div>

    <!-- ===== FOOTER ===== -->
    <div class="footer">

        <div class="note">
            * This is a provisional seat allotment slip.  
            Candidates must report to the college with required documents.
        </div>

        <div class="signature">
            <div class="signature-line"></div>
            <div><b>Principal</b></div>
        </div>

    </div>

</div>

<div class="print-btn">
    <button onclick="printPage()">Print</button>
</div>

</body>
</html>