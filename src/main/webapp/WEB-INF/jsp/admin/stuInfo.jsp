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
			function checkStudent() {
				var noid = $('#noid').val();
				var name = $('#name').val();
				var claName = '${claName}';
				var claID = '${claID}';

				var students = '${students}';
				var len = students.length;
				students = students.substring(1, len - 1)
				var student = students.split(', ');

				if(noid.length != 12) {
					alert('学号长度错误!');
					return false;
				}

				for(var i = 0; i < student.length; i++) {
					if(student[i] == noid) {
						alert('学号已存在!');
						return false;
					}
				}
				if(name == '') {
					alert('请输入姓名!');
					return false;
				}

				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/claInfo/stuInfo/addStudent.do",
					data: "noid=" + noid + "&name=" + name + "&claName=" + claName + "&claID=" + claID + "&message=",
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
			
			function resetPsw(stuID) {
				var claID = '${claID}';
				var claName = '${claName}';
				if(confirm('确认重置?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/claInfo/stuInfo/resetStuPsw.do",
						data: "stuID=" + stuID + "&claID=" +　claID + "&claName=" +　claName + "&message=",
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
			

			function delStudent(stuID) {
				var claID = '${claID}';
				var claName = '${claName}';
				if(confirm('确认删除?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/claInfo/stuInfo/delStudent.do",
						data: "stuID=" + stuID + "&claID=" +　claID + "&claName=" +　claName + "&message=",
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
			
			function checkFile(form) {
				var file = form.stuInfo.value;
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
					<li>
						<i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">
						<a href="./${sessionScope.pathCode}/claInfo.do?">班级信息</a>
					</li>
					<li class="active">${claName}班 学生信息</li>
				</ol>
				<div class="page-header">
					<h3>${claName}班 学生信息</h3>
					<button data-target="#upload" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 15px 2% 5px 5px;">导入学生</button>
					<button data-target="#addStu" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 15px 2% 5px 5px;">添加学生</button>
				</div>
				<!-- end: PAGE TITLE & BREADCRUMB -->
			</div>
		</div>
		
		<div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">导入学生</h4>
					</div>
					<form action="./${sessionScope.pathCode}/claInfo/stuInfo/upLoadStu.do" method="post" enctype="multipart/form-data">
						<div class="modal-body">
							<input type="hidden" name="claName" value="${claName}">
							<input type="hidden" name="claID" value="${claID}">
							
							<div style="padding: 10px 30px 10px 30px">
								<input type="file" id="stuInfo" name="stuInfo">
							</div>

							<div style="padding: 10px 30px 10px 30px">
								<h5>
									<span class="label label-warning">Warning</span> 导入格式: 
								</h5>
								<p>请导入: Microsoft Excel 97-2003 工作表 (.xls)</p>
								<p><font color="red">注意: 导入学生的班级为当前班级!</font></p>
								
								<img src="./img/type-stu.png" class="img-responsive" alt="Responsive image">
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
										<th><small>序号</small></th>
										<th><small>学号</small></th>
										<th><small>姓名</small></th>
										<th><small>性别</small></th>
										<th><small>联系方式</small></th>
										<th><small>重置密码</small></th>
										<th><small>删除</small></th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${students}" var="student" varStatus="status">
										<tr>
											<td>${status.index + 1}</td>
											<td><small>${student.noid}</small></td>
											<td><small>${student.name }</small></td>
											<c:if test="${student.sex eq true }">
												<td><small>女</small></td>
											</c:if>
											<c:if test="${student.sex eq false }">
												<td><small>男</small></td>
											</c:if>
											<td><small>${student.phone }</small></td>
											<td>
												<button type="button" class="btn btn-info btn-sm" data-dismiss="modal" onclick="resetPsw('${student.id }')">重置密码</button>
											</td>
											<td>
												<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" onclick="delStudent('${student.id }')">删除</button>
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



		<!-- Modal 添加学生-->
		<div class="modal fade" id="addStu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						<h4 class="modal-title" id="myModalLabel">添加学生</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" onsubmit="return false">
							<div class="form-group">
								<label for="noid" class="col-sm-2 control-label">学号</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="noid" name="noid" placeholder="example: 201560140428">
								</div>
							</div>
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">姓名</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="name" name="name" placeholder="example: 张三">
								</div>
							</div>
							
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">班级</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="claName" name="claName" disabled="disabled" value="${claName}">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="button" class="btn btn-primary" style="float: right; margin: 5px 10% 5px 5px;" onclick="checkStudent()">添加</button>
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