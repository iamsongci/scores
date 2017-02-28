<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">

<style type="text/css">
	.td_width{
		width: 100px;
	}

</style>

<script type="text/javascript">

	var rooms = '';
	$.ajax({
		type : "post",
		url : "./${sessionScope.pathCode}/getExistRooms.do",
		dataType : 'html',
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(data) {
			rooms = eval("(" + data + ")");
		},
		error : function(request) {
			alert("Connection error!");
		}
	});
	
	function append() {
		var newID = $('#newID').val();
		var newStartNum = $('#newStartNum').val();
		var newEndNum = $('#newEndNum').val();
		var newOtherUse = $('#newOtherUse').val();
		if(newID == '') {
			alert('请输入机房号!');
			return;
		}
		if(newID.length != 3) {
			alert('请输入3位机房号!');
			return;
		}
		
		if(isNaN(newID)) {
			alert('机房号请输入数值!');
			return;
		}
		for(var i = 0; i < rooms.length; i++) {
			if(rooms[i].room_id == newID) {
				alert('机房号已存在!');
				return;
			}
		}
		if(newStartNum == '') {
			alert('请输入开始座位号!');
			return;
		}
		if(isNaN(newStartNum)) {
			alert('开始座位号请输入数值!');
			return;
		}
		if(newStartNum < 1) {
			alert('开始座位号不能小于1!');
			return;
		}
		if(newEndNum == '') {
			alert('请输入结束座位号!');
			return;
		}
		if(isNaN(newEndNum)) {
			alert('结束座位号请输入数值!');
			return;
		}
		if(newEndNum > 255) {
			alert('开始座位号不能大于255!');
			return;
		}
		if (confirm('确认添加?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/append.do",
				data : "newID=" + newID + "&newStartNum=" + newStartNum + "&newEndNum=" + newEndNum + "&newOtherUse=" + newOtherUse,
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
	
	var currentID = '';
	function getCurrentID(ID) {
		currentID = ID;
	}
	
	function updateStartNum() {
		var startNum = $('#changeStart').val();
		if(isNaN(startNum)) {
			alert('座位号请输入数值!');
			return;
		}
		if(startNum < 1) {
			alert('座位号不能小于1!');
			return;
		}
		for(var i = 0; i < rooms.length; i++) {
			if(rooms[i].room_id == currentID) {
				if(startNum >= rooms[i].end_num) {
					alert('开始座位号不能大于或等于结束座位号!');
					return;
				}
			}
		}
		
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/updateStart.do",
				data : "ID=" + currentID + "&start=" + startNum,
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
	
	function updateEndNum() {
		var endNum = $('#changeEnd').val();
		if(isNaN(endNum)) {
			alert('座位号请输入数值!');
			return;
		}
		if(endNum > 255) {
			alert('座位号不能大于255!');
			return;
		}
		for(var i = 0; i < rooms.length; i++) {
			if(rooms[i].room_id == currentID) {
				if(endNum <= rooms[i].start_num) {
					alert('结束座位号不能小于或等于开始座位号!');
					return;
				}
			}
		}
		
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/updateEnd.do",
				data : "ID=" + currentID + "&end=" + endNum,
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
	
	function updateUse() {
		var use = $('#newUse').val();
		if(appendUse.trim == '') {
			alert('请输入其他用途!');
			return;
		}
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/updateUse.do",
				data : "ID=" + currentID + "&use=" + use,
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
	
	function resetUse(ID) {
		if (confirm('确认重置?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/resetUse.do",
				data : "ID=" + ID,
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
	
	function deleteRoom(ID) {
		if (confirm('确认删除?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/delete.do",
				data : "ID=" + ID,
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
	<div class="row">
		<div class="col-sm-12">
			<ol class="breadcrumb">
				<li><i class="clip-home-3"></i> <a
					href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
				<li class="active">机房信息</li>
			</ol>
			<div class="page-header">
				<h2>机房信息</h2>
			</div>
		</div>
	</div>
	
	
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
							<h5><font color="red">${errormsg}</font></h5>
						</tr>
						<tr>
							<th><small>机房号</small></th>
							<th><small>座位号类型</small></th>
							<th><small>开始座位号</small></th>
							<th><small>结束座位号</small></th>
							<th><small>其他用途</small></th>
							<th><small>删除</small></th>
						</tr>
					</thead>
						
					<tbody>
						<c:forEach items="${rooms}" var="room">
							<tr>
								<td><small>${room.room_id}</small></td>
								<td><small>${room.num_type}</small></td>
								<td><small>${room.num_type}${room.start_num}</small><button data-target="#changeStartNum" data-toggle="modal" onclick="getCurrentID('${room.room_id}')" class="btn btn-info btn-sm" style="float: right; margin-right: 25%">修改</button></td>
								<td><small>${room.num_type}${room.end_num}</small><button data-target="#changeEndNum" data-toggle="modal" onclick="getCurrentID('${room.room_id}')" class="btn btn-info btn-sm" style="float: right; margin-right: 25%">修改</button></td>
								<td>
									<c:choose>
										<c:when test="${not empty room.other_use}">										
											<small>${room.other_use}</small>
											<button class="btn btn-warning btn-sm" onclick="resetUse('${room.room_id}')" style="float: right; margin-right: 25%">重置</button>
										</c:when>
										<c:when test="${not empty room.used}">
											<small>已分配座位给导师</small>
										</c:when>
										<c:otherwise>
											<button class="btn btn-primary btn-sm" data-target="#appendUse" data-toggle="modal" onclick="getCurrentID('${room.room_id}')" >添加</button>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${not empty room.other_use}">
											<small>机房有其他用途, 不能删除</small>
										</c:when>
										<c:when test="${not empty room.used}">
											<small>已分配座位给导师, 不能删除</small>
										</c:when>
										<c:otherwise>										
											<button class="btn btn-danger btn-sm" onclick="deleteRoom('${room.room_id}')">删除</button>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

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
						机房号：<input type="text" maxlength="3" class="form-control" id="newID" name="newID" placeholder="example: 105">
					</div>
					<div class="modal-body">
						开始座位号：<input type="text" maxlength="3" class="form-control" id="newStartNum" name="newStartNum" placeholder="example: 10">
					</div>
					<div class="modal-body">
						结束座位号：<input type="text" maxlength="3" class="form-control" id="newEndNum" name="newEndNum" placeholder="example: 80">
					</div>
					<div class="modal-body">
						其他用途：(可不填)<input type="text" maxlength="10" class="form-control" id="newOtherUse" name="newOtherUse" placeholder="example: 培训">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="append()">提交</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="appendUse" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">添加用途</h4>
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" maxlength="10" id="newUse" name="newUse" placeholder="example: 培训">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateUse()">更改</button>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="modal fade" id="changeStartNum" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">修改开始座位号</h4>
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" maxlength="3" id="changeStart" name="changeStart" placeholder="example: 10">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateStartNum()">更改</button>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="modal fade" id="changeEndNum" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">修改结束座位号</h4>
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" maxlength="3" id="changeEnd" name="changeEnd" placeholder="example: 10">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateEndNum()">更改</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	

	<script src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
	<script src="assets/plugins/autosize/jquery.autosize.min.js"></script>
	<script src="assets/plugins/select2/select2.min.js"></script>
	<script src="assets/js/form-elements.js"></script>
	<script>
		jQuery(document).ready(function() {
			FormElements.init();
		});
	</script>
</body>
</html>
