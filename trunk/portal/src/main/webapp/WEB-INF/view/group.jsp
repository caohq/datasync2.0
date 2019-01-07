<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/10/31
  Time: 10:42
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx" />

<html>

<head>
    <title>用户与组管理</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .error-message {
            color: red;
        }
        .page-content {
            height: 830px;
            min-height: 830px;
        }
        #table_List1 th,#table_List2 th{
            background-color: #64aed9;
            text-align: center;
            font-family: 'Arial Negreta', 'Arial Normal', 'Arial';
            font-weight: 700;
            font-style: normal;
            font-size: 18px;
            color: #FFFFFF;
        }
    </style>
</head>

<body>

<div style="height: 850px;min-height: 850px;" class="page-content" >
    <h3>&nbsp;&nbsp;用户与组管理</h3>
    <hr />

    <div class="col-md-12">
        <div class="tabbable-custom ">
            <!-- tab header --->
            <ul class="nav nav-tabs ">
                <li class="active">
                    <a href="#userContent" data-toggle="tab" id="showUserContent" style="white-space:nowrap;">
                        用户管理
                    </a>
                </li>
                <li>
                    <a href="#groupContent" data-toggle="tab">
                        用户组管理</a>
                </li>
            </ul>
            <!--tab content-->
            <div class="tab-content">

                <!--用户管理标签页-->
                <div class="tab-pane active" id="userContent" style="min-height: 400px">
                    <div class="row">
                        <div class="col-xs-12 col-md-12 col-lg-12">

                            <!--用户管理标签页: 用户筛选条件-->
                            <div class="alert alert-info" role="alert">
                                <div class="row">
                                    <div class="col-md-12 form-inline">
                                        <div style="float: left;width: 23%">
                                            <label class="control-label">用户账号:</label>
                                            <input type="text" id="loginIdFilter" style="width: 69%"
                                                   name="loginIdFilter" placeholder="用户账号" class="form-control search-text" />
                                        </div>
                                        <div style="float: left;width: 23%">
                                            <label class="control-label">用户名:</label>
                                            <input type="text" id="userNameFilter" style="width: 69%"
                                                   name="userNameFilter" placeholder="用户名" class="form-control search-text" />
                                        </div>
                                        <div style="float: left;width: 23%">
                                            <label class="control-label">用户组:</label>
                                            <select name='groupsFilter' id='groupsFilter' style="width: 69%"
                                                    multiple="multiple" class="form-control select2me" style="width: 200px;" >
                                                <c:forEach  var="group"  items="${allGroupList}">
                                                    <option value="${group.groupName}" id="${group.id}" style="width: 150px; height: 30px;">${group.groupName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div style="float: left;width: 10%;text-align: center">
                                            <button id="searchUserBtn" name="searchUserBtn" onclick="searchUser();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                                        </div>
                                        <div style="float: left;width: 21%;">
                                            <button id="addUserBtn" name="addUserBtn" style="float: right;"
                                                    class="btn info green btn-sm" onclick="addUser()" ><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增用户</button>
                                        </div>
                                            <%--<label class="control-label">用户账号:</label>
                                            <input type="text" id="loginIdFilter" name="loginIdFilter" placeholder="用户账号" class="form-control search-text" />
                                            &nbsp;&nbsp;--%>
                                     </div>
                                </div>
                            </div>

                            <!--用户管理标签页: 用户列表-->
                            <div class="table-message">列表加载中......</div>
                            <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                        <tr id="table_List1">
                                            <th style="width: 5%;">编号</th>
                                            <th style="width: 15%;">用户名 </th>
                                            <th style="width: 15%;">账号 </th>
                                            <th style="width: 15%;">编辑时间</th>
                                            <th style="width: 25%;">用户组</th>
                                            <th >操作</th>
                                        </tr>
                                    </thead>

                                    <tbody id="userList">

                                    </tbody>

                                </table>
                            </div>

                            <!--用户管理标签页: 分页-->
                            <div class="row margin-top-20">
                                <div class="page-message col-md-6 margin-top-10">
                                    当前第<span style="color:blue;" id="curUserPageNum"></span>页,共<span style="color:blue;" id="totalUserPages"></span>页, 共<span style="color:blue;" id="totalUsers"></span>条数据
                                </div>
                                <div class="page-list col-md-6">
                                    <div id="paginationForUser" style="float: right"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!--group tab-->
                <div class="tab-pane" id="groupContent">
                    <div class="row">
                        <div class="col-xs-12 col-md-12 col-lg-12">
                            <div class="alert alert-info" role="alert">
                                <!--查询条件 -->
                                <div class="row">
                                    <div class="col-md-12 form-inline">

                                        <label class="control-label">用户组名:</label>
                                        <input type="text" id="groupName" name="groupName" class="form-control search-text ">
                                        &nbsp;&nbsp;&nbsp;&nbsp;

                                        <button id="btnSearch" name="btnSearch" onclick="search();" class="btn success blue btn-sm"><i class="fa fa-search"></i>&nbsp;&nbsp;查询</button>
                                        &nbsp;&nbsp;
                                        <button id="btnAdd" name="btnAdd" style="float: right" onclick="" class="btn info green btn-sm"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增用户组</button>
                                    </div>
                                </div>

                            </div>
                            <div class="table-message-group">列表加载中......</div>
                            <div class="table-scrollable">

                                <table class="table table-striped table-bordered table-advance table-hover">
                                    <thead>
                                    <tr id="table_List2">
                                        <th style="width: 5%;">编号</th>
                                        <th style="width: 15%;">
                                            用户组名
                                        </th>
                                        <th style="width: 30%;">描述</th>
                                        <th style="width: 17%;">创建时间</th>
                                        <th style="width: 25%;">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="groupList"></tbody>
                                </table>
                            </div>
                            <div class="row margin-top-20">
                                <div class="col-md-6 margin-top-10" id="message-group1">
                                    当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span style="color:blue;" id="totalPages"></span>页,<span style="color:blue;" id="totalCount"></span>条数据
                                </div>
                                <div class="col-md-6" id="message-group2">
                                    <div id="pagination" style="float: right" ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--新增用户组Group-->
<div class="modal fade" tabindex="-1" role="dialog" id="addModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增用户组</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="addGroupForm" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group">
                        <label for="groupNameAdd" class="col-sm-3 control-label">用户组名称<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="groupNameAdd" name="groupName" placeholder="请输入用户组名称"  required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descAdd" class="col-sm-3 control-label">描述<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <textarea  type="text" class="form-control" cols="30" rows="5" id="descAdd" name="desc" placeholder="请输入用户组描述信息" required="required"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitAddData();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" onclick="resetData();" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!--修改用户组Group-->
<div class="modal fade" tabindex="-1" role="dialog" id="editModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改用户组</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="editGroupForm" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group">

                        <input type="hidden" class="form-control"
                               id="groupId"
                               name="id" value=""/>

                        <input type="hidden" class="form-control"
                               id="groupUsers"
                               name="users" />

                        <label for="groupNameEdit" class="col-sm-3 control-label">用户组名称<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="groupNameEdit" name="groupName" placeholder="请输入用户组名称" readonly  required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="descEdit" class="col-sm-3 control-label">描述<span class="required">
													*</span></label>
                        <div class="col-sm-8">
                            <textarea  type="text" class="form-control" cols="30" rows="5" id="descEdit" name="desc" placeholder="请输入用户组描述信息" required="required"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitEditData();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!--用户组Group, 添加用户-->
<div class="modal fade" tabindex="-1" role="dialog" id="groupModalForAddUser">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户组添加用户</h4>
            </div>
            <div class="modal-body" style="min-height: 150px">
                <form class="form-horizontal" id="groupFormForAdduser" method="post" accept-charset="utf-8" role="form"  onfocusout="true">
                    <div class="form-group" style="margin-bottom:2px;">
                        <input type="hidden" id="spanGroupId">
                        <label class="col-sm-3 control-label">用户组名称:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <span id="spanGroupName"></span>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:2px;">
                        <label  class="col-sm-3 control-label">描述:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <span id="spanDesc"></span>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:2px;">
                        <label  class="col-sm-3 control-label">本组己有用户:</label>
                        <div class="col-sm-8" style="padding-top: 7px;" >
                            <select class='form-control select2me' name='users' id='users' multiple>
                                <c:forEach  var="item"  items="${list}">
                                    <option value="${item.id}" id="${item.id}" >${item.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" onclick="submitAddUser();" ><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- 用户组 group -->
<script type="text/html" id="groupTmpl">
    {{each list}}
    <tr>
        <td style="display:table-cell; vertical-align:middle ; text-align: center;" >{{(currentPage-1)*pageSize+$index+1}}</td>
        <td style="display:table-cell; vertical-align:middle" ><a href="javascript:editData('{{$value.id}}');">{{$value.groupName}}</a>
        </td>
        <td style="display:table-cell; vertical-align:middle ;text-align: left;">{{$value.desc}}</td>
        <td style="display:table-cell; vertical-align:middle ;text-align: center;">{{dateFormat($value.createTime)}}</td>
        <td style="display:table-cell; vertical-align:middle;text-align: center;" id="a{{$value.id}}" >
            <%--<button class="btn default btn-xs green-stripe" onclick="viewData()">查看</button>&nbsp;&nbsp;--%>
                <button class="btn default btn-xs green" onclick="addUserData('{{$value.id}}')"><i class="fa fa-user"></i>添加用户</button>
                <button class="btn default btn-xs purple updateButton" onclick="editData('{{$value.id}}')"><i class="fa fa-edit"></i>修改</button>&nbsp;
            <button class="btn default btn-xs red" onclick="deleteData('{{$value.id}}')"><i class="fa fa-trash"></i>删除</button>&nbsp;
        </td>
    </tr>
    {{/each}}
</script>

<!--用户管理标签页：用户列表表格-->
<script type="text/html" id="userListTable">
    {{each list}}
    <tr>
        <td style="text-align: center">{{(curUserPageNum-1) * pageSize + 1 + $index}}</td>
        <td style="text-align: center">{{$value.userName}}</td>
        <td style="text-align: center">{{$value.loginId}}</td>
        <td style="text-align: center">{{$value.createTime}}</td>
        <%--<td style="text-align: center">{{$value.stat}}</td>--%>
        <td style="text-align: center">{{$value.groups}}</td>
        <td style="text-align: center" id = "{{$value.id}}">
            <button class="btn default btn-xs purple updateUserButton" data-target="#updateUserDialog" data-toggle="modal" onclick="updateUser(this);"><i class="fa fa-edit"></i>&nbsp;修改</button>
            &nbsp;
            <button class="btn default btn-xs red updateUserGroupButton" onclick="deleteUser(this);"><i class="fa fa-trash"></i>&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>

<!--用户管理标签页：新建用户对话框-->
<div id="addUserDialog" class="modal fade"  role="dialog"  tabindex="-1" role="dialog" aria-hidden="true" data-width="400">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header  bg-primary">
                <button class="close" data-dismiss="modal"> <span aria-hidden="true">×</span> </button>
                <h4 id="titleForAddUserDialog" class="modal-title">新增用户</h4>
            </div>

            <div class="modal-body">
                <form id="addUserForm" class="form-horizontal" role="form" method="post" accept-charset="utf-8"  onfocusout="true">
                    <div class="form-body">
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="userName">
                                用&nbsp;户&nbsp;名<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户名称" id="userName" name="userName"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="loginId">
                                用户账号<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户账号,只可输入数字和字母的组合" id="loginId" name="loginId"  required="required" onkeyup="this.value=this.value.replace(/[^\w_]/g,'');" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="password">
                                密&nbsp;&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入密码,至少为6位"  id="password" name="password" required="required">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectCodeForAddUserDialog">
                                专业库
                            </label>
                            <div class="col-md-9">
                                    <select class='form-control' name='subjectCodeForAddUserDialog' id='subjectCodeForAddUserDialog' placeholder="请选择专业库">
                                        <option value="" disabled selected>请选择专业库</option>
                                        <c:forEach  var="subject"  items="${subjectList}">
                                            <option value="${subject.subjectCode}" id="${subject.subjectCode}" >${subject.subjectName}</option>
                                        </c:forEach>
                                    </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 control-label" for="groupsForAddUserDialog">
                                用户组<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <select class='form-control select2me' name='groupsForAddUserDialog' id='groupsForAddUserDialog' multiple="multiple" placeholder="请选择用户组">
                                    <c:forEach  var="group"  items="${allGroupList}">
                                        <option value="${group.groupName}" id="${group.id}" >${group.groupName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button id="saveUserAddBtn" class="btn green" onclick="agreeAddUser();">
                    保存
                </button>
                <button id="cancelUserAddBtn" class="btn default"  data-dismiss="modal">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>

<!--用户管理标签页：修改用户对话框-->
<div id="updateUserDialog" class="modal fade"  role="dialog" tabindex="-1"  role="dialog" aria-hidden="true" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h4 id="titleForUpdateUserDialog" class="modal-title" >修改用户</h4>
            </div>

            <div class="modal-body">
                <form id="updateUserForm" class="form-horizontal" role="form" method="post" accept-charset="utf-8"  onfocusout="true">
                    <div class="form-body">
                        <span id="idForUpdate" hidden="hidden"></span>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="userNameForUpdate">
                                用&nbsp;户&nbsp;名<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户名称" id="userNameForUpdate" name="userNameForUpdate" required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="loginIdForUpdate">
                                用户账号
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入用户账号" id="loginIdForUpdate" name="loginIdForUpdate" readonly="readonly" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="passwordForUpdate">
                                密&nbsp;&nbsp;&nbsp;&nbsp;码<span style="color: red;">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" placeholder="请输入密码"  id="passwordForUpdate" name="passwordForUpdate" required="required">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="subjectCodeForUpdateUserDialog">
                                专业库
                            </label>
                            <div class="col-md-9">
                                <select class='form-control' name='subjectCodeForUpdateUserDialog' id='subjectCodeForUpdateUserDialog'>
                                    <c:forEach  var="subject"  items="${subjectList}">
                                        <option value="${subject.subjectCode}" id="${subject.subjectCode}" >${subject.subjectName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label" for="groupsForUpdateUserDialog">
                                用户组
                            </label>
                            <div class="col-md-9">
                                <select class='form-control select2me' name='groupsForUpdateUserDialog' id='groupsForUpdateUserDialog' multiple="multiple">
                                    <c:forEach  var="group"  items="${allGroupList}">
                                        <option value="${group.groupName}" id="${group.id}" >${group.groupName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button id="saveUserUpdateBtn" class="btn green" onclick="agreeUpdateUser();">
                    保存
                </button>
                <button id="cancelUserUpdateBtn" class="btn default"  data-dismiss="modal">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>

<!--用户管理标签页：删除用户对话框-->
<div id="deleteUserDialog" class="modal fade" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    删除用户
                </h5>
            </div>
            <div class="modal-body">
                <h5>确认删除该用户？</h5>
            </div>

            <div class="modal-footer">
                <span id="idOfUserToBeDeleted" hidden="hidden"></span>
                <button id="agreeDeleteUserBtn" class="btn green" onclick="agreeDeleteUser();">确认</button>
                <button id="cancelDeleteUserBtn"  class="btn default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script src="${ctx}/resources/js/subStrLength.js"></script>
    <script src="${ctx}/resources/js/regex.js"></script>
    <script src="${ctx}/resources/bundles/jquery/jquery.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>

    <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>


    <script type="text/javascript">
        var ctx = '${ctx}';
        var currentPageNo = 1;
        var validatorAdd;
        var groupUsersSelect2;
        var validAddData;
        var validEditData;

        $(function () {
            template.helper("dateFormat", formatDate);
            getData(1);

            $(".search-text").keydown(function (event) {
                if (event.keyCode == 13){
                    getData(1);
                }
            });

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

            validAddData = {
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    groupName: {
                        required: true,
                        remote:
                            {
                                url: "isExist",
                                type: "get",
                                dataType: "json",
                                data:
                                    {
                                        'groupName': function()
                                        {
                                            return $("#groupNameAdd").val();
                                        }
                                    }
                            }
                    },
                    desc: {
                        required: true
                    }
                },
                messages: {
                    groupName: {
                        required: "请输入用户组名称",
                        remote :"此用户组名称己存在"
                    },
                    desc: {
                        required: "请输入用户组描述信息"
                    }
                },
                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.parent(".input-group").size() > 0) {
                        error.insertAfter(element.parent(".input-group"));
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                }
            };

            validEditData = {
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    groupName: {
                        required: true
                    },
                    desc: {
                        required: true
                    }
                },
                messages: {
                    groupName: {
                        required: "请输入用户组名称"
                    },
                    desc: {
                        required: "请输入用户组描述信息"
                    }
                },
                errorPlacement: function (error, element) { // render error placement for each input type
                    if (element.parent(".input-group").size() > 0) {
                        error.insertAfter(element.parent(".input-group"));
                    } else {
                        error.insertAfter(element); // for other inputs, just perform default behavior
                    }
                },
                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                        .closest('.form-group').removeClass('has-error'); // set error class to the control group
                }
            };

            $("#addGroupForm").validate(validAddData);
            $("#editGroupForm").validate(validEditData);

            //getAllUserList();
            groupUsersSelect2 = $('#users').select2({
                placeholder: "请选择用户",
                allowClear: true
            });


            //////////////////////////////////////////////////////////////////////////////////////////////////
            //
            // 用户管理标签页：jquery初始化代码
            //
            //////////////////////////////////////////////////////////////////////////////////////////////////
            $("#showUserContent").click(function() {
                location.reload();
            });


            queryUser(null, null, null, 1); //用户管理标签页：获得用户列表
            //选择用户组筛选用户
            var groupsFilterSelect2 = $("#groupsFilter").select2(
                {
                    placeholder: "请选择用户组",
                    allowClear: true
                }
            );
            //添加用户对话框中，选择用户组
            var userGroupForAddUserDialogSelect2 = $("#groupsForAddUserDialog").select2({
                placeholder: "请选择用户组",
                allowClear: true
            });
            //添加、更新用户对话框中，选择用户组
            var groupsForUpdateUserDialogSelect2 = $('#groupsForUpdateUserDialog').select2({
                placeholder: "请选择用户组",
                allowClear: true
            });

            var addUserValid = {
                errorElement: 'span',
                errorClass: 'error-message',
                focusInvalid: false,
                rules: {
                    userName: "required",
                    loginId: {
                        required: true,
                        remote:
                            {
                                url: "${ctx}/user/queryLoginId",
                                type: "get",
                                data:
                                    {
                                        'loginId': function()
                                        {
                                            return $("#loginId").val();
                                        }
                                    },
                                dataType: "json"
                            }
                    },
                    password: {
                        required: true,
                        minlength: 6
                    },
                    groupsForAddUserDialog: "required",
                },
                messages: {
                    userName: "请输入用户名",
                    loginId: {
                        required: "请输入用户账号",
                        remote: "此用户账号已经存在！"
                    },
                    password: {
                        required: "请输入密码",
                        minlength: "密码至少为6位"
                    },
                    groupsForAddUserDialog: "请输入用户组",
                }
            };
            var updateUserValid = {
                errorElement: 'span',
                errorClass: 'error-message',
                focusInvalid: false,
                rules: {
                    userNameForUpdate: "required",

                    loginIdForUpdate: {
                        required: true,
                        /*remote:
                            {
                                url: "${ctx}/user/queryLoginId",
                                type: "get",
                                data:
                                    {
                                        'loginId': function()
                                        {
                                            return $("#loginId").val();
                                        }
                                    },
                                dataType: "json"
                            }*/
                    },
                    passwordForUpdate: {
                        required: true,
                        minlength: 6
                    },
                    /*groupsForUpdateUserDialog: "required",*/
                },
                messages: {
                    userNameForUpdate: "请输入用户名",
                    loginIdForUpdate: {
                        required: "请输入用户账号",
                        /*remote: "此用户账号已经存在！"*/
                    },
                    passwordForUpdate: {
                        required: "请输入密码",
                        minlength: "密码至少为6位"
                    },
                    /*groupsForUpdateUserDialog: "请输入用户组"*/
                }
            };
            $("#addUserForm").validate(addUserValid);
            $("#updateUserForm").validate(updateUserValid);
        });

        function search() {
            getData(1);
        }

        //获取所有的用户信息
        function getAllUserList() {
            $.ajax({
                url: "${ctx}/group/getUserList",
                type: "get",
                dataType: "json",
                success: function (data) {

                }
            });
        }

        function getData(pageNo) {
            $.ajax({
                url: "${ctx}/group/getPageData",
                type: "get",
                dataType: "json",
                data: {
                    "groupName":$.trim($("#groupName").val()),
                    "pageNo": pageNo,
                    "pageSize": 10
                },
                success: function (data) {
                    console.log("-----------------")
                    console.log(data)

                    var html = template("groupTmpl", data);
                    $("#groupList").empty();
                    $("#groupList").append(html);
                    if(data.list.length ==0){
                        $(".table-message-group").html("暂时没有数据")
                        $("#message-group1").hide()
                        $("#message-group2").hide()
                        return
                    }
                    $(".table-message-group").html("")
                    $("#message-group1").show()
                    $("#message-group2").show()
                    $("#currentPageNo").html(data.currentPage);
                    currentPageNo = data.currentPage;
                    $("#totalPages").html(data.totalPages);
                    $("#totalCount").html(data.totalCount);
                    if (data.totalCount == 0){
                        $("#currentPageNo").html("0");
                    }

                    if ($("#pagination .bootpag").length != 0) {
                        $("#pagination").off();
                        $('#pagination').empty();
                    }

                    $('#pagination').bootpag({
                        total: data.totalPages,
                        page: data.currentPage,
                        maxVisible: 5,
                        leaps: true,
                        firstLastUse: true,
                        first: '首页',
                        last: '尾页',
                        wrapClass: 'pagination',
                        activeClass: 'active',
                        disabledClass: 'disabled',
                        nextClass: 'next',
                        prevClass: 'prev',
                        lastClass: 'last',
                        firstClass: 'first'
                    }).on('page', function (event, num) {
                        getData(num);
                        currentPageNo = num;
                    });
                }
            });
        }

        function deleteData(id) {

            bootbox.confirm("<span style='font-size:16px;'>确定要删除此条记录吗？</span>", function (r) {
                if (r) {
                    $.ajax({
                        url: ctx + "/group/delete/" + id,
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            if (data.result == 'ok') {
                                toastr["success"]("删除成功！", "数据删除");
                                getData(currentPageNo);
                                //删除用户组的同时,刷新用户列表信息
                                searchUser();
                            }
                            else {
                                toastr["error"]("删除失败！", "数据删除");
                            }
                        },
                        error: function () {
                            toastr["error"]("删除失败！", "数据删除");
                        }
                    });
                }
            });
        }

        $("#btnAdd").click(function () {
            $("#groupNameAdd").val("");
            $("#descAdd").val("");
            resetData();
            $("#addModal").modal('show');
        });

        //重置校验窗体xiajl20181117
        function resetData() {
            $("#addGroupForm").validate().resetForm();
            $("#addGroupForm").validate().clean();
            $('.form-group').removeClass('has-error');
        }

        function submitAddData() {
            if (!$("#addGroupForm").valid()) {
                return;
            }
            $.ajax({
                type: "POST",
                url: '${ctx}/group/add',
                data: $("#addGroupForm").serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("添加成功！", "添加用户组");
                        $("#addModal").modal("hide");
                        $("#groupNameAdd").val("");
                        $("#descAdd").val("");
                        getData(currentPageNo);
                    } else {
                        toastr["error"]("添加失败！", "添加用户组");
                    }
                }
            });
        }

        <!--编辑用户组-->
        function editData(id) {
            $.ajax({
                type: "GET",
                url: '${ctx}/group/info',
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    $("#editModal").modal("show");
                    $("#groupNameEdit").val(data.group.groupName);
                    $("#descEdit").val(data.group.desc);
                    $("#groupId").val(data.group.id);
                }
            });
        }


        <!--用户组中增加用户界面-->
        function addUserData(id) {
            $.ajax({
                type: "GET",
                url: '${ctx}/group/info',
                data: {"id": id},
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $("#groupModalForAddUser").modal("show");
                    $("#spanGroupName").html(data.group.groupName);
                    $("#spanDesc").html(data.group.desc);
                    $("#spanGroupId").val(data.group.id);
                    //编辑显示己增加的用户
                    //编辑显示己增加的用户
                    console.log(data.group.users);
                    console.log(JSON.stringify(data.group.users));

                    $("#users").select2().val(JSON.parse(data.group.users)).trigger("change");

                }
            });
        }

        function submitEditData() {
            if (!$("#editGroupForm").valid()) {
                return;
            }
            $.ajax({
                type: "POST",
                url: '${ctx}/group/update',
                data: $("#editGroupForm").serialize(),
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("编辑成功！", "用户组编辑");
                        $("#editModal").modal("hide");
                        getData(currentPageNo);
                    } else {
                        toastr["error"]("编辑失败！", "用户组编辑");
                    }
                }
            });
        }

        <!--用户组中增加用户信息确认 -->
        function submitAddUser() {
            console.log("id=" +$("#spanGroupId").val());
            $.ajax({
                type: "POST",
                url: '${ctx}/group/updateUsers',
                data: {"id": $("#spanGroupId").val(),
                    "users":JSON.stringify($("#users").val())
                },
                dataType: "json",
                success: function (data) {
                    if (data.result == 'ok') {
                        toastr["success"]("用户组增加用户成功！", "用户组编辑");
                        $("#groupModalForAddUser").modal("hide");
                        //同时更新用户信息
                        queryUser(null, null, null, 1);
                    } else {
                        toastr["error"]("用户组增加用户失败！", "用户组编辑");
                    }
                }
            });
        }
    </script>


    <%--//////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 用户管理标签页：javascript代码
    //
    //////////////////////////////////////////////////////////////////////////////////////////////////--%>
    <script type="text/javascript">
        var currentUserPage = 1;

        //添加用户按钮
        function addUser()
        {
            $("#userName").val("");
            $("#loginId").val("");
            $("#password").val("");
            $("#subjectCodeForAddUserDialog").val("");
            $("#groupsForAddUserDialog").select2("val", "");

            resetAddUserDialog();

            $("#addUserDialog").modal("show");
        }

        function resetAddUserDialog()
        {
            $("#addUserForm").validate().resetForm();
            $("#addUserForm").validate().clean();
            $(".form-group").removeClass("has-error");
        }

        //添加用户对话框的保存
        function agreeAddUser()
        {
            if (!$("#addUserForm").valid()) {
                return;
            }

            console.log("adduser\n" + (typeof $("#groupsForAddUserDialog").val()) + "\nadduser");

            $.ajax({
                url: "${ctx}/user/addUser",
                type: "get",
                data: {
                    "userName": $("#userName").val(),
                    "loginId": $("#loginId").val(),
                    "password": $("#password").val(),
                    "subjectCode": $("#subjectCodeForAddUserDialog").val().toString(),
                    "groups": $("#groupsForAddUserDialog").val().toString(),
                },
                dataType: "text",
                success: function (data) {
                    console.log(data);
                    $("#addUserDialog").modal("hide");
                    setTimeout(function(){}, 100);
                    queryUser(null, null, null, 1); //没有搜索条件的情况下，显示第一页
                    location.reload();
                },
                error: function(data) {

                }
            });
        }

        //查询 按钮
        function searchUser()
        {
            var loginId = $("#loginIdFilter").val().trim();
            var userName = $("#userNameFilter").val().trim();
            var groups = $("#groupsFilter").val();
            if(groups == null)
            {
                groups = "";
            }
            else
            {
                groups = groups.toString();
            }

            console.log("searchUser - parameters - loginId = " + loginId);
            console.log("searchUser - parameters - userName = " + userName);
            console.log("searchUser - parameters - groups = " + groups);

            queryUser(loginId, userName, groups, 1);
        }

        function queryUser(loginId, userName, groups, curUserPageNum)
        {
            $.ajax({
                url: "${ctx}/user/queryUser",
                type: "get",
                data: {
                    "loginId": loginId,
                    "userName": userName,
                    "groups": groups,
                    "curUserPageNum": curUserPageNum,
                    "pageSize": 10
                },
                dataType: "json",
                success: function (data) {
                    console.log(data);

                    var userSize = data.totalUsers;
                    if (userSize == 0)
                    {
                        $("#paginationForUser").off();
                        $(".table-message").show();
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").hide();
                        $(".page-list").hide();
                        $("#userList").hide();
                    }
                    else
                    {
                        $(".table-message").hide();
                        $(".page-message").show();
                        $(".page-list").show();
                        $("#userList").show();

                        var html = template("userListTable", data);
                        $("#userList").empty();
                        $("#userList").append(html);

                        $(".table-message").html("列表加载中......")
                        $("#curUserPageNum").html(data.curUserPageNum);
                        currentUserPage = data.curUserPageNum;
                        $("#totalUserPages").html(data.totalUserPages);
                        $("#totalUsers").html(data.totalUsers);


                        if ($("#paginationForUser .bootpag").length != 0) {
                            $("#paginationForUser").off();
                            $('#paginationForUser').empty();
                        }

                        $('#paginationForUser').bootpag({
                            total: data.totalUserPages,
                            page: data.curUserPageNum,
                            maxVisible: 5,
                            leaps: true,
                            firstLastUse: true,
                            first: '首页',
                            last: '尾页',
                            wrapClass: 'pagination',
                            activeClass: 'active',
                            disabledClass: 'disabled',
                            nextClass: 'next',
                            prevClass: 'prev',
                            lastClass: 'last',
                            firstClass: 'first'
                        }).on('page', function (event, toNum) {
                            queryUser(loginId, userName, groups, toNum);
                            currentUserPage = toNum;
                        });
                    }
                }
            });
        }

        //删除按钮
        function deleteUser(deleteBtn)
        {
            var idOfUser = $(deleteBtn).parent().attr("id");

            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>",
                function (result)
                {
                    if (result) {
                        var deleteUrl = "${ctx}/user/deleteUser";
                        $.ajax({
                            url: deleteUrl,
                            type: "get",
                            data: {
                                id: idOfUser
                            },
                            dataType: "text",
                            success: function (data) {
                                console.log(data);
                                console.log("typeof data = " + (typeof data));
                                if (data.trim() == "1") {
                                    queryUser(null, null, null, currentUserPage);
                                    toastr["success"]("删除成功！", "数据删除");
                                    //location.reload();
                                }
                                else {
                                    toastr["error"]("删除失败！", "数据删除");
                                }
                            },
                            error: function(data)
                            {
                                console.log(data);
                                toastr["error"]("删除失败！", "数据删除");
                            }
                        });
                    }
                }
            );
        }

        function agreeDeleteUser(agreeDeleteBtn)
        {
            $("#deleteUserDialog").modal("hide");
            var idOfUser = $("#idOfUserToBeDeleted").html();
            $.ajax({
                url: "${ctx}/user/deleteUser",
                type: "get",
                data:
                    {"id": idOfUser},
                dataType: "json",
                success: function (data) {
                    queryUser(null, null, null, 1);
                },
                error: function(data) {

                }
            });
        }

        function updateUser(updateBtn)
        {
            var idOfUser = $(updateBtn).parent().attr("id");

            $.ajax(
                {
                    url: "${ctx}/user/getUserById",
                    type: "get",
                    data: {
                        "id": idOfUser
                    },
                    dataType: "json",
                    success: function (data) {
                        console.log("updateUser - getUserById user = " + data.toString());
                        console.log("udpateUser - idForUpdate = " + data.id);
                        $("#idForUpdate").html(data.id);
                        $("#userNameForUpdate").val(data.userName);
                        $("#loginIdForUpdate").val(data.loginId);
                        $("#passwordForUpdate").val(data.password);

                        var subjectCodeArr = data.subjectCode.split(",");
                        console.log("getUserById - subjectCodeArr - " + subjectCodeArr);
/*
                        $("#subjectCodeForUpdateUserDialog").select2().val(subjectCodeArr).trigger("change");
*/
                        $("#subjectCodeForUpdateUserDialog").val(subjectCodeArr);

                        var groupArr = data.groups.split(",");
                        console.log("getUserById - groupArr - " + groupArr);
                        $("#groupsForUpdateUserDialog").select2().val(groupArr).trigger("change");

                        $("#updateUserDialog").modal("show");

                    },
                    error: function(data) {

                    }
                }

            );
        }

        function agreeUpdateUser()
        {
            if (!$("#updateUserForm").valid()) {
                return;
            }

            $.ajax(
                {
                    url: "${ctx}/user/updateUser",
                    type: "get",
                    data: {
                        "id": $("#idForUpdate").html(),
                        "userName": $("#userNameForUpdate").val(),
                        "loginId": $("#loginIdForUpdate").val(),
                        "password": $("#passwordForUpdate").val(),
                        "subjectCode": $("#subjectCodeForUpdateUserDialog").val().toString(),
                        "groups": ($("#groupsForUpdateUserDialog").val()==null) ? "" : ($("#groupsForUpdateUserDialog").val().toString())
                    },
                    dataType: "text",
                    success: function (data) {
                        console.log(data);
                        $("#updateUserDialog").modal("hide");
                        queryUser(null, null, null, 1); //没有搜索条件的情况下，显示第一页
                        location.reload();
                    },
                    error: function(data) {
                        console.log(data);
                    }
                }
            );
        }

        /*//subjectCode唯一性
        $("#loginId").change(
            function()
            {
                var loginId = $(this).val();

            }
        );*/

        <%--$("#loginId").blur(--%>
            <%--function()--%>
            <%--{--%>
                <%--$.ajax({--%>
                    <%--type: "GET",--%>
                    <%--async: false,--%>
                    <%--url: '${ctx}/user/queryLoginId',--%>
                    <%--data: {loginId: $(this).val()},--%>
                    <%--dataType: "text",--%>
                    <%--success: function (data){--%>
                        <%--var cntOfLoginId = parseInt(data);--%>
                        <%--if (cntOfLoginId > 0)--%>
                        <%--{--%>
                            <%--alert("loginId已经存在，请另外选择一个！")--%>
                        <%--}--%>
                    <%--},--%>
                    <%--error: function(data) {--%>
                        <%--console.log(data);--%>
                    <%--}--%>
                <%--});--%>
            <%--}--%>

    </script>
</div>

</html>
