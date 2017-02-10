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
			function checkTeacher() {
				var noid = $('#noid').val();
				var name = $('#name').val();
				var type = $('#teatype option:selected').val();

				var teachers = '${teachers}';
				var len = teachers.length;
				teachers = teachers.substring(1, len - 1)
				var teacher = teachers.split(', ');

				if(isNaN(noid)) {
					alert('工号只能为数字!');
					return;
				}

				if(noid.length != 4) {
					alert('工号长度错误!');
					return false;
				}

				if(name == '') {
					alert('请输入姓名!');
					return false;
				}

				if(type == '请选择') {
					alert('请选择教师类型!');
					return false;
				}

				for(var i = 0; i < teacher.length; i++) {
					if(teacher[i] == noid) {
						alert('工号已存在!');
						return false;
					}
				}

				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/addTeacher.do",
					data: "noid=" + noid + "&name=" + name + "&type=" + type + "&message=",
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

			function delTeacher(id) {
				if(confirm('确认删除?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/delTeacher.do",
						data: "id=" + id + "&message=",
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

			function resetPsw(teaID) {
				if(confirm('确认重置?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/resetTeaPsw.do",
						data: "ID=" + teaID + "&message=",
						dataType: 'html',
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						success: function(result) {
							$('#resetPsw').modal('show')
						},
						error: function(request) {
							alert("Connection error!");
						}
					});
				}
			}

			function checkFile(form) {
				var file = form.teaInfo.value;
				if(file == '') {
					alert('请选择文件!');
					return false;
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
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">导师基本信息</li>
				</ol>
				<div class="page-header">
					<h3>导师信息</h3>
					<button data-target="#upload" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;">导入导师</button>
					<button data-target="#addTea" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 2% 5px 5px;">添加导师</button>
				</div>
			</div>
		</div>

		<div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">导入导师</h4>
					</div>
					<form action="./${sessionScope.pathCode}/upLoadTea.do" method="post" enctype="multipart/form-data">
						<div class="modal-body">
							<div style="padding: 10px 30px 10px 30px">
								<input type="file" id="teaInfo" name="teaInfo">
							</div>

							<div style="padding: 10px 30px 10px 30px">
								<h5>
									<span class="label label-warning">Warning</span> 导入格式: 
								</h5>
								<p>请导入: Microsoft Excel 97-2003 工作表 (.xls)</p>
								<img src="./img/type-tea.png" class="img-responsive" alt="Responsive image">
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" style="float:right; margin-left: 25px ;" onclick="return checkFile(this.form)">提交</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<!-- start: TABLE WITH IMAGES PANEL -->
				<form name="add" action="./${sessionScope.pathCode}/addTeaWithStu.do" method="post">
					<input type="hidden" name="classId" value="${classId}">
					<div class="panel-body">
						<div class="row"></div>
						<div class="panel-body">
							<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<h5><font color="red">${message}</font></h5>
									</tr>
									<tr>
										<th><small>角色</small></th>
										<th><small>工号</small></th>
										<th><small>姓名</small></th>
										<th><small>性别</small></th>
										<th><small>手机号</small></th>
										<th><small>邮箱</small></th>
										<th><small>操作</small></th>
										<th><small>删除</small></th>

									</tr>
								</thead>
								<tbody>
									<c:forEach items="${teachers}" var="teacher">
										<tr>
											<td><small>
										<c:choose>
											<c:when test="${teacher.role == 'tea'}">
												<span class="label label-primary">导师</span>
											</c:when>
											<c:when test="${teacher.role == 'room'}">
												<span class="label label-warning">机房管理员</span>
											</c:when>
											<c:when test="${teacher.role == 'edu'}">
												<span class="label label-danger">教育</span>
											</c:when>
										</c:choose>
									</small></td>
											<td><small>${teacher.noid}</small></td>
											<td><small>${teacher.name}</small></td>
											<td><small>
									<c:if test="${teacher.sex eq true}">
										女
									</c:if>
									<c:if test="${teacher.sex eq false}">
										男
									</c:if>
									</small></td>
											<td><small>${teacher.phone}</small></td>
											<td><small>${teacher.email}</small></td>

											<td>
												<button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="resetPsw('${teacher.id }')">重置密码</button>
											</td>
											<td>
												<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="delTeacher('${teacher.id }')">删除</button>
											</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- Modal 添加导师-->
		<div class="modal fade" id="addTea" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">添加导师</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" onsubmit="return false">
							<div class="form-group">
								<label for="noid" class="col-sm-2 control-label">工号</label>
								<div class="col-sm-10">
									<input type="text" maxlength="4" class="form-control" id="noid" name="noid" placeholder="example: 6688">
								</div>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">姓名</label>
								<div class="col-sm-10">
									<input type="text" maxlength="10" class="form-control" id="name" name="name" placeholder="example: 张三">
								</div>
							</div>

							<div class="form-group">
								<label for="teatype" class="col-sm-2 control-label">类型</label>
								<div class="col-sm-10">
									<select class="form-control" id="teatype" name="teatype">
										<option value="请选择">请选择</option>
										<option value="tea">导师</option>
										<option value="room">机房管理员</option>
										<option value="edu">教育</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="button" class="btn btn-primary" style="float: right; margin: 5px 10% 5px 5px;" onclick="checkTeacher()">添加</button>
									<button type="button" class="btn btn-default" data-dismiss="modal" style="float: right; margin: 5px 2% 5px 5px;">关闭</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal    重置密码提示 -->
		<div class="modal fade" id="resetPsw" tabindex="-1" aria-labelledby="pwdT">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
						<h4 class="modal-title" id="pwdT">重置密码</h4>
					</div>
					<div class="modal-body">
						密码已重置为:123456<br />
						<p></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
		<script>
			$("#selectAll").click(function() {  
				$("input[name='stu_id']").each(function() {
					$(this).attr("checked", !this.checked);
				});                   
			});
		</script>
	</body>

</html>