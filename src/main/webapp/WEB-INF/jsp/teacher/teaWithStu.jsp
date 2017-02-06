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
            <li class="active"> <a
                    href="./${sessionScope.pathCode}/myPower.do"> 我的实践课题 </a></li>
            <li class="active"> <a
                    href="./${sessionScope.pathCode}/chooseTeacher.do?projectId=${projectId}">选择分配教师</a></li>
            <li class="active">查看导师所带学生信息</li>
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
                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example" >
                    <thead>
                    <tr>
                    <th >
                            <small>序号</small>
                        </th>
                        <th ><small>学号</small></th>
                        <th >
                            <small>姓名</small>
                        </th>
                        <th>
                            <small>性别</small>
                        </th>
                         <th>
                            <small>班级</small>
                        </th>
                          <th>
                            <small>手机号</small>
                        </th>
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
                                <small>${list.name}</small>
                            </td>
                            <c:if test="${list.sex eq true }">
                            <td>
                                <small>女</small>
                            </td>
                            </c:if>
                            <c:if test="${list.sex eq false }">
                            <td>
                                <small>男</small>
                            </td>
                            </c:if>
                            
                             <td>
                                <small>${list.cla_name }</small>
                            </td>
                            <td>
                                <small>${list.phone }</small>
                            </td>
                            <td>
                                     <small><a href="./${sessionScope.pathCode}/delTeaWithStu.do?scoreId=${list.score_id}&projectId=${projectId}&teaId=${teaId}">取消分配</a></small>
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
</body>
</html>
