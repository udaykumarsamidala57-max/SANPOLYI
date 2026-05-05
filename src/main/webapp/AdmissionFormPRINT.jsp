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

/* ✅ A4 PAGE */
@page {
    size: A4 portrait;
    margin: 10mm;
}

body {
    font-family: Arial;
    margin: 0;
}

/* HALF PAGE */
.copy {
    height: 48%;
    border: 2px solid #000;
    padding: 12px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

/* LABEL (Office / Parent) */
.copy-label {
    position: absolute;
    right: 15px;
    top: 10px;
    font-size: 11px;
    font-weight: bold;
}

/* TEAR LINE */
.tear-line {
    border-top: 2px dashed #000;
    text-align: center;
    font-size: 11px;
    margin: 6px 0;
}

/* HEADER */
.header {
    text-align: center;
}

.header h2 {
    margin: 0;
    font-size: 16px;
}

.header h3 {
    margin: 3px 0;
    font-size: 14px;
}

/* CONTENT */
.content {
    font-size: 13px;
    line-height: 1.6;
}

.field {
    display: flex;
    margin-bottom: 6px;
}

.label {
    width: 40%;
}

.value {
    width: 60%;
    border-bottom: 1px dotted #000;
}

/* DECLARATION */
.declaration {
    font-size: 12px;
    margin-top: 8px;
}

/* SIGNATURES */
.signatures {
    margin-top: 15px;
    display: flex;
    justify-content: space-between;
    font-size: 12px;
}

.sign-line {
    border-top: 1px solid #000;
    width: 150px;
    margin-top: 25px;
}

/* PRINCIPAL */
.principal {
    text-align: right;
    margin-top: 10px;
    font-size: 12px;
}

.principal-line {
    border-top: 1px solid #000;
    width: 150px;
    margin-left: auto;
    margin-top: 25px;
}

/* NOTE */
.note {
    font-size: 11px;
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

<!-- ===== TOP COPY (OFFICE) ===== -->
<div class="copy" style="position:relative;">
    <div class="copy-label">Office Copy</div>

    <div class="header">
        <h2>SANDUR POLYTECHNIC, YESHWANTNAGAR</h2>
        <h3>PROVISIONAL ADMISSION ORDER 2026-27</h3>
        <hr>
    </div>
<br><br>	
    <div class="content">
        <div class="field"><div class="label">Name of Candidate</div><div class="value"><%= name %></div></div>
        <div class="field"><div class="label">Application No</div><div class="value"><%= appno %></div></div>
        <div class="field"><div class="label">Branch Selected</div><div class="value"><%= branch %></div></div>
        <div class="field"><div class="label">Category</div><div class="value"><%= Segment %></div></div>
        <div class="field"><div class="label">Special Category</div><div class="value"><%= sp %></div></div>
    </div>
<br><br>
    <div class="declaration">
        <b>Declaration:</b><br>
        I have accepted the course and taking admission as 
        <b><%= Admission_t %></b>.  
        The last date for admission: ______________________
    </div>
<br><br>
    <div class="signatures">
        <div>
            <div class="sign-line"></div>
            Student Signature
        </div>
        <br><br><br>
        <div>
            <div class="sign-line"></div>
            Parent/Guardian
        </div>
    </div>

    <div class="principal">
        <div class="principal-line"></div>
        Principal Signature
    </div>

    <div class="note">
        (Seat will be cancelled if admission is not taken within due date)
    </div>
</div>

<!-- ===== TEAR LINE ===== -->
<br><div class="tear-line"></div>

<!-- ===== BOTTOM COPY (PARENT) ===== -->
<div class="copy" style="position:relative;">
    <div class="copy-label">Student Copy</div>

    <div class="header">
        <h2>SANDUR POLYTECHNIC, YESHWANTNAGAR</h2>
        <h3>PROVISIONAL ADMISSION ORDER 2026-27</h3>
        <hr>
    </div>
<br><br>
    <div class="content">
        <div class="field"><div class="label">Name of Candidate</div><div class="value"><%= name %></div></div>
        <div class="field"><div class="label">Application No</div><div class="value"><%= appno %></div></div>
        <div class="field"><div class="label">Branch Selected</div><div class="value"><%= branch %></div></div>
        <div class="field"><div class="label">Category</div><div class="value"><%= Segment %></div></div>
        <div class="field"><div class="label">Special Category</div><div class="value"><%= sp %></div></div>
    </div>
<br><br>
    <div class="declaration">
        <b>Declaration:</b><br>
        I have accepted the course and taking admission as 
        <b><%= Admission_t %></b>.  
        The last date for admission: ______________________
    </div>
<br><br>
    <div class="signatures">
        <div>
            <div class="sign-line"></div>
            Student Signature
        </div>
        
        <br><br>
        <div>
            <div class="sign-line"></div>
            Parent/Guardian
        </div>
    </div>
<br><br>
    <div class="principal">
        <div class="principal-line"></div>
        Principal Signature
    </div>

    <div class="note">
        (Seat will be cancelled if admission is not taken within due date)
    </div>
</div>

<div class="print-btn">
    <button onclick="printPage()">Print</button>
</div>

</body>
</html>