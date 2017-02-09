<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

	<head>
		<title>实践课题管理系统</title>
		<!-- DataTables CSS -->
		<link href="assets/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

		<!-- DataTables Responsive CSS -->
		<link href="assets/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
		<!-- Custom CSS -->
		<link href="assets/vendor/dist/css/sb-admin-2.css" rel="stylesheet">

		<!-- Custom Fonts -->
		<link href="assets/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<!-- 成绩修改 -->
        <script type="text/javascript">
	function updateScore(id,u,p,r) {
	    $("#score_id").val(id);  
		$("#usual_score").val(u);  
		$("#pro_score").val(p); 
		$("#report_score").val(r); 
		count();
	}
	function count(){
	var u=$("#usual_score").val();
	var p=$("#pro_score").val();
	var r=$("#report_score").val();
	if (isNaN(u)||isNaN(p)||isNaN(r)) {
			alert("请输入0~100之间的数值哦！");
			return;
		}else{
		    if(u>=0&&u<=100&&p>=0&&p<=100&&r>=0&&r<=100){
		         var t=u*0.3+p*0.3+r*0.4;
		         t=Math.round(t);
		         $("#total_score").val(t);
		         
		    }else{
		      alert("成绩范围在0~100之间哦！");
		      return;
		    }
		}
	}
	function check(){
	var u=$("#usual_score").val();
	var p=$("#pro_score").val();
	var r=$("#report_score").val();
	if (isNaN(u)||isNaN(p)||isNaN(r)) {
			alert("请输入0~100之间的数值哦 ，不然无法提交.");
			return;
		}else{
		    if(u>=0&&u<=100&&p>=0&&p<=100&&r>=0&&r<=100){
		         $("#form1").submit();
		    }else{
		      alert("成绩范围在0~100之间哦！请认真检查.");
		      return;
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
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">
						<a href="./${sessionScope.pathCode}/myPower.do"> 我的实践课题 </a>
					</li>
					<li class="active">
						<a href="./${sessionScope.pathCode}/proClasses.do?projectId=${proId}"> 班级列表 </a>
					</li>
					<li class="active">学生信息</li>
				</ol>
				<div class="page-header">
					<h3>学生信息列表</h3>
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
						<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
							<thead>
								<tr>
									<th>
										<small>序号</small>
									</th>
									<th><small>学号</small></th>
									<th>
										<small>姓名</small>
									</th>
									<th>
										<small>性别</small>
									</th>
									<th>
										<small>指导教师</small>
									</th>
									<th>
										<small>成绩</small>
									</th>
									<th>
										<small>操作</small>
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${listAll}" var="li" varStatus="status">
									<tr>
										<td>${ status.index + 1}</td>
										<td>
											<small>${li.noid}</small>
										</td>
										<td>
											<small>${li.name}</small>
										</td>
										<c:if test="${li.sex eq true }">
											<td>
												<small>女</small>
											</td>
										</c:if>
										<c:if test="${li.sex  eq false }">
											<td>
												<small>男</small>
											</td>
										</c:if>
										<td>
										      <c:forEach items="${list}" var="stu" >
										       <c:if test="${ stu.id eq li.id}">
										        <small>${stu.tea_name}</small>
										       </c:if></c:forEach>
										</td>
										<td>
										      <c:forEach items="${list}" var="stu" >
										       <c:if test="${ stu.id eq li.id}">
										       <c:if test="${stu.scores_status ne 2}">
														<span class="label label-warning">无</span>
													</c:if>
													<c:if test="${ stu.scores_status eq 2}">
													      <c:if test="${stu.total_score < 60 }">
													           <span class="label label-danger">${stu.total_score}</span>
													      </c:if>
													       <c:if test="${stu.total_score >=60 }">
													           <span class="label label-success">${stu.total_score}</span>
													      </c:if>
														
													</c:if>
										       </c:if></c:forEach>
										</td>
										<td>
										      <c:forEach items="${list}" var="stu" >
										       <c:if test="${ stu.id eq li.id}">
										       <c:if test="${ stu.scores_status eq 2}">
														 <small><button class="btn btn-primary" data-toggle="modal" data-target="#scoreInfo" onclick="updateScore(${stu.score_id},${stu.usual_score},${stu.project_score },${stu.report_score })">修改</button></small>
												</c:if>
										       </c:if></c:forEach>
										</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!-- DataTables JavaScript -->
		<script src="assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script src="assets/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="assets/vendor/datatables-responsive/dataTables.responsive.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			$(document).ready(function() {
				$('#dataTables-example').DataTable({
					responsive: true
				});
			});
		</script>
		
		<!-- 弹出框 -->
	<div class="modal fade" id="scoreInfo" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="alterModalLabel">成绩信息</h4>
				</div>
				<form id="form1" name="form1" method="post"
					action="./${sessionScope.pathCode}/updateStuScore.do">
					<div class="modal-body">
					       <input type="hidden" name="score_id" id="score_id"/>
					       <input type="hidden" name="claId" id="claId" value="${claId }"/>
					       <input type="hidden" name="proId" id="proId" value="${proId }"/>
						平时成绩：<input 
						    type="text" maxlength='3' class="form-control" id="usual_score" name="usual_score" ONBLUR="count()"/></br> 
						项目验收成绩：<input 
						    type="text" maxlength='3' class="form-control" id="pro_score" name="pro_score" ONBLUR="count()"/></br> 
						报告成绩：<input
							type="text" maxlength='3' class="form-control" id="report_score" name="report_score"ONBLUR="count()"/></br>
						总成绩：<input
							type="text" maxlength='3' class="form-control" id="total_score" readonly="readonly" />
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<button type="button" class="btn btn-default btn-primary"
							onclick="check()">确认修改</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</body>

</html>