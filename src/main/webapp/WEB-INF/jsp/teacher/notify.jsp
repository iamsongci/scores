<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>软件学院实践课题管理系统</title>

<script type="text/javascript">
	function init(title, content) {
		document.getElementById("title").innerHTML = "标题: " + title;
		document.getElementById("content").innerHTML = content;
	}

	function create() {
		var title = $('#newtitle').val();
		var content = $('#newcontent').val();
		var choice = document.getElementById("newtoStudent");
		var toStudent = false;
		if (choice.checked == true)
			toStudent = true;
		if (choice.checked == false)
			toStudent = false;
		if (title.trim() == "") {
			alert("标题不能为空!");
			return;
		}
		if (content.trim() == "") {
			alert("内容不能为空!");
			return;
		}
		if (confirm('确认创建通知?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/create.do",
				data : "title=" + title + "&content=" + content
						+ "&toStudent=" + toStudent,
				dataType : 'html',
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(result) {
					location.reload();
				},
				error : function(request) {
					alert("删除失败!");
				}
			});
		}
	}

	function delnotify(ID) {
		if (confirm('确认要删除通知?')) {
			$.ajax({
				type : "post",
				url : "./${sessionScope.pathCode}/delNotify.do",
				data : "ID=" + ID,
				dataType : 'html',
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(result) {
					location.reload();
				},
				error : function(request) {
					alert("删除失败!");
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
                    href="./${sessionScope.pathCode}/home.do"> 首页 </a>
            </li>
            <li class="active">通知管理</li>
			</ol>
			<div class="page-header">
				<h2>通知管理</h2>
			</div>
			<!-- end: PAGE TITLE & BREADCRUMB -->
		</div>
	</div>
	<!-- end: PAGE HEADER -->
	<div class="row">
		<div class="col-md-12">
			<div class="panel-body">

				<table class="table  table-hover">
					<tr>
						<button data-target="#create" data-toggle="modal" type="button"
							class="btn btn-info"
							style="float: right; margin: 5px 10% 5px 5px;">创建新通知</button>
					</tr>
					<thead>
						<tr>
							<th><small>标题</small></th>
							<th><small>发布人</small></th>
							<th><small>发布时间</small></th>
							<th><small>是否发送给学生</small></th>
							<th><small>删除</small></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${notifies}" var="notify">
							<tr>
								<td>
									<div class="visible-md visible-lg hidden-sm hidden-xs">
										<a data-target="#more" data-toggle="modal"
											onclick="init('${notify.title}', '${notify.content}')"> <small>${notify.title}</small>
										</a>
									</div>
								</td>
								<td>
									<c:choose>
										<c:when test="${notify.owner_name == 'super'}">
											<span class="label label-primary">系统</span>
										</c:when>
										
										<c:otherwise>
											<span class="label label-primary">${notify.owner_name}</span>
										</c:otherwise>
									</c:choose>
									
								
								</td>
								<td><small>${notify.time}</small></td>
								<td>
									<small>
										<c:if test="${notify.owner_id == user.id}">
											<c:choose>
												<c:when test="${notify.toStudent == true}">
													<span class="label label-danger">是</span>
												</c:when>
												
												<c:when test="${notify.toStudent == false}">
													<span class="label label-warning">否</span>
												</c:when>
											</c:choose>
										</c:if>
									</small>
								</td>
								<td>
									<c:if test="${notify.owner_id == user.id}">
										<button type="button" class="btn btn-danger" onclick="delnotify('${notify.id}')">删除</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
		<!-- end: GENERAL PANEL -->
	</div>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="create" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">创建新通知</h4>
				</div>
				<div class="modal-body">
					<div style="padding: 10px 50px 10px 30px">
						<input type="text" maxlength="30" id="newtitle" name="newtitle" placeholder="标题">
					</div>
					<div style="padding: 10px 30px 10px 30px">
						<textarea id="newcontent" name="newcontent" class="form-control"
							rows="5" placeholder="内容""></textarea>
					</div>
					<div style="padding: 10px 45px 0px 30px">
						<label style="float: right;"><input type="checkbox"
							id="newtoStudent" name="newtoStudent">是否发送给学生</label>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="create()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	<!-- 模态框（Modal）end -->


	<!-- 模态框（Modal） -->
	<div class="modal fade" id="more" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="title" name="title"></h4>
				</div>
				<div class="modal-body">
					<div id="content" name="content" style="word-break:break-all"></div>
				</div>
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