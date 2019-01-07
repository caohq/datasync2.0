<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/30
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>数据发布管理系统</title>

    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jqeury-file-upload/css/jquery.fileupload.css">--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.Jcrop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-datepicker/css/datepicker.css">
    <style>
        .undeslist label{
            font-size: 18px;
        }
        .custom-error{
            color:#a94442!important;
            border-color:#a94442!important;
        }
        .key-word ,.permissions-word{
            padding:0 8px;
            height: 28px;
            background:#57add9;
            color:#fff;
            font-size: 14px;
            margin-right:10px;
            margin-bottom: 5px;
            float:left;
        }

        .key-word p , .permissions-word p{
            float:left;
            font-size:14px;
            line-height:28px;
        }
        .key-word span , .permissions-word span{
            float:left;
            cursor:pointer;
            margin-left:5px;
            font-size:16px;
            margin-top:2px;
        }

    </style>
</head>

<body>

<div class="page-content">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue" id="form_wizard_1">
                <div class="portlet-title" style="background-color:#3fd5c0">
                    <div class="caption">
                        <i class="fa fa-gift"></i> 数据发布 - <span class="step-title">
								第&nbsp;<span id="staNum">1</span>&nbsp;步,共&nbsp;3&nbsp;步</span>
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-wizard">
                        <div class="form-body">
                            <ul class="nav nav-pills nav-justified steps">
                                <li class="active">
                                    <a href="#tab1"  class="step">
												<span class="number">
												1 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 元数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab2"  class="step">
												<span class="number">
												2 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 实体数据 </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#tab3"  class="step">
												<span class="number">
												3 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 设置权限 </span>
                                    </a>
                                </li>
                            </ul>
                            <div id="bar" class="progress progress-striped" role="progressbar">
                                <div class="progress-bar progress-bar-success">
                                </div>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab1">
                                    <form class="form-horizontal" id="submit_form1" accept-charset="utf-8" role="form"  onfocusout="true"
                                          method="POST">
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_dataName" >数据集名称 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="Task_dataName" required="required"
                                                       id="Task_dataName" placeholder="请输入名称">
                                            </div>

                                        </div>
                                        <div class="form-group ">
                                            <label class="control-label col-md-3" for="dataDescribeID">简介 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">


                                                    <textarea  type="text" class="form-control" cols="30" rows="4"  placeholder="不少于50字"
                                                               id="dataDescribeID" name="dataDescribeID"  required="required" ></textarea>

                                            </div>
                                        </div>
                                    </form>
                                    <div style="overflow: hidden;margin: 0 -15px">
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili3" style="text-align: right">图片<span  class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class=" margin-top-10">
                                                    <form name="form" id="fileForm" action="" class="form-horizontal" method="post">
                                                        <div id="cutDiv" style="width: 200px; height: 150px;border: 1px solid rgb(169, 169, 169)">
                                                            <%--<img alt="" src="" id="cutimg" style="height: 150px; width: 200px;"/>--%>
                                                            <input type="hidden" id="x" name="x" />
                                                            <input type="hidden" id="y" name="y" />
                                                            <input type="hidden" id="w" name="w" />
                                                            <input type="hidden" id="h" name="h" />
                                                            <input type="hidden" id="tag" name="tag" val=""/>
                                                            <input type="hidden" id="imgFlagNum" val=""/>
                                                        </div>
                                                        <span class="btn default btn-file" id="checkPicture">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <input class="photo-file" id="fcupload" type="file" name="imgFile" onchange="readURL(this);">
                                                            </span>
                                                        <span id="uploadSpan" class="btn default btn-file" style="display: none">
                                                                <span class="fileinput-new">
                                                            上传</span>
                                                                <input type="button" onclick="doUpload();"/>
                                                        </span>
                                                    </form>
                                                    <div class="timeVili3" style="display: none">请上传选择图片</div>
                                                    <div class="clearfix margin-top-10">
                                                        <%--   <span class="label label-danger">
                                                       注意! </span>
                                                                   图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                                   Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <form class="form-horizontal" id="submit_form2" method="POST" accept-charset="utf-8" role="form"  onfocusout="true">

                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="select2_tags">关键词<span class="required">
                                                    * </span></label>
                                            <div class="checkbox-list col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" id="select2_tags" value="" name="select2_tags" required="required"  placeholder="至少两个关键词">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili2" for="centerCatalogId">资源目录<span class="norequired" >
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" id="cemterCatalogDiv" style="padding-top:13px" >

                                                <div id="jstree-demo"></div>
                                                <input type="text"  id="centerCatalogId" name="centerCatalogId"  style="display: none">
                                                <div class="timeVili2" style="display: none">请选择目录</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili" >选择时间<span style="margin-left: 13px">
                                                     </span></label>
                                            <div class="col-md-5"  style="padding-top:13px">
                                                <div class="input-group input-daterange">
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="起始时间" readonly>
                                                    <div class="input-group-addon">to</div>
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="起始时间" readonly>
                                                </div>
                                                <div class="timeVili" style="display: none">请正确选择时间</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="dataSourceDesID">版权声明<span style="margin-left: 13px">
                                                     </span></label>
                                            <div class="col-md-5" id="dataSourceDes" style="padding-top:13px">
                                                <textarea  type="text" class="form-control" cols="30" rows="4" placeholder="请输入来源信息"
                                                           id="dataSourceDesID" name="dataSourceDesID" ></textarea>

                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="create_Organization">创建者机构 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="create_Organization" required="required" placeholder="请输入机构名"
                                                       id="create_Organization" >
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="create_person">创建人员<span style="margin-left: 13px">
                                                     </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control"
                                                       id="create_person" name="create_person" placeholder="请输入创建人员">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" >创建日期<span style="margin-left: 13px">
                                                    </span></label>
                                            <div class="col-md-5"  style="padding-top:13px">
                                                <div class="input-group input-daterange">
                                                    <input type="text" class="form-control selectData" id="createTime"
                                                           data-date-format="yyyy-mm-dd" placeholder="创建日期" readonly>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="publish_Organization">发布者机构 <span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="publish_Organization" required="required" placeholder="请输入发布者机构"
                                                       id="publish_Organization" >
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_email">发布者邮箱号<span class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control"
                                                       id="Task_email" name="Task_email" required="required" placeholder="请输入邮箱号">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_phone">发布者电话号码 <span style="margin-left: 13px">
                                                     </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="Task_phone" placeholder="请输入电话号码"
                                                       id="Task_phone" >
                                            </div>

                                        </div>






                                    </form>

                                </div>
                                <div class="tab-pane" id="tab2">
                                    <div style="font-size: 18px">
                                        <span>数据源:</span>
                                        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
                                        <label for="aaa" style="font-size: 18px;color: #1CA04C">数据库表</label>
                                        <input name="ways" type="radio" value="LH" id="bbb"/>
                                        <label for="bbb" style="font-size: 18px;color: #1CA04C">文件型数据</label>
                                    </div>
                                    <div style="overflow: hidden" class="select-database" >
                                        <div class="col-md-2" style="font-size: 18px;text-align:left;margin: 0 -15px ">
                                            <span>选择表资源</span>
                                        </div>
                                        <div class="col-md-9" >
                                            <div class="row undeslist" >
                                            </div>
                                        </div>
                                    </div>
                                    <div style="overflow: hidden;display: none" class="select-local">
                                        <div class="col-md-4 col-md-offset-2" style="font-size: 18px" id="fileContainerTree"></div>
                                        <div id="fileDescribeDiv" class="col-md-5 tagsinput" style="border: 1px solid grey;display: none" >


                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab3">

                                    <div style="overflow: hidden">
                                        <div class="col-md-6 col-md-offset-1" style="font-size: 18px">
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label  class="col-sm-4 control-label">可公开范围</label>
                                                    <div class="col-sm-8">
                                                        <%--<select name="" id="permissions" class="form-control">
                                                            <option value="" selected="selected">请选择公开范围</option>
                                                            <option value="外网公开用户">外网公开用户</option>
                                                            <option value="内网用户">内网用户</option>
                                                            <option value="质量组用户">质量组用户</option>
                                                            <option value="分析组用户">分析组用户</option>
                                                        </select>--%>
                                                            <select name="permissions" id="permissions" class="form-control" multiple>
                                                                <%--<option value="外网公开用户">外网公开用户</option>
                                                                <option value="内网用户">内网用户</option>
                                                                <option value="质量组用户">质量组用户</option>
                                                                <option value="分析组用户">分析组用户</option>--%>
                                                            </select>
                                                    </div>
                                                </div>
                                                <%--<div class="form-group">
                                                    <label  class="col-sm-4 control-label">已选择</label>
                                                    <div class="col-sm-8">
                                                        <div style=" width: 412px;border: 1px solid rgb(169, 169, 169);min-height: 40px;padding-top: 5px;overflow: hidden;padding-left: 5px" class="permissions-wrap"></div>
                                                    </div>
                                                </div>--%>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <a href="javascript:;" class="btn default button-previous" onclick="fromAction(false)" style="display: none">
                                        <i class="m-icon-swapleft"></i> 上一步 </a>
                                    <a href="javascript:;" class="btn blue button-next" onclick="fromAction(true)" >
                                        下一步 <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                    <a href="javascript:;" class="btn green button-submit" style="display: none">
                                        提交 <i class="m-icon-swapup m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                          </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="subjectCode" value="${sessionScope.SubjectCode}"/>
<input type="hidden" id="imgPath" val="">
<script type="text/html" id="dataRelationshipList">
    {{each list as value i}}
    <div class="col-md-4">
        <label>
            <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="resTable"  keyval="{{value}}"></div>
            <div style="padding-left: 20px;word-break: break-all;cursor: pointer" keyval="{{value}}"> {{value}}</div>
        </label>
    </div>
    {{/each}}
</script>
<div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
    <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                        id="editTableFieldComsCloseId"></button>
                <h4 class="modal-title" id="relationalDatabaseModalTitle">预览数据</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box green-haze" style="border:0;">
                            <div class="portlet-title " style="display: none">
                                <ul class="nav nav-tabs" style="float:left;">
                                    <li class="active" style="display: none">
                                        <a href="#editTableFieldComsId" data-toggle="tab"
                                           id="editTableDataAndComsButtonId" aria-expanded="true">
                                            编辑 </a>
                                    </li>
                                    <li class="active">
                                        <a href="#previewTableDataAndComsId" id="previewTableDataAndComsButtonId"
                                           data-toggle="tab" aria-expanded="false">
                                            预览 </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content"
                                 style="background-color: white;min-height:300px;max-height:70%;padding-top: 20px ; overflow: scroll;">
                                <div class="tab-pane active" id="editTableFieldComsId">
                                </div>
                                <div class="tab-pane" id="previewTableDataAndComsId">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button"  data-dismiss="modal" class="btn red">关闭
                </button>
                <%--<button type="button" data-dismiss="modal" id="editTableFieldComsCancelId" class="btn default">取消</button>--%>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="dataUserList">
    {{each groupList as value i}}
    <option value="{{value.groupName}}">{{value.groupName}}</option>
    {{/each}}
</script>
<%@ include file="./tableFieldComsTmpl.jsp" %>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script type="text/javascript" src="${ctx}/resources/js/jquery.Jcrop.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-form/jquery.form.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/js/jquery.json.min.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var sdoId = "${resourceId}";
        var sub = '${sessionScope.SubjectCode}'
        var initNum =1;
        var firstFlag=false;
        var secondFlag=false;
        var resourceId=sdoId;
        var publicType="mysql";
        var firstTime;
        var lastTime;

        /*var tagNames=new Array();*/
        $('.selectData').datepicker({
            language:'zh-CN'
        });
        $('.selectData').each(function() {
            $(this).datepicker('clearDates');
        });
        $('.selectData:eq(0)').datepicker().on("changeDate",function (ev) {
            firstTime = new Date(ev.date).getTime()
            $(".timeVili").removeClass("custom-error")
            $(".timeVili:eq(1)").hide()
        })
        $('.selectData:eq(1)').datepicker().on("changeDate",function (ev) {
            lastTime =new Date(ev.date).getTime()
            $(".timeVili").removeClass("custom-error")
            $(".timeVili:eq(1)").hide()
        })

        var validData = {
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                Task_dataName: {
                    required: true
                },
                dataDescribeID: {
                    required: true,
                    minWords:true
                }
            },
            messages: {
                Task_dataName: {
                    required: "请输入数据集名称"
                },

                dataDescribeID: {
                    required: "请输入简介信息"
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
        var validData2 = {
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                select2_tags: {
                    required: true,
                    minTwoKey:true
                },
                create_Organization:{
                    required: true,
                },
                publish_Organization:{
                    required: true,
                },
                Task_phone: {
                    isPhone:true
                },
                Task_email: {
                    required: true,
                    isEmail:true
                },
            },
            messages: {
                select2_tags: {
                    required: "至少添加两个关键词"
                },
                create_Organization:{
                    required: "请输入机构名",
                },
                publish_Organization:{
                    required: "请输入发布者机构",
                },
                Task_email: {
                    required: "请输入发布者邮箱地址"
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
            },

        };

        jQuery.validator.addMethod("isPhone", function (value, element) {
            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
            var isMob = /^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$/;
            return this.optional(element) || isMob.test(value)||isPhone.test(value) ;
        }, "请输入正确电话号码");

        jQuery.validator.addMethod("isEmail", function (value, element) {
            var winPath = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
            return this.optional(element) || winPath.test(value);
        }, "请输入正确邮箱地址");

        jQuery.validator.addMethod("minTwoKey", function (value, element) {
            var keyFlag = $("#select2_tags").val().split(",").length <2?false:true
            return keyFlag;
        }, "至少输入两个关键词");

        jQuery.validator.addMethod("minWords", function (value, element) {
            var workFlag = $("#dataDescribeID").val().length <50 ?false:true
            return this.optional(element)||($("#dataDescribeID").val()==""|| workFlag);
        }, "最少输入50个字符");

        $("#select2_tags").change(function () {
            $("#submit_form2").validate(validData2).element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        })

        $("#submit_form1").validate(validData)
        $("#submit_form2").validate(validData2)




        //将图片截图并上传功能
        var api = null;
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                reader.onload = function(event) {
                    $('#cutimg').removeAttr('src');
                    $('#cutimg').attr('src', event.target.result);
                    $("#checkPicture").hide();
                    $("#uploadSpan").show();
                    console.log(event.target.result)
                    api = $.Jcrop('#cutimg', {
                        setSelect: [ 10, 10, 100, 100 ],
                        aspectRatio: 4/3,
                        allowSelect:true,
                       /* allowSelect:false,
                        allowResize:false,*/
                        onSelect: updateCoords,
                        onChange:updateCoords
                    });
                };
                if (api != undefined) {
                    api.destroy();
                }
            }
            function updateCoords(obj) {
                $("#x").val(obj.x);
                $("#y").val(obj.y);
                $("#w").val(obj.w);
                $("#h").val(obj.h);
            };
        }
        function doUpload(){
            $(".jcrop-holder").hide();
            var formData = new FormData($( "#fileForm" )[0]);
            $.ajax({
                url: '${ctx}/resource/uploadHeadImage' ,
                type: 'post',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (result) {
                    var resultJson = JSON.parse(result);
                    console.log(resultJson)
                    var filePath = '${ctx}/resources/img/images/'+resultJson.saveName;
                    $("#imgPath").val('resources/img/images/'+resultJson.saveName);
                    $('.jcrop-tracker').hide();
                    $("#checkPicture").show();
                    $("#uploadSpan").hide();
                    $('#cutimg').attr('src',filePath+'_cut.jpg');
                    $('#cutimg').show();
                },
                error: function (returndata) {
                    alert(returndata);
                }
            });
        }
        $(".progress-bar-success").width(initNum*33+"%");
        $("[name='ways']").on("change",function () {
            if(this.value =="DB"){
                $(".select-database").show();
                $(".select-local").hide();
                publicType ="mysql"
            }else {
                $(".select-database").hide();
                $(".select-local").show();
                publicType ="file"
            }
        })
        $("[name='need_checked']").on("change",function () {
            var $index = $("[name='need_checked']").index($(this))
            if($(this).val() != "" &&$(this).val().trim()!=""){
                $("[name='need_checked']:eq("+$index +")").removeClass("custom-error")
                $("[name='need_message']:eq("+$index +")").removeClass("custom-error")
                $("[name='need_message']:eq("+$index +")").hide()
                $(".required:eq("+$index +")").parent().removeClass("custom-error")
            }
        })
        $("#task_email").on("change",function () {
            $("[name='data_email']").hide()
        })
        $("#task_phone").on("change",function () {
            $("[name='data_phone']").hide()
        })
        $(".undeslist").delegate("input","click",function () {
            staticSourceTableChoice(1,this,sub,$(this).attr("keyval"),"dataResource")
            $("#previewTableDataAndComsButtonId").click()
        })
        $(".button-submit").click(function () {
            addResourceThirdStep()
        })

        relationalDatabaseTableList();
        userGroupList()
        function fromAction(flag) {
            if(flag){
                ++initNum;
                if(initNum ==2 ){
                    if(resourceId == ""){
                        addResourceFirstStep()
                    }else {
                        editResourceFirstStep()
                    }
                    if(firstFlag){
                        initNum--
                        toastr["error"]("请填写必须项目");
                        return
                    }
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab1").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(1)").addClass("active")
                    $(".button-previous").show();
                }else if(initNum ==3) {
                    addResourceSecondStep()
                    if(secondFlag){
                        initNum--
                        toastr["error"]("请选择至少一项");
                        return
                    }
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab2").removeClass("active")
                    $("#tab3").addClass("active")
                    $(".steps li:eq(2)").addClass("active")
                    $(".button-submit").show()
                    $(".button-next").hide()
                }
            }else {
                --initNum
                if(initNum == 1){
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab2").removeClass("active")
                    $("#tab1").addClass("active")
                    $(".steps li:eq(1)").removeClass("active")
                    $(".button-previous").hide();
                }else if(initNum == 2){
                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum*33+"%");
                    $("#tab3").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(2)").removeClass("active")
                    $(".button-next").show()
                    $(".button-submit").hide()
                }
            }
        }
        function initCenterResourceCatalogTree(container,index) {
            $.ajax({
                url: ctx + "/getLocalResCatalog",
                type: "get",
                dataType: "json",
                data: {editable: false},
                success: function (data) {
                    console.log(data)
                    console.log(index)
                    var listPar = data.core.data
                    if(data.id == index){
                        data.state.selected =true
                    }else {

                    }
                    $(container).jstree(data).bind("select_node.jstree", function (event, selected) {
                        /*$(".button-save").removeAttr("disabled");*/
                        $("#centerCatalogId").val(selected.node.id);
                        $(".timeVili2").removeClass("custom-error")
                        $(".timeVili2:eq(1)").hide()
                    }).on("loaded.jstree", function (event, data) {
                        //这两句化是在loaded所有的树节点后，然后做的选中操作，这点是需要注意的，loaded.jstree 这个函数
                        //取消选中，然后选中某一个节点
                        $(container).jstree("deselect_all",true);
                        //$("#keyKamokuCd").val()是选中的节点id，然后后面的一个参数 true表示的是不触发默认select_node.change的事件
                        $(container).jstree('select_node',index,true);
                    });
                }
            })
        }
        function relationalDatabaseTableList() {
            $.ajax({
                url:ctx+"/resource/relationalDatabaseTableList",
                type:"GET",
                success:function (data) {
                    $(".undeslist").empty();
                    var List =JSON.parse(data)
                    console.log(List)
                    var tabCon = template("dataRelationshipList", List);
                    $(".undeslist").append(tabCon);

                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function userGroupList() {
            $.ajax({
                url:ctx+"/resource/getUserGroups",
                type:"GET",
                success:function (data) {
                    var list = JSON.parse(data)
                    var tabCon = template("dataUserList", list);
                    $("#permissions").append(tabCon);
                    $('#permissions').select2({
                        placeholder: "请选择用户",
                        allowClear: true
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
        function addResourceSecondStep() {
            secondFlag = false
            var dataList=""
            if(publicType =="mysql"){
                var $ele = $("[name='resTable']:checked")

                $ele.each(function () {
                    dataList+=$(this).attr("keyval")+";"
                })
            }else {
                var $ele = $(".fileTag")
                $ele.each(function () {
                    dataList+=$(this).attr("name")+";"
                })
            }
            if($ele.size() ==0 ){
                secondFlag = true
                return
            }
            dataList = dataList.substr(0, dataList.length - 1);
            console.log(dataList)
            $.ajax({
                url:ctx+"/resource/addResourceSecondStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    publicType:publicType,
                    dataList:dataList
                },
                success:function (data) {
                    console.log(data)
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function addResourceThirdStep() {
           /* var $preEle= $(".permissions-word .tagname")
            if($preEle.size() ==0){
                toastr["error"]("请选择用户组");
                return
            }
            var userStr = ""
            $preEle.each(function () {
                userStr+=$(this).text()+";"
            })*/
            var $preEle= $("#permissions").val();
            if($preEle == null){
                toastr["error"]("请选择用户组");
                return
            }
            $.ajax({
                url:ctx+"/resource/addResourceThirdStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    userGroupIdList:$preEle.toString()
                },
                success:function (data) {
                    window.location.href = "${ctx}/dataRelease"
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }
        function editResourceFirstStep() {
            firstFlag=false
            if((firstTime ==null && lastTime !=null)||(firstTime !=null && lastTime ==null)||(firstTime>lastTime)){
                $(".timeVili").addClass("custom-error")
                $(".timeVili:eq(1)").show()
                firstFlag=true
            }
            if($("#centerCatalogId").val()==""){
                $(".timeVili2").addClass("custom-error")
                $(".timeVili2:eq(1)").show()
                firstFlag=true
            }
            if(!$("#submit_form1").valid() ){
                firstFlag=true
            }
            if(!$("#submit_form2").valid()){
                firstFlag=true
            }
            if(firstFlag){
                return
            }
            var keywordStr = $("#select2_tags").val()

            $.ajax({
                url:ctx+"/resource/editResourceFirstStep",
                type:"POST",
                data:{
                    resourceId:resourceId,
                    title:$("#Task_dataName").val(),
                    imagePath:$("#imgPath").val(),
                    introduction:$("#dataDescribeID").val(),
                    keyword:keywordStr,
                    catalogId:$("#centerCatalogId").val(),
                    createdByOrganization:$("#dataSourceDesID").val(),
                    startTime:$('.selectData:eq(0)').val(),
                    endTime:$('.selectData:eq(1)').val(),
                    email:$("#Task_email").val(),
                    phoneNum:$("#Task_phone").val(),
                    createTime:$("#createTime").val(),
                    publishOrganization:$("#publish_Organization").val(),
                    createOrganization:$("#create_Organization").val(),
                    createPerson:$("#create_person").val()
                },
                success:function (data) {
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }

        function getResourceById() {
            $.ajax({
                url:ctx+"/resource/getResourceById",
                type:"POST",
                data:{
                    resourceId:resourceId,
                },
                success:function (data) {
                    var totalList = JSON.parse(data).resource
                    console.log(JSON.parse(data));
                    initCenterResourceCatalogTree($("#jstree-demo"),totalList.catalogId);
                    $("#Task_dataName").val(totalList.title)
                    $("#Task_email").val(totalList.email)
                    $("#Task_phone").val(totalList.phoneNum)
                    firstTime = totalList.startTime
                    lastTime =totalList.endTime
                    if(firstTime !=null){
                        $('.selectData:eq(0)').val(convertMilsToDateString(firstTime))
                    }
                    if(lastTime !=null){
                        $('.selectData:eq(1)').val(convertMilsToDateString(lastTime))
                    }
                    if(totalList.createTime !=null){
                        $("#createTime").val(convertMilsToDateString(totalList.createTime))
                    }
                    $("#publish_Organization").val(totalList.publishOrgnization)
                    $("#create_Organization").val(totalList.createOrgnization)
                    $("#create_person").val(totalList.createPerson)
                    $("#dataDescribeID").val(totalList.introduction)
                    $("#cutDiv").append('<img src="" id="cutimg" style="height:100%; width: 100%;display: block"/>');
                    var path = "${ctx}/"+totalList.imagePath+"_cut.jpg";
                    $('#cutimg').attr('src',path);
                    $('#imgPath').val(totalList.imagePath);
                    publicType =  totalList.publicType==""?"mysql":totalList.publicType=="mysql"?"mysql":"file"
                    $("#select2_tags").val(totalList.keyword)
                    $("#select2_tags").select2({
                        tags: true,
                        multiple: true,
                        tags:[""],
                    });
                    $("#dataSourceDesID").val(totalList.createdByOrganization)
                    var publicContentList = totalList.publicContent.split(";")
                    var typeNum = (totalList.publicType=="mysql"||totalList.publicType=="")?0:1;
                    $("[name='ways']:eq("+ typeNum+")").prop("checked",true)
                    if(typeNum ==0){
                        for(var i=0;i<publicContentList.length;i++){
                            $("[keyval='"+publicContentList[i] +"']").prop("checked",true)
                        }
                    }else {
                        var fileId=totalList.filePath
                        fileId = fileId.substr(0, fileId.length - 1);
                        var str = fileId.replace(/%_%/g, "/");
                        console.log(str);
                        var filePathList = str.split(";")
                        console.log(filePathList)
                        for (var i=0;i<filePathList.length;i++){
                            $("#fileDescribeDiv").append("<span class='tag fileTag' style='display: inline-block;margin-right: 5px' name="+ filePathList[i]+"><span class='filePathClass'>"+filePathList[i] +"</span> &nbsp;&nbsp; <a href='javascript:void(0)' title='Removing tag' onclick='tagClick(this)'>x</a> </span>")
                        }
                        $("#fileDescribeDiv").show();
                        $(".select-database").hide();
                        $(".select-local").show();

                    }
                    var userList = totalList.userGroupId.split(",")
                    $('#permissions').select2().val(userList).trigger("change");
                    $('#permissions').select2({
                        placeholder: "请选择用户",
                        allowClear: true,
                    });
                },
                error:function (data) {
                    console.log("请求失败")
                }
            })
        }

        $('#fileContainerTree').jstree({
            'core': {
                'data': function (node, cb) {
                    var children;
                    if (node.id == '#') {
                        children = initFileTree();
                    } else {
                        children = getFileList(node.id);
                    }
                    generateChildJson(children);
                    cb.call(this, children);
                }
            },
            "plugins": [
                "checkbox", "wholerow"
            ]
        }).bind('select_node.jstree', function (e, data) {
            var fileId = data.node.id;
            var str = fileId.replace(/%_%/g, "/");
            /*var isContain = false;*/
            $("#fileDescribeDiv").append("<span class='tag fileTag' style='display: inline-block;margin-right: 5px;display: none' nameid="+ fileId+" name="+fileId +"><span class='filePathClass'>"+str +"</span> &nbsp;&nbsp; <a href='javascript:void(0)' title='Removing tag' onclick='tagClick(this)'>x</a> </span>")
        }).bind("deselect_node.jstree", function (e, data) {
            var fileId = data.node.id;
            var fileName = data.node.text;
            $("span[nameid='" + fileId + "']").remove();
            /*$("#form_wizard_1").find(".button-save").removeAttr("disabled");*/
        });

        function initFileTree() {
            var root;
            $.ajax({
                type: "GET",
                url: '${ctx}/resource/fileSourceFileList',
                dataType: "json",
                async: false,
                success: function (data) {
                    root = data;
                }
            });
            return root;
        }
        function getFileList(folderPath) {
            var children;
            $.ajax({
                url: "${ctx}/resource/treeNode",
                type: "get",
                data: {'filePath': folderPath},
                dataType: "json",
                async: false,
                success: function (data) {
                    children = data;
                }
            });
            return children;
        }
        function generateChildJson(childArray) {
            console.log(childArray)
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.type == 'directory') {
                    child.children = true;
                    child.icon = "jstree-folder";
                } else {
                    child.icon = "jstree-file";
                }
            }
        }
        function tagClick(obj){
            $(obj).parent().remove();
        }

        jQuery(document).ready(function () {
            getResourceById();
        })

    </script>
</div>

</html>

