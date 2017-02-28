<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">

<script type="text/javascript">

	
	
	function update() {
		var index = $('#index').val();
		var newNumber = $('#newNumber').val();
		if(isNaN(newNumber)) {
			alert('请输入数值!');
			return;
		}
		
		if(newNumber < 0) {
			alert('请输入正确的数值!');
			return;
		}
		
		if(curNum > newNumber) {
			alert('数值不能变小!');
			return;
		}
		
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/upRoomNum.do",
				data : "id=" + index + "&newNumber=" + newNumber,
				dataType : 'html',
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(result) {
					location.reload();
				},
				error : function(request) {
					alert("Connection error!");
				}
			});
		}
	}
	
	function addNewRoom() {
		var id = $('#newID').val();
		var num = $('#num').val();
		if(isNaN(num)) {
			alert('请输入数值!');
			return;
		}
		if(num < 0) {
			alert('请输入正确的数值!');
			return;
		}
		var rooms = '${rooms}';
		var len = rooms.length;
		rooms = rooms.substring(1, len - 1)
		var IDs = rooms.split(', ');
		for(var i = 0; i < IDs.length; i++) {
			if(IDs[i] == id) {
				alert('机房号已存在!');
				return;
			}
		}
		if (confirm('确认添加?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/addNewRoom.do",
				data : "id=" + id + "&num=" + num,
				dataType : 'html',
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(result) {
					location.reload();
				},
				error : function(request) {
					alert("Connection error!");
				}
			});
		}
		
	}

</script>
</head>

<body>
	<c:if test="${message != null }">
	</c:if>
	<!-- start: PAGE HEADER -->
	<div class="row">
		<div class="col-sm-12">
			<!-- start: PAGE TITLE & BREADCRUMB -->
			<ol class="breadcrumb">
				<li><i class="clip-home-3"></i> <a
					href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
				<li class="active">机房信息</li>
			</ol>
			<!-- end: PAGE TITLE & BREADCRUMB -->
			<div class="page-header">
				<h2>机房信息</h2>
			</div>
		</div>
	</div>
	<!-- end: PAGE HEADER 頭部結束-->
	<c:if test="${message == '1'}">
		<div class="alert alert-success">
			<a href="#" class="close" data-dismiss="alert"> &times; </a>

		</div>
	</c:if>
	<div class="row">
		<div class="col-md-12">
			<div class="panel-body">
				<table class="table  table-hover">
					<tr>
						<button type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;">添加机房</button>
					</tr>
					<thead>
						<tr>
							<th><small>机房号</small></th>
						</tr>
					</thead>
						
					<tbody>
						<c:forEach items="${rooms}" var="room">
							<tr>
								<td><small>${room.room_id}</small></td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- end: TABLE WITH IMAGES PANEL -->
	</div>

	

	<script
		src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
	<!-- 3 -->
	<script src="assets/plugins/autosize/jquery.autosize.min.js"></script>
	<!-- 1 -->
	<script src="assets/plugins/select2/select2.min.js"></script>
	<!-- 2 -->
	<script src="assets/js/form-elements.js"></script>
	<!-- 4 -->
	<!-- end: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
	<script>
		jQuery(document).ready(function() {
			FormElements.init();
		});
	</script>
</body>
</html>
