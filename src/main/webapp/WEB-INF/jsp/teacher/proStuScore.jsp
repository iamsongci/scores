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
<script>  
function exportExcel(num){  
     location.href="./${sessionScope.pathCode}/exportProStuScore.do?claId="+${claId}+"&proId="+${proId}+"&num="+num;  
     <!--这里不能用ajax请求，ajax请求无法弹出下载保存对话框-->  
 }  
 function sumbitScore(){
  alert("提交");
    $("#form3").submit();
 }
       function excel_button() {  
        var excel_file = $("#excel_file").val();  
        if (excel_file == "" || excel_file.length == 0) {  
            alert("请选择文件路径！");  
            return false;  
        } else {  
         alert("提交");  
             $("#form3").submit();
        }  
    };  
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
				<div style="position: absolute;right:120px;top:65px"> 
        <button class="btn btn-primary" data-toggle="modal" data-target="#importScore">导入</button></div>
				 <div style="position: absolute;right:45px;top:65px"> 
        <button class=" btn btn-info" onclick="exportExcel(1)" >导出</button></div>
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
								<c:forEach items="${list}" var="li" varStatus="status">
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
										        <small>${li.tea_name}</small>
										</td>
										<td>
										       <c:if test="${li.scores_status ne 2}">
														<span class="label label-warning">无</span>
													</c:if>
													<c:if test="${ li.scores_status eq 2}">
													      <c:if test="${li.total_score < 60 }">
													           <span class="label label-danger">${li.total_score}</span>
													      </c:if>
													       <c:if test="${li.total_score >=60 }">
													           <span class="label label-success">${li.total_score}</span>
													      </c:if>
														
													</c:if>
										</td>
										<td>
										       <c:if test="${ li.scores_status eq 2}">
														 <small><button class="btn btn-primary" data-toggle="modal" data-target="#scoreInfo" onclick="updateScore(${li.score_id},${li.usual_score},${li.project_score },${li.report_score })">修改</button></small>
												</c:if>
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
					       <input type="hidden" name="scores_status" id="scores_status" value="2" />
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
	
	<!-- 文件上传提示框 -->
	<div class="modal fade" id="importScore" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="alterModalLabel">学生成绩导入</h4>
				</div>
				<form id="form3" name="form3" method="post" enctype="multipart/form-data"
					action="./${sessionScope.pathCode}/importProStuScore.do">
					<div class="modal-body">
					     <h5> <p> 请在上传之前点击<font color="red">下载上传模板</font>，</p><p>我们会将没有成绩的学生(已分配导师)信息罗列出来，您只需填写学生最终成绩即可</p>
					       <p>请成绩录入完毕后保存Excel表格，点击下方【选择文件】，后点击【提交成绩】即可  </p> 
					      </h5>
					       <input type="hidden" name="claId" id="claId" value="${claId }"/>
					       <input type="hidden" name="proId" id="proId" value="${proId }"/>
					       <input type="file" name="file" id="excel_file";
					       accept="application/vnd.ms-excel" />
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<button type="button" class="btn btn-default btn-primary"
							onclick="exportExcel(0)">下载模板</button>
							 <button type="button" class="btn btn-default btn-info"onclick="excel_button()"
							>提交成绩</button> 
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</body>

</html>