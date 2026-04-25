<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>University Admission Form</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #f5f7fa;
}

/* HEADER */
.header {
    background: #002147;
    color: #fff;
    padding: 18px 30px;
}
.header h1 {
    margin: 0;
    font-size: 22px;
}
.header p {
    margin: 3px 0 0;
    font-size: 13px;
    opacity: 0.8;
}

/* CONTAINER */
.container {
    max-width: 1100px;
    margin: 30px auto;
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
}

/* TITLE */
.form-title {
    text-align: center;
    margin-bottom: 25px;
}
.form-title h2 {
    margin: 0;
    color: #002147;
}
.form-title p {
    color: #666;
    font-size: 14px;
}

/* SECTION */
.section {
    margin-bottom: 25px;
    padding: 20px;
    border: 1px solid #e3e6ea;
    border-radius: 6px;
    background: #fafbfc;
}
.section-title {
    font-weight: 600;
    margin-bottom: 15px;
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
    font-size: 13px;
    margin-bottom: 5px;
}
input, textarea, select {
    padding: 9px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    transition: 0.2s;
}
input:focus, textarea:focus, select:focus {
    border-color: #002147;
    outline: none;
    box-shadow: 0 0 4px rgba(0,33,71,0.3);
}

/* FULL WIDTH */
.full {
    grid-column: span 2;
}

/* BUTTON */
.submit-box {
    text-align: center;
    margin-top: 20px;
}
button {
    background: #002147;
    color: #fff;
    border: none;
    padding: 12px 35px;
    font-size: 15px;
    border-radius: 5px;
    cursor: pointer;
}
button:hover {
    background: #003366;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .form-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />

<div class="header">
    <h1>SANPOLY Admission Portal</h1>
    <p>Academic Year 2026–27</p>
</div>

<div class="container">

    <div class="form-title">
        <h2>Student Admission Form</h2>
        <p>Please complete all required fields carefully</p>
    </div>

    <form action="AdmissionServlet" method="post">

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
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
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
                    <label>Category</label>
                    <select name="category">
                        <option>SC</option>
                        <option>ST</option>
                        <option>C-1</option>
                        <option>2A</option>
                        <option>2B</option>
                        <option>3A</option>
                        <option>3B</option>
                        <option>General</option>
                    </select>
                </div>

                <div class="form-field">
                    <label>Cast</label>
                    <input type="text" name="cast">
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
            <div class="section-title">Address Details</div>
            <div class="form-grid">

                <input type="text" name="native_place" placeholder="Native Place">
                <input type="text" name="taluk" placeholder="Taluk">
                <input type="text" name="district" placeholder="District">
                <input type="text" name="state" placeholder="State">

                <textarea class="full" name="postal_address" placeholder="Postal Address"></textarea>
                <textarea class="full" name="permanent_address" placeholder="Permanent Address"></textarea>

            </div>
        </div>

        <!-- FAMILY -->
        <div class="section">
            <div class="section-title">Family Details</div>
            <div class="form-grid">

                <input type="text" name="father_guardian_name" placeholder="Father / Guardian Name">
                <input type="text" name="father_occupation" placeholder="father_occupation">
                <input type="text" name="Father_org" placeholder="Father_org">
                <input type="text" name="mother_name" placeholder="Mother Name">
                <input type="text" name="mother_occupation" placeholder="mother_occupation">
                <input type="text" name="Mother_org" placeholder="Mother_org">
                <input type="number" name="income" placeholder="Annual Income">

            </div>
        </div>

        <!-- CONTACT -->
        <div class="section">
            <div class="section-title">Contact Details</div>
            <div class="form-grid">

                <input type="text" name="phone_no" placeholder="Phone Number">
                <input type="text" name="Whatsapp_no" placeholder="Whatsapp_no">
                <input type="email" name="email" placeholder="Email Address">

                <input class="full" type="text" name="aadhar_no" placeholder="Aadhar Number">
                <input class="full" type="text" name="APAAR" placeholder="APAAR">

            </div>
        </div>

        <!-- ACADEMIC -->
        <div class="section">
            <div class="section-title">Academic Information</div>
            <div class="form-grid">

                <p>SSlC Sate</p>

                <select name="SSLC_State" required>
                    <option value="Karnataka">Karnataka</option>
                    <option value="Non-Karnataka">Non-Karnataka</option>
                </select>

                <input type="text" name="medium_of_instruction" placeholder="Medium of Instruction">
                <input type="number" name="sscl_passing_year" placeholder="SSLC Passing Year">
                <input type="text" name="SSLC_Board" placeholder="SSLC_Board">
                <input type="text" name="SSLC_TMarks" placeholder="SSLC_TMarks">
                <input type="number" step="0.01" name="marks_maths" placeholder="Maths %">
                <input type="number" step="0.01" name="marks_science" placeholder="Science %">

            </div>
        </div>

        <!-- COURSE -->
        <div class="section">
            <div class="section-title">Course Preferences</div>
            <div class="form-grid">

                <select name="preference_1" required>
                    <option value="">Preference 1</option>
                    <option value="EE">EE</option>
                    <option value="ME">ME</option>
                    <option value="CS">CS</option>
                    <option value="EC">EC</option>
                    <option value="CE">CE</option>
                </select>

                <select name="preference_2">
                    <option value="">Preference 2</option>
                    <option value="EE">EE</option>
                    <option value="ME">ME</option>
                    <option value="CS">CS</option>
                    <option value="EC">EC</option>
                    <option value="CE">CE</option>
                </select>

                <select name="preference_3">
                    <option value="">Preference 3</option>
                    <option value="EE">EE</option>
                    <option value="ME">ME</option>
                    <option value="CS">CS</option>
                    <option value="EC">EC</option>
                    <option value="CE">CE</option>
                </select>

                <select name="preference_4">
                    <option value="">Preference 4</option>
                    <option value="EE">EE</option>
                    <option value="ME">ME</option>
                    <option value="CS">CS</option>
                    <option value="EC">EC</option>
                    <option value="CE">CE</option>
                </select>

                <select name="preference_5">
                    <option value="">Preference 5</option>
                    <option value="EE">EE</option>
                    <option value="ME">ME</option>
                    <option value="CS">CS</option>
                    <option value="EC">EC</option>
                    <option value="CE">CE</option>
                </select>

            </div>
        </div>

        <div class="submit-box">
            <button type="submit">Submit Application</button>
        </div>

    </form>
</div>

</body>
</html>