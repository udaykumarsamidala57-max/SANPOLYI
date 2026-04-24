<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
    <title>Admission Form</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f6f9;
        }
        .container {
            width: 60%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        .row {
            display: flex;
            gap: 10px;
        }
        .row div {
            flex: 1;
        }
        button {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background: #28a745;
            color: white;
            border: none;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background: #218838;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Student Admission Form</h2>

```
<form action="AdmissionServlet" method="post">

    <label>Name of Applicant</label>
    <input type="text" name="applicant_name" required>

    <div class="row">
        <div>
            <label>Date of Birth</label>
            <input type="date" name="date_of_birth" required>
        </div>
        <div>
            <label>Gender</label>
            <select name="gender">
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
            </select>
        </div>
    </div>

    <label>Native Place</label>
    <input type="text" name="native_place">

    <div class="row">
        <div>
            <label>Taluk</label>
            <input type="text" name="taluk">
        </div>
        <div>
            <label>District</label>
            <input type="text" name="district">
        </div>
    </div>

    <label>State</label>
    <input type="text" name="state">

    <label>Nationality</label>
    <input type="text" name="nationality">

    <div class="row">
        <div>
            <label>Religion</label>
            <input type="text" name="religion_category">
        </div>
        <div>
            <label>Category</label>
            <input type="text" name="category">
        </div>
    </div>

    <div class="row">
        <div>
            <label>Mother Tongue</label>
            <input type="text" name="mother_tongue">
        </div>
        <div>
            <label>Blood Group</label>
            <input type="text" name="blood_group">
        </div>
    </div>

    <label>Father / Guardian Name</label>
    <input type="text" name="father_guardian_name">

    <label>Mother Name</label>
    <input type="text" name="mother_name">

    <div class="row">
        <div>
            <label>Occupation</label>
            <input type="text" name="occupation">
        </div>
        <div>
            <label>Income</label>
            <input type="number" name="income">
        </div>
    </div>

    <label>Postal Address</label>
    <textarea name="postal_address"></textarea>

    <label>Permanent Address</label>
    <textarea name="permanent_address"></textarea>

    <div class="row">
        <div>
            <label>Phone Number</label>
            <input type="text" name="phone_no">
        </div>
        <div>
            <label>Email</label>
            <input type="email" name="email">
        </div>
    </div>

    <label>Aadhar Number</label>
    <input type="text" name="aadhar_no">

    <div class="row">
        <div>
            <label>Medium of Instruction</label>
            <input type="text" name="medium_of_instruction">
        </div>
        <div>
            <label>SSLC Passing Year</label>
            <input type="number" name="sscl_passing_year">
        </div>
    </div>

    <div class="row">
        <div>
            <label>Maths %</label>
            <input type="number" step="0.01" name="marks_maths">
        </div>
        <div>
            <label>Science %</label>
            <input type="number" step="0.01" name="marks_science">
        </div>
    </div>

    <label>Course Preferences</label>
    <input type="text" name="preference_1" placeholder="Preference 1">
    <input type="text" name="preference_2" placeholder="Preference 2">
    <input type="text" name="preference_3" placeholder="Preference 3">
    <input type="text" name="preference_4" placeholder="Preference 4">
    <input type="text" name="preference_5" placeholder="Preference 5">

    <button type="submit">Submit Application</button>

</form>
```

</div>

</body>
</html>
