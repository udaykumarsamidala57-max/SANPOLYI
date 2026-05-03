<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    if(pageTitle == null || pageTitle.trim().isEmpty()){
        pageTitle = "Dashboard";
    }

    String breadcrumb = (String) request.getAttribute("breadcrumb");
    if(breadcrumb == null){
        breadcrumb = "Admissions";
    }
%>

<style>
.adm-header {
    background: linear-gradient(to right, #f8fbff, #ffffff);
    border:1px solid #d6e2f0;
    border-left:7px solid #002147;   /* slightly thicker */
    padding:16px 22px;               /* 🔼 more spacing */
    border-radius:10px;
    margin:14px 0;

    display:flex;
    justify-content:space-between;
    align-items:center;

    box-shadow:0 4px 12px rgba(0,0,0,0.08); /* little deeper */
}

/* LEFT SIDE */
.adm-left {
    display:flex;
    flex-direction:column;
}

/* 🔹 Breadcrumb */
.adm-breadcrumb {
    font-size:13px;     /* 🔼 slightly bigger */
    color:#6c757d;
    margin-bottom:4px;
}

/* 🔹 Title */
.adm-title {
    font-size:22px;     /* 🔼 key increase */
    font-weight:700;
    color:#002147;
    letter-spacing:0.4px;
}

/* RIGHT SIDE */
.adm-right {
    text-align:right;
}

/* 🔹 Module Badge */
.adm-badge {
    background:#002147;
    color:#fff;
    padding:6px 12px;   /* 🔼 bigger pill */
    font-size:18px;
    border-radius:20px;
    letter-spacing:0.6px;
}
</style>

<div class="adm-header">

    <!-- LEFT -->
    <div class="adm-left">
        <div class="adm-breadcrumb" id="admBreadcrumb"></div>
       <div class="adm-title" id="admPageTitle"></div>
    </div>

    <!-- RIGHT -->
    <div class="adm-right">
        <div class="adm-badge">
            SANPOLY Admissions | 2026 -27
        </div>
    </div>

</div>
<script>
document.addEventListener("DOMContentLoaded", function () {

    // 🔹 ===== TITLE =====
    let title = document.title;
    title = title.replace(" - SANPOLY", "").trim();
    document.getElementById("admPageTitle").innerText = title;


    // 🔹 ===== BREADCRUMB =====
    let path = window.location.pathname;

    // Example: /SANPOLY/SeatAllotmentReport.jsp
    let parts = path.split("/").filter(p => p !== "");

    // Remove project name (optional)
    if(parts.length > 0){
        parts.shift(); // removes SANPOLY or project root
    }

    // Clean names
    let formatted = parts.map(p => {
        return p
            .replace(".jsp", "")
            .replace(/([A-Z])/g, " $1")  // CamelCase → words
            .trim();
    });

    // Build breadcrumb
    let breadcrumb = "Home";

    formatted.forEach(p => {
        breadcrumb += " / " + p;
    });

    document.getElementById("admBreadcrumb").innerText = breadcrumb;
});
</script>