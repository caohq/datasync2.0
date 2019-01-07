<%--
  Created by IntelliJ IDEA.
  User: shiba
  Date: 2018/11/7
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>系统登录</title>
    <meta name="author" content="DeathGhost" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/loginStyle.css" tppabs="${ctx}/resources/css/loginStyle.css">
    <style>
        body{height:100%;background:#16a085;overflow:hidden;}
        canvas{z-index:-1;position:absolute;}
    </style>
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
    <script src="${ctx}/resources/js/verificationNumbers.js" tppabs="${ctx}/resources/js/verificationNumbers.js"></script>
    <script src="${ctx}/resources/js/Particleground.js" tppabs="${ctx}/resources/js/Particleground.js"></script>
    <script>
        $(document).ready(function() {
            //粒子背景特效
            $('body').particleground({
                dotColor: '#5cbdaa',
                lineColor: '#5cbdaa'
            });
            /*//验证码
            createCode();*/
        });
    </script>
</head>
<body>
<dl class="admin_login">
    <dt>
        <strong style="color: #f9fafa">烟草科研主题库统一登录认证</strong>
        <em style="color: #f9fafa">Management System</em>
    </dt>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <dd class="user_icon">
            <input type="text" id="loginId" name="loginId" placeholder="用户名" class="login_txtbx"/>
        </dd>
        <dd class="pwd_icon">
            <input type="password" id="password" name="password" placeholder="密码" class="login_txtbx"/>
        </dd>
        <dd <%--style="display: none"--%>>
            <font color="red">${errorMsg }</font>
        </dd>
    <%--<dd class="val_icon">
        <div class="checkcode">
            <input type="text" id="J_codetext" placeholder="验证码" maxlength="4" class="login_txtbx">
            <canvas class="J_codeimg" id="myCanvas" onclick="createCode()">对不起，您的浏览器不支持canvas，请下载最新版浏览器!</canvas>
        </div>
        <input type="button" value="验证码核验" class="ver_btn" onClick="validate();">
    </dd>--%>
        <dd>
            <input type="submit" id="loginButton" value="登录" class="submit_btn"/>
        </dd>
    </form>
    <dd>
        <p>2018-2020 &copy;</p>
        <p>中国科学院计算机网络信息中心.版权所有.</p>
    </dd>
</dl>
</body>
</html>
