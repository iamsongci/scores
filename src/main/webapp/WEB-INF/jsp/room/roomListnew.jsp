<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>

		<title>软件学院实践课题管理系统</title>
		<link rel="stylesheet" href="assets/plugins/select2/select2.css">

		<script type="text/javascript">
			function enter(ID) {
				var teaID = '${teaID}';
				var teaName = '${teaName}';
				
				var url = "./${sessionScope.pathCode}/roomInfo.do?roomID=" + ID + "&teaID=" + teaID + "&teaName=" + teaName;
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
					<li class="active">机房分配管理</li>
					<li class="active">选择分配教师</li>
					<li class="active">为 ${teaName } 分配机房</li>
				</ol>
				<div class="page-header">
					<h3>机房列表</h3>
				</div>
			</div>
		</div>

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
									<td><small>${room.start_num} - ${room.end_num}</small></td>
									<td>
										<c:choose>
											<c:when test="${not empty room.other_use}">
												<small>其他用途: ${room.other_use}</small>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#dis" onclick="enter('${room.room_id}')">查看</button
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