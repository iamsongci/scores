<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">

<script type="text/javascript">

	function initOne(id) {
		$("#morInfo").modal("hide");

		$('#index').val(id);
	}
	
	function initTwo(str, id) {
		
		var begin = '<dl class="dl-horizontal">';
		var end = '</dl>';
		var ch = str.split(', ');
		var code = '';
		for(var i = 0; i < ch.length; i++) {
			var temp = ch[i].split('=');
			if(temp[1] == "" || temp[1] == 'null' || temp[1] == null)
				temp[1] = '[暂无]';
			if(i == 1)
				code = code + '<dt>' + temp[0] + '</dt>' + '<dd>' + temp[1] + '<button type="button" style="margin-left:20%" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#changeMyProName" onclick="initOne(' + id + ')" >修改我的课题名称</button>' + '</dd>';
			else
				code = code + '<dt>' + temp[0] + '</dt>' + '<dd>' + temp[1] + '</dd>';
		}
		code = begin + code + end;
		$("#text").html(code);
		
	}
	
	function update() {
		var index = $('#index').val();
		var newProName = $('#newProName').val();
		if(newProName == '' || newProName == null) {
			alert("课题名不能为空!");
			return;
		}
		if(newProName.length > 30) {
			alert("课题名称过长!");
			return;
		}
		
		if (confirm('确认修改?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/upProName.do",
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
							<th><small>类型</small></th>
							<th><small>名称</small></th>
							<th><small>导师</small></th>
							<th><small>联系</small></th>
							<th><small>邮箱</small></th>
							<th><small>报告</small></th>
							<th><small>分数</small></th>
							<th><small>详细</small></th>
						</tr>
					</thead>
					<c:forEach items="${scores}" var="score">
						<tbody>
							<tr>
								<td><small>${score.pro_name}</small></td>
								
								<td>
								
									<c:choose> 
									  <c:when test="${empty score.my_pro_name}">   
									    <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#changeMyProName" onclick="initOne('${score.id}')" >修改我的课题名称</button>
									  </c:when>
									  <c:otherwise>   
										${score.my_pro_name}
									  </c:otherwise> 
									</c:choose> 
									
								</td>
								<td><small>${score.tea_name}</small></td>
								<td><small>${score.tea_phone}</small></td>
								<td><small>${score.tea_email}</small></td>
								<td><small>
									<c:choose>
										<c:when test="${score.report_status == 0}">
											未提交
										</c:when>
										<c:when test="${score.report_status == 1}">
											已提交
										</c:when>
										<c:when test="${score.report_status == 2}">
											通过
										</c:when>
										<c:otherwise>   
											未通过
									 	 </c:otherwise> 
									</c:choose>
								</small></td>
								
								<td><small>${score.total_score}</small></td>
								<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#morInfo" onclick="initTwo('${score}', '${score.id}')" >详细信息</button></td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- end: TABLE WITH IMAGES PANEL -->
	</div>


	<!-- changeMyProName -->
	<div class="modal fade" id="changeMyProName" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">修改课题名称</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="index" name="index">
					课题名称：<input type="text" maxlength="30" class="form-control" id="newProName" name="newProName">
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

	<!-- moreInfo -->
	<div class="modal fade" id="morInfo" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">详细信息</h4>
				</div>
				<div class="modal-body" id="text" name="text"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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
