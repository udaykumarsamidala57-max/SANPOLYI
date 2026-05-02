<%@ page import="java.sql.*, com.bean.DBUtil3" %>

<%
Connection con = DBUtil3.getConnection();

/* =========================
   DELETE
========================= */
if(request.getParameter("delete") != null){
    int id = Integer.parseInt(request.getParameter("delete"));
    PreparedStatement ps = con.prepareStatement("DELETE FROM seat_matrix WHERE id=?");
    ps.setInt(1, id);
    ps.executeUpdate();
    response.sendRedirect("seat_matrix.jsp");
}

/* =========================
   SAVE (INSERT / UPDATE)
========================= */
if(request.getMethod().equalsIgnoreCase("POST")){
    
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

    response.sendRedirect("seat_matrix.jsp");
}

/* =========================
   EDIT LOAD
========================= */
String eid = request.getParameter("edit");

String category="", ME="", EC="", CS="", EE="", CE="";

if(eid != null){
    PreparedStatement ps = con.prepareStatement("SELECT * FROM seat_matrix WHERE id=?");
    ps.setInt(1, Integer.parseInt(eid));
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        category = rs.getString("category");
        ME = rs.getString("ME");
        EC = rs.getString("EC");
        CS = rs.getString("CS");
        EE = rs.getString("EE");
        CE = rs.getString("CE");
    }
}
%>

<h2>Seat Matrix</h2>

<!-- ================= FORM ================= -->
<form method="post">
    <input type="hidden" name="id" value="<%=eid==null?"":eid%>">

    Category:
    <input type="text" name="category" value="<%=category%>" required><br><br>

    ME: <input type="number" name="ME" value="<%=ME%>" required>
    EC: <input type="number" name="EC" value="<%=EC%>" required>
    CS: <input type="number" name="CS" value="<%=CS%>" required>
    EE: <input type="number" name="EE" value="<%=EE%>" required>
    CE: <input type="number" name="CE" value="<%=CE%>" required>

    <br><br>
    <button type="submit">Save</button>
</form>

<hr>

<!-- ================= TABLE ================= -->
<table border="1" cellpadding="10">
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

while(rs.next()){
%>
<tr>
    <td><%=rs.getInt("id")%></td>
    <td><%=rs.getString("category")%></td>
    <td><%=rs.getInt("ME")%></td>
    <td><%=rs.getInt("EC")%></td>
    <td><%=rs.getInt("CS")%></td>
    <td><%=rs.getInt("EE")%></td>
    <td><%=rs.getInt("CE")%></td>
    <td><%=rs.getInt("total")%></td>
    <td>
        <a href="seat_matrix.jsp?edit=<%=rs.getInt("id")%>">Edit</a> |
        <a href="seat_matrix.jsp?delete=<%=rs.getInt("id")%>"
           onclick="return confirm('Delete?')">Delete</a>
    </td>
</tr>
<%
}
%>

</table>