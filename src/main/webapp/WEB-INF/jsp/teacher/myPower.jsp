<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实践课题管理系统</title>
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
            <li class="active">我的实践课题</li>
        </ol>
        <div class="page-header">
            <h3>实践课题管理列表</h3>
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
                <table class="table table-hover"
                       style="TABLE-LAYOUT:fixed;WORD-BREAK:break-all">
                    <thead>
                    <tr>
                        <th width="50%"><small>课题类型</small></th>
                        <th width="25%">
                            <small>学生导师分配管理</small>
                        </th>
                        <th>
                            <small>学生成绩汇总管理</small>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${power}" var="p">
                        <tr>
                            <input type="hidden" class="project_id" value="${p.project_id}">
                            <td>
                                <small>${p.project_name }</small>
                            </td>
                            <td>
                                <c:if test="${p.distribution_id eq user.id }">
                                     <small><a href="./${sessionScope.pathCode}/chooseTeacher.do?projectId=${p.project_id}">进入</a></small>
                                </c:if>
                            </td>
                            <td>
                                 <c:if test="${p.aggregate_id eq user.id }">
                                     <small><a>进入</a></small>
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

</body>
</html>
