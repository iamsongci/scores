<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

	<head>
		<title>实践课题管理系统</title>
		
		<script type="text/javascript">
			function enter(teaID, teaName) {
				var url = "./${sessionScope.pathCode}/roomList.do?teaID=" + teaID + "&teaName=" + teaName;
				url = encodeURI(url);
				window.location.href = url;
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
					<li class="active">
						<a href="./${sessionScope.pathCode}/distribute.do"> 机房分配管理 </a>
					</li>
					<li class="active">选择分配教师</li>
				</ol>
				<div class="page-header">
					<h3>教师列表</h3>
				</div>
				<!-- end: PAGE TITLE & BREADCRUMB -->
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<!-- start: TABLE WITH IMAGES PANEL -->
				<div class="panel-body">
					<div class="row"></div>
					<div class="panel-body">
						<table class="table table-hover">
							<thead>
								<tr>
									<th><small>姓名</small></th>
									<th><small>联系方式</small></th>
									<th><small>所带学生人数</small></th>
									<th><small>操作</small></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${teachers}" var="teacher">
									<tr>
										<td><small>${teacher.name}</small></td>
										<td><small>${teacher.phone}</small></td>
										<td><small>${teacher.num}</small></td>
										<td>
											<button type="button" class="btn btn-info" onclick="enter('${teacher.id}', '${teacher.name }')">分配</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</body>

</html>