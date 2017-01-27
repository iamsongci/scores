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
		//向模态框中传值  
		document.getElementById("title").innerHTML = "标题: " + title;
		document.getElementById("content").innerHTML = content;
	}

	function subm() {
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
				url : "./${sessionScope.pathCode}/createNotify.do",
				data : "title=" + title + "&content=" + content
						+ "&toStudent=" + toStudent,
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

	function requestUrl(notifyID) {
		if (confirm('确认要删除通知?')) {
			$
					.ajax({
						type : "post",
						url : "./${sessionScope.pathCode}/deleteNotify.do",
						data : "notifyID=" + notifyID,
						dataType : 'html',
						contentType : "application/x-www-form-urlencoded; charset=utf-8",
						success : function(result) {
							location.reload();
						},
						error : function(request) {
							alert("Connection error!");
						}
					});
			alert('已删除');
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
					<c:forEach items="${notifyList}" var="notify">
						<tbody>
							<tr>
								<td>
									<div class="visible-md visible-lg hidden-sm hidden-xs">
										<a data-target="#more" data-toggle="modal"
											onclick="init('${notify.title}', '${notify.content}')"> <small>${notify.title}</small>
										</a>
									</div>
								</td>
								<td>
									<c:if test="${notify.owner == 'zzti'}">
										<small><button type="button" class="btn btn-primary">系统</button></small>
									</c:if> 
									<c:if test="${notify.owner == '机房'}">
										<small><button type="button" class="btn btn-success">${notify.owner}</button></small>
									</c:if> <c:if
										test="${notify.owner != '机房' and notify.owner != 'zzti'}">
										<small><button type="button" class="btn btn-info">${notify.owner}</button></small>
									</c:if>
								</td>
								<td><small>${notify.time}</small></td>
								<td><small> 
								<c:if test="${notify.owner == user.tutorName}">
									<c:if
										test="${notify.toStudent eq false}">否
									</c:if> 
									<c:if
										test="${notify.toStudent eq true}">是
									</c:if>
								</c:if>
								</small></td>
								
								<td>
									<div class="visible-md visible-lg hidden-sm hidden-xs">
										<c:if test="${notify.owner == user.tutorName}">
											<a onclick="requestUrl('${notify.notifyID}')"> <i
												class="fa fa-info-circle"></i> <small>删除</small>
											</a>
										</c:if>

									</div>
								</td>

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
						<input type="text" id="newtitle" name="newtitle" placeholder="标题">
						<!-- <input type="text" id="newtime" name="newtime"
							style="float: right;" placeholder="时间。例:2016-1-12"> -->
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
					<button type="button" class="btn btn-primary" onclick="subm()">提交</button>
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
					<div id="content" name="content"></div>
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
