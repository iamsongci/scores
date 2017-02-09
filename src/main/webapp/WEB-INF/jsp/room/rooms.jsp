<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">

<script type="text/javascript">

	var curNum = '';
	function init(id, num) {
		$('#index').val(id);
		curNum = num;
	}
	
	function del(id) {
		alert('test');
		/* 
		if (confirm('确认删除?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/delRoom.do",
				data : "id=" + id,
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
		*/
	}
	
	function delAll() {
		alert('test');
		/* 
		if (confirm('确认全部删除?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/delAll.do",
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
		*/
		
	}
	
	
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
						<button data-target="#addRoom" data-toggle="modal" type="button"
							class="btn btn-info"
							style="float: right; margin: 5px 10% 5px 5px;">添加机房</button>
					</tr>
					<thead>
						<tr>
							<th><small>机房号</small></th>
							<th><small>机位数</small></th>
							<th><small>修改</small></th>
							<th><small>删除</small></th>
							
						</tr>
					</thead>
						
					<tbody>
						<c:forEach items="${rooms}" var="room">
							<tr>
								<td><small>${room.room_id}</small></td>
								<td><small>${room.room_num}</small></td>
								<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#change" onclick="init('${room.room_id}', '${room.room_num }')" >修改</button></td>
								<td><button type="button" class="btn btn-danger btn-sm" onclick="del('${room.room_id}')" >删除</button></td>
							</tr>
						</c:forEach>
					</tbody>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><button type="button" class="btn btn-danger btn-sm" onclick="delAll()" >全部删除</button></td>
						</tr>
				</table>
			</div>
		</div>
		<!-- end: TABLE WITH IMAGES PANEL -->
	</div>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="addRoom" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">添加机房</h4>
				</div>
				<div class="modal-body">
					<div class="modal-body">
						机房号：<input type="text" maxlength="5" class="form-control" id="newID" name="newID" placeholder="example: 105">
					</div>
					<div class="modal-body">
						机位数：<input type="text" maxlength="4" class="form-control" id="num" name="num" placeholder="example: 80">
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addNewRoom()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal）end -->
	
	
	<!-- changeMyProName -->
	<div class="modal fade" id="change" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">修改机位数</h4>
				</div>
				<div class="modal-body">
					机位数：<input type="text" class="form-control" id="newNumber" name="newNumber">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="update()">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal）end -->
	

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
