<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<html>

	<head>
		<title>软件学院实践课题管理系统</title>

		<!-- <script src="assets/js/ajaxfileupload.js" type="text/javascript"></script> -->

		<link rel="stylesheet" href="assets/plugins/select2/select2.css">
		<script type="text/javascript">
			function delClass(id) {
				alert('test');
				
				/* if (confirm('确认删除?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/*****.do",
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
				} */
			}

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

			
		</script>
	</head>

	<body>
		<!-- start: PAGE HEADER -->
		<div class="row">
			<div class="col-sm-12">
				<!-- start: PAGE TITLE & BREADCRUMB -->
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i> <a href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
					<li class="active">班级基本信息</li>
				</ol>
				<div class="page-header">
					<h3>班级信息</h3>
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
								<!-- <button data-target="#upload" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;">导入班级</button> -->
								<button data-target="#addClass" data-toggle="modal" type="button" class="btn btn-info" style="float: right; margin: 5px 10% 5px 5px;">添加班级</button>
							</tr>
							<tr>
								<th><small>年级</small></th>
								<th><small>班级</small></th>
								<th><small>删除</small></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${classs}" var="classs">
								<tr>
									<td><small>
									<c:if test="${classs.type eq true}">
										本科
									</c:if>
									<c:if test="${classs.type eq false}">
										专科
									</c:if>
									${classs.grade}级
									</small></td>
									<td><small>${classs.classes_name}</small></td>
									<td><small>
									<button type="button" class="btn btn-danger" onclick="delClass('${classs.id}')" >删除</button>
									</small></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- end: TABLE WITH IMAGES PANEL -->
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