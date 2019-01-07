<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/09/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>系统</title>
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="source-head">
        <span>分布式数据汇交管理系统/数据源</span>
    </div>
    <%--<div class="source-title">
        <span>数据源信息管理</span>
    </div>--%>
    <div class="alert alert-info" role="alert" style="margin:0  33px">
        <!--查询条件 -->
        <div class="row">
            <div class="col-md-9">
                <button type="button" class="btn  btn-sm green pull-right" id="addSqlSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加SQL数据源</button>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn  btn-sm green pull-right" id="addFileSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加文件型数据源</button>
            </div>
        </div>
    </div>
    <div class="source-table">
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" id="dataSourceList">
            <thead>
            <tr>
                <th>编号</th>
                <th>数据源名称</th>
                <th>数据库名称</th>
                <th>数据源类型</th>
                <th>创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="aaa">

            </tbody>
        </table>
        <div class="page-message" style="float: left">

        </div>
        <div class="page-list" style="float: right"></div>
    </div>
</div>
<div id="addSqlSourcetable" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加SQL数据源信息</h4>
            </div>
            <div class="modal-body" style="min-height: 100px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="chinaName" class="col-sm-3 control-label">数据源名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="chinaName" required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="englishName" class="col-sm-3 control-label">英文名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="englishName" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">类型</label>
                        <div class="col-sm-8">
                            <select name="" id="" class="form-control">
                                <option value="">DB2</option>
                                <option value="">Oracle</option>
                                <option value="">SqlServer</option>
                                <option value="">MySql</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="HostNum" class="col-sm-3 control-label">主机</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="HostNum">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="portNum" class="col-sm-3 control-label">端口</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="portNum">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userName" class="col-sm-3 control-label">用户名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="userName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="possword" class="col-sm-3 control-label">密码</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="possword">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal" onclick="confirmAddNode();" ><i
                        class="glyphicon glyphicon-ok"></i>添加
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<div id="addFileSourcetable" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加SQL数据源信息</h4>
            </div>
            <div class="modal-body" style="min-height: 100px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="chinaName3" class="col-sm-3 control-label">数据源名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="chinaName3" required="required" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="englishName3" class="col-sm-3 control-label">英文名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="englishName3" required="required">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">本地路径</label>
                        <div class="col-sm-8">
                            <input type="file" style="margin-bottom: 15px">
                            <input type="text" class="form-control" required="required">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn green" data-dismiss="modal" onclick="confirmAddNode();" ><i
                                class="glyphicon glyphicon-ok"></i>添加
                        </button>
                        <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<div id="EModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加数据源信息</h4>
            </div>
            <div class="modal-body" style="min-height: 100px">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="chinaName2" class="col-sm-3 control-label">数据源名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="chinaName2" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="englishName2" class="col-sm-3 control-label">数据来源</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="englishName2">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">上传位置</label>
                        <div class="col-sm-8">
                            <select name="" id="selDB" class="form-control">
                                <option value="" selected="selected">------------</option>
                                <option value="">dataOneDB</option>
                                <option value="">dataTwoDB</option>
                                <option value="">dataThreeDB</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal" onclick="confirmEditNode();" ><i
                        class="glyphicon glyphicon-ok"></i>完成
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- validation Mode -->
<div id="fileSourceModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title" id="fileSourceModalTitle">添加文件数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="addFileSource1" method="post"
                      accept-charset="utf-8" id="fileSourceForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源ID"
                                                   id="dataSourceId" name="dataSourceId" style="display: none"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">数据源名称<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceName"
                                                   name="dataSourceName"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">文件类型<span class="required">
													* </span></label>

                                        <div class="col-md-9">
                                            <select class="form-control" id="fileType" name="fileType">
                                                <option value="本地文件">本地文件</option>
                                                <option value="其他">其他</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">文件地址<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入文件地址"
                                                   id="filePath"
                                                   name="filePath"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">sss<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入文件地址"
                                                   id="ss"
                                                   name="ss"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green"><i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" id="cancelButton">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="resourceTmp1">
    {{each list as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.name}}</td>
        <td>{{value.data}}</td>
        <td>{{value.source}}</td>
        <td>{{value.time}}</td>
        <td class="upload-percent">--</td>
        <td><button type="button" class="btn btn-success" keyIdTd="{{value.id}}" >{{btnName(value.num)}}</button></td>
    </tr>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>
        <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
    <script>







        $(function(){

        });
        var editSouceID ="";
        var documentTr = null;
        /*get edit data*/
        $(".source-table").delegate("button","click",function () {
            editSouceID = $(this).attr("keyID");
            documentTr = $(this).parent().parent();
            /*$.ajax({
                type: "GET",
                url: '${ctx}/license/info',
            data: {"id": id},
            dataType: "json",
            success: function (data) {
                $("#id_edit").val(data.license.id);
                $("#name_edit").val(data.license.name);
                $("#org_edit").val(data.license.org);
                $("#content_edit").val(data.license.content);
                $('#image-edit-preview-id').attr('src', ctx + data.license.icon);
            }
        });*/
            $("#EModal").modal('show');
        })
        /*get data table*/
        function tableConfiguration(num,data) {
            data.pageNum=num;
            var conData = data;
            $.ajax({
                url:"",
                type:"GET",
                data:conData,
                success:function (data) {
                    $(".data-table").html("");
                    var DataList = JSON.parse(data);
                    var tabCon = template("resourceTmp1", DataList);
                    $("#aaa").append(tabCon);
                    if(DataList=="{}"){
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $(".page-list").html("");
                        return
                    }
                    $(".table-message").hide();
                    /*
                    * 创建table
                    * */
                    if ($(".page-list .bootpag").length != 0) {
                        $(".page-list").off();
                        $('.page-list').empty();
                    }
                    $(".page-message").html("当前第"+dataFile.pageNum +"页,共"+dataFile.totalPage +"页,共"+dataFile.totalNum+"条数据");
                    $('#page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.pageNum,
                        maxVisible: 6,
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
                        tableConfiguration(num,conData);
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }
        function confirmDeleteNode(){
            $(".form-horizontal [type='text']").val("")
            alert("ok")
        }
        function confirmEditNode(){
            documentTr.find(".source-name").text($("#chinaName2").val())
            documentTr.find(".source-DB").text($("#englishName2").val())
            documentTr.find(".source-local").text($("#selDB option:selected").text())
            $("#chinaName2").val("");
            $("#englishName2").val("")
            $("#selDB option:first").prop("selected", 'selected');
            $.ajax({
                url:"",
                type:"POST",
                data:{
                    id:editSouceID
                },
                success:function () {

                }
            })
        };
        function confirmAddNode(){
            $.ajax({

            })
        }
        $("#addSqlSource").click(function () {
            $("#fileSourceModal").modal('show');
            var $fileFrom =$('#fileSourceForm')
            handleValidation($fileFrom);

        })
        $("#addFileSource").click(function () {
            $("#addFileSourcetable").modal('show');
        })


        function handleValidation(element) {
            // for more info visit the official plugin documentation:
            // http://docs.jquery.com/Plugins/Validation
            var formValid;
            formValid = element.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    dataSourceName: {
                        required: true
                    },
                    fileType: {
                        required: true
                    },
                    filePath: {
                        required: true,
                        isFilePath: true
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

                success: function (label) {
                    label
                        .closest('.form-group').removeClass('has-error'); // set success class to the control group
                },

                submitHandler: function (form) {
                    <!--ajax  request-->
                }

            });

            $("#cancelButton").click(function () {
                console.log(123);
                formValid.resetForm();
            })


        };
        jQuery.validator.addMethod("isFilePath", function (value, element) {
            var winPath = /^[a-zA-Z]:(((\/(?! )[^/:*?<>\""|\/]+)+\/?)|(\/)?)\s*$/g;
            var lnxPath = /^([\/][\w-]+)*$/;
            return this.optional(element) || winPath.test(value) || lnxPath.test(value);
        }, "请正确填写路径");
    </script>
</div>

</html>
