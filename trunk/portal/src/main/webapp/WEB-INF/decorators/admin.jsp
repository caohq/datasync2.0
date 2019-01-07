<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/9/21
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>

<head>
    <title>
        <shiro:hasRole name="root">
            主题库后台管理系统
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            烟草科研主题库构建与发布工具
        </shiro:hasRole>
    </title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>

    <link href="${ctx}/resources/bundles/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrapv3.3/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/components.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/global/css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/layout.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/metronic/css/themes/light.css" rel="stylesheet" type="text/css"
          id="style_color"/>
    <link href="${ctx}/resources/bundles/metronic/css/custom.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/css/customUserLogin.css" rel="stylesheet" type="text/css"/>

    <!--BEGIN PAGE STYLES-->
    <sitemesh:write property="head"/>
    <!--END PAGE STYLES-->

    <!-- BEGIN THEME STYLES -->
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/style.css">
    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/main.css">--%>
    <!-- END THEME STYLES -->

    <link rel="shortcut icon" href="${ctx}/resources/img/favicon.ico"/>

    <style>
        /*.myactive{
            background-color: #b7ecfe!important;
        }*/
        .page-sidebar .page-sidebar-menu > li > a{
            padding: 8px 15px;
        }
        .navbar-nav>li>a{
            padding-top: 10px;
            padding-bottom: 10px;
        }
    </style>

</head>

<body>
<%--<div class="main-wrap">
    <div class="page-head">
        <div class="head-left">
            <img src="${ctx}/resources/img/u7.png" >
        </div>
        <div class="head-right-center">
            <div class="head-banner-center">
                <span style="font-weight:700;font-family: '新細明體-ExtB Bold', '新細明體-ExtB Regular', '新細明體-ExtB'">DataSync</span>
                <span style="font-weight:400;">&nbsp;&nbsp;&nbsp;中国烟草质量中心平台</span>
            </div>
            <div class="login-btn">
                请登录
            </div>
        </div>
    </div>
    <div class="page-body">
        <div class="body-left">
            <ul class="list-ul center1" style="display: none">
                <li><a href="${ctx}/ccc">专业库管理</a></li>
                <li><a href="${ctx}/subjectMgmt/sdgsdfs?currentPage=1">用户组管理</a></li>
                <li><a href="${ctx}/subjectMgmt/sdgsdfs?currentPage=1">资源分类管理</a></li>
                <li><a href="${ctx}/subjectMgmt/zasda?currentPage=1">数据发布管理</a></li>
                <li><a href="${ctx}/subjectMgmt/dsa?currentPage=1">统计管理</a></li>
                <li><a href="${ctx}/subjectMgmt/querySubject?currentPage=1">all数据发布管理</a></li>
            </ul>
            <ul class="list-ul center2"  style="display: none">
                <li><a href="${ctx}/aaa">数据配置</a></li>
                <li><a href="${ctx}/subjectMgmt/sdgsdfs?currentPage=1">数据发布管理</a></li>
            </ul>

        </div>
        <div class="body-right" style="min-height: 500px">
            <sitemesh:write property="body"/>
            &lt;%&ndash;<div class="setting-head">
                <span>DataSync / 数据配置</span>
            </div>
            <div class="setting-title">
                <span>数据配置</span>
            </div>
            <div class="container-fluid setting-table" >
                <div class="row">
                    <div class="col-md-2" style="font-size: 20px">选择表资源</div>
                    <div class="col-md-9" >
                        <div class="row" >
                            <!--<div class="col-md-4">
                                <label>
                                    <input type="radio" name="data-table"> aw_day
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="radio" name="data-table"> Remember mesadad
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="radio" name="data-table"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="radio" name="data-table"> Remember me
                                </label>
                            </div>
                            <div class="col-md-4">
                                <label>
                                    <input type="radio" name="data-table"> Remember me
                                </label>
                            </div>-->
                            <table class="table">
                                <tr>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_dadsadaday
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                </tr>
                                <tr>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_dadsadaday
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                </tr>
                                <tr>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                    <td><label>
                                        <input type="radio" name="data-table"> aw_day
                                    </label></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>&ndash;%&gt;
        </div>
    </div>
</div>--%>
<div class="top_div">

            <%--<ul class="nav navbar-nav pull-right">
                <!-- BEGIN USER LOGIN DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-user">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        <i class="glyphicon glyphicon-user"></i>
                        <span class="username username-hide-on-mobile">
                           &lt;%&ndash;<shiro:user>&ndash;%&gt;
                               欢迎您！${sessionScope.userName} &nbsp;&nbsp;
                               &lt;%&ndash;<span>角色:${sessionScope.roleNames} </span>&ndash;%&gt;
                           &lt;%&ndash;</shiro:user>&ndash;%&gt;
                        </span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <li><a href="logout"><i class="icon-key"></i>&nbsp;安全退出</a></li>
&lt;%&ndash;
                        <li><a href="#">Another action</a></li>
&ndash;%&gt;
                        &lt;%&ndash;<shiro:guest>
                            <li>
                                <a href="${applicationScope.systemPro['cas.url.prefix']}/login?service=${applicationScope.systemPro['drsr.url']}/shiro-cas">
                                    <i class="icon-rocket"></i>用户登录
                                </a>
                            </li>
                        </shiro:guest>
                        <shiro:user>
                            <li>
                                <a target='_blank'
                                   href="${applicationScope.systemPro['cas.url.prefix']}/reg01004Action.do?userID=<%=CasURLCode.encode(session.getAttribute("loginId").toString())%>">
                                    <i class="icon-calendar"></i>用户信息</a>
                            </li>
                            <li>
                                <a href="${applicationScope.systemPro['cas.url.prefix']}/logout?service=${applicationScope.systemPro['drsr.url']}/logout">
                                    <i class="icon-key"></i>退出</a>
                            </li>
                        </shiro:user>&ndash;%&gt;
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
            </ul>--%>
    <ul class="cus_ul">
        <li>
            <a href="#" id="cus_User_id">
                <i class="glyphicon glyphicon-user"></i>
                &nbsp;&nbsp;
                <span>欢迎您！${sessionScope.userName}</span>
                &nbsp;
                <i class="fa fa-angle-down"></i>
            </a>
            <ul class="cus_drop">
                <li>
                    <a href="logout"><i class="icon-key"></i>&nbsp;安全退出</a>
                </li>
            </ul>
        </li>
    </ul>

</div>

<div class="con_div">

    <div class=" container tatle_div">
        <shiro:hasRole name="root">
            主题库后台管理系统
        </shiro:hasRole>
        <shiro:hasRole name="admin">
            烟草科研主题库构建与发布工具
        </shiro:hasRole>
<%--
        <button class="btn blue" style="float: right;margin-top: 28px;" ><i class="icon-user"></i>登录</button>
--%>

    </div>

    <div class="page-container" style="min-height: 550px;width: 90%;margin: 0 auto">
        <!-- BEGIN SIDEBAR -->
        <div class="page-sidebar-wrapper">
            <div class="page-sidebar navbar-collapse" style="min-height: 500px">
                <!-- BEGIN SIDEBAR MENU -->
                <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
                <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
                <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
                <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
                <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
                <ul class="page-sidebar-menu" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                    <li>
                        <div style="height: 70px"></div>
                    </li>

                <shiro:hasRole name="root">


                    <li class="start">
                        <a href="${ctx}/subjectMgmt/subjectIndex">
                            <i class="icon-user"></i>
                            <span class="title">主题库注册管理</span>
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <li class="startProject">
                        <a href="${ctx}/subjectMgmt/subjectDes">
                            <i class="icon-user"></i>
                            <span class="title">专业库注册管理</span>
                            <span class="arrow"></span>
                        </a>
                    </li>
                    <%-- <shiro:hasRole name="Register">--%>
                    <li>
                        <a href="${ctx}/resCatalog">
                            <i class="icon-settings"></i>
                            <span class="title">数据分类管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>
                    <%--<li>
                        <a href="${ctx}/createTask">
                            <i class="icon-list"></i>
                            <span class="title">元素结构管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>--%>
                    <li>
                        <a href="${ctx}/group/list">
                            <i class="icon-user"></i>
                            <span class="title">用户与组管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/dataRelease">
                            <i class="icon-layers"></i>
                            <span class="title">发布审核管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class=" icon-drawer"></i>
                            <span class="title">数据统计管理</span>
                            <span class="arrow "></span>
                        </a>
                        <ul class="sub-menu">
                            <li>
                                <a href="${ctx}/relationship/index">
                                    专题detail</a>
                            </li>
                            <li>
                                <a href="${ctx}/fileResource/index">
                                    专题total</a>
                            </li>
                        </ul>
                    </li>
                </shiro:hasRole>
                    <%-- </shiro:hasRole>
                     <shiro:hasRole name="管理员">--%>
                    <%--<li>
                        <a href="${ctx}/resource/audit/localAudit">
                            <i class="icon-lock"></i>
                            <span class="title">注册资源审核</span>
                            <span class="arrow "></span>
                        </a>
                    </li>

                    <li>
                        <a href="${ctx}/resCatalog">
                            <i class="icon-list"></i>
                            <span class="title">本地资源目录管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>

                    <li>
                        <a href="${ctx}/metaTemplate/">
                            <i class="icon-layers"></i>
                            <span class="title">元数据模板管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>--%>
                    <shiro:hasRole name="admin">

                    <li>
                        <a href="${ctx}/dataConfiguration">
                            <i class="icon-wrench"></i>
                            <span class="title">数据配置管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/dataRelease">
                            <i class="icon-layers"></i>
                            <span class="title">数据发布管理</span>
                            <span class="arrow "></span>
                        </a>
                    </li>
                    </shiro:hasRole>

                </ul>
                <!-- END SIDEBAR MENU -->
            </div>
        </div>
        <!-- END SIDEBAR -->
        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <sitemesh:write property="body"/>

        </div>
        <!-- END CONTENT -->
    </div>
 <%--   <div class="container daohang_div">
        <div class="col-xs-6 nav_div">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td><a href="${ctx}/">首页</a></td>
                    <td><a href="${ctx}/resource/resourcesList">资源与服务</a></td>
                    <td><a href="${ctx}/demcons/main/list/all">需求与咨询</a></td>
                    <td><a href="${ctx}/person/myApplyPage">个人中心</a></td>
                    <td><a href="${ctx}/subjectMgmt/querySubject?currentPage=1">专业库注册</a></td>
                </tr>
            </table>
        </div>
        <div class="col-xs-6"></div>
    </div>

    <div class="container neirong_div">
        <sitemesh:write property="body"/>
    </div>--%>
</div>

<div class="foot_div">2018-2020 &copy; 中国科学院计算机网络信息中心.版权所有.</div>


<script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
<script src="${ctx}/resources/bundles/jquery/jquery-migrate.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/back-to-top.js"></script>
<script src="${ctx}/resources/bundles/frontend/layout/scripts/layout.js"></script>
<script src="${ctx}/resources/bundles/bootbox/bootbox.min.js"></script>
<script src="${ctx}/resources/bundles/metronic/global/scripts/metronic.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/metronic/scripts/layout.js" type="text/javascript"></script>
<script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
<script src="${ctx}/resources/js/regex.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
<script src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
<script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
<script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>


<script type="text/javascript">
    var userName="${sessionScope.userName}";
    template.helper("dateFormat", convertMilsToDateString);
    template.helper("dateTimeFormat", convertMilsToDateTimeString);
    function convertMilsToDateTimeString(mil) {
        var date = new Date(mil);
        return date.Format("yyyy-MM-dd hh:mm:ss");
    }
    function convertMilsToDateString(mil) {
        var date = new Date(mil);
        return date.Format("yyyy-MM-dd");
    }
/*    $("#cus_User_id").toggle(
        function () {
            $(".cus_drop").show();
            $("#cus_User_id").css("background-color","#eee")
        },
        function () {
            $(".cus_drop").show();
            $("#cus_User_id").css("background-color","#eee")
        }
    )*/
    $("#cus_User_id").click(function (ev) {
        if($(".cus_drop").is(":hidden")){
            $(".cus_drop").show();
        }else {
            $(".cus_drop").hide();
        }
        $("#cus_User_id").css("background-color","#eee")
        ev.stopPropagation()
    })
    $("body:not(.cus_ul)").click(function () {
        $(".cus_drop").hide();
        $("#cus_User_id").css("background-color","")
    })
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };
    jQuery(document).ready(function () {
        scrolltotop.init('${ctx}');
        Layout.init();
        bootbox.setLocale("zh_CN");
        var path = window.location.pathname;
        if (path.indexOf('?') > -1)
            path = path.substring(0, path.indexOf('?'));
        $("ul.page-sidebar-menu a").each(function () {
            var href = $(this).attr("href");
            if (href.indexOf('?') > -1)
                href = href.substring(0, href.indexOf('?'));
            if (href === path) {
                $(this).parent().addClass("active");
                if ($(this).parent().parent().hasClass("sub-menu")) {
                    $(this).parent().parent().parent().children("a").trigger("click");
                    $(this).parent().parent().parent().children("a").append('<span class="selected"></span>');
                    $(this).parent().parent().parent().addClass("active");
                } else {
                    $(this).parent().children("a").append('<span class="selected"></span>');
                }
            }
        });
    });
</script>
<sitemesh:write property="div.siteMeshJavaScript"/>
</body>
</html>
