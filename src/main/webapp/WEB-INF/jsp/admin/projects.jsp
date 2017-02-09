<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<title>软件学院实践课题管理系统</title>

		<script type="text/javascript">
			var thisProID = '';
			var thisType = '';

			function getProID(proID, type) {
				thisProID = proID;
				thisType = type;
			}

			function getTea(teaID, teaName) {
				if(thisType == 1) {
					var url = "./${sessionScope.pathCode}/proDistr.do?proID=" + thisProID + "&teaID=" + teaID + "&teaName=" + teaName;
					url = encodeURI(url);
					window.location.href = url;
				}

				if(thisType == 2) {
					var url = "./${sessionScope.pathCode}/proAggre.do?proID=" + thisProID + "&teaID=" + teaID + "&teaName=" + teaName;
					url = encodeURI(url);
					window.location.href = url;
				}
			}

			function reset(proID, type) {
				if(type == 1) {
					var url = "./${sessionScope.pathCode}/resetDistr.do?proID=" + proID;
					url = encodeURI(url);
					if(confirm('确认重置?')) {
						window.location.href = url;
					}
				}

				if(type == 2) {
					var url = "./${sessionScope.pathCode}/resetAggre.do?proID=" + proID;
					url = encodeURI(url);
					if(confirm('确认重置?')) {
						window.location.href = url;
					}
				}

			}

			function checkPro() {
				var proName = $('#proName').val();
				if(proName == '') {
					alert('请输入课题名!');
					return;
				}
				var url = "./${sessionScope.pathCode}/addProject.do?proName=" + proName;
				url = encodeURI(url);
				window.location.href = url;
			}

		</script>
	</head>

	<body>
		<div class="row">
			<div class="col-sm-12">
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">课题管理</li>
				</ol>
				<div class="page-header">
					<h3>课题管理</h3>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="panel-body">
					<table class="table  table-hover">
						<thead>
							<tr>
								<button data-target="#addPro" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 2% 5px 5px;">添加课题</button>
							</tr>
							<tr>
								<th><small>课题名</small></th>
								<th><small>分配管理</small></th>
								<th><small>重置</small></th>
								<th><small>汇总管理</small></th>
								<th><small>重置</small></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${projects}" var="project">
								<tr>
									<td><small>${project.project_name}</small></td>
									<td>
										<c:if test="${not empty project.distribution_name}">
											<small>${project.distribution_name}</small>
										</c:if>
										<c:if test="${empty project.distribution_name}">
											<button data-target="#teaList" data-toggle="modal" type="button" class="btn btn-info" onclick="getProID('${project.project_id}', 1)">分配</button>
										</c:if>
									</td>

									<td>
										<c:if test="${not empty project.distribution_name}">
											<button type="button" class="btn btn-danger" onclick="reset('${project.project_id}', 1)">重置</button>
										</c:if>
									</td>

									<td>
										<c:if test="${not empty project.aggregate_name}">
											<small>${project.aggregate_name}</small>
										</c:if>
										<c:if test="${empty project.aggregate_name}">
											<button data-target="#teaList" data-toggle="modal" type="button" class="btn btn-info" onclick="getProID('${project.project_id}', 2)">分配</button>
										</c:if>
									</td>
									<td>
										<c:if test="${not empty project.aggregate_name}">
											<button type="button" class="btn btn-danger" onclick="reset('${project.project_id}', 2)">重置</button>
										</c:if>
									</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="modal fade" id="teaList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						<h4 class="modal-title" id="myModalLabel">导师列表</h4>
					</div>
					<div class="modal-body">
						<table class="table  table-hover">
							<thead>
								<tr>
									<th><small>工号</small></th>
									<th><small>姓名</small></th>
									<th><small>分配</small></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${teachers}" var="teacher">
									<tr>
										<td><small>${teacher.noid}</small></td>
										<td><small>${teacher.name}</small></td>
										<td width="100px">
											<button type="button" class="btn btn-info" onclick="getTea('${teacher.id}', '${teacher.name }')">分配</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="addPro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						<h4 class="modal-title" id="myModalLabel">添加课题</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" onsubmit="return false">

							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">课题名</label>
								<div class="col-sm-10">
									<input type="text" maxlength="30" class="form-control" id="proName" name="proName" placeholder="example: 一级实践课题">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="button" class="btn btn-primary" style="float: right; margin: 5px 10% 5px 5px;" onclick="checkPro()">添加</button>
									<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right; margin: 5px 2% 5px 5px;">关闭</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

	</body>

</html>