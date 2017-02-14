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
                    <li class="active"> <a
                    href="./${sessionScope.pathCode}/chooseClasses.do?projectId=${projectId}&teaId=${teaId}">选择班级</a></li>
            <li class="active">选择学生</li>
        </ol>
        <div class="page-header">
            <h3>学生信息列表<h5><font color="red">请在全选或多选前，选择【显示50条】,最后在页面底部提交。</font></h5></h3>
        </div>
        <!-- end: PAGE TITLE & BREADCRUMB -->
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <!-- start: TABLE WITH IMAGES PANEL -->
         <form name="add" action="./${sessionScope.pathCode}/addTeaWithStu.do" method="post">
             <input type="hidden" name="projectId" value="${projectId}">
             <input type="hidden" name="teaId" value="${teaId}">
             <input type="hidden" name="classId" value="${classId}">
        <div class="panel-body">
            <div class="row"></div>
            <div class="panel-body">
                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example" >
                    <thead>
                    <tr>
                    <th >
                            <small>全选/反选--><input type="checkbox" id="selectAll"/></small>
                    </th>
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
                            <small>联系方式</small>
                        </th>
                    </tr>
                    </thead>
                   
                    <tbody>
                    <c:forEach items="${listAll}" var="all" varStatus="status">
                        <tr>
                        <td>
                         <c:forEach items="${list}" var="list" >
                           <c:if test="${list.id eq all.id}">
                             <input id="chk" type="checkbox" name="stu_id" value="${list.id}"/>
                           </c:if>
                        </c:forEach>
                        </td>
                            <td>${ status.index + 1}</td>
                            <td>
                                <small>${all.noid}</small>
                            </td>
                             <td>
                                <small>${all.name }</small>
                            </td>
                            <c:if test="${all.sex eq true }">
                            <td>
                                <small>女</small>
                            </td>
                            </c:if>
                            <c:if test="${all.sex eq false }">
                            <td>
                                <small>男</small>
                            </td>
                            </c:if>
                            <td>
                                <small>${all.phone }</small>
                            </td>
                           </tr>
                    </c:forEach>
                    </tbody>
                </table>
                
            </div>
        </div>
        <input class="btn btn-primary btn-block" type="submit"/>
        </form>
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
    <script>
    $("#selectAll").click(function(){   
           $("input[name='stu_id']").each(function(){
           $(this).attr("checked",!this.checked);  
           });   
                                    
    });
    </script>
</body>
</html>
