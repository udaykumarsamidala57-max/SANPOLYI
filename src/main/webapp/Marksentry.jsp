<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Marks Entry</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
 href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
body { background:#f4f6f9; }
.container-box {
    background:#fff;
    padding:15px;
    border-radius:8px;
    margin-top:20px;
}
.table th { background:#002147; color:#fff; text-align:center; }
.table td { text-align:center; }
</style>
</head>

<body>

<div class="container">
<div class="container-box">

<h3>Marks Entry</h3>

<div class="table-responsive">
<table class="table table-bordered table-sm table-hover">

<thead>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Maths</th>
    <th>Science</th>
    <th>Aggr</th>
    <th>Total</th>
    <th>Action</th>
</tr>
</thead>

<tbody>

<%
List<Map<String,String>> list = (List<Map<String,String>>)request.getAttribute("data");

if(list!=null && !list.isEmpty()){
 for(Map<String,String> row:list){

String id=row.get("id")==null?"":row.get("id");
String name=row.get("name")==null?"":row.get("name");
String maths=row.get("maths")==null?"0":row.get("maths");
String science=row.get("science")==null?"0":row.get("science");
String aggr=row.get("aggr")==null?"0":row.get("aggr");

String board=row.get("board")==null?"0":row.get("board");
String puc=row.get("puc")==null?"0":row.get("puc");
String girls=row.get("girls")==null?"0":row.get("girls");
String et=row.get("et")==null?"0":row.get("et");

// 🔥 TOTAL CALCULATION IN JSP
double avg = 0;
try{
    avg = (Double.parseDouble(maths) + Double.parseDouble(science)) / 2;
}catch(Exception e){}

double total = 0;
try{
    total = avg + Double.parseDouble(board) + Double.parseDouble(puc)
            + Double.parseDouble(girls) + Double.parseDouble(et);
}catch(Exception e){}
%>

<tr>
<td><%=id%></td>
<td style="text-align:left;"><%=name%></td>
<td><%=maths%></td>
<td><%=science%></td>
<td><%=String.format("%.2f", avg)%></td>
<td><%=String.format("%.2f", total)%></td>

<td>
<button class="btn btn-sm btn-primary"
onclick="editRecord(this)"
data-id="<%=id%>"
data-name="<%=name%>"
data-maths="<%=maths%>"
data-science="<%=science%>"
data-board="<%=board%>"
data-puc="<%=puc%>"
data-girls="<%=girls%>"
data-et="<%=et%>">
Edit
</button>
</td>
</tr>

<% }} else { %>
<tr><td colspan="7" class="text-danger">No Records</td></tr>
<% } %>

</tbody>
</table>
</div>

</div>
</div>

<!-- ================= MODAL ================= -->

<div class="modal fade" id="editModal">
<div class="modal-dialog">
<div class="modal-content">

<form method="post" action="Marks">

<div class="modal-header bg-dark text-white">
<h5>Marks Entry</h5>
<button type="button" class="close text-white" data-dismiss="modal">&times;</button>
</div>

<div class="modal-body">

<input type="hidden" name="id" id="m_id">

<div class="form-group">
<label>Name</label>
<input id="m_name" class="form-control" readonly>
</div>

<div class="form-group">
<label>Maths</label>
<input id="m_maths" name="maths" class="form-control" readonly>
</div>

<div class="form-group">
<label>Science</label>
<input id="m_science" name="science" class="form-control" readonly>
</div>

<div class="form-group">
<label>Aggregate</label>
<input id="m_aggr" name="aggr" class="form-control" readonly>
</div>

<hr>

<div class="form-group">
<label>Board</label>
<input type="number" name="board" id="m_board" class="form-control">
</div>

<div class="form-group">
<label>PUC</label>
<input type="number" name="puc" id="m_puc" class="form-control">
</div>

<div class="form-group">
<label>Girls</label>
<input type="number" name="girls" id="m_girls" class="form-control">
</div>

<div class="form-group">
<label>ET</label>
<input type="number" name="et" id="m_et" class="form-control">
</div>

<hr>

<div class="form-group">
<label>Total</label>
<input id="m_total" class="form-control" readonly>
</div>

</div>

<div class="modal-footer">
<button class="btn btn-success">Update</button>
</div>

</form>

</div>
</div>
</div>

<!-- ================= SCRIPT ================= -->

<script>

function editRecord(btn){

let b=$(btn);

$('#m_id').val(b.data('id'));
$('#m_name').val(b.data('name'));
$('#m_maths').val(b.data('maths'));
$('#m_science').val(b.data('science'));

$('#m_board').val(b.data('board'));
$('#m_puc').val(b.data('puc'));
$('#m_girls').val(b.data('girls'));
$('#m_et').val(b.data('et'));

calculateAll();

$('#editModal').modal('show');
}

function calculateAll(){

let m=parseFloat($('#m_maths').val())||0;
let s=parseFloat($('#m_science').val())||0;

let board=parseFloat($('#m_board').val())||0;
let puc=parseFloat($('#m_puc').val())||0;
let girls=parseFloat($('#m_girls').val())||0;
let et=parseFloat($('#m_et').val())||0;

let avg = (m+s)/2;
$('#m_aggr').val(avg.toFixed(2));

let total = avg + board + puc + girls + et;
$('#m_total').val(total.toFixed(2));
}

$('#m_board, #m_puc, #m_girls, #m_et').on('input', function(){
calculateAll();
});

</script>

</body>
</html>