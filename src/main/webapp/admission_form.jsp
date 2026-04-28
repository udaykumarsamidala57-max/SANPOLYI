<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>University Admission Form</title>

<style>
/* SAME CSS — NO CHANGE */
body { margin:0; font-family:'Segoe UI',Arial; background:#f5f7fa; }
.header { background:#002147; color:#fff; padding:18px 30px; }
.container { max-width:1100px; margin:30px auto; background:#fff; padding:30px; border-radius:8px; box-shadow:0 8px 25px rgba(0,0,0,0.08); }
.section { margin-bottom:25px; padding:20px; border:1px solid #e3e6ea; border-radius:6px; background:#fafbfc; }
.section-title { font-weight:600; margin-bottom:15px; color:#002147; }
.form-grid { display:grid; grid-template-columns:repeat(2,1fr); gap:15px; }
input, textarea, select { padding:9px; border:1px solid #ccc; border-radius:4px; }
.full { grid-column:span 2; }
.submit-box { text-align:center; margin-top:20px; }
button { background:#002147; color:#fff; padding:12px 35px; border:none; border-radius:5px; }
</style>
</head>

<body>

<div class="header">
    <h1>SANPOLY Admission Portal</h1>
    <p>Academic Year 2026–27</p>
</div>

<div class="container">

<form action="AdmissionServlet" method="post">

<!-- BASIC INFO -->
<div class="section">
<div class="section-title">Application Info</div>
<div class="form-grid">
<input type="text" name="APPNO" placeholder="Application Number">
<input type="text" name="cast_no" placeholder="Catg. Certificate Number">
</div>
</div>

<!-- PERSONAL -->
<div class="section">
<div class="section-title">Personal Information</div>
<div class="form-grid">

<input type="text" name="applicant_name" placeholder="Applicant Name" required>
<input type="date" name="date_of_birth" required>

<select name="gender">
<option value="M">M</option>
<option value="F">F</option>
</select>

<select name="Admission_type">
<option>Dayscholar</option>
<option>Residential</option>
</select>

<input type="text" name="nationality" value="Indian" readonly>
<input type="text" name="religion_category" placeholder="Religion">

<select name="category">
<option>SC</option>
<option>ST</option>
<option>General</option>
</select>

<input type="text" name="cast" placeholder="Caste">
<input type="text" name="mother_tongue" placeholder="Mother Tongue">
<input type="text" name="blood_group" placeholder="Blood Group">

</div>
</div>

<!-- ADDRESS -->
<div class="section">
<div class="section-title">Address</div>
<div class="form-grid">

<input type="text" name="native_place">
<input type="text" name="taluk">
<input type="text" name="district">
<input type="text" name="state">

<textarea class="full" name="postal_address"></textarea>
<textarea class="full" name="permanent_address"></textarea>

</div>
</div>

<!-- FAMILY -->
<div class="section">
<div class="section-title">Family Details</div>
<div class="form-grid">

<input type="text" name="father_guardian_name">
<input type="text" name="father_occupation">
<input type="text" name="Father_org">

<input type="text" name="mother_name">
<input type="text" name="mother_occupation">
<input type="text" name="Mother_org">

<input type="number" name="income">

</div>
</div>

<!-- CONTACT -->
<div class="section">
<div class="section-title">Contact</div>
<div class="form-grid">

<input type="text" name="phone_no">
<input type="text" name="Whatsapp_no">
<input type="email" name="email">

<input class="full" type="text" name="aadhar_no">
<input class="full" type="text" name="APAAR_ID">

</div>
</div>

<!-- ACADEMIC -->
<div class="section">
<div class="section-title">Academic</div>
<div class="form-grid">

<select name="SSLC_State">
<option>Karnataka</option>
<option>Non-Karnataka</option>
</select>

<input type="text" name="medium_of_instruction">
<input type="number" name="sscl_passing_year">

<input type="text" name="SSLC_Board">
<input type="text" name="SSLC_TMarks">

<input type="number" name="marks_maths">
<input type="number" name="marks_science">

<input type="text" name="SSLC_Aggr">

</div>
</div>

<!-- COURSE -->
<div class="section">
<div class="section-title">Preferences</div>
<div class="form-grid">

<select name="preference_1"><option>EE</option><option>CS</option></select>
<select name="preference_2"><option>EE</option><option>CS</option></select>
<select name="preference_3"><option>EE</option><option>CS</option></select>
<select name="preference_4"><option>EE</option><option>CS</option></select>
<select name="preference_5"><option>EE</option><option>CS</option></select>

</div>
</div>

<div class="submit-box">
<button type="submit">Submit</button>
</div>

</form>


</div>

</body>
</html>