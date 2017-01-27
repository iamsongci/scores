<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>软件学院实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">
<script type="text/javascript">
     function requestUrl(name,id,pathCode) {
		var url="./"+pathCode+"/assign.do?tutorName="+name+"&&tutorID="+id;
		url=encodeURI(url);
		url=encodeURI(url); 
		window.location.href = url;
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
				<li class="active">导师机房分配</li>
			</ol>
			<!-- end: PAGE TITLE & BREADCRUMB -->
			</ol>
			<!-- end: PAGE TITLE & BREADCRUMB -->
			<div class="page-header">
				<h2>导师列表</h2>
			</div>
		</div>
	</div>
	<!-- end: PAGE HEADER 頭部結束-->
	<c:if test="${message == '1'}">
		<div class="alert alert-success">
			<a href="#" class="close" data-dismiss="alert"> &times; </a> <strong>成功！</strong>信息保存成功
		</div>
	</c:if>
	<div class="row">
		<div class="col-md-12">
			<div class="panel-body">
				<table class="table  table-hover">
					<thead>
						<tr>
							<th><small>工号</small></th>
							<th><small>姓名</small></th>
							<th><small>性别</small></th>
							<th><small>所带学生人数</small></th>
							<th><small>操作</small></th>
						</tr>
					</thead>
					<c:forEach items="${assignInfo}" var="info">
						<tbody>
							<tr>
								<td><small>${info.tutorID}</small></td>
								<td><small>${info.tutorName}</small></td>
							<c:choose>
                            <c:when test="${info.tutorSex eq false}">
                                <td>
                                    <small>男</small>
                                </td>
                            </c:when>
                            <c:when test="${info.tutorSex eq true}">
                                <td>
                                    <small>女</small>
                                </td>
                            </c:when>
                        </c:choose>
								<td><small>${info.number }</small></td>
								
								<td>
									<div class="visible-md visible-lg hidden-sm hidden-xs">
										<a onclick="requestUrl('${info.tutorName}','${info.tutorID}','${sessionScope.pathCode}')" >
											<i class="fa fa-info-circle"></i> <small>分配</small>
										</a> 
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
		<!-- end: TABLE WITH IMAGES PANEL -->
	</div>
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
