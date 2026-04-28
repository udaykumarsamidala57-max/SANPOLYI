<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admission List</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
body {
    background: #f4f6f9;
}

.container-box {
    background: #fff;
    padding: 15px;
    border-radius: 8px;
    margin-top: 20px;
}

.table th, .table td {
    text-align: center;
    vertical-align: middle;
}

.table th {
    background: #002147;
    color: white;
}

h3 {
    font-weight: 600;
}
</style>

</head>

<body>

<div class="container">
<div class="container-box">

<h3>Admission List</h3>

<div class="table-responsive">
<table class="table table-bordered table-hover table-sm">

<thead>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Maths</th>
    <th>Science</th>
    <th>Aggr</th>
    <th>Board</th>
    <th>PUC</th>
    <th>Girls</th>
    <th>ET</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");

if(list != null && !list.isEmpty()){

    for(Map<String,String> row : list){

        String id = row.get("id") == null ? "" : row.get("id");
        String name = row.get("name") == null ? "" : row.get("name");
        String maths = row.get("maths") == null ? "" : row.get("maths");
        String science = row.get("science") == null ? "" : row.get("science");
        String aggr = row.get("aggr") == null ? "" : row.get("aggr");
        String board = row.get("board") == null ? "" : row.get("board");
        String puc = row.get("puc") == null ? "" : row.get("puc");
        String girls = row.get("girls") == null ? "" : row.get("girls");
        String et = row.get("et") == null ? "" : row.get("et");
%>

<tr>
    <td><%=id%></td>
    <td style="text-align:left;"><%=name%></td>
    <td><%=maths%></td>
    <td><%=science%></td>
    <td><%=aggr%></td>
    <td><%=board%></td>
    <td><%=puc%></td>
    <td><%=girls%></td>
    <td><%=et%></td>

    <td>
        <button class="btn btn-sm btn-primary"
            onclick="editRecord(this)"
            data-id="<%=id%>"
            data-maths="<%=maths%>"
            data-science="<%=science%>"
            data-aggr="<%=aggr%>"
            data-board="<%=board%>"
            data-puc="<%=puc%>"
            data-girls="<%=girls%>"
            data-et="<%=et%>">
            Edit
        </button>
    </td>
</tr>

<%
    }

}else{
%>

<tr>
    <td colspan="10" class="text-danger">No Records Found</td>
</tr>

<%
}
%>

</tbody>
</table>
</div>

</div>
</div>

<!-- ================= EDIT MODAL ================= -->

<div class="modal fade" id="editModal">
<div class="modal-dialog">
<div class="modal-content">

<form method="post" action="AdmissionServlet">

<div class="modal-header bg-dark text-white">
<h5 class="modal-title">Edit Admission</h5>
<button type="button" class="close text-white" data-dismiss="modal">&times;</button>
</div>

<div class="modal-body">

<input type="hidden" name="id" id="m_id">

<div class="form-group">
<label>Maths</label>
<input type="number" step="0.01" name="maths" id="m_maths" class="form-control">
</div>

<div class="form-group">
<label>Science</label>
<input type="number" step="0.01" name="science" id="m_science" class="form-control">
</div>

<div class="form-group">
<label>Aggregate</label>
<input type="text" name="aggr" id="m_aggr" class="form-control">
</div>

<div class="form-group">
<label>Board</label>
<input type="text" name="board" id="m_board" class="form-control">
</div>

<div class="form-group">
<label>PUC</label>
<input type="text" name="puc" id="m_puc" class="form-control">
</div>

<div class="form-group">
<label>Girls</label>
<input type="text" name="girls" id="m_girls" class="form-control">
</div>

<div class="form-group">
<label>ET</label>
<input type="text" name="et" id="m_et" class="form-control">
</div>

</div>

<div class="modal-footer">
<button type="submit" class="btn btn-success">Update</button>
<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
</div>

</form>

</div>
</div>
</div>

<!-- ================= SCRIPT ================= -->

<script>
function editRecord(btn){

    let b = $(btn);

    $('#m_id').val(b.data('id'));
    $('#m_maths').val(b.data('maths'));
    $('#m_science').val(b.data('science'));
    $('#m_aggr').val(b.data('aggr'));
    $('#m_board').val(b.data('board'));
    $('#m_puc').val(b.data('puc'));
    $('#m_girls').val(b.data('girls'));
    $('#m_et').val(b.data('et'));

    $('#editModal').modal('show');
}
</script>

</body>
</html>