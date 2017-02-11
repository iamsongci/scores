<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>实践课题管理系统</title>
<link rel="stylesheet" href="assets/plugins/select2/select2.css">


	<script type="text/javascript">
		function checkfrom(form) {
			var emailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
			var phoneReg = /^1[0-9]{10}$/;
			var sex = $('#sex option:selected').val();
			var phone = form.phone.value;
			var email = form.email.value;
			if(! phoneReg.test(phone)) {
				alert("请输入11位手机号!");
				return;
			}
			if(! emailReg.test(email)) {
				alert("请输入正确的邮箱!");
				return;
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
				<li class="active">个人信息</li>
			</ol>
			<div class="page-header">
				<h3>
					个人信息
					<c:if  test="${user.phone eq null or user.phone eq ''}">
					    <small>首次登录必须完善信息后才可执行其他操作!</small>
					</c:if>
					 
				</h3>
			</div>
			<!-- end: PAGE TITLE & BREADCRUMB -->
		</div>
	</div>
	<!-- end: PAGE HEADER 頭部結束-->
	<div class="row">
		<div class="col-md-12">
			<!-- start: GENERAL PANEL -->
			<div class="panel-body">
				<form id="condition" class="form-horizontal"
					action="./${sessionScope.pathCode}/upMyInfo.do" method="post">

					<div class="form-group">
						<label
							class="col-sm-2 control-label" for="stuStudentId">教工号 </label>
						<div class="col-sm-5">
							<input type="text" value="${user.noid}"
								name="noid" id="noid" class="form-control"
								readonly="readonly">

						</div>
						<span class="help-inline col-sm-2"> <i
							class="fa fa-info-circle"></i><font color="red"> 不可修改</font> </span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="stuName"> 姓名 </label>
						<div class="col-sm-5">
							<input type="text" value="${user.name }"
								id="name" name="name" class="form-control"
								readonly="readonly">
						</div>
						<span class="help-inline col-sm-2"> <i
							class="fa fa-info-circle"></i> <font color="red">不可修改 </font></span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="sex"> 性别 </label>
						<div class="col-sm-5">
							<select class="form-control search-select" id="sex"
								name="sex">
								<option value="false" selected="selected">
									<c:if test="${user.sex eq false }">
										 </c:if>男</option>
								<option value="true" selected="selected">
									<c:if test="${user.sex eq true}">
										</c:if>女</option>
							</select>
						</div>

					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="phone"> 联系方式
						</label>
						<div class="col-sm-5">
							<input type="text" value="${user.phone }"
								id="phone" name="phone" class="form-control">
						</div>
						<span class="help-inline col-sm-4"> <i
							class="fa fa-info-circle"></i><font color="red"> 此项为必填项 此项为空将不能执行任何操作</font> </span>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="email"> 电子邮箱
						</label>
						<div class="col-sm-5">
							<input type="text" value="${user.email }"
								id="email" name="email" class="form-control"
								placeholder="Email">
						</div>

					</div>
					
					<div class="from-group">
						<label class="col-sm-2 control-label"></label>
						<div class="col-sm-2" style="text-align:right;">
							<button type="submit" class="btn btn-blue btn-block" onclick="return checkfrom(this.form)">
								<i class="clip-checkmark-2"></i> 确认
							</button>
						</div>
						<div class="col-sm-2" style="text-align:right;">
							<button type="button" class="btn btn-blue btn-block"
								onclick="javascript:history.go(-1);">
								<i class="clip-arrow-right-2 "></i> 返回
							</button>
						</div>
					</div>
				</form>

			</div>
			<!-- end: GENERAL PANEL -->

		</div>
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
