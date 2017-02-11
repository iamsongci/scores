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

			function initTwo(ID) {
				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/getScore.do",
					data: "ID=" + ID,
					dataType: 'html',
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					success: function(result) {
						$("#text").html(result);
					},
					error: function(request) {
						alert("Connection error!");
					}
				});
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

				if(confirm('确认修改?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/upProName.do",
						data: "newProName=" + newProName + "&index=" + index,
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

		<c:if test="${message != null }">
		</c:if>
		<!-- start: PAGE HEADER -->
		<div class="row">
			<div class="col-sm-12">
				<!-- start: PAGE TITLE & BREADCRUMB -->
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
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
												<c:if test="${score.scores_status != 2}">
													<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#changeMyProName" onclick="initOne('${score.id}')">添加课题名称</button>
												</c:if>
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
											<button class="btn btn-warning" data-toggle="modal" data-target="#putReport" 
											        onclick="myScoresId(${score.id},${score.tea_id},${score.pro_id })">点击提交</button>
										</c:when>
										<c:when test="${score.report_status == 1}">
										<!-- <a href=".${score.address }"><button class="btn btn-info">已提交 </button></a>-->
										<form  method="post" action="./${sessionScope.pathCode}/download.do">
										    <input type="hidden" name="id" value="${score.id}"/>
										    <input type="submit"class="btn btn-info"value="已提交"/>
										</form> 
										</c:when>
										<c:when test="${score.report_status == 2}">
											<button class="btn btn-success">通过</button>
										</c:when>
										<c:otherwise>   
											<button class="btn btn-danger">未通过</button>
									 	</c:otherwise> 
									</c:choose>
								</small></td>

									<td><small>
									<c:if test="${score.scores_status == 2}">
										${score.total_score}
									</c:if>
								</small></td>
									<td><button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#morInfo" onclick="initTwo('${score.id}')">详细信息</button></td>
								</tr>
							</tbody>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- end: TABLE WITH IMAGES PANEL -->
		</div>

		<!-- changeMyProName -->
		<div class="modal fade" id="changeMyProName" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">修改课题名称</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="index" name="index"> 课题名称：
						<input type="text" maxlength="30" class="form-control" id="newProName" name="newProName">
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
		<div class="modal fade" id="morInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">详细信息</h4>
					</div>
					<div class="modal-body" id="text" name="text" style="word-break:break-all"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
		<!-- 模态框（Modal）end -->

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
			jQuery(document).ready(function() {
				FormElements.init();
			});
		</script>
		<!-- 获取scoreid -->
		<script type="text/javascript">
		  function myScoresId(id,tea_id,pro_id){
		     $("#score_id").val(id);
		      $("#tea_id").val(tea_id);
		      $("#pro_id").val(pro_id);
		      
		  }
		</script>
		<!-- 文件大小限制 -->
		<script type="text/javascript">
			var maxsize = 5 * 1024 * 1024; //2M  
			var errMsg = "上传的附件文件不能超过5M！！！";
			var tipMsg = "您的浏览器暂不支持计算上传文件的大小，确保上传文件不要超过4M，建议使用IE、FireFox、Chrome浏览器。";
			var browserCfg = {};
			var ua = window.navigator.userAgent;
			if(ua.indexOf("MSIE") >= 1) {
				browserCfg.ie = true;
			} else if(ua.indexOf("Firefox") >= 1) {
				browserCfg.firefox = true;
			} else if(ua.indexOf("Chrome") >= 1) {
				browserCfg.chrome = true;
			}

			function checkfile() {
				try {
					var obj_file = document.getElementById("file");
					if(obj_file.value == "") {
						alert("请先选择上传文件");
						return;
					}
					var filesize = 0;
					if(browserCfg.firefox || browserCfg.chrome) {
						filesize = obj_file.files[0].size;
					} else if(browserCfg.ie) {
						var obj_img = document.getElementById('tempimg');
						obj_img.dynsrc = obj_file.value;
						filesize = obj_img.fileSize;
					} else {
						alert(tipMsg);
						return;
					}
					if(filesize == -1) {
						alert(tipMsg);
						return;
					} else if(filesize > maxsize) {
						alert(errMsg);
						return;
					} else {
						$("#form1").submit();
					}
				} catch(e) {
					alert(e);
				}
			}
		</script>
		 <!-- 报告提交模态框-->
    <div class="modal fade" id="putReport" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >文件提交</h4>
				</div>
				<form id="form1" name="form1" method="post" enctype="multipart/form-data"
					action="./${sessionScope.pathCode}/doUpload.do">
					<div class="modal-body">
					<h5>注意：当报告合格并经过课题指导教师确认后方可提交</h5><h5>提交的文件大小不能超过<font color="#FF0000">5M</font>，可提交word文档与PDF文档</h5>
					<input type="hidden"name="score_id" id="score_id"/>
					<input type="hidden"name="tea_id" id="tea_id"/>
					<input type="hidden"name="pro_id" id="pro_id"/>
					<input type="file"name="file" id="file"
					       accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf"/>
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<button type="button" class="btn btn-default btn-primary"onclick="checkfile()">提交</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</body>

</html>