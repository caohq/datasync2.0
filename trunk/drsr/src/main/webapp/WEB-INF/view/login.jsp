<%--
  Created by IntelliJ IDEA.
  User: zzl
  Date: 2018/10/30
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="${ctx}/resources/css/login/default.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/login/account.css" rel="stylesheet" type="text/css" />
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

    <div class="login">

        <%--<!--svg photo-->
        <i ripple>
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path fill="#C7C7C7" d="m12,2c-5.52,0-10,4.48-10,10s4.48,10,10,10,10-4.48,10-10-4.48-10-10-10zm1,17h-2v-2h2zm2.07-7.75-0.9,0.92c-0.411277,0.329613-0.918558,0.542566-1.20218,1.03749-0.08045,0.14038-0.189078,0.293598-0.187645,0.470854,0.02236,2.76567,0.03004-0.166108,0.07573,1.85002l-1.80787,0.04803-0.04803-1.0764c-0.02822-0.632307-0.377947-1.42259,1.17-2.83l1.24-1.26c0.37-0.36,0.59-0.86,0.59-1.41,0-1.1-0.9-2-2-2s-2,0.9-2,2h-2c0-2.21,1.79-4,4-4s4,1.79,4,4c0,0.88-0.36,1.68-0.930005,2.25z"/>
            </svg>
        </i>--%>

        <div class="photo">
        </div>

        <span style="font-size: x-large; font-family:"黑体"; height: 50px;">分布式数据汇交管理系统登录</span>

        <form action="${ctx}/validateLogin" method="post">
        <div id="u" class="form-group">
            <input id="userName" spellcheck="false" class="form-control" name="userName" type="text" size="15" required="" />
            <span class="form-highlight"></span>
            <span class="form-bar"></span>
            <label for="userName" class="float-label">用户名</label>
            <erroru>
                用户名不能为空
                <i>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M0 0h24v24h-24z" fill="none"/>
                        <path d="M1 21h22l-11-19-11 19zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/>
                    </svg>
                </i>
            </erroru>
        </div>

        <div id="p" class="form-group">
            <input id="password" class="form-control" spellcheck=false name="password" type="password" size="12" required="" />
            <span class="form-highlight"></span>
            <span class="form-bar"></span>
            <label for="password" class="float-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
            <errorp>
                密码不能为空
                <i>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M0 0h24v24h-24z" fill="none"/>
                        <path d="M1 21h22l-11-19-11 19zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/>
                    </svg>
                </i>
            </errorp>
        </div>

        <div id="loginNotice" class="form-group" style="color: #FF0000; font-size: medium;">
            ${loginNotice}
        </div>

        <div class="form-group">
            <%--<input type="checkbox" id="remember">
            <label for="remember">记住密码</label>--%>
            <%-- ripple --%>
            <button id="loginBtn" type="submit" >登录</button>
        </div>
        </form>

    </div>
</div>

<script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $(function () {
            var animationLibrary = 'animate';
            $.easing.easeOutQuart = function (x, t, b, c, d) {
                return -c * ((t = t / d - 1) * t * t * t - 1) + b;
            };
            $('[ripple]:not([disabled],.disabled)').on('mousedown', function (e) {
                var button = $(this);
                var touch = $('<touch><touch/>');
                var size = button.outerWidth() * 1.8;
                var complete = false;
                $(document).on('mouseup', function () {
                    var a = { 'opacity': '0' };
                    if (complete === true) {
                        size = size * 1.33;
                        $.extend(a, {
                            'height': size + 'px',
                            'width': size + 'px',
                            'margin-top': -size / 2 + 'px',
                            'margin-left': -size / 2 + 'px'
                        });
                    }
                    touch[animationLibrary](a, {
                        duration: 500,
                        complete: function () {
                            touch.remove();
                        },
                        easing: 'swing'
                    });
                });
                touch.addClass('touch').css({
                    'position': 'absolute',
                    'top': e.pageY - button.offset().top + 'px',
                    'left': e.pageX - button.offset().left + 'px',
                    'width': '0',
                    'height': '0'
                });
                button.get(0).appendChild(touch.get(0));
                touch[animationLibrary]({
                    'height': size + 'px',
                    'width': size + 'px',
                    'margin-top': -size / 2 + 'px',
                    'margin-left': -size / 2 + 'px'
                }, {
                    queue: false,
                    duration: 500,
                    'easing': 'easeOutQuart',
                    'complete': function () {
                        complete = true;
                    }
                });
            });
        });
        var username = $('#userName'), password = $('#password');
        var erroru = $('erroru'), errorp = $('errorp');
        var submit = $('#submit'), udiv = $('#u'), pdiv = $('#p');
        username.blur(function () {
            if (username.val() == '') {
                udiv.attr('errr', '');
            } else {
                udiv.removeAttr('errr');
            }
        });
        password.blur(function () {
            if (password.val() == '') {
                pdiv.attr('errr', '');
            } else {
                pdiv.removeAttr('errr');
            }
        });

        submit.on('click', function (event) {
            event.preventDefault();

            if (username.val() == '') {
                udiv.attr('errr', '');
            } else {
                udiv.removeAttr('errr');
            }
            if (password.val() == '') {
                pdiv.attr('errr', '');
            } else {
                pdiv.removeAttr('errr');
            }

        });
    });
</script>

</body>

</html>

