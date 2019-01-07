/**
 * Created by shibaoping on 2018/10/9.
 */
var flag;

function add() {
    $('#addModal').modal('show');
    $('#jstree_show').jstree({
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
                    url: "/fileResource/resCatalogTest",
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
    })/*.bind('select_node.jstree', function (e, data) {
     var fileId = data.node.id;
     var str = fileId.replace(/%_%/g, "/")+";";
     if($("#fileMark").val()!='') {
     var previousStr = $("#fileMark").val();
     var newStr =  previousStr+str;
     $("#fileMark").val(newStr);
     alert(newStr);
     }else{
     $("#fileMark").val(str);
     alert(str);
     }
     }).bind('deselect_node.jstree', function (e, data) {
     var fileId = data.node.id;
     var str = fileId.replace(/%_%/g, "/")+";";
     if($("#fileMark").val()!='') {
     var previousStr = $("#fileMark").val();
     var newStr = previousStr.replace(str, "");
     $("#fileMark").val(newStr);
     alert(newStr);
     }
     });*/
}

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

function fileSourceAjax() {
    var nodes = $('#jstree_show').jstree("get_checked");
    $.ajax({
        type: "GET",
        url: "/drsr/fileSourceabc",
        dataType: "json",
        data: {"data": nodes},
        traditional: true,
        async: false,
        success: function (result) {
            alert(result);
        }
    })
}


function editData(dataId) {
    $('#editModal').modal('show');
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
                    url: "/fileResource/resCatalogTest",
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
    })/*.bind('select_node.jstree', function (e, data) {
     var fileId = data.node.id;
     var str = fileId.replace(/%_%/g, "/")+";";
     if($("#fileMark").val()!='') {
     var previousStr = $("#fileMark").val();
     var newStr =  previousStr+str;
     $("#fileMark").val(newStr);
     alert(newStr);
     }else{
     $("#fileMark").val(str);
     alert(str);
     }
     }).bind('deselect_node.jstree', function (e, data) {
     var fileId = data.node.id;
     var str = fileId.replace(/%_%/g, "/")+";";
     if($("#fileMark").val()!='') {
     var previousStr = $("#fileMark").val();
     var newStr = previousStr.replace(str, "");
     $("#fileMark").val(newStr);
     alert(newStr);
     }
     });*/
    $.ajax({
        type: 'post',
        url: "/fileResource/queryData",
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
                        var filepath = (jsonData[index][key]).replace(/%_%/g, "/").split(";");
                        var path = "";
                        for(var i = 0;i<filepath.length-1;i++){
                            path += '<span class="tag" style="display: inline-block">' +
                                '<span class="filePathClass">'+filepath[i]+'</span>'+'&nbsp;&nbsp;<a href="#" title="Removing tag" onclick="tagClick(this)">x</a> </span>'
                        }
                        $("#tags_tagsinput").html(path);
                        /*
                         $("#filePathE").val(jsonData[index][key]);
                         */
                    }
                    if (key == 'dataSourceId') {
                        $("#idHidden").val(jsonData[index][key]);
                    }
                }
            }
        }
    })
}

function deleteD(dataId) {
    $("#markDeleteHidden").val(dataId);
    $(".modal-backdrop").hide();
    $(".modal-content").hide();
    $(".mask").show();
    $(".deleteAlert").show();
}

function addTrue() {
    $(".addSuccess").hide();
    $(".mask").hide();
    window.location.href = "/fileResource/index";
}

function addFalse() {
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function successClose() {
    $(".addSuccess").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function falseClose() {
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function validAlertClose() {
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function validAlertTrue() {
    var dataId = $("#markDeleteHidden").val();
    $.ajax({
        type: 'post',
        url: "/fileResource/deleteData",
        data: {"dataId": dataId},
        success: function (result) {
            if (result == '1') {
                $(".mask").show();
                $(".addSuccess").show();
                window.location.href = "/fileResource/index";
            } else {
                $(".mask").show();
                $(".addFail").show();
                window.location.href = "/fileResource/index";
            }
        }
    })

}

function conFalse() {
    $(".conFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

$("#commentForm").validate({
    debug: true,//只验证不提交表单
    submitHandler: function () {
        if ($("#markAddHidden").val() != "") {

        } else {
            $("#markAddHidden").val("1");
            var nodes = $('#jstree_show').jstree("get_checked");
            var dataSourceName = $("#dataSourceName").val();
            var dataSourceType = 'file';
            var fileType = "本地文件";
            $.ajax({
                type: 'post',
                url: "/fileResource/add",
                async: true,
                traditional: true,
                data: {
                    "dataSourceName": dataSourceName,
                    "dataSourceType": dataSourceType,
                    "fileType": fileType,
                    "data": nodes
                },
                success: function (result) {
                    var jsonData = JSON.parse(result);
                    if (jsonData == '1') {
                        $(".modal-backdrop").hide();
                        $(".modal-content").hide();
                        $(".addSuccess").show();
                        $(".mask").show();
                    } else if (jsonData == '2') {
                        $("#fileError").show();
                    } else {
                        $(".modal-backdrop").hide();
                        $(".modal-content").hide();
                        $(".addFail").show();
                        $(".mask").show();
                    }
                }
            })
        }
    }
});


$("#commentEditForm").validate({
    submitHandler: function () {
        if ($("#markEditHidden").val() != "") {

        } else {
            var dataSourceId = $("#idHidden").val();
            var dataSourceName = $("#dataSourceNameE").val();
            var dataSourceType = '文件数据源';
            var fileType = '本地文件';
            var nodes = $('#jstree_show_edit').jstree("get_checked");
            var attr = [];
            $("#tags_tagsinput span").each(function (i) {
                if($(this).attr('class')=='filePathClass'){
                    attr.push($(this).text());
                }
            })
            $.ajax({
                type: 'post',
                url: "/fileResource/edit",
                async: true,
                traditional: true,
                data: {
                    "dataSourceId": dataSourceId,
                    "dataSourceName": dataSourceName,
                    "dataSourceType": dataSourceType,
                    "fileType": fileType,
                    "attr": attr,
                    "nodes":nodes
                },
                success: function (result) {
                    var jsonData = JSON.parse(result);
                    if (jsonData == '1') {
                        $("#markEditHidden").val("1");
                        $("#editModal").hide();
                        $(".addSuccess").show();
                        $(".mask").show();
                    } else if (jsonData == '2') {
                        $("#fileErrorE").show();
                    } else {
                        $("#editModal").hide();
                        $(".addFail").show();
                        $(".mask").show();
                    }
                }
            })
        }
    }
});

function conFalseClose() {
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function uploadFilesClick() {
    $(".fileIsNullAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function fileAlertClose() {
    $(".fileIsNullAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/fileResource/index";
}

function tagClick(obj){
    $(obj).parent().hide();
    $(obj).parent().text("");
}
