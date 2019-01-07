<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/30
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>数据发布管理系统</title>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .arrListSty{
            display: inline-block;
            margin-right: 5px;
            background-color: #aaaaaa;
            padding: 3px 6px;
            margin-bottom: 5px;
        }
        #relModal .form-group div,#fileModal .form-group div{
            word-break: break-all;
        }
        .commentsList{
            border:1px solid darkgray;
            margin-bottom: 5px;
            background-color: #7ad588;
            border-radius:7px!important;
        }
        .commentsList .form-group{
            margin-bottom: 0px!important;
        }
        .commentsList label{
            padding-top: 0px!important;
        }
    </style>
</head>

<body>

<div class="page-content">
    <div>
        <%--<div class="uplod-head">
            <span>数据发布管理</span>
        </div>--%>
            <shiro:hasRole name="admin">
                <h3>数据发布管理</h3>
            </shiro:hasRole>
            <shiro:hasRole name="root">
                <h3>发布审核管理</h3>
            </shiro:hasRole>

            <hr>
        <div class="alert alert-info" role="alert">
            <!--查询条件 -->
            <div class="row">
                <form class="form-inline" style="margin-bottom: 0px">

                        <label style="padding-left: 10px;">数据集名称:</label>
                        <input type="text" class="form-control" id="resourceName" placeholder="请输入数据集名称">


                        <label style="padding-left: 10px;">数据类型:</label>
                        <select id="resourcePublicType" class="form-control" style="width: 120px">
                            <option value="">全部</option>
                            <option value="mysql">mysql</option>
                            <option value="file">file</option>
                        </select>


                        <label style="padding-left: 10px;">状态:</label>
                        <select id="resourceState" class="form-control" style="width: 120px">
                            <option value="">全部</option>
                            <option value="1">待审核</option>
                            <option value="-1">未完成</option>
                            <option value="2">审核通过</option>
                            <option value="0">审核未通过</option>
                        </select>

                    <button type="button" class="btn blue btn-sm" style="margin-left: 20px" id="seachResource"><i class="fa fa-search"></i>&nbsp;&nbsp;查&nbsp;&nbsp;询</button>
                    <shiro:hasRole name="admin">
                    <button type="button" class="btn green btn-sm" style="float: right;margin-right: 15px" onclick="newRelease()"><i class="glyphicon glyphicon-plus"></i>&nbsp;&nbsp;新增数据发布
                    </button>
                    </shiro:hasRole>
                </form>
            </div>
        </div>
        <div class="upload-table">
            <div class="table-message">列表加载中......</div>
            <table class="table table-bordered data-table" id="upload-list">
                <thead>
                <tr>
                    <th width="7%">编号</th>
                    <th width="22%">数据集名称</th>
                    <th width="13%">类型</th>
                   <%-- <th width="10%">来源位置</th>--%>
                    <th width="20%">发布时间</th>
                    <th width="16%">状态</th>
                    <th width="22%">操作</th>
                </tr>
                </thead>
                <tbody id="bd-data">
                </tbody>
            </table>

            <div class="row margin-top-20 ">
                <div class="page-message" style="float: left;padding-left: 20px; line-height: 56px"></div>
                <div class="page-list" style="float: right; padding-right: 15px;"></div>
            </div>
        </div>
    </div>
</div>
<div id="relModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">数据集详情查看</h4>
            </div>
            <div class="modal-body" style="max-height: 500px;overflow: auto">
                <div class="commentsList" id="mysqlComments" style="display: none">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核人姓名&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="mysqlCommentsName">aaa</div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核时间&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="mysqlCommentsTime">bbb</div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核内容&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="mysqlCommentsContent">vvvv</div>
                        </div>
                    </form>
                </div>
                <form class="form-horizontal">
                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">数据源ID:</label>
                        <div class="col-sm-8 modediv" id="rel-dataSourceId"></div>
                    </div>--%>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">数据集标识:</label>
                            <div class="col-sm-8 modediv" id="rel-pid"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">数据集名称:</label>
                            <div class="col-sm-8 modediv" id="rel-title"></div>
                        </div>
                        <div class="form-group" style="word-break: break-all">
                            <label class="col-sm-3 control-label">发布类型:</label>
                            <div class="col-sm-8 modediv" id="rel-publicType"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">简介:</label>
                            <div class="col-sm-8 modediv" id="rel-introduction" style="work-break:break-all"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布图片:</label>
                            <div class="col-sm-8 modediv" id="rel-imagePath">
                                <img src="" alt="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源关键词:</label>
                            <div class="col-sm-8 modediv" id="rel-keyword"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">分类目录ID:</label>
                            <div class="col-sm-8 modediv" id="rel-catalogId"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">开始时间:</label>
                            <div class="col-sm-8 modediv" id="rel-startTime"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">结束时间:</label>
                            <div class="col-sm-8 modediv" id="rel-endTime"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">版权声明:</label>
                            <div class="col-sm-8 modediv" id="rel-createdByOrganization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">状态:</label>
                            <div class="col-sm-8 modediv" id="rel-status"></div>
                        </div>
                       <%-- <div class="form-group">
                            <label class="col-sm-3 control-label">资源填写状态:</label>
                            <div class="col-sm-8 modediv" id="rel-resState"></div>
                        </div>--%>


                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">字段注释:</label>
                            <div class="col-sm-8 modediv" id="rel-fieldComs"></div>
                        </div>--%>
                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">专业库代码:</label>
                            <div class="col-sm-8 modediv" id="rel-subjectCode"></div>
                        </div>--%>
                        <hr style="border-bottom:1px dashed #111;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建人员:</label>
                            <div class="col-sm-8 modediv" id="rel-createdBy"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建者机构:</label>
                            <div class="col-sm-8 modediv" id="rel-createOrgnization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建日期:</label>
                            <div class="col-sm-8 modediv" id="rel-creationDate"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者机构:</label>
                            <div class="col-sm-8 modediv" id="rel-publishOrgnization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者邮件:</label>
                            <div class="col-sm-8 modediv" id="rel-email"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者电话:</label>
                            <div class="col-sm-8 modediv" id="rel-phoneNum"></div>
                        </div>

                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">分类:</label>
                        <div class="col-sm-8 modediv" id="rel-taxonomy"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">格式:</label>
                        <div class="col-sm-8 modediv" id="rel-dataFormat"></div>
                    </div>--%>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">最新发布日期:</label>
                        <div class="col-sm-8 modediv" id="rel-updateDate"></div>
                    </div>

                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">引用格式:</label>
                        <div class="col-sm-8 modediv" id="rel-citation"></div>
                    </div>--%>
                        <hr style="border-bottom:1px dashed #111;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">实体表名:</label>
                            <div class="col-sm-8 modediv" id="rel-publicContent"></div>
                        </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总存储量:</label>
                        <div class="col-sm-8 modediv" id="rel-toMemorySize"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总文件数:</label>
                        <div class="col-sm-8 modediv" id="rel-toFilesNumber"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总记录数:</label>
                        <div class="col-sm-8 modediv" id="rel-toRecordNumber"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户组:</label>
                        <div class="col-sm-8 modediv" id="rel-userGroupId"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" data-dismiss="modal" class="btn  default">关闭</button>
            </div>
        </div>
    </div>
</div>
<div id="fileModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">数据集详情查看</h4>
            </div>
            <div class="modal-body" style="max-height: 500px;overflow: auto">
                <div class="commentsList" id="fileComments" style="display: none">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核人姓名&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="fileCommentsName">aaa</div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核时间&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="fileCommentsTime">bbb</div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">审核内容&nbsp;&nbsp;:</label>
                            <div class="col-sm-9" id="fileCommentsContent">vvvv</div>
                        </div>
                    </form>
                </div>
                <form class="form-horizontal">
                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">数据源ID:</label>
                        <div class="col-sm-8 modediv" id="file-dataSourceId"></div>
                    </div>--%>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">数据集标识:</label>
                            <div class="col-sm-8 modediv" id="file-pid"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">数据集名称:</label>
                            <div class="col-sm-8 modediv" id="file-title"></div>
                        </div>
                        <div class="form-group" style="word-break: break-all">
                            <label class="col-sm-3 control-label">发布类型:</label>
                            <div class="col-sm-8 modediv" id="file-publicType"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">简介:</label>
                            <div class="col-sm-8 modediv" id="file-introduction"style="work-break:break-all"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布图片:</label>
                            <div class="col-sm-8 modediv" id="file-imagePath"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">资源关键词:</label>
                            <div class="col-sm-8 modediv" id="file-keyword"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">分类目录ID:</label>
                            <div class="col-sm-8 modediv" id="file-catalogId"></div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">开始时间:</label>
                            <div class="col-sm-8 modediv" id="file-startTime"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">结束时间:</label>
                            <div class="col-sm-8 modediv" id="file-endTime"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">版权声明:</label>
                            <div class="col-sm-8 modediv" id="file-createdByOrganization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">状态:</label>
                            <div class="col-sm-8 modediv" id="file-status"></div>
                        </div>
                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">资源填写状态:</label>
                            <div class="col-sm-8 modediv" id="file-resState"></div>
                        </div>--%>

                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">发布内容:</label>
                            <div class="col-sm-8 modediv" id="file-publicContent"></div>
                        </div>--%>

                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">字段注释:</label>
                            <div class="col-sm-8 modediv" id="file-fieldComs"></div>
                        </div>--%>
                        <%--<div class="form-group">
                            <label class="col-sm-3 control-label">专业库代码:</label>
                            <div class="col-sm-8 modediv" id="file-subjectCode"></div>
                        </div>--%>
                        <hr style="border-bottom:1px dashed #111;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建人员:</label>
                            <div class="col-sm-8 modediv" id="file-createdBy"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建者机构:</label>
                            <div class="col-sm-8 modediv" id="file-createOrgnization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">创建日期:</label>
                            <div class="col-sm-8 modediv" id="file-creationDate"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者机构:</label>
                            <div class="col-sm-8 modediv" id="file-publishOrgnization"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者邮件:</label>
                            <div class="col-sm-8 modediv" id="file-email"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">发布者电话:</label>
                            <div class="col-sm-8 modediv" id="file-phoneNum"></div>
                        </div>
                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">分类:</label>
                        <div class="col-sm-8 modediv" id="file-taxonomy"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">格式:</label>
                        <div class="col-sm-8 modediv" id="file-dataFormat"></div>
                    </div>--%>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">最新发布日期:</label>
                        <div class="col-sm-8 modediv" id="file-updateDate"></div>
                    </div>
                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">机构:</label>
                        <div class="col-sm-8 modediv" id="file-organizationName"></div>
                    </div>--%>
                    <%--<div class="form-group">
                        <label class="col-sm-3 control-label">引用格式:</label>
                        <div class="col-sm-8 modediv" id="file-citation"></div>
                    </div>--%>
                        <hr style="border-bottom:1px dashed #111;">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">实体文件路径:</label>
                            <div class="col-sm-8 modediv" id="file-filePath"></div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">实体文件名称:</label>
                            <div class="col-sm-8 modediv" id="file-fileName"></div>
                        </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总存储量:</label>
                        <div class="col-sm-8 modediv" id="file-toMemorySize"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总文件数:</label>
                        <div class="col-sm-8 modediv" id="file-toFilesNumber"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">总记录数:</label>
                        <div class="col-sm-8 modediv" id="file-toRecordNumber"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">用户组:</label>
                        <div class="col-sm-8 modediv" id="file-userGroupId"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" data-dismiss="modal" class="btn  default">关闭</button>
            </div>
        </div>
    </div>
</div>
<div id="auditModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">数据审核</h4>
            </div>
            <div class="modal-body" style="overflow: auto">
                <div id="AuditMessageList">
                </div>
                <div id="AuditMessage">
                    <form class="form-horizontal" id="submit_form1" accept-charset="utf-8" role="form"  onfocusout="true"
                          method="POST">
                        <div class="form-group">
                            <label class="control-label col-md-3" for="audit_status" >审核结果 <span class="required">
                                                    * </span>
                            </label>
                            <div class="col-md-7" style="padding-top:13px">
                                <%--<input type="text" class="form-control" name="Task_dataName" required="required"
                                       id="Task_dataName" placeholder="请输入名称">--%>
                                    <select id="audit_status" class="form-control" name="audit_status">
                                        <option value="2" selected="selected">审核通过</option>
                                        <option value="0">审核未通过</option>
                                    </select>
                            </div>

                        </div>
                        <div class="form-group ">
                            <label class="control-label col-md-3" for="audit_content">审核详情<span class="required">
                                                    * </span>
                            </label>
                            <div class="col-md-7" style="padding-top:13px">
                                                    <textarea  type="text" class="form-control" cols="30" rows="4"  placeholder="请输入审核结果理由，不少于20字"
                                                               id="audit_content" name="audit_content"  required="required" ></textarea>

                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green"  auditId=""  id="auditId" ><i
                        class="glyphicon glyphicon-ok"></i>确认
                </button>
                <button type="button"  class="btn default" onclick="remValidate()">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each resourceList as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td><a href="javascript:void(0)">{{value.title}}</a></td>
        {{if value.publicType == 'mysql' ||value.publicType == '' }}
        <td>mysql</td>
        {{else if value.publicType == 'file'}}
        <td>file</td>
        {{/if}}
       <%-- <td style="word-break: break-all">{{value.createdByOrganization}}</td>--%>
        <td>{{dateFormat(value.creationDate)}}</td>

        {{if value.status == '1'}}
        <td id="{{value.dataTaskId}}" >待审核</td>
        {{else if value.status == '0'}}
        <td id="{{value.dataTaskId}}" style="color: #d9534f">审核未通过&nbsp;<span class="glyphicon glyphicon-remove"></span></td>
        {{else if value.status == '2'}}
        <td id="{{value.dataTaskId}}" style="color: #5cb85c">审核通过&nbsp;<span class="glyphicon glyphicon-ok"></span></td>
        {{else if value.status == '-1'}}
        <td id="{{value.dataTaskId}}" <%--style="color:#ec971f"--%>>未完成</td>
        {{/if}}

        <%--<td class="{{value.id}}">{{upStatusName(value.status)}}</td>--%>
        <td>
            <%--{{if value.status == '-1'}}
            <button type="button" class="btn  edit-data btn-xs blue" style="margin-right: 66px"
                    onclick="showData('{{value.id}}','{{value.publicType}}','{{value.status}}')"><i
                    class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
            </button>
            {{else if value.status != '-1'}}
            <button type="button" class="btn  edit-data btn-xs blue"
                    onclick="showData('{{value.id}}','{{value.publicType}}','{{value.status}}')"><i
                    class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
            </button>
            {{/if}}--%>
            <shiro:hasRole name="admin">
                    <button type="button" class="btn  edit-data btn-xs blue"
                            onclick="showData('{{value.id}}','{{value.publicType}}','{{value.status}}')"><i
                            class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
                    </button>
                        <button type="button" class="btn purple upload-data btn-xs" keyIdTd="{{value.id}}"><i class="fa fa-edit"></i>&nbsp;编辑
                        </button>
            </shiro:hasRole>

            <shiro:hasRole name="admin">
                    <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.id}}');"><i
                            class="glyphicon glyphicon-trash"></i>&nbsp;删除
                    </button>
            </shiro:hasRole>
            <shiro:hasRole name="root">
                {{if value.status == '-1'}}
                        <button type="button" class="btn  edit-data btn-xs blue" style="margin-right: 66px"
                                onclick="showData('{{value.id}}','{{value.publicType}}','{{value.status}}')"><i
                                class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
                        </button>
                        {{else if value.status != '-1'}}
                        <button type="button" class="btn  edit-data btn-xs blue"
                                onclick="showData('{{value.id}}','{{value.publicType}}','{{value.status}}')"><i
                                class="glyphicon glyphicon-eye-open"></i>&nbsp;查看
                        </button>
                        {{/if}}
                        {{if value.status == '1'}}
                            <button type="button" class="btn green btn-xs exportSql"
                                   onclick="auditRelease('{{value.id}}')" ><i class="fa fa-edit"></i>&nbsp;审核
                            </button>
                        {{/if}}
                        {{if value.status == '0'}}
                        <button type="button" class="btn green btn-xs exportSql"
                                onclick="auditRelease('{{value.id}}')" ><i class="fa fa-edit"></i>&nbsp;审核
                        </button>
                        {{/if}}
                        {{if value.status == '2'}}
                        <button type="button" class="btn red btn-xs exportSql"
                                onclick="disableRelease('{{value.id}}')" ><i class="fa fa-edit"></i>&nbsp;停用
                        </button>
                        {{/if}}
            </shiro:hasRole>
        </td>
    </tr>
    {{/each}}
</script>
<script type="text/html" id="resourceTmp2">
    {{each auditMessageList as value i}}
    <div class="commentsList">
        <form class="form-horizontal">
            <div class="form-group">
                <label  class="col-sm-3 control-label">审核人姓名&nbsp;&nbsp;:</label>
                <div class="col-sm-9">{{value.auditPerson}}</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">审核时间&nbsp;&nbsp;:</label>
                <div class="col-sm-9">{{dateFormat(value.auditTime)}}</div>
            </div>
            <div class="form-group">
                <label  class="col-sm-3 control-label">审核内容&nbsp;&nbsp;:</label>
                <div class="col-sm-9">{{value.auditCom}}</div>
            </div>
        </form>
    </div>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">

    <script type="text/javascript">
        var publicType = ""
        var resourceState = ""
        var resourceName=""
        $(function(){
            template.helper("dateFormat", formatDate);
            tableConfiguration2(1,"","","")
        });
        $("#resourcePublicType").on("change", function () {
            publicType = $("#resourcePublicType option:selected").val();
        });
        $("#resourceState").on("change", function () {
            resourceState = $("#resourceState option:selected").val();
        });
        $("#seachResource").click(function () {
            resourceName = $("#resourceName").val()
            tableConfiguration2(1,publicType,resourceState,resourceName);
        })
        $("#bd-data").delegate(".upload-data","click",function () {
            var id = $(this).attr("keyIdTd");
            console.log(id)
            window.location.href="${ctx}/resource/editResource?resourceId="+id;
        })
        var validData = {
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                audit_status: {
                    required: true
                },
                audit_content: {
                    required: true,
                    minWords:true
                }
            },
            messages: {
                audit_status: {
                    required: "请输入数据集名称"
                },
                audit_content: {
                    required: "请输入审核具体信息"
                },
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
        jQuery.validator.addMethod("minWords", function (value, element) {
            var workFlag = $("#audit_content").val().length <20 ?false:true
            return this.optional(element)||($("#dataDescribeID").val()==""|| workFlag);
        }, "最少输入50个字符");
        $("#submit_form1").validate(validData)

        function remValidate() {
            $("#submit_form1").validate().resetForm();
            $(".has-error").removeClass("has-error")
            $('#auditModal').modal('hide')

        }
        function auditRelease(id) {
            $("#auditId").attr("auditId",id)
            $("#audit_status option:eq(0)").prop("selected",true)
            $("#audit_content").val("")
            $("#AuditMessageList").empty()
            $.ajax({
                url:"${ctx}/resource/getAuditMessage",
                type:"GET",
                data:{
                    resourceId:id
                },
                success:function (data) {
                    var list = JSON.parse(data)
                    console.log(list)
                    var tabCon = template("resourceTmp2", list);
                    $("#AuditMessageList").append(tabCon);
                    $("#auditModal").modal("show")
                },
                error:function () {
                    console.log("请求失败")
                }
            })

        }
        $("#auditId").click(function () {
            if(!$("#submit_form1").valid()){
                return
            }
            var id = $(this).attr("auditId")
            var status=$("#audit_status").val()
            var auditContent = $("#audit_content").val()
            $.ajax({
                url:"${ctx}/resource/audit",
                type:"POST",
                data:{
                    resourceId:id,
                    status:status,
                    auditContent:auditContent
                },
                success:function (data) {
                    $('#auditModal').modal('hide')
                    tableConfiguration2(1,"","","")
                },
                error:function () {
                    console.log("请求失败")
                }
            })

        })
        function disableRelease(id) {
            $.ajax({
                url:"${ctx}/resource/stopResource",
                type:"POST",
                data:{
                    resourceId:id,
                },
                success:function (data) {
                    tableConfiguration2(1,"","","")
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
        function resSend() {
            window.location.href = "${ctx}/dataSourceDescribeEdit"
        }
        function showData(id,type,tabStatus) {
            tabStatus = tabStatus ==0?"审核未通过":tabStatus ==1?"未审核":"审核通过"
            if(tabStatus == "审核未通过"){
                $.ajax({
                    url:"${ctx}/resource/getAuditMessage",
                    type:"GET",
                    data:{
                        resourceId:id
                    },
                    success:function (data) {
                        var list = JSON.parse(data).auditMessageList[0]
                        console.log(list)
                        if(type=="mysql" || type==""){
                            $("#mysqlComments").show()
                            $("#mysqlCommentsName").html(list.auditPerson)
                            $("#mysqlCommentsTime").html(convertMilsToDateTimeString(list.auditTime))
                            $("#mysqlCommentsContent").html(list.auditCom)
                        }else {
                            $("#fileComments").show()
                            $("#fileCommentsName").html(list.auditPerson)
                            $("#fileCommentsTime").html(convertMilsToDateTimeString(list.auditTime))
                            $("#fileCommentsContent").html(list.auditCom)
                        }
                    },
                    error:function () {
                        console.log("请求失败")
                    }
                })
            }
            $.ajax({
                url: "${ctx}/resource/resourceDetail",
                type: "GET",
                data: {
                    resourceId:id
                },
                success: function (data) {
                    console.log(JSON.parse(data))
                    var dataList = JSON.parse(data).resource;
                    console.log(dataList)
                    if(type == "mysql" || type =="" ){
                        $("#rel-dataSourceId").html(id)
                        $("#rel-email").html(dataList.email)
                        $("#rel-catalogId").html(dataList.catalogId)
                        $("#rel-imagePath img").attr("src","${ctx}/"+dataList.imagePath+"_cut.jpg")
                        $("#rel-status").html(tabStatus)
                        $("#rel-resState").html(dataList.resState)
                        $("#rel-publicType").html("mysql")
                        $("#rel-publishOrgnization").html(dataList.publishOrgnization)
                        $("#rel-createOrgnization").html(dataList.createOrgnization)
                        var $publicContent=$("#rel-publicContent")
                        listSpan(dataList.publicContent,";",$publicContent)
                        var $filePath=$("#rel-filePath")
                        /*var filrStr = dataList.filePath.substr(0, dataList.filePath.length - 1);
                        listSpan(filrStr,";",$filePath)*/
                        $("#rel-fileName").html(dataList.fileName)
                        $("#rel-fieldComs").html(dataList.fieldComs)
                        $("#rel-subjectCode").html(dataList.subjectCode)
                        $("#rel-pid").html(id)
                        $("#rel-title").html(dataList.title)
                        $("#rel-introduction").html(dataList.introduction)
                        var $keyword=$("#rel-keyword")
                        listSpan(dataList.keyword,",",$keyword)
                        $("#rel-taxonomy").html(dataList.taxonomy)
                        $("#rel-dataFormat").html(dataList.dataFormat)
                        if(dataList.startTime ==null){
                            $("#rel-startTime").parent().hide()
                        }else {
                            $("#rel-startTime").parent().show()
                        }
                        if(dataList.endTime==null){
                            $("#rel-endTime").parent().hide()
                        }else {
                            $("#rel-endTime").parent().show()
                        }
                        if(dataList.createdByOrganization==""){
                            $("#rel-createdByOrganization").parent().hide()
                        }else {
                            $("#rel-createdByOrganization").parent().show()
                        }
                        if(dataList.createPerson == ""){
                            $("#rel-createdBy").parent().hide()
                        }else {
                            $("#rel-createdBy").parent().show()
                        }
                        if(dataList.creationDate==null){
                            $("#rel-creationDate").parent().hide()
                        }else {
                            $("#rel-creationDate").parent().show()
                        }
                        if(dataList.phoneNum==""){
                            $("#rel-phoneNum").parent().hide()
                        }else {
                            $("#rel-phoneNum").parent().show()
                        }
                        if(dataList.toMemorySize==""){
                            $("#rel-toMemorySize").parent().hide()
                        }else {
                            $("#rel-toMemorySize").parent().show()
                        }
                        $("#rel-startTime").html(convertMilsToDateString(dataList.startTime))
                        $("#rel-endTime").html(convertMilsToDateString(dataList.endTime))
                        $("#rel-createdByOrganization").html(dataList.createdByOrganization)
                        $("#rel-createdBy").html(dataList.createPerson)
                        $("#rel-creationDate").html(convertMilsToDateString(dataList.creationDate))
                        $("#rel-organizationName").html(dataList.organizationName)
                        $("#rel-mail").html(dataList.mail)
                        $("#rel-phoneNum").html(dataList.phoneNum)
                        $("#rel-updateDate").html(convertMilsToDateTimeString(dataList.updateDate))
                        $("#rel-citation").html(dataList.citation)
                        $("#rel-toMemorySize").html(dataList.toMemorySize)
                        $("#rel-toFilesNumber").html(dataList.toFilesNumber)
                        $("#rel-toRecordNumber").html(dataList.toRecordNumber)
                        var $userGroupId=$("#rel-userGroupId")
                        listSpan(dataList.userGroupId,",",$userGroupId)
                       /* $("#rel-userGroupId").html(dataList.userGroupId)*/
                        $("#relModal").modal("show")
                    }else {
                        $("#file-dataSourceId").html(id)
                        $("#file-email").html(dataList.email)
                        $("#file-catalogId").html(dataList.catalogId)
                        $("#file-imagePath").html(dataList.imagePath)
                        $("#file-status").html(tabStatus)
                        $("#file-resState").html(dataList.resState)
                        $("#file-publishOrgnization").html(dataList.publishOrgnization)
                        $("#file-createOrgnization").html(dataList.createOrgnization)
                        $("#file-publicType").html("file")
                        var $publicContent=$("#file-publicContent")
                        listSpan(dataList.publicContent,";",$publicContent)
                        var $filePath=$("#file-filePath")
                        var str = dataList.filePath.replace(/%_%/g, "/");
                        var filrStr = str.substr(0, str.length - 1);
                        listSpan(filrStr,";",$filePath)
                        $("#file-fileName").html(dataList.fileName)
                        $("#file-fieldComs").html(dataList.fieldComs)
                        $("#file-subjectCode").html(dataList.subjectCode)
                        $("#file-pid").html(id)
                        $("#file-title").html(dataList.title)
                        $("#file-introduction").html(dataList.introduction)
                        var $keyword=$("#file-keyword")
                        listSpan(dataList.keyword,",",$keyword)
                        $("#file-taxonomy").html(dataList.taxonomy)
                        $("#file-dataFormat").html(dataList.dataFormat)
                        if(dataList.startTime ==null){
                            $("#file-startTime").parent().hide()
                        }else {
                            $("#file-startTime").parent().show()
                        }
                        if(dataList.endTime==null){
                            $("#file-endTime").parent().hide()
                        }else {
                            $("#file-endTime").parent().show()
                        }
                        if(dataList.createdByOrganization==""){
                            $("#file-createdByOrganization").parent().hide()
                        }else {
                            $("#file-createdByOrganization").parent().show()
                        }
                        if(dataList.createPerson==""){
                            $("#file-createdBy").parent().hide()
                        }else {
                            $("#file-createdBy").parent().show()
                        }
                        if(dataList.creationDate==null){
                            $("#file-creationDate").parent().hide()
                        }else {
                            $("#file-creationDate").parent().show()
                        }
                        if(dataList.phoneNum==""){
                            $("#file-phoneNum").parent().hide()
                        }else {
                            $("#file-phoneNum").parent().show()
                        }
                        if(dataList.toMemorySize==""){
                            $("#file-toMemorySize").parent().hide()
                        }else {
                            $("#file-toMemorySize").parent().show()
                        }
                        $("#file-startTime").html(convertMilsToDateString(dataList.startTime))
                        $("#file-endTime").html(convertMilsToDateString(dataList.endTime))
                        $("#file-createdByOrganization").html(dataList.createdByOrganization)
                        $("#file-createdBy").html(dataList.createPerson)
                        $("#file-creationDate").html(convertMilsToDateString(dataList.creationDate))
                        $("#file-organizationName").html(dataList.organizationName)
                        $("#file-mail").html(dataList.mail)
                        $("#file-phoneNum").html(dataList.phoneNum)
                        $("#file-updateDate").html(convertMilsToDateTimeString(dataList.updateDate))
                        $("#file-citation").html(dataList.citation)
                        $("#file-toMemorySize").html(dataList.toMemorySize)
                        $("#file-toFilesNumber").html(dataList.toFilesNumber)
                        $("#file-toRecordNumber").html(dataList.toRecordNumber)
                        var $userGroupId=$("#file-userGroupId")
                        listSpan(dataList.userGroupId,",",$userGroupId)
                        $("#fileModal").modal("show")
                    }
                },
                error: function () {
                    $(".table-message").html("请求失败");
                }
            })
        }
        function newRelease() {
            window.location.href = "${ctx}/dataSourceDescribe"
        }

        function tableConfiguration2(num,publicType,resourceState,resourceName) {
            $.ajax({
                url: "${ctx}/resource/getPageData",
                type: "GET",
                data: {
                    pageNo: num,
                    title: resourceName,
                    publicType: publicType,
                    pageSize: 10,
                    status: resourceState
                },
                success: function (data) {
                    $("#bd-data").html("");
                    var DataList = JSON.parse(data);
                    console.log(DataList)
                    var tabCon = template("resourceTmp1", DataList);
                    $("#bd-data").append(tabCon);

                    if (DataList.resourceList.length == 0) {
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $(".page-list").html("");
                        return
                    }
                    $(".table-message").html("");
                    /*
                    * 创建table
                    * */
                    if ($(".page-list .bootpag").length != 0) {
                        $(".page-list").off();
                        $('.page-list').empty();
                    }
                    $(".page-message").html("当前第<span style='color:blue'>" + DataList.currentPage + "</span>页,共<span style='color:blue'>" + DataList.totalPages + "</span>页,共<span style='color:blue'>" + DataList.totalCount + "</span>条数据");
                    $('.page-list').bootpag({
                        total: DataList.totalPages,
                        page: DataList.currentPage,
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
                        tableConfiguration2(num,publicType,resourceState,resourceName);
                    });
                },
                error: function () {
                    console.log("请求失败")
                }
            })


        }

        function removeData(id){
            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>",function (r) {
                if(r){
                    $.ajax({
                        url:"${ctx}/resource/delete/"+id,
                        type:"POST",
                        /*data:{
                            datataskId:id
                        },*/
                        success:function (data) {
                            toastr["success"]("删除成功");
                            tableConfiguration2(1,publicType,resourceState,resourceName);
                        },
                        error:function () {
                            console.log("请求失败");
                        }
                    })
                }else {

                }
            })


        }
        function listSpan(arrStr,spl,ele){
            var arrList =  arrStr.split(spl);
            if(arrList.length ==1 &&arrList[0] ==""){
                ele.parent().hide()
                ele.empty()
                return
            }else {
                ele.parent().show()
            }
            var arrListStr = ""
            for(var i=0;i<arrList.length;i++){
                arrListStr+="<span class='arrListSty'>"+arrList[i]+"</span>"
            }
            ele.empty()
            ele.append(arrListStr)
        }
    </script>
</div>

</html>

