<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission Enquiry</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f4f6f9;
}

/* HEADER */
.header {
    background: #002147;
    color: white;
    padding: 15px 30px;
    font-size: 22px;
    font-weight: 600;
}

/* MAIN CONTAINER */
.container {
    max-width: 1000px;
    margin: 30px auto;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0px 4px 12px rgba(0,0,0,0.1);
}

h2 {
    margin-bottom: 20px;
    color: #002147;
}

/* SECTION */
.section {
    margin-bottom: 25px;
}

.section-title {
    font-weight: 600;
    margin-bottom: 10px;
    border-bottom: 2px solid #002147;
    padding-bottom: 5px;
    color: #002147;
}

/* GRID */
.form-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
}

/* FIELD */
.form-field {
    display: flex;
    flex-direction: column;
}

label {
    font-size: 14px;
    margin-bottom: 4px;
}

input, select {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

/* ERROR */
.error-msg {
    color: red;
    font-size: 12px;
}

/* BUTTON */
.submit-box {
    text-align: center;
    margin-top: 20px;
}

button {
    background: #002147;
    color: white;
    border: none;
    padding: 10px 25px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background: #003366;
}
</style>

</head>
<body>

<div class="header">
    🎓 University Admission Enquiry
</div>

<div class="container">

<h2>Admission Enquiry Form</h2>

<form action="SaveEnquiryServlet" method="post" onsubmit="return validateBeforeSubmit();">

<!-- STUDENT -->
<div class="section">
    <div class="section-title">Student Details</div>
    <div class="form-grid">

        <div class="form-field">
            <label>Student Name *</label>
            <input type="text" name="student_name" required>
        </div>

        <div class="form-field">
            <label>Gender</label>
            <select name="gender">
                <option value="">-- Select --</option>
                <option>Male</option>
                <option>Female</option>
            </select>
        </div>

        <div class="form-field">
            <label>Date of Birth</label>
            <input type="date" id="dob" name="date_of_birth" oninput="calculateAge()">
        </div>

        <div class="form-field">
            <label>Age</label>
            <input type="text" id="age" name="age" readonly>
        </div>

        <div class="form-field">
            <label>Class of Admission</label>
            <select name="class_of_admission">
                <option value="">-- Select --</option>
                <option>LKG</option>
                <option>UKG</option>
                <option>Class 1</option>
                <option>Class 2</option>
                <option>Class 3</option>
                <option>Class 4</option>
                <option>Class 5</option>
                <option>Class 6</option>
                <option>Class 7</option>
                <option>Class 8</option>
            </select>
        </div>

        <div class="form-field">
            <label>Admission Type</label>
            <select name="admission_type">
                <option value="">-- Select --</option>
                <option>Dayscholar</option>
                <option>Residential</option>
                <option>Semi Residential</option>
            </select>
        </div>

    </div>
</div>

<!-- FATHER -->
<div class="section">
    <div class="section-title">Father Details</div>
    <div class="form-grid">

        <div class="form-field">
            <label>Name</label>
            <input type="text" name="father_name">
        </div>

        <div class="form-field">
            <label>Occupation</label>
            <input type="text" name="father_occupation">
        </div>

        <div class="form-field">
            <label>Organization</label>
            <input type="text" name="father_organization">
        </div>

        <div class="form-field">
            <label>Mobile</label>
            <input type="text" id="father_mobile" maxlength="10" onkeyup="checkMobile(this.value)">
            <div id="mobileMsg" class="error-msg"></div>
        </div>

    </div>
</div>

<!-- MOTHER -->
<div class="section">
    <div class="section-title">Mother Details</div>
    <div class="form-grid">

        <div class="form-field">
            <label>Name</label>
            <input type="text" name="mother_name">
        </div>

        <div class="form-field">
            <label>Occupation</label>
            <input type="text" name="mother_occupation">
        </div>

        <div class="form-field">
            <label>Organization</label>
            <input type="text" name="mother_organization">
        </div>

        <div class="form-field">
            <label>Mobile</label>
            <input type="text" name="mother_mobile_no" maxlength="10">
        </div>

    </div>
</div>

<!-- OTHER -->
<div class="section">
    <div class="section-title">Other Details</div>
    <div class="form-grid">

        <div class="form-field">
            <label>Segment</label>
            <select name="segment">
                <option value="">-- Select --</option>
                <option>General</option>
                <option>SMIORE</option>
                <option>SVPS</option>
                <option>SVPSGEN</option>
                <option>RTE</option>
            </select>
        </div>

        <div class="form-field">
            <label>Place From</label>
            <input type="text" name="place_from">
        </div>

    </div>
</div>

<div class="submit-box" id="submitBox">
    <button type="submit">Submit Enquiry</button>
</div>

</form>
</div>

<script>
let mobileExists = false;

function calculateAge() {
    let dob = new Date(document.getElementById("dob").value);
    let today = new Date();

    let y = today.getFullYear() - dob.getFullYear();
    let m = today.getMonth() - dob.getMonth();
    let d = today.getDate() - dob.getDate();

    if (d < 0) { m--; d += 30; }
    if (m < 0) { y--; m += 12; }

    document.getElementById("age").value = y+"Y "+m+"M "+d+"D";
}

function checkMobile(mobile) {
    if (mobile.length != 10) return;

    let xhr = new XMLHttpRequest();
    xhr.open("GET", "SaveEnquiryServlet?mobile=" + mobile, true);

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            if (xhr.responseText.trim() === "EXISTS") {
                document.getElementById("mobileMsg").innerHTML = "Already exists!";
                document.getElementById("submitBox").style.display = "none";
                mobileExists = true;
            } else {
                document.getElementById("mobileMsg").innerHTML = "";
                document.getElementById("submitBox").style.display = "block";
                mobileExists = false;
            }
        }
    };
    xhr.send();
}

function validateBeforeSubmit() {
    if (mobileExists) {
        alert("Mobile already exists!");
        return false;
    }
    return true;
}
</script>

</body>
</html>