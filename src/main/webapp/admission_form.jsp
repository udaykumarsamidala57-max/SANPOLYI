<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SANPOLY Admission Form</title>
<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String role = (String) sess.getAttribute("role");
String User = (String) sess.getAttribute("username");
if (!"Global".equalsIgnoreCase(role)&& !"Office".equalsIgnoreCase(role)) {

    out.println("<h3 style='color:red;text-align:center;'>Access Denied! You are not authorized.</h3>");
    return;
}
%>
<style>
body { margin:0; font-family:'Segoe UI',Arial; background:#f5f7fa; }

.header {
    background:#002147;
    color:#fff;
    padding:6px 14px;

    display:inline-flex;
    align-items:center;
    gap:10px;

    float:left;
    border-radius:8px;
    margin:10px;

    box-shadow:0 2px 6px rgba(0,0,0,0.15);
}

.header h1 {
    margin:0;
    font-size:14px;
    font-weight:600;
    letter-spacing:0.3px;
}

.header p {
    margin:0;
    font-size:12px;
    opacity:0.85;
    padding-left:8px;
    border-left:1px solid rgba(255,255,255,0.4);
}

.page-title {
    font-size:13px;
    font-weight:500;
    padding-left:10px;
    border-left:1px solid rgba(255,255,255,0.4);
    opacity:0.9;
}

.container {
    max-width:1100px;
    margin:30px auto;
    background:#fff;
    padding:30px;
    border-radius:8px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.section {
    margin-bottom:25px;
    padding:20px;
    border:1px solid #e3e6ea;
    border-radius:6px;
    background:#fafbfc;
}

.section-title {
    font-weight:600;
    margin-bottom:15px;
    color:#002147;
}

/* GRID */
.form-grid {
    display:grid;
    grid-template-columns:repeat(2,1fr);
    gap:18px;
}

/* FIELD BLOCK */
.form-field {
    display:flex;
    flex-direction:column;
}

/* LABEL ALIGNMENT */
label {
    font-size:13px;
    font-weight:600;
    margin-bottom:5px;
    color:#333;
}

/* INPUT ALIGNMENT */
input, textarea, select {
    padding:10px;
    border:1px solid #ccc;
    border-radius:4px;
    font-size:14px;
    width:100%;
    box-sizing:border-box;
}

/* FULL WIDTH */
.full {
    grid-column:span 2;
}

/* BUTTON */
.submit-box {
    text-align:center;
    margin-top:20px;
}

button {
    background:#002147;
    color:#fff;
    padding:12px 35px;
    border:none;
    border-radius:5px;
    font-size:15px;
    cursor:pointer;
}

button:hover {
    background:#003366;
}
</style>
</head>

<body>
<%@ include file="header.jsp" %>


<div class="container">

<form action="AdmissionServlet" method="post">

<!-- BASIC INFO -->
<div class="section">
<div class="section-title">Application Info</div>
<div class="form-grid">

<div class="form-field">
<label>Application Number</label>
<input type="text" name="APPNO">
</div>

<div class="form-field">
<label>Category Number</label>
<input type="text" name="cast_no">
</div>

</div>
</div>

<!-- PERSONAL -->
<div class="section">
<div class="section-title">Personal Information</div>
<div class="form-grid">

<div class="form-field">
<label>Applicant Name</label>
<input type="text" name="applicant_name" required>
</div>

<div class="form-field">
<label>Date of Birth</label>
<input type="date" name="date_of_birth" required>
</div>

<div class="form-field">
<label>Gender</label>
<select name="gender">
<option value="M">Male</option>
<option value="F">Female</option>
</select>
</div>

<div class="form-field">
<label>Admission Type</label>
<select name="Admission_type">
<option>Dayscholar</option>
<option>Residential</option>
</select>
</div>

<div class="form-field">
<label>Nationality</label>
<input type="text" name="nationality" value="Indian" readonly>
</div>

<div class="form-field">
<label>Religion</label>
<input type="text" name="religion_category">
</div>


<div class="form-field">
<label>Caste</label>
<input type="text" name="cast">
</div>

<div class="form-field">
<label>Category</label>
<select name="category">
<option></option>
<option>SC</option>
<option>ST</option>
<option>General</option>
<option>CAT1</option>
<option>2A</option>
<option>2B</option>
<option>3A</option>
<option>3B</option>
</select>
</div>



<div class="form-field">
<label>Mother Tongue</label>
<input type="text" name="mother_tongue">
</div>

<div class="form-field">
<label>Blood Group</label>
<input type="text" name="blood_group">
</div>

</div>
</div>

<!-- ADDRESS -->
<div class="section">
<div class="section-title">Address</div>
<div class="form-grid">

<div class="form-field">
<label>Native Place</label>
<input type="text" name="native_place">
</div>

<div class="form-field">
<label>Taluk</label>
<input type="text" name="taluk">
</div>

<div class="form-field">
<label>District</label>
<input type="text" name="district">
</div>

<div class="form-field">
<label>State</label>
<input type="text" name="state">
</div>

<div class="form-field full">
<label>Postal Address</label>
<textarea name="postal_address"></textarea>
</div>

<div class="form-field full">
<label>Permanent Address</label>
<textarea name="permanent_address"></textarea>
</div>

</div>
</div>

<!-- FAMILY -->
<div class="section">
<div class="section-title">Family Details</div>
<div class="form-grid">

<div class="form-field">
<label>Father / Guardian Name</label>
<input type="text" name="father_guardian_name">
</div>

<div class="form-field">
<label>Father Occupation</label>
<input type="text" name="father_occupation">
</div>

<div class="form-field">
<label>Father Organization</label>
<input type="text" name="Father_org">
</div>

<div class="form-field">
<label>Mother Name</label>
<input type="text" name="mother_name">
</div>

<div class="form-field">
<label>Mother Occupation</label>
<input type="text" name="mother_occupation">
</div>

<div class="form-field">
<label>Mother Organization</label>
<input type="text" name="Mother_org">
</div>

<div class="form-field">
<label>Annual Income</label>
<input type="number" name="income">
</div>

</div>
</div>

<!-- CONTACT -->
<div class="section">
<div class="section-title">Contact</div>
<div class="form-grid">

<div class="form-field">
<label>Phone Number</label>
<input type="text" name="phone_no">
</div>

<div class="form-field">
<label>WhatsApp Number</label>
<input type="text" name="Whatsapp_no">
</div>

<div class="form-field">
<label>Email Address</label>
<input type="email" name="email">
</div>

<div class="form-field full">
<label>Aadhar Number</label>
<input type="text" name="aadhar_no">
</div>

<div class="form-field full">
<label>APAAR ID</label>
<input type="text" name="APAAR_ID">
</div>

</div>
</div>

<!-- ACADEMIC -->
<div class="section">
<div class="section-title">Academic</div>
<div class="form-grid">

<div class="form-field">
<label>SSLC State</label>
<select name="SSLC_State">
<option>Karnataka</option>
<option>Non-Karnataka</option>
</select>
</div>

<div class="form-field">
<label>Medium of Instruction</label>
<select name="medium_of_instruction">
<option>KANNADA</option>
<option>ENGLISH</option>
</select>
</div>

<div class="form-field">
<label>SSLC Passing Year</label>
<input type="number" name="sscl_passing_year">
</div>

<div class="form-field">
<label>SSLC Board</label>
<select name="SSLC_Board">
<option>KSEAB</option>
<option>CBSE</option>
<option>ICSE</option>
<option>OTHERS</option>
</select>
</div>

<div class="form-field">
<label>SSLC Total Marks Obtained</label>
<input type="text" name="SSLC_TMarks">
</div>

<div class="form-field">
<label>Maths Marks</label>
<input type="number" name="marks_maths">
</div>

<div class="form-field">
<label>Science Marks</label>
<input type="number" name="marks_science">
</div>

<div class="form-field">
<label>SSLC Percentage</label>
<input type="text" name="SSLC_Aggr">
</div>

</div>
</div>

<!-- COURSE -->
<div class="section">
<div class="section-title">Preferences</div>
<div class="form-grid">

<div class="form-field">
<label>Preference 1</label>
<select name="preference_1"><option>EE</option><option>CS</option><option>ME</option><option>CE</option><option>EC</option></select>
</div>

<div class="form-field">
<label>Preference 2</label>
<select name="preference_2"><option>EE</option><option>CS</option><option>ME</option><option>CE</option><option>EC</option><option>NA</option></select>
</div>

<div class="form-field">
<label>Preference 3</label>
<select name="preference_3"><option>EE</option><option>CS</option><option>ME</option><option>CE</option><option>EC</option><option>NA</option></select>
</div>

<div class="form-field">
<label>Preference 4</label>
<select name="preference_4"><option>EE</option><option>CS</option><option>ME</option><option>CE</option><option>EC</option><option>NA</option></select>
</div>

<div class="form-field">
<label>Preference 5</label>
<select name="preference_5"><option>EE</option><option>CS</option><option>ME</option><option>CE</option><option>EC</option><option>NA</option></select>
</div>

</div>
</div>

<div class="submit-box">
<button type="submit">Submit</button>
</div>

</form>

</div>

</body>
</html>