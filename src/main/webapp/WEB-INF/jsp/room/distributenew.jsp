<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>

		<title>软件学院实践课题管理系统</title>
		<link rel="stylesheet" href="assets/plugins/select2/select2.css">
		<script type="text/javascript">
			
			function deltearoom(ID) {
				if (confirm('确认删除?')) {
					$.ajax({
						type : "post",
						url : "./${sessionScope.pathCode}/delTeaRoomNew.do",
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

			
			function enter() {
				var url = "./${sessionScope.pathCode}/teaList.do";
				url = encodeURI(url);
				window.location.href = url;
			}
			
		</script>
	</head>

	<body>
		<div class="row">
			<div class="col-sm-12">
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i><a href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
					<li class="active">导师机房分配</li>
				</ol>
				<div class="page-header">
					<h2>导师机房分配</h2>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel-body">
					<table class="table table-hover">
						<thead>
							<tr>
								<button data-target="#upload" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;" onclick="enter()" >分配</button>
							</tr>
							<tr>
								<th><small>机房号</small></th>
								<th><small>导师名</small></th>
								<th><small>座位</small></th>
								<th><small>操作</small></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${tearooms}" var="tearoom">
								<tr>
									<td><small>${tearoom.room_id}</small></td>
									<td><small>${tearoom.identity_name}</small></td>
									<td><small>${tearoom.seats}</small></td>
									<td>
										<button type="button" class="btn btn-danger btn-sm" onclick="deltearoom('${tearoom.id}')">删除</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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