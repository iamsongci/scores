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
				<h2>通知</h2>
			</div>
			<!-- end: PAGE TITLE & BREADCRUMB -->
		</div>
	</div>
	<!-- end: PAGE HEADER -->
	<div class="row">
	                    <div class="col-md-12">
                        <h4>学生端使用说明</h4>
                        <h5>具体操作流程如下：</h5>

                        <p>一、在登录系统后请先对学生联系方式进行添加，方便导师联系</p>

                        <p>二、导师的信息通知将会在首页显示，请及时查看。</p>

                        <p>三、可在课题信息中查看当前课题的指导教师与成绩；</p>

                        <p>四、请及时完成导师的任务，最终报告模板将会在报告模板中显示</p>

                       
                    </div>
		<div class="col-md-12">
			<div class="panel-body">

				<table class="table  table-hover">
					
					<thead>
						<tr>
							<th width="60%"><small>标题</small></th>
							<th><small>发布人</small></th>
							<th><small>发布时间</small></th>
						</tr>
					</thead>
					<c:forEach items="${notifyList}" var="notify">
						<tbody>
							<tr>
								<td>
									<div class="visible-md visible-lg hidden-sm hidden-xs">
										<a data-target="#more" data-toggle="modal"
											onclick="init('${notify.title}', '${notify.content}')"> 
											<small>${notify.title}</small>
										</a>
									</div>
								</td>

								<td>
									<c:if test="${notify.owner == 'zzti'}"><small><button type="button" class="btn btn-primary">系统</button></small></c:if>
									<c:if test="${notify.owner == '机房'}"><small><button type="button" class="btn btn-success">${notify.owner}</button></small></c:if>
									<c:if test="${notify.owner != '机房' and notify.owner != 'zzti'}"><small><button type="button" class="btn btn-info">${notify.owner}</button></small></c:if>
								</td>
								<td><small>${notify.time}</small></td>

								
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
