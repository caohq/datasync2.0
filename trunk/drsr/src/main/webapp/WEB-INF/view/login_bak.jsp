<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/10/30
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>分布式数据汇交管理系统</title>

    <link href="${ctx}/resources/bundles/metronic/global/css/components.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/layout.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/themes/light.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/bundles/metronic/css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/globle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/main.css" rel="stylesheet" type="text/css"/>

    <link rel="stylesheet" type="text/css" href="css/default.css">
    <link rel="stylesheet" type="text/css" href="css/account.css" />
</head>

<body>

<div class="page-header navbar navbar-static-top" style="background-color: #438eb9">
    <div class="page-header-inner">
        <div class="page-logo" style="width: auto;">
            <a href="${ctx}/">
                <h4 style="margin-top:14px ">分布式数据汇交管理系统</h4>
            </a>
        </div>
    </div>
</div>



<div class="page-content">

    <div style="height: 10%;">
    </div>

    <div class="source-title" style="text-align: center; font-size: x-large;">
        <span>分布式数据汇交管理系统登录</span>
        <br />
        <br />
    </div>

    <div class="source-table" style="text-align: center; font-size: x-large;">
        <label for="userName">
            用户名<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入用户名" id="userName" name="userName" required="required"/>
        <br />
        <br />

        <label>
            密&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入密码" id="password" name="password"  required="required" />
        <br />
        <br />

        <label>
            代&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
        </label>
        <input type="text" placeholder="请输入专题库代码" id="subjectCode" name="subjectCode"  required="required" />
        <br />
        <br />

        <div id="loginNotice" style="color: #FF0000; font-size: medium;">

        </div>

        <br />

        <button id="loginBtn" class="btn green">
            登陆
        </button>
        &nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;
        <button id="resetBtn" class="btn default">
            重置
        </button>

    </div>

</div>

<script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
    jQuery("#loginBtn").click(
        function() {
            var userName = $("#userName").val();
            var password = $("#password").val();
            var subjectCode = $("#subjectCode").val();

            var loginUrl = "${ctx}/validateLogin?userName=" + userName + "&password=" + password + "&subjectCode=" + subjectCode;

            $.ajax({
                type: "GET",
                url: loginUrl,
                dataType: "text",
                success: function (data) {
                    var loginStatus = parseInt(data);
                    console.log("loginStatus = " + loginStatus);

                    if(loginStatus == 1)
                    {
                        $("#loginNotice").html("登录成功");
                    }
                    else
                    {
                        $("#loginNotice").html("用户名或者密码或者专题库代码错误！")
                    }
                },
                error: function(data)
                {
                    console.log(data);
                }
            });
        }
    );

    jQuery("#resetBtn").click(
        function () {
            $("#userName").val("");
            $("#password").val("");
            $("#subjectCode").val("");

        }
    );
</script>


</body>

</html>

