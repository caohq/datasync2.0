
<%--
  Created by IntelliJ IDEA.
  User: shibaoping
  Date: 2018/10/24
  Time: 14:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>系统</title>
    <link href="${ctx}/resources/bundles/rateit/src/rateit.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/bundles/jstree/dist/themes/default/style.css" rel="stylesheet" type="text/css">
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .custom-error{
            color:#a94442!important;
            border-color:#a94442!important;
        }
        .custom-error1{
            color:#a94442!important;
        }
        .custom-error2{
            border-color:#a94442!important;
        }
    </style>
</head>
<body>
<div class="page-content">
    <div class="source-head">
        <h3>文件数据源</h3>
        <hr>
    </div>
    <%--<div class="source-title">
        <span>文件数据源信息管理</span>
    </div>--%>
    <div class="alert alert-info" role="alert" style="margin:0  33px">
        <!--查询条件 -->
        <div class="row">
            <%--<div class="col-md-9">
                <button type="button" class="btn  btn-sm green pull-right" id="addSqlSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加SQL数据源</button>
            </div>--%>
            <div class="col-md-12">
                <button type="button" class="btn  btn-sm green pull-right" id="addFileSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;新增文件型数据源</button>
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
                <th>文件类型</th>
                <th width="30%">文件地址</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="fileBody">
            </tbody>
        </table>
        <div class="page-message" style="float: left">

        </div>
        <div class="page-list" style="float: right"></div>
    </div>
</div>
<!-- validation add Mode -->
<div id="fileSourceModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cancelButton();"></button>
                <h4 class="modal-title" id="fileSourceModalTitle">新增文件型数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal formClass" role="form" action="" method="post"
                      accept-charset="utf-8" id="fileSourceForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label for="dataSourceName" class="col-md-3 control-label"><span class="required">
													* </span>数据源名称</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceName"
                                                   name="dataSourceName"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">文件类型</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="fileType"  value="本地文件" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="filePath" class="col-md-3 control-label timeVili"><span class="required">
													* </span>文件路径</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control timeVili" placeholder="请输入文件路径"
                                                   id="filePath"
                                                   name="filePath" onblur="filePathCheck(1);"/>
                                            <div class="timeVili custom-error" style="display: none">请输入正确的文件路径</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn green" onclick="viliFileRes(this)">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- validation edit Mode -->
<div id="fileSourceEditModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="cancelButton();"></button>
                <h4 class="modal-title">编辑文件型数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal formClass" role="form" action="" method="post"
                      accept-charset="utf-8" id="fileSourceEditForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label for = "dataSourceNameE" class="col-md-3 control-label"><span class="required">
													* </span>数据源名称</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control"
                                                   id="dataSourceNameE"
                                                   name="dataSourceNameE" placeholder="请输入数据源名称"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">文件类型</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" name="fileType"  value="本地文件" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for = "filePathE" class="col-md-3 control-label timeVili"><span class="required">
													* </span>文件路径</label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control timeVili"
                                                   id="filePathE"
                                                   name="filePathE" onblur="filePathCheck(2);" placeholder="请输入文件路径"/>
                                            <div class="timeVili custom-error" style="display: none">请输入正确的文件路径</div>
                                        </div>
                                    </div>
                                    <%--<div class="form-group">
                                        <label  class="col-sm-3 control-label"><font color='red'>*</font>文件地址</label>
                                        <div class="col-sm-9">
                                            <div id="tags_tagsinput" class="tagsinput" style="border: 1px solid black" ></div>
                                            <div id="jstree_show_edit"></div>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn green" onclick="viliFileRes(this)">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="idHidden" val=""/>
<script type="text/html" id="resourceTmp1">
    {{each list as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.dataSourceName}}</td>
        <td>{{value.fileType}}</td>
        <td style="word-break: break-all">{{value.filePath}}</td>
    <%--<td style="text-align: left">
            <div style="white-space:pre-line;">
                {{splStr(value.filePath)}}
            </div>
        </td>--%>
        <td>{{value.createTime}}</td>
        <td>
            <button type="button" class="btn btn-success btn-xs purple " onclick="editData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-edit"></i>&nbsp;编辑</button>
            <button type="button" class="btn btn-success btn-xs red" onclick="deleteData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>
        <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
        <script src="${ctx}/resources/bundles/jstree/dist/jstree.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.min.js"></script>
    <script>
        $(function(){
            tableConfiguration();
        });
        /*get data table*/



        function tableConfiguration(num) {
            $.ajax({
                url:"${ctx}/fileResource/indexPages",
                type:"GET",
                data:{"num":num},
                success:function (data) {
                    var DataList = JSON.parse(data)
                    var fileData = {
                        list:DataList.fileDataOfThisPage
                    }
                    console.log(DataList.list)
                    var tabCon = template("resourceTmp1", fileData);
                    $("#fileBody").html("");
                    $("#fileBody").append(tabCon);
                    if(DataList.fileDataOfThisPage=="{}"||DataList.fileDataOfThisPage==null){
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
                    $(".page-message").html("当前第<span style='color:blue'>"+DataList.currentPage +"</span>页,共<span style='color:blue'>"+DataList.totalPage +"</span>页,共<span style='color:blue'>"+DataList.totalNum+"</span>条数据");
                    $('.page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.currentPage,
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
                        tableConfiguration(num);
                    });
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        }

        template.helper("splStr",function (str) {
            var str1 = str.replace(/;/g,"\n");
            return str1;
        })
        var validData ={
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                dataSourceName: {
                    required: true
                },
                filePath: {
                    required: true
                },
                filePathE: {
                    required: true
                },
                dataSourceNameE: {
                    required: true
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

        }
        $("#fileSourceForm").validate(validData)

        function viliFileRes(obj){
            var filePath =$("#filePath").val();
            var filePathE =$("#filePathE").val();
            var formId = $(obj).parent().parent().attr("id");
            if(formId=="fileSourceForm"){
                if(!$("#fileSourceForm").valid()){
                    return
                }
                filePath = filePath.replace("\/", "%_%");
                filePath = filePath.replace("\\", "%_%");
            }else {
                if(!$("#fileSourceEditForm").valid()){
                    return
                }
                filePathE = filePathE.replace("\/", "%_%");
                filePathE = filePathE.replace("\\", "%_%");
                filePath = filePathE;
            }
            $.ajax({
                url:"${ctx}/fileResource/check",
                type:"post",
                data:{
                    filePath:filePath
                },
                success:function (data) {
                    var jsonData = JSON.parse(data)
                    if(jsonData==false){
                        $(".timeVili:eq(0)").addClass("custom-error1")
                        $(".timeVili:eq(1)").addClass("custom-error2")
                        $(".timeVili:eq(2)").show()
                        return
                    }else {
                        var formName = formId;
                        if (formName == 'fileSourceEditForm') {
                            var dataSourceId = $("#idHidden").val();
                            var dataSourceName = $("#dataSourceNameE").val();
                            var filePath = $("#filePathE").val();
                            filePath= filePath.replace("\/", "%_%");
                            filePath= filePath.replace("\\", "%_%");

                            var dataSourceType = 'file';
                            var fileType = '本地文件';
                            /*var nodes = $('#jstree_show_edit').jstree("get_checked");
                            for (var index in jsonData) {
                                for (var key in jsonData[index]) {

                                }
                            }
                            nodes.replaceAll("/","%_%");
                            var tags_tagsinput = $("#tags_tagsinput").text();
                            if((nodes.length==0)&&(tags_tagsinput.length==0)){
                                toastr["error"]("您尚未选取文件");
                            }else{
                            var attr = [];
                            $("#tags_tagsinput span").each(function (i) {
                                if($(this).attr('class')=='filePathClass'){
                                    attr.push($(this).text());
                                }
                            })*/
                            $.ajax({
                                type: 'post',
                                url: "${ctx}/fileResource/edit",
                                async: true,
                                traditional: true,
                                data: {
                                    "dataSourceId": dataSourceId,
                                    "dataSourceName": dataSourceName,
                                    "dataSourceType": dataSourceType,
                                    "fileType": fileType,
                                    "filePath":filePath
                                    /*"attr": attr,
                                    "nodes":nodes*/
                                },
                                success: function (result) {
                                    var jsonData = JSON.parse(result);
                                    if (jsonData == '1') {
                                        toastr["success"]("编辑成功");
                                        $('#fileSourceEditModal').modal('hide');
/*
                                        formValid.resetForm();
*/
                                        tableConfiguration();
                                    } else {
                                        toastr["error"]("编辑失败");
                                    }
                                }
                            })
                        }
                        else {
                            var dataSourceName = $("#dataSourceName").val();
                            var dataSourceType = 'file';
                            var fileType = "本地文件";
                            var filePath = $("#filePath").val();
                            filePath= filePath.replace("\/", "%_%");
                            filePath= filePath.replace("\\", "%_%");
                            /*if(nodes.length==0){
                                toastr["error"]("您尚未选取文件");
                            }else{*/
                            $.ajax({
                                type: 'post',
                                url: "${ctx}/fileResource/add",
                                async: true,
                                traditional: true,
                                data: {
                                    "dataSourceName": dataSourceName,
                                    "dataSourceType": dataSourceType,
                                    "fileType": fileType,
                                    "filePath":filePath
                                    /*
                                                                    "data": nodes
                                    */
                                },
                                success: function (result) {
                                    var jsonData = JSON.parse(result);
                                    if (jsonData == '1') {
                                        toastr["success"]("新增成功");
                                        $('#fileSourceModal').modal('hide');
/*
                                        formValid.resetForm();
*/
                                        tableConfiguration();
                                    } else {
                                        toastr["error"]("新增失败");
                                    }
                                }
                            })
                        }
                    }

                }
            })



        }

        $("#addFileSource").click(function () {
            $("#fileSourceModal").modal('show');
            /*$('#jstree_show').jstree({
                "core": {
                    "themes": {
                        "responsive": false,
                    },
                    // so that create works
                    "check_callback": true,
                    'data': function (obj, callback) {
                        var jsonstr = "[]";
                        var jsonarray = eval('(' + jsonstr + ')');
                        var children;
                        if (obj != '#') {
                            var str = obj.id;
                            var str1 = str.replace(/%_%/g, "/");
                        }
                        $.ajax({
                            type: "GET",
                            url: "${ctx}/fileResource/resCatalogTest",
                            dataType: "json",
                            data: {"data": str1},
                            async: false,
                            success: function (result) {
                                var arrays = result;
                                for (var i = 0; i < arrays.length; i++) {
                                    console.log(arrays[i])
                                    var arr = {
                                        "id": arrays[i].id,
                                        "parent": arrays[i].parentId == "root" ? "#" : arrays[i].parentId,
                                        "text": arrays[i].name,
                                        "type": arrays[i].type,
                                        "children":arrays[i].children
                                    }
                                    jsonarray.push(arr);
                                    children = jsonarray;
                                }
                            }

                        });
                        generateChildJson(children);
                        callback.call(this, children);
                        /!*else{
                         callback.call(this,);
                         }*!/
                    }
                },
                "types": {
                    "default": {
                        "icon": "glyphicon glyphicon-flash"
                    },
                    "file": {
                        "icon": "glyphicon glyphicon-ok"
                    }
                },
                "plugins": ["dnd"/!*, "state"*!/, "types", "checkbox", "wholerow"]
            })*/
            /*var $sqlFrom =$('#fileSourceForm')
            handleValidation($sqlFrom);*/
        })

        function generateChildJson(childArray) {
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.type == 'directory') {
                    /*
                     child.children = true;
                     */
                    child.icon = "jstree-folder";
                } else {
                    child.icon = "jstree-file";
                }
            }
        }

        //编辑文件数据源
       function editData(dataId) {
           $('#jstree_show_edit').jstree({
           "core": {
               "themes": {
                   "responsive": false,
               },
               // so that create works
               "check_callback": true,
               'data': function (obj, callback) {
                   var jsonstr = "[]";
                   var jsonarray = eval('(' + jsonstr + ')');
                   var children;
                   if (obj != '#') {
                       var str = obj.id;
                       var str1 = str.replace(/%_%/g, "/");
                   }
                   $.ajax({
                       type: "GET",
                       url: "${ctx}/fileResource/resCatalogTest",
                       dataType: "json",
                       data: {"data": str1},
                       async: false,
                       success: function (result) {
                           var arrays = result;
                           for (var i = 0; i < arrays.length; i++) {
                               console.log(arrays[i])
                               var arr = {
                                   "id": arrays[i].id,
                                   "parent": arrays[i].parentId == "root" ? "#" : arrays[i].parentId,
                                   "text": arrays[i].name,
                                   "type": arrays[i].type,
                                   "children":arrays[i].children
                               }
                               jsonarray.push(arr);
                               children = jsonarray;
                           }
                       }

                   });
                   generateChildJson(children);
                   callback.call(this, children);
                   /*else{
                    callback.call(this,);
                    }*/
               }
           },
           "types": {
               "default": {
                   "icon": "glyphicon glyphicon-flash"
               },
               "file": {
                   "icon": "glyphicon glyphicon-ok"
               }
           },
           "plugins": ["dnd"/*, "state"*/, "types", "checkbox", "wholerow"]
       })
           $.ajax({
               type: 'post',
               url: "${ctx}/fileResource/queryData",
               data: {"dataId": dataId},
               success: function (result) {
                   var jsonData = JSON.parse(result);
                   //var Data = jsonData.substring(1,jsonData.length-1);
                   var dataSourceName = jsonData.dataSourceName;
                   for (var index in jsonData) {
                       for (var key in jsonData[index]) {
                           if (key == 'dataSourceName') {
                               $("#dataSourceNameE").val(jsonData[index][key]);
                           }
                           if (key == 'dataSourceType') {
                               $("#dataSourceTypeE").val(jsonData[index][key]);
                           }
                           if (key == 'databaseName') {
                               $("#dataBaseNameE").val(jsonData[index][key]);
                           }
                           if (key == 'databaseType') {
                               $("#dataBaseTypeE").val(jsonData[index][key]);
                           }
                           if (key == 'filePath') {
                               $("#filePathE").val(jsonData[index][key]);
                               /*var filepath = (jsonData[index][key]).replace(/%_%/g, "/").split(";");
                               var path = "";
                               for(var i = 0;i<filepath.length-1;i++){
                                   path += '<span class="tag" style="display: inline-block">' +
                                           '<span class="filePathClass">'+filepath[i]+'</span>'+'&nbsp;&nbsp;<a href="#" title="Removing tag" onclick="tagClick(this)">x</a> </span>'
                               }
                               $("#tags_tagsinput").html(path);*/
                           }
                           if (key == 'dataSourceId') {
                               $("#idHidden").val(jsonData[index][key]);
                           }
                       }
                   }
               }
           })
            $("#fileSourceEditModal").modal('show');
            var $fileFrom =$('#fileSourceEditForm');
            /*handleValidation($fileFrom);*/
        }

        //删除文件数据源
        function deleteData(dataId) {
            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>",function (r) {
                if(r){
                    $.ajax({
                        type: 'post',
                        url: "${ctx}/fileResource/deleteData",
                        data: {"dataId": dataId},
                        success: function (result) {
                            var res = JSON.parse(result);
                            if (res == '1') {
                                toastr["success"]("删除成功");
                                tableConfiguration();
                            } else {
                                toastr["error"]("删除失败");
                            }
                        }
                    })
                }else{

                }
            })
        }

        function tagClick(obj){
            $(obj).parent().hide();
            $(obj).parent().text("");
        }

       /* function handleValidation(element) {
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
                    filePath: {
                        required: true
                    },
                    filePathE: {
                        required: true
                    },
                    dataSourceNameE: {
                        required: true
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

                }

            });
        };*/
        /*function cancelButton() {
            $("#fileSourceForm").validate().resetForm();
            $("#fileSourceForm").validate().clean();
            $('.form-group').removeClass('has-error');
        }*/
        function filePathCheck(id){
            var filePath;
            if(id=="1") {
                filePath = $("#filePath").val();
                filePath = filePath.replace("/\//g", "%_%");
                filePath = filePath.replace("/\\/g", "%_%");
            }else{
                filePath = $("#filePathE").val();
                filePath = filePath.replace("/\//g", "%_%");
                filePath = filePath.replace("/\\/g", "%_%");
            }
            $.ajax({
                type: "GET",
                url: "${ctx}/fileResource/check",
                dataType: "json",
                data: {"filePath": filePath},
                async: false,
                success: function (result) {
                    if(result){
                        if(id=="1") {
                            $(".timeVili:eq(0)").removeClass("custom-error1")
                            $(".timeVili:eq(1)").removeClass("custom-error2")
                            $(".timeVili:eq(2)").hide()
                        }else{
                            $(".timeVili:eq(3)").removeClass("custom-error1")
                            $(".timeVili:eq(4)").removeClass("custom-error2")
                            $(".timeVili:eq(5)").hide()
                        }
                    }else{
                        if(id=="1") {
                            $(".timeVili:eq(0)").addClass("custom-error1")
                            $(".timeVili:eq(1)").addClass("custom-error2")
                            $(".timeVili:eq(2)").show()
                        }else{
                            $(".timeVili:eq(3)").addClass("custom-error1")
                            $(".timeVili:eq(4)").addClass("custom-error2")
                            $(".timeVili:eq(5)").show()
                        }
                    }
                }

            });
        }
        $("#filePath").on("focus",function () {
            $(".timeVili:eq(0)").removeClass("custom-error1")
            $(".timeVili:eq(1)").removeClass("custom-error2")
            $(".timeVili:eq(2)").hide()
        })
        $("#filePathE").on("focus",function () {
            $(".timeVili:eq(3)").removeClass("custom-error1")
            $(".timeVili:eq(4)").removeClass("custom-error2")
            $(".timeVili:eq(5)").hide()
        })
        function cancelButton() {
            $("#fileSourceForm").validate().resetForm();
            $("#fileSourceForm").validate().clean();
            $('.form-group').removeClass('has-error');
            $(".timeVili:eq(0)").removeClass("custom-error1")
            $(".timeVili:eq(1)").removeClass("custom-error2")
            $(".timeVili:eq(2)").hide()
            $(".timeVili:eq(3)").removeClass("custom-error1")
            $(".timeVili:eq(4)").removeClass("custom-error2")
            $(".timeVili:eq(5)").hide()
        }
    </script>
</div>

</html>
