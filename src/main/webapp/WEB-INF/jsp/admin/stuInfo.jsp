<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<html>

	<head>
		<title>软件学院实践课题管理系统</title>

		<!-- <script src="assets/js/ajaxfileupload.js" type="text/javascript"></script> -->

		<link rel="stylesheet" href="assets/plugins/select2/select2.css">
		<script type="text/javascript">
			function checkStudent() {
				var noid = $('#noid').val();
				var name = $('#name').val();
				var claname = $('#classes option:selected').text();
				var claid = $('#classes option:selected').val();

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
				if(claname == '请选择') {
					alert('请选择班级!');
					return false;
				}

				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/addStudent.do",
					data: "noid=" + noid + "&name=" + name + "&claname=" + claname + "&claid=" + claid,
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

			function delStudent(id) {
				if(confirm('确认删除?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/delStudent.do",
						data: "id=" + id,
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

			function submitFile() {
				var file = $("#file").val();

				if(confirm('确认提交?')) {
					$.ajaxFileUpload({
						url: './${sessionScope.pathCode}/upLoadStu.do',
						secureuri: false, //安全传输
						fileElementId: 'file', //file标签的id  
						dataType: null, //返回数据的类型  
						success: function(result) //服务器成功响应处理函数
							{
								location.reload();
							},
						error: function(request) //服务器响应失败处理函数
							{
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
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">学生基本信息</li>
				</ol>
				<div class="page-header">
					<h3>学生信息</h3>
				</div>
				<!-- end: PAGE TITLE & BREADCRUMB -->
			</div>
		</div>

		<div class="modal fade" id="upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">导入学生基本信息</h4>
					</div>
					<div class="modal-body">
						<div style="padding: 10px 30px 10px 30px">
							<input type="file" id="file" name="file" accept="application/vnd.ms-excel">
						</div>
						<div style="padding: 10px 30px 10px 30px">
							<h4>
							<span class="label label-warning">Warning</span> 导入格式: 
						</h4>
							<img src="./img/type-stu.png" class="img-responsive" alt="Responsive image">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" onclick="submitFile()">提交</button>
					</div>
				</div>
			</div>
		</div>

		<!-- end: PAGE HEADER 頭部結束-->
		<div class="row">
			<div class="col-md-12">
				<div class="panel-body">
					<table class="table  table-hover">
						<thead>
							<tr>
								<!-- <button data-target="#download" data-toggle="modal" type="button"
								class="btn btn-info"
								style="float: right; margin: 5px 2% 5px 5px;">导出学生信息</button> -->
								<button data-target="#upload" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;">导入学生</button>
								<button data-target="#addStu" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 2% 5px 5px;">添加学生</button>
							</tr>
							<tr>
								<th><small>学号</small></th>
								<th><small>姓名</small></th>
								<th><small>性别</small></th>
								<th><small>班级</small></th>
								<th><small>手机号</small></th>
								<th><small>邮箱</small></th>
								<th><small>操作</small></th>
								<th><small>删除</small></th>

							</tr>
						</thead>
						<tbody>
							<c:forEach items="${students}" var="student">
								<tr>
									<td><small>${student.noid}</small></td>
									<td><small>${student.name}</small></td>
									<td><small>
									<c:if test="${student.sex eq true}">
										女
									</c:if>
									<c:if test="${student.sex eq false}">
										男
									</c:if>
									</small></td>
									<td><small>${student.cla_name }</small></td>
									<td><small>${student.phone}</small></td>
									<td><small>${student.email}</small></td>
									<td>
										<a href="./${sessionScope.pathCode}/resetStuPsw.do?ID=${student.id}"> 重置密码 </a>
									</td>
									<td>
										<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="delStudent('${student.id }')">删除</button>
									</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>

				</div>

			</div>
			<!-- end: TABLE WITH IMAGES PANEL -->
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
								<label for="classes" class="col-sm-2 control-label">班级</label>
								<div class="col-sm-10">
									<select class="form-control" id="classes" name="classes">
										<option value="请选择">请选择</option>
										<c:forEach items="${classes}" var="classs">
											<option value="${classs.id}">${classs.classes_name }</option>
										</c:forEach>
									</select>
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
		<div class="modal fade" id="pwdM" tabindex="-1" aria-labelledby="pwdT">
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
		</script>

	</body>

</html>