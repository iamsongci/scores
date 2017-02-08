<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

	<head>
		<title>实践课题管理系统</title>
		<!-- DataTables CSS -->
		<link href="assets/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
		<!-- DataTables Responsive CSS -->
		<link href="assets/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
		<!-- Custom CSS -->
		<link href="assets/vendor/dist/css/sb-admin-2.css" rel="stylesheet">
		<!-- Custom Fonts -->
		<link href="assets/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript">
		function checkClass(from) {
			var classs = "${classs}";
			var len = classs.length;
			classs = classs.substring(1, len - 1)
			var classs = classs.split(', ');
			var type = $('#type option:selected').val();
			var grade = from.grade.value;
			var gradeReg = /^\d{2}$/;
			var nameClassReg = /^\d{3}$/;
			var classes_name = from.classes_name.value;
			len = classes_name.length;
			var start = classes_name.substring(0, 2);
			var end   = classes_name.substring(len - 3, len);
			if (type == '请选择') {
				alert('请选择专/本科!');
				return false;
			}
			if(! gradeReg.test(grade)) {
				alert("请输入2位年级号!");
				return false;
			}
			if (classes_name == '') {
				alert('请输入班级名!');
				return false;
			} 
			if(type == 'true') {
				if(start != 'RB') {
					alert('专/本科与班级名不对应!');
					return false;
				}
			}
			
			if(type == 'false') {
				if(start != 'RZ') {
					alert('专/本科与班级名不对应!');
					return false;
				}
			}
			
			if(! nameClassReg.test(end)) {
				alert('班级名输入错误!');
				return false;
			}
			gra = end.substring(0, 2);
			if(gra != grade) {
				alert('班级与年级不对应!');
				return false;
			}
			
			for(var i = 0; i < classs.length; i = i + 2) {
				if(grade == classs[i] && classes_name == classs[i + 1]) {
					alert("该班级已存在!");
					return false;
				}
			}
		}
			
		function enter(claID, claName) {
			var url = "./${sessionScope.pathCode}/stuInfo.do?claID=" + claID + "&claName=" + claName;
			url = encodeURI(url);
			window.location.href = url;
		}
		
		
		function del(claID) {
			if (confirm('确认删除?')) {
				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/delClass.do",
					data: "claID=" + claID,
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
		<!-- start: PAGE HEADER -->
		<div class="row">
			<div class="col-sm-12">
				<!-- start: PAGE TITLE & BREADCRUMB -->
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i><a href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
					<li class="active">班级信息</li>
				</ol>
				<div class="page-header">
					<h3>班级信息</h3>
					<button data-target="#addClass" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 15px 2% 5px 5px;">添加班级</button>
				</div>
				<!-- end: PAGE TITLE & BREADCRUMB -->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<!-- start: TABLE WITH IMAGES PANEL -->
				<div class="panel-body">
					<div class="row"></div>
					<div class="panel-body">
						<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
							<thead>
								<tr>
									<th><small>序号</small></th>
									<th><small>年级</small></th>
									<th><small>类别</small></th>
									<th><small>班级名</small></th>
									<th><small>班级人数</small></th>
									<th><small>进入</small></th>
									<th><small>删除</small></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${classes}" var="classes" varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td><small>${classes.grade}级</small></td>
										<c:if test="${classes.type eq true }">
											<td><small>本科</small></td>
										</c:if>
										<c:if test="${classes.type eq false }">
											<td><small>专科</small></td>
										</c:if>
										<td><small>${classes.classes_name }</small></td>
										<td><small>${classes.cla_num }</small></td>
										<td>
											<c:if test="${classes.cla_num != 0}">
												<button type="button" class="btn btn-primary btn-sm" onclick="enter('${classes.id}', '${classes.classes_name}')">进入</button>
											</c:if>
										</td>
										<td>
											<c:if test="${classes.cla_num == 0}">
												<button type="button" class="btn btn-danger btn-sm" onclick="del('${classes.id}')">删除</button>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal 添加班级-->
		<div class="modal fade" id="addClass" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						<h4 class="modal-title" id="myModalLabel">添加班级</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" action="./${sessionScope.pathCode}/addClass.do" method="post" onsubmit="return checkClass(this);">

							<div class="form-group">
								<label for="type" class="col-sm-2 control-label">专/本</label>
								<div class="col-sm-10">
									<select class="form-control" id="type" name="type">
										<option value="请选择" >请选择</option>
										<option value="true" >本科</option>
										<option value="false" >专科</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label for="grade" class="col-sm-2 control-label">年级</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="grade" name="grade" placeholder="example: 15">
								</div>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">班级名</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="classes_name" name="classes_name" placeholder="example: RB卓越151">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="submit" class="btn btn-primary" style="float: right; margin: 5px 10% 5px 5px;">添加</button>
									<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right; margin: 5px 2% 5px 5px;">关闭</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- DataTables JavaScript -->
		<script src="assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script src="assets/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="assets/vendor/datatables-responsive/dataTables.responsive.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			$(document).ready(function() {
				$('#dataTables-example').DataTable({
					responsive: true
				});
			});
		</script>
	</body>

</html>