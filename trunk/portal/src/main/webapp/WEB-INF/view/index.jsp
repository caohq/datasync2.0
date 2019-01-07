<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2017/9/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>主题库后台管理系统</title>
    <style type="text/css">
        .task-title{
            line-height: 50px;
            padding: 0 33px;
            text-align: center;
        }
        .task-title span{
            font-family: 'Arial Normal', 'Arial';
            font-weight: 400;
            font-style: normal;
            font-size: 28px;
            color: #000000;
        }
        .form-group{
            overflow: hidden;
        }
        .messageCon{
            background: -webkit-linear-gradient(whitesmoke, lightgrey); /* Safari 5.1 - 6.0 */
            background: -o-linear-gradient(whitesmoke, lightgrey); /* Opera 11.1 - 12.0 */
            background: -moz-linear-gradient(whitesmoke, lightgrey); /* Firefox 3.6 - 15 */
            background: linear-gradient(whitesmoke, lightgrey); /* 标准的语法（必须放在最后） */
        }

    </style>
</head>

<body>

<div class="page-content">
    <shiro:hasRole name="root">
        <h3><b>欢迎使用主题库后台管理系统</b></h3>
    </shiro:hasRole>
    <shiro:hasRole name="admin">
        <h3><b>欢迎使用烟草科研主题库构建与发布工具</b></h3>
        <hr>
        <div class="task-title" style="font-size: 16px; font-weight: bold; padding-right:250px;text-align: center;">
            <span>主题库信息</span>
        </div>

        <div class="messageCon"  style="font-size: 18px;padding: 25px 50px">



                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">主题库名称:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.subjectName}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4 " style="text-align: right;font-weight: bold;color: #000000">主题库代码:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.subjectCode}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">管理员账号:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.admin}</div>
                </div>

                <%--<div class="form-group">
                    <label  class="col-sm-3 control-label">密码:</label>
                    <div class="col-sm-8">${subject.adminPasswd}</div>
                </div>--%>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">联系人:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.contact}</div>
                </div>

                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">电话:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.phone}</div>
                </div>

                <div class="form-group">
                    <div class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">邮箱:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.email}</div>
                </div>


                <div class="form-group">
                    <div  class="col-sm-4" style="text-align: right;font-weight: bold;color: #000000">描述:</div>
                    <div class="col-sm-6" style="padding-left: 50px;">${subject.brief}</div>
                </div>
        </div>

    </shiro:hasRole>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var ctx = '${ctx}';
    </script>
</div>

</html>
