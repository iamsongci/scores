<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">

<script type="text/javascript">

	function init(index, name) {
		$('#index').val(index);
		$('#newProName').val(name);
	}
	
	function update() {
		var index = $('#index').val();
		var newProName = $('#newProName').val();
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/updatePorName.do",
				data : "newProName=" + newProName + "&index=" + index,
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

	<c:if test="${message != null }">
	</c:if>
	<!-- start: PAGE HEADER -->
	<div class="row">
		<div class="col-sm-12">
			<!-- start: PAGE TITLE & BREADCRUMB -->
			<ol class="breadcrumb">
				<li><i class="clip-home-3"></i> <a
					href="./${sessionScope.pathCode}/home.do"> 首页 </a></li>
				<li class="active">课题信息</li>
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
							<th><small>课题类型</small></th>
							<th><small>课题名称</small></th>
							<th><small>导师</small></th>
							<th><small>导师邮箱</small></th>
							<th><small>导师联系方式</small></th>
							<th><small>总分数</small></th>
							<th><small>操作</small></th>
						</tr>
					</thead>
					<c:forEach items="${projectAssignInfoList}" var="projectAssignInfo">
						<tbody>
							<tr>
								<td><small>${projectAssignInfo.projectName}</small></td>
								<td><small>${projectAssignInfo.trueName}</small></td>
								<td><small>${projectAssignInfo.tutorName}</small></td>
								<td><small>${projectAssignInfo.tutorEmail}</small></td>
								<td><small>${projectAssignInfo.tutorPhone }</small></td>
								<td><small>${projectAssignInfo.studentTotalScore }</small></td>
								<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#updateModal" onclick="init('${projectAssignInfo.index}', '${projectAssignInfo.trueName}')" >修改我的课题名称</button></td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
				<div class="form-group">
					<label class="col-sm-8 "> </label>
					<div class="col-sm-4" style="text-align: right; height: 40px">
						<page:createPager pageSize="${pageSize}" totalPage="${totalPage}"
							totalCount="${totalCount}" curPage="${pageNum}"
							formId="condition" />
					</div>
				</div>

			</div>

		</div>
		<!-- end: TABLE WITH IMAGES PANEL -->
	</div>

	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">修改信息</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="index" name="index">
					课题名称：<input type="text" class="form-control" id="newProName" name="newProName">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="update()">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal）end -->

	<script
		src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
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
