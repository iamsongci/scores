<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>

		<title>软件学院实践课题管理系统</title>
		<link rel="stylesheet" href="assets/plugins/select2/select2.css">

		<script type="text/javascript">
			var rooms = '';
			
			var maxnum = '';
			var roomID = '';
			var teaID = '${teaID}';
			var teaName = '${teaName}';
			function init(id, num) {
				roomID = id;
				maxnum = num;

				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/getRooms.do",
					dataType: 'html',
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					success: function(result) {
						$('#scope').html("");
						rooms = eval("(" + result + ")");
						var seats = '';
						for(var i = 0; i < rooms.length; i++) {
							if(rooms[i].room_id == id)
								seats += rooms[i].start + ' - ' + rooms[i].end + ', ';
						}
						if(seats == '') 
							$('#scope').append('无');
						$('#scope').append(seats);

					},
					error: function(request) {
						alert("Connection error!");
					}
				});
			}
			
			function sub() {
				var start = $("#start").val();
				var end = $("#end").val();
				
				if(isNaN(start)) {
					alert('请输入数值!');
					return;
				}
				if(isNaN(end)) {
					alert('请输入数值!');
					return;
				}
				if(start.trim() == '' || end == '') {
					alert('请输入座位号!');
					return;
				}
				if(start > maxnum || end > maxnum) {
					alert('超过最大机位数!');
					return;
				}
				if(start < 0 || end < 0) {
					alert('机位输入错误!');
					return;
				}
				if(start > end) {
					alert('座位号错误!');
					return;
				}
				for(var i = 0; i < rooms.length; i++) {
					if(rooms[i].room_id == roomID) {
						if(rooms[i].start <= start && start <= rooms[i].end) {
							alert('座位已使用!');
							return;
						}
						if(rooms[i].start <= end && end <= rooms[i].end) {
							alert('座位已使用!');
							return;
						}
					}
				}
				if(confirm('确认座位号:' + start + " - " + end + '?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/addTeaRoom.do",
						data : "teaID=" + teaID + "&teaName=" + teaName + "&roomID=" + roomID + "&start=" + start + "&end=" + end,
						dataType: 'html',
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						success: function(result) {
							location.reload();
						},
						error: function(request) {
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
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">
						<a href="./${sessionScope.pathCode}/distribute.do"> 机房分配管理 </a>
					</li>
					<li class="active">
						<a href="./${sessionScope.pathCode}/chooseTeacher.do"> 选择分配教师 </a>
					</li>
					<li class="active">为 ${teaName } 分配机房</li>
				</ol>
				<!-- end: PAGE TITLE & BREADCRUMB -->
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
						<thead>
							<tr>
								<th><small>机房号</small></th>
								<th><small>机位数</small></th>
								<th><small>分配</small></th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${rooms}" var="room">
								<tr>
									<td><small>${room.room_id}</small></td>
									<td><small>${room.room_num}</small></td>
									<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#dis" onclick="init('${room.room_id}', '${room.room_num }')">分配</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

				</div>

			</div>
			<!-- end: TABLE WITH IMAGES PANEL -->
		</div>

		<!-- changeMyProName -->
		<div class="modal fade" id="dis" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">分配</h4>
					</div>
					<div class="modal-body">
						已选范围：<label id="scope"></label></br>
					</div>

					<div>
						<form class="form-inline" role="form">
							<div class="form-group" style="margin-left: 60px;">
								<input type="email" class="form-control" id="start" name="start" placeholder="起始座位号">
							</div>
							<div class="form-group">
								<input type="email" class="form-control" id="end" name="end" placeholder="结束座位号">
							</div>
							<button type="button" class="btn btn-default btn-primary" onclick="sub()">确定</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						</form>
					</div>

					<div class="modal-footer">
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- 模态框（Modal）end -->

		<script src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
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