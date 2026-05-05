<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String appno = request.getParameter("APPNO");
String name = request.getParameter("name");
String branch = request.getParameter("branch");
String Segment = request.getParameter("Segment");
String sp = request.getParameter("Special_Catg");
String Admission_t  = request.getParameter("Admission_type");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Provisional Admission Order</title>

<style>

/* ===== A5 LANDSCAPE ===== */
@page {
    size: A5 landscape;
    margin: 6mm;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    margin: 0;
}

/* MAIN CARD */
.card {
    height: 100vh;
    border: 2px solid #000;
    padding: 16px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* ===== HEADER ===== */
.header {
    text-align: center;
    border-bottom: 2px solid #000;
    padding-bottom: 8px;
}

.header h2 {
    margin: 0;
    font-size: 20px;
    letter-spacing: 1px;
}

.header h3 {
    margin: 4px 0 0;
    font-size: 15px;
    font-weight: 600;
}

/* ===== CONTENT BOX ===== */
.content-box {
    border: 1px solid #000;
    padding: 10px;
    margin-top: 10px;
}

/* GRID */
.content {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px 20px;
    font-size: 14px;
}

/* FIELD */
.field {
    display: flex;
    justify-content: space-between;
}

.label {
    font-weight: 600;
}

.value {
    min-width: 120px;
    border-bottom: 1px solid #000;
    text-align: left;
}

/* ===== DECLARATION BOX ===== */
.declaration-box {
    border: 1px solid #000;
    padding: 10px;
    margin-top: 10px;
    font-size: 13px;
    line-height: 1.5;
}

/* ===== SIGNATURE SECTION ===== */
.signatures {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
}

.sign-box {
    text-align: center;
    width: 30%;
}

.sign-line {
    border-top: 1px solid #000;
    margin-top: 35px;
}

/* ===== PRINCIPAL ===== */
.principal {
    text-align: right;
    margin-top: 10px;
}

.principal-line {
    border-top: 1px solid #000;
    width: 160px;
    margin-left: auto;
    margin-top: 35px;
}

/* ===== NOTE ===== */
.note {
    font-size: 11px;
    margin-top: 8px;
    border-top: 1px dashed #000;
    padding-top: 5px;
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

    <!-- HEADER -->
    <div class="header">
        <h2>SANDUR POLYTECHNIC, YESHWANTNAGAR</h2>
        <h3>PROVISIONAL ADMISSION ORDER 2026–27</h3>
    </div>

    <!-- CONTENT -->
    <div class="content-box">
        <div class="content">
            <div class="field"><span class="label">Application No</span><span class="value"><%= appno %></span></div>
            <div class="field"><span class="label">Candidate Name</span><span class="value"><%= name %></span></div>

            <div class="field"><span class="label">Branch</span><span class="value"><%= branch %></span></div>
            <div class="field"><span class="label">Category</span><span class="value"><%= Segment %></span></div>

            <div class="field"><span class="label">Special Category</span><span class="value"><%= sp %></span></div>
            <div class="field"><span class="label">Admission Type</span><span class="value"><%= Admission_t %></span></div>
        </div>
    </div>

    <!-- DECLARATION -->
    <div class="declaration-box">
        <b>Declaration</b><br>
        I hereby accept the allotted course and confirm my admission as 
        <b><%= Admission_t %></b>.  
        <br><br>
        Last date for admission: __________________________
    </div>

    <!-- SIGNATURES -->
    <div class="signatures">
        <div class="sign-box">
            <div class="sign-line"></div>
            Student Signature
        </div>

        <div class="sign-box">
            <div class="sign-line"></div>
            Parent / Guardian
        </div>
    </div>

    <!-- PRINCIPAL -->
    <div class="principal">
        <div class="principal-line"></div>
        Principal
    </div>

    <!-- NOTE -->
    <div class="note">
        Note: Admission will be cancelled if not completed within the due date.
    </div>

</div>

<!-- PRINT BUTTON -->
<div class="print-btn">
    <button onclick="printPage()">Print</button>
</div>

</body>
</html>