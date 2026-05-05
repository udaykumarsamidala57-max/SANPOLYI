<%@ page import="java.sql.*, com.bean.DBUtil3" %>


<%
HttpSession sess = request.getSession(false);
if (sess == null || sess.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String role = (String) sess.getAttribute("role");
String dept = (String) sess.getAttribute("department");
String user = (String) sess.getAttribute("username");
if (!"Global".equalsIgnoreCase(role)) {

	    out.println("<h3 style='color:red;text-align:center;'>Access Denied! You are not authorized.</h3>");
	    return;
	}
%>


<%
Connection con = DBUtil3.getConnection();

/* DELETE */
if(request.getParameter("delete") != null){
    int id = Integer.parseInt(request.getParameter("delete"));
    PreparedStatement ps = con.prepareStatement("DELETE FROM seat_matrix WHERE id=?");
    ps.setInt(1, id);
    ps.executeUpdate();
    response.sendRedirect("Seatmatrix.jsp");
}

/* SAVE */
if("POST".equalsIgnoreCase(request.getMethod())){
    
    String id = request.getParameter("id");
    String category = request.getParameter("category");

    int ME = Integer.parseInt(request.getParameter("ME"));
    int EC = Integer.parseInt(request.getParameter("EC"));
    int CS = Integer.parseInt(request.getParameter("CS"));
    int EE = Integer.parseInt(request.getParameter("EE"));
    int CE = Integer.parseInt(request.getParameter("CE"));

    int total = ME + EC + CS + EE + CE;

    if(id == null || id.equals("")){
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO seat_matrix(category,ME,EC,CS,EE,CE,total) VALUES(?,?,?,?,?,?,?)"
        );
        ps.setString(1, category);
        ps.setInt(2, ME);
        ps.setInt(3, EC);
        ps.setInt(4, CS);
        ps.setInt(5, EE);
        ps.setInt(6, CE);
        ps.setInt(7, total);
        ps.executeUpdate();
    } else {
        PreparedStatement ps = con.prepareStatement(
            "UPDATE seat_matrix SET category=?,ME=?,EC=?,CS=?,EE=?,CE=?,total=? WHERE id=?"
        );
        ps.setString(1, category);
        ps.setInt(2, ME);
        ps.setInt(3, EC);
        ps.setInt(4, CS);
        ps.setInt(5, EE);
        ps.setInt(6, CE);
        ps.setInt(7, total);
        ps.setInt(8, Integer.parseInt(id));
        ps.executeUpdate();
    }

    response.sendRedirect("Seatmatrix.jsp");
}

/* EDIT LOAD */
String eid = request.getParameter("edit");

String category="", ME="", EC="", CS="", EE="", CE="", totalVal="";

if(eid != null){
    PreparedStatement ps = con.prepareStatement("SELECT * FROM seat_matrix WHERE id=?");
    ps.setInt(1, Integer.parseInt(eid));
    ResultSet rs1 = ps.executeQuery();

    if(rs1.next()){
        category = rs1.getString("category");
        ME = rs1.getString("ME");
        EC = rs1.getString("EC");
        CS = rs1.getString("CS");
        EE = rs1.getString("EE");
        CE = rs1.getString("CE");
        totalVal = rs1.getString("total");
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Seat Matrix</title>

<style>
body { font-family: Arial; background:#f4f6f9; padding:20px; }

h2 { text-align:center; }

table { border-collapse: collapse; width:75%; background:#fff; margin: 30px auto; }

th { background:#002147; color:#fff; padding:10px; }
td { padding:8px; text-align:center; }

input[type="number"], input[type="text"] {
    width:80px;
    padding:5px;
    text-align:center;
}

.category-input { width:150px; }

.btn { padding:6px 12px; border:none; cursor:pointer; }

.save-btn { background:#28a745; color:white; }
.edit-btn { color:blue; text-decoration:none; }
.delete-btn { color:red; text-decoration:none; }

.total-row {
    background:#dfe6e9;
    font-weight:bold;
}
</style>

<script>
function calculateTotal(){
    let me = parseInt(document.getElementById("ME").value) || 0;
    let ec = parseInt(document.getElementById("EC").value) || 0;
    let cs = parseInt(document.getElementById("CS").value) || 0;
    let ee = parseInt(document.getElementById("EE").value) || 0;
    let ce = parseInt(document.getElementById("CE").value) || 0;

    document.getElementById("total").value = me+ec+cs+ee+ce;
}

window.onload = calculateTotal;
</script>

</head>
<body>

	

<%@ include file="header.jsp" %>



<!-- FORM -->
<form method="post">
<input type="hidden" name="id" value="<%=eid==null?"":eid%>">

<table border="1">
<tr>
    <th>Category</th>
    <th>ME</th>
    <th>EC</th>
    <th>CS</th>
    <th>EE</th>
    <th>CE</th>
    <th>Total</th>
    <th>Action</th>
</tr>

<tr>
    <td><input type="text" name="category" class="category-input" value="<%=category%>" required></td>

    <td><input type="number" id="ME" name="ME" value="<%=ME%>" onkeyup="calculateTotal()" required></td>
    <td><input type="number" id="EC" name="EC" value="<%=EC%>" onkeyup="calculateTotal()" required></td>
    <td><input type="number" id="CS" name="CS" value="<%=CS%>" onkeyup="calculateTotal()" required></td>
    <td><input type="number" id="EE" name="EE" value="<%=EE%>" onkeyup="calculateTotal()" required></td>
    <td><input type="number" id="CE" name="CE" value="<%=CE%>" onkeyup="calculateTotal()" required></td>

    <td><input type="number" id="total" value="<%=totalVal%>" readonly></td>

    <td>
    <% if ("secretary".equalsIgnoreCase(user)) {%>
    <button type="submit" class="btn save-btn">Save</button>
    <%} %>
    </td>
</tr>
</table>
</form>

<br><br>

<!-- DATA TABLE -->
<table border="1">
<tr>
    <th>ID</th>
    <th>Category</th>
    <th>ME</th>
    <th>EC</th>
    <th>CS</th>
    <th>EE</th>
    <th>CE</th>
    <th>Total</th>
    <th>Action</th>
</tr>

<%
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM seat_matrix");

int tME=0, tEC=0, tCS=0, tEE=0, tCE=0, tTotal=0;

while(rs.next()){

    int me = rs.getInt("ME");
    int ec = rs.getInt("EC");
    int cs = rs.getInt("CS");
    int ee = rs.getInt("EE");
    int ce = rs.getInt("CE");
    int tot = rs.getInt("total");

    tME += me;
    tEC += ec;
    tCS += cs;
    tEE += ee;
    tCE += ce;
    tTotal += tot;
%>
<tr>
    <td><%=rs.getInt("id")%></td>
    <td><%=rs.getString("category")%></td>
    <td><%=me%></td>
    <td><%=ec%></td>
    <td><%=cs%></td>
    <td><%=ee%></td>
    <td><%=ce%></td>
    <td><%=tot%></td>
    <td>
    <% if ("secretary".equalsIgnoreCase(user)) {%>
        <a class="edit-btn" href="Seatmatrix.jsp?edit=<%=rs.getInt("id")%>">Edit</a> |
        <a class="delete-btn" href="Seatmatrix.jsp?delete=<%=rs.getInt("id")%>"
           onclick="return confirm('Delete?')">Delete</a>
           <%} %>
    </td>
</tr>
<%
}
%>

<tr class="total-row">
    <td colspan="2">TOTAL</td>
    <td><%=tME%></td>
    <td><%=tEC%></td>
    <td><%=tCS%></td>
    <td><%=tEE%></td>
    <td><%=tCE%></td>
    <td><%=tTotal%></td>
    <td>-</td>
</tr>

</table>

</body>
</html>