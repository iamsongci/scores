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
	function Score(id,u,p,r) {
	    $("#score_id").val(id);  
		$("#usual_score").val(u);  
		$("#pro_score").val(p); 
		$("#report_score").val(r); 
		count();
	}
	function addScore(id){
	   $("#scoreId").val(id); 
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
		    var a=-1;
		    $("#claId").val(a);
		    $("#proId").val(a);
		    $("#form2").submit();
		    }else{
		      alert("成绩范围在0~100之间哦！请认真检查.");
		      return;
		    }
		}
	}
	function save(){
	var u=$("#usual").val();
	var p=$("#pro").val();
	var r=$("#report").val();
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
	function add(){
	var u=$("#usual").val();
	var p=$("#pro").val();
	var r=$("#report").val();
	if (isNaN(u)||isNaN(p)||isNaN(r)) {
			alert("请输入0~100之间的数值哦！");
			return;
		}else{
		    if(u>=0&&u<=100&&p>=0&&p<=100&&r>=0&&r<=100){
		         var t=u*0.3+p*0.3+r*0.4;
		         t=Math.round(t);
		         $("#total").val(t);
		         
		    }else{
		      alert("成绩范围在0~100之间哦！");
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
            <li><i class="clip-home-3"></i> <a
                    href="./${sessionScope.pathCode}/home.do"> 首页 </a>
            </li>
            <li class="active">学生成绩信息</li>
        </ol>
        <div class="page-header">
          <h3> 学生成绩信息</h3>
        </div>
        <div style="position: absolute;right:45px;top:65px"> 
        <button class="btn btn-warning" data-toggle="modal" data-target="#putScore"">提交学生成绩</button></div>
        
        <!-- end: PAGE TITLE & BREADCRUMB -->
    </div>
</div>
<!-- 
<c:if test="${putScoresMessage eq 1 }"><div class="alert alert-success">学生成绩已提交成功！</div></c:if>
<c:if test="${putScoresMessage eq 0 }"><div class="alert alert-danger">没有可提交的成绩或学生成绩提交失败，如有问题请联系管理员！</div></c:if>
<c:if test="${putScoresMessage eq 2 }"><div class="alert alert-success">学生成绩已保存！</div></c:if>
<c:if test="${putScoresMessage eq 3 }"><div class="alert alert-danger">学生成绩保存失败，如有问题请联系管理员！</div></c:if>
 -->
<div class="row">
    <div class="col-md-12">
        <!-- start: TABLE WITH IMAGES PANEL -->
        <div class="panel-body">
            <div class="row"></div>
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example" >
                    <thead>
                    <tr>
                        <th ><small>序号</small></th>
                        <th ><small>学号</small></th>
                        <th ><small>姓名</small></th>
                        <th ><small>性别</small></th>
                        <th ><small>班级</small></th>
                        <th ><small>课题</small></th>
                        <th ><small>项目名称</small></th>
                        <th ><small>报告</small></th>
                        <th ><small>总成绩</small></th>
                        <th>
                            <small>操作</small>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="list" varStatus="status">
                        <tr>
                            <td>${ status.index + 1}</td>
                            <td>
                                <small>${list.noid}</small>
                            </td>
                             <td>
                                <small>${list.name }</small>
                            </td>
                            <td>
                                <c:if test="${list.sex eq true }">
                                   <small>女</small>
                                </c:if>
                                <c:if test="${list.sex eq false }">
                                   <small>男</small>
                                </c:if>
                                
                            </td>
                            <td><small>${list.cla_name }</small></td>
                            <td><small>${list.pro_name }</small></td>
                            <td><small>${list.my_pro_name }</small></td>
                            <td><small>report</small></td>
                            <td>
                                 <c:if test="${list.total_score < 60 }">
													           <span class="label label-danger">${list.total_score}</span>
													      </c:if>
													       <c:if test="${list.total_score >=60 }">
													           <span class="label label-success">${list.total_score}</span>
													      </c:if>
                            </td>
                            <td>
                            <c:if test="${list.total_score eq null && list.scores_status eq 0}">
                                    <button class="btn btn-primary" data-toggle="modal" data-target="#addScore" onclick="addScore(${list.score_id})">添加成绩</button>
                            </c:if>
                             
                             <c:if test="${list.total_score ne null && list.scores_status eq 1}">
                                   <button class="btn btn-info" data-toggle="modal" data-target="#updateScore" onclick="Score(${list.score_id},${list.usual_score},${list.project_score },${list.report_score })">修改成绩</button>
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
    <!-- 成绩添加模态框-->
    <div class="modal fade" id="addScore" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >学生成绩添加</h4>
				</div>
				<form id="form1" name="form1" method="post"
					action="./${sessionScope.pathCode}/addStudentScore.do">
					<div class="modal-body">
					          <input type="hidden" name="scoreId" id="scoreId"/>
						平时成绩：<input 
						    type="text" maxlength='3' class="form-control" id="usual" name="usual" ONBLUR="add()"/></br> 
						项目验收成绩：<input 
						    type="text" maxlength='3' class="form-control" id="pro" name="pro" ONBLUR="add()"/></br> 
						报告成绩：<input
							type="text" maxlength='3' class="form-control" id="report" name="report"ONBLUR="add()"/></br>
						总成绩：<input
							type="text" maxlength='3' class="form-control" id="total" readonly="readonly" />
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<button type="button" class="btn btn-default btn-primary"
							onclick="save()">保存</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
    <!-- 成绩修改模态框-->
     <div class="modal fade" id="updateScore" tabindex="-1" role="dialog"
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
				<form id="form2" name="form2" method="post"
					action="./${sessionScope.pathCode}/updateStuScore.do">
					<div class="modal-body">
					         <input type="hidden" name="score_id" id="score_id"/>
					       <input type="hidden" name="claId" id="claId" />
					       <input type="hidden" name="proId" id="proId" />
					       <input type="hidden" name="scores_status" id="scores_status" value="1" />
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
							onclick="check()">确定修改</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	 <!-- 学生成绩提交模态框-->
    <div class="modal fade" id="putScore" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >注意：</h4>
				</div>
				<form id="form3" name="form3" method="post"
					action="./${sessionScope.pathCode}/addMyStuScore.do">
					<div class="modal-body">
					<h5>将对您<font color="#FF0000">已添加</font>的学生成绩进行提交【未添加的将不会被提交】</h5>
					<h5>提交后将<font color="#FF0000">无法进行成绩修改</font>，如有问题请联系相关课题的管理员！</h5>
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<a href="./${sessionScope.pathCode}/putStudentScore.do">
						<button type="button" class="btn btn-default btn-primary">提交</button></a>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
    
    
</body>
</html>
