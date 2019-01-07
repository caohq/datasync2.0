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
    <link href="${ctx}/resources/css/projectMessage.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .form-group div{
            font-size: 18px;
        }
    </style>
</head>

<body>

<div class="page-content">

    <div class="task-head">

    </div>

    <div class="task-title">
        <span>数据节点信息认证管理</span>
    </div>

    <div class="messageCon" >

        <form class="form-horizontal">

            <div class="form-group">
                <label  class="col-sm-3 control-label">数据节点名称:</label>
                <div class="col-sm-8">${subject.subjectName}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">数据节点代码 :</label>
                <div class="col-sm-8">${subject.subjectCode}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">管理员账号:</label>
                <div class="col-sm-8">${subject.admin}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">密码:</label>
                <div class="col-sm-8">${subject.adminPasswd}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">联系人:</label>
                <div class="col-sm-8">${subject.contact}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">电话:</label>
                <div class="col-sm-8">${subject.phone}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">邮箱:</label>
                <div class="col-sm-8">${subject.email}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">FTP用户名:</label>
                <div class="col-sm-8">${subject.ftpUser}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">FTP密码:</label>
                <div class="col-sm-8">${subject.ftpPassword}</div>
            </div>

            <div class="form-group">
                <label  class="col-sm-3 control-label">描述:</label>
                <div class="col-sm-8">${subject.brief}</div>
            </div>
        </form>
    </div>
</div>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script>
        $(function(){
        });

        function tableConfiguration(num, data) {
            data.pageNum=num;
            var conData = data;
            $.ajax({
                url:"",
                type:"GET",
                data:conData,
                success:function (data) {
                    $(".data-table").html("");
                    var DataList = JSON.parse(data);
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
    </script>
</div>

</html>
