<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<html>
<head>
<title><sitemesh:write property='title' /></title>
<!-- start: META -->
<meta charset="utf-8" />
<!--[if IE]>
    <meta http-equiv='X-UA-Compatible' content="IE=edge,IE=9,IE=8,chrome=1"/><![endif]-->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="" name="description" />
<meta content="" name="author" />
<base href="<%=basePath%>">
<!-- end: META -->
<!-- start: MAIN CSS -->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="assets/plugins/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/style.css">
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="assets/css/main-responsive.css">
<link rel="stylesheet" href="assets/plugins/iCheck/skins/all.css">
<link rel="stylesheet"
	href="assets/plugins/bootstrap-colorpalette/css/bootstrap-colorpalette.css">
<link rel="stylesheet"
	href="assets/plugins/perfect-scrollbar/src/perfect-scrollbar.css">
<link rel="stylesheet" href="assets/css/theme_light.css" type="text/css"
	id="skin_color">
<link rel="stylesheet" href="assets/css/print.css" type="text/css"
	media="print" />
<!--[if IE 7]>
    <!--<link rel="stylesheet" href="assets/plugins/font-awesome/css/font-awesome-ie7.min.css">-->
<![endif]-->
<!-- end: MAIN CSS -->
<!-- start: CSS REQUIRED FOR THIS PAGE ONLY -->
<link rel="stylesheet"
	href="assets/plugins/fullcalendar/fullcalendar/fullcalendar.css">
<link rel="stylesheet" href="assets/plugins/select2/select2.css">
<link rel="stylesheet"
	href="assets/plugins/datepicker/css/datepicker.css">
<link rel="stylesheet"
	href="assets/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css">
<link rel="stylesheet"
	href="assets/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css">
<link rel="stylesheet"
	href="assets/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.css">
<link rel="stylesheet"
	href="assets/plugins/jQuery-Tags-Input/jquery.tagsinput.css">
<link rel="stylesheet"
	href="assets/plugins/bootstrap-fileupload/bootstrap-fileupload.min.css">
<link rel="stylesheet"
	href="assets/plugins/summernote/build/summernote.css">
<!-- end: CSS REQUIRED FOR THIS PAGE ONLY -->
<link rel="shortcut icon" href="favicon.ico" />




<!-- start: MAIN JAVASCRIPTS -->
<!--[if lt IE 9]>
    <script src="assets/plugins/respond.min.js"></script>
    <script src="assets/plugins/excanvas.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery-1.7.2.min.js"></script>
    <![endif]-->
<!--[if gte IE 9]><!-->

<script type="text/javascript" src="assets/js/jquery-1.7.2.min.js"></script>
<!--<![endif]-->
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>-->
<script src="assets/plugins/jquery-ui/jquery-ui-1.10.2.custom.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script
	src="assets/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"></script>
<script src="assets/plugins/blockUI/jquery.blockUI.js"></script>
<script src="assets/plugins/iCheck/jquery.icheck.min.js"></script>
<script src="assets/plugins/perfect-scrollbar/src/jquery.mousewheel.js"></script>
<script src="assets/plugins/perfect-scrollbar/src/perfect-scrollbar.js"></script>
<script src="assets/plugins/less/less-1.5.0.min.js"></script>
<script src="assets/plugins/jquery-cookie/jquery.cookie.js"></script>
<script
	src="assets/plugins/bootstrap-colorpalette/js/bootstrap-colorpalette.js"></script>
<script src="assets/js/main.js"></script>
<!-- end: MAIN JAVASCRIPTS -->
<!-- start: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
<script src="assets/plugins/flot/jquery.flot.js"></script>
<script src="assets/plugins/flot/jquery.flot.pie.js"></script>
<script src="assets/plugins/flot/jquery.flot.resize.min.js"></script>
<script src="assets/plugins/jquery.sparkline/jquery.sparkline.js"></script>
<script
	src="assets/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js"></script>
<script
	src="assets/plugins/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>
<script src="assets/plugins/fullcalendar/fullcalendar/fullcalendar.js"></script>
<script src="assets/js/index.js"></script>
<!-- end: JAVASCRIPTS REQUIRED FOR THIS PAGE ONLY -->
<script>
	jQuery(document).ready(function() {
		Main.init();
	});
</script>

<script type="text/javascript">
	function check() {
		var userPwReal = "${sessionScope.user.studentPassword}";
		var pwd1 = document.getElementById('apassword').value;
		var pwd2 = document.getElementById('userPw1').value;
		var pwd3 = document.getElementById('userPw2').value;

		if (pwd1 != userPwReal) {
			alert("原密码不正确");
			return;
		}

		if (pwd2 == "") {
			alert("新密码不能空");
			return;
		}
		if (pwd3 != pwd2) {
			alert("两次输入的密码不一致");
			return;
		}
		if (pwd2 == pwd1) {
			alert("新密码与旧密码不能相同!");
			return;
		}
		form1.submit();
	}
</script>
<sitemesh:write property='head' />

</head>
<body>
	<!-- start: HEADER -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<!-- start: TOP NAVIGATION CONTAINER -->
		<div class="container">
			<div class="navbar-header">
				<!-- start: RESPONSIVE MENU TOGGLER -->
				<button data-target=".navbar-collapse" data-toggle="collapse"
					class="navbar-toggle" type="button">
					<span class="clip-list-2"></span>
				</button>
				<!-- end: RESPONSIVE MENU TOGGLER -->
				<!-- start: LOGO -->
				<a class="navbar-brand" href="./${sessionScope.pathCode}/home.do">
					软件学院实践课题管理系统 </a>
				<!-- end: LOGO -->
			</div>
			<div class="navbar-tools">
				<!-- start: TOP NAVIGATION MENU -->
				<ul class="nav navbar-right">
					<li class="dropdown current-user"><a class="dropdown-toggle"
						href="./student/home.do"> <i class="clip-youtube "></i> <span class="username">系统使用说明</span>
					</a></li>
					<!-- start: USER DROPDOWN -->
					<li class="dropdown current-user"><a data-toggle="dropdown"
						data-hover="dropdown" class="dropdown-toggle"
						data-close-others="true" href="javascript:void(0)"><i
							class="clip-user-3 "></i> <span class="username">${sessionScope.user.studentName }</span>
							<i class="clip-chevron-down"></i> </a>
						<ul class="dropdown-menu">
							<li><a href="./${sessionScope.pathCode}/studentInfo.do">
									<i class="glyphicon glyphicon-user"></i> &nbsp;个人信息
							</a></li>
							<li data-toggle="modal" data-target="#AdminChoucha"><a
								data-target="#AdminChoucha"> <i
									class="glyphicon glyphicon-lock"></i> &nbsp;修改密码
							</a></li>
							<li><a href="./logout.do"> <i
									class="glyphicon glyphicon-log-out"></i> &nbsp;退出
							</a></li>
						</ul></li>
					<!-- end: USER DROPDOWN -->
				</ul>
				<!-- end: TOP NAVIGATION MENU -->
			</div>
		</div>
		<!-- end: TOP NAVIGATION CONTAINER -->
	</div>
	<!-- end: HEADER -->
	<!-- start: MAIN CONTAINER -->
	<div class="main-container">
		<div class="navbar-content">
			<!-- start: SIDEBAR -->
			<div class="main-navigation navbar-collapse collapse">
				<!-- start: MAIN MENU TOGGLER BUTTON -->
				<div class="navigation-toggler">
					<i class="clip-chevron-left"></i> <i class="clip-chevron-right"></i>
				</div>
				<!-- end: MAIN MENU TOGGLER BUTTON -->
				<!-- start: MAIN NAVIGATION MENU -->
				<ul class="main-navigation-menu">
					<li id="index" class="active open"><a href="./student/home.do"><i
							class="clip-home-3"></i> <span class="title">首页</span><span
							class="selected"></span> </a></li>
					<!--  <li><a href="./${sessionScope.pathCode}/notify.do"><i
							class=" glyphicon glyphicon-bullhorn  "></i> <span class="title">通知</span></a>
					</li>-->
					<li id="stuSubjectInfo"><a
						href="./${sessionScope.pathCode}/stuSubjectInfo.do"> <i
							class="glyphicon glyphicon-file "></i> <span class="title">课题信息</span>
							<span class="selected"></span>
					</a></li>

					<%-- <li id="stuReport"><a
						href="./${sessionScope.pathCode}/empty.do"> <i
							class="clip-stack-empty "></i> <span class="title">日报</span> <span
							class="selected"></span>
					</a></li>
					<li id="stuMould"><a
						href="./${sessionScope.pathCode}/empty.do"> <i
							class="clip-download"></i> <span class="title">文件模板</span> <span
							class="selected"></span>
					</a></li> --%>
					<li id="stuInfo"><a
						href="./${sessionScope.pathCode}/studentInfo.do"> <i
							class=" clip-user-3"></i> <span class="title">个人信息</span> <span
							class="selected"></span>
					</a></li>
				</ul>
				<!-- end: MAIN NAVIGATION MENU -->
			</div>
			<!-- end: SIDEBAR -->
		</div>
		<!-- start: PAGE -->
		<div class="main-content">
			<div class="container">
				<sitemesh:write property='body' />
			</div>
		</div>
		<!-- end: PAGE -->
	</div>
	<!-- end: MAIN CONTAINER -->

	<!-- 弹出框 -->
	<div class="modal fade" id="AdminChoucha" tabindex="-1" role="dialog"
		aria-labelledby="alterModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="alterModalLabel">修改密码</h4>
				</div>
				<form id="form1" method="post"
					action="./${sessionScope.pathCode}/updateStuPsd.do">
					<div class="modal-body">
						原密码：<input type="password" maxlength='13' class="form-control"
							id="apassword" /></br> 新密码：<input type="password" maxlength='13'
							class="form-control" id="userPw1" name="pwd" /></br> 确认密码：<input
							type="password" maxlength='13' class="form-control" id="userPw2" />
					</div>
					<div class="modal-footer">
						<script type="text/javascript">
							
						</script>
						<button type="button" class="btn btn-default btn-primary"
							onclick="check()">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 消息提示框 -->








	<!-- start: FOOTER -->
	<div class="footer clearfix">
		<div class="footer-inner">2016 &copy; 实践课题管理系统 by 中原工学院软件学院.</div>
		<div class="footer-items">
			<span class="go-top"><i class="clip-chevron-up"></i> </span>
		</div>
	</div>
	<!-- end: FOOTER -->
	<div id="event-management" class="modal fade" tabindex="-1"
		data-width="760" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">Event Management</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal"
						class="btn btn-light-grey">Close</button>
					<button type="button"
						class="btn btn-danger remove-event no-display">
						<i class='fa fa-trash-o'></i> Delete Event
					</button>
					<button type='submit' class='btn btn-success save-event'>
						<i class='fa fa-check'></i> Save
					</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var level1menuId = '${menuSelected1}';
		var level2menuId = '${menuSelected1}';
		$(".open").each(function() {
			$(this).removeClass('active open');
		});

		$('#' + level1menuId).click();
		$('#' + level1menuId).addClass('active open');
	</script>
</body>

</html>
