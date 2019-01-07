/**
 * Created by shibaoping on 2018/10/9.
 */
var flag;

function add() {
    $('#addModal').modal('show');
}
function editData(dataId) {
    $.ajax({
        type:'post',
        url: "/relationship/queryData",
        data:{"dataId":dataId},
        success: function(result) {
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
                    if (key == 'host') {
                        $("#hostE").val(jsonData[index][key]);
                    }
                    if (key == 'port') {
                        $("#portE").val(jsonData[index][key]);
                    }
                    if (key == 'userName') {
                        $("#userNameE").val(jsonData[index][key]);
                    }
                    if (key == 'password') {
                        $("#passwordE").val(jsonData[index][key]);
                    }
                    if (key == 'dataSourceId'){
                        $("#idHidden").val(jsonData[index][key]);
                    }
                }
            }
        }
    })
    $('#editModal').modal('show');
}
function deleteD(dataId) {
   $("#markDeleteHidden").val(dataId);
    $(".modal-content").hide();
    $(".mask").show();
    $(".deleteAlert").show();
}

function addTrue(){
    $(".addSuccess").hide();
    $(".mask").hide();
    window.location.href = "/relationship/indexTest";
}

function addFalse(){
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

function successClose(){
    $(".addSuccess").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

function falseClose(){
    $(".addFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

function validAlertClose(){
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

function validAlertTrue(){
var dataId = $("#markDeleteHidden").val();
        $.ajax({
            type:'post',
            url: "/relationship/deleteData",
            data:{"dataId":dataId},
            success: function(result){
                if(result=='1'){
                    $(".mask").show();
                    $(".addSuccess").show();
                    window.location.href = "/relationship/indexTest";
                }else{
                    $(".mask").show();
                    $(".addFail").show();
                    window.location.href = "/relationship/indexTest";
                }
            }
        })

}

function conFalse(){
    $(".conFail").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

    $("#commentForm").validate({
        debug: true,//只验证不提交表单
        onfocusout: function(element) {
            $(element).valid();
        },
        submitHandler: function () {
            if ($("#markAddHidden").val() != "") {

            } else {
                var dataSourceName = $("#dataSourceName").val();
                var dataSourceType = $("#dataSourceType").val();
                var dataBaseName = $("#databaseName").val();
                var dataBaseType = $("#dataBaseType").val();
                var host = $("#host").val();
                var port = $("#port").val();
                var userName = $("#userName").val();
                var password = $("#password").val();
                $.ajax({
                    type: 'post',
                    url: "/relationship/add",
                    async: false,
                    data: {
                        "dataSourceName": dataSourceName,
                        "dataSourceType": dataSourceType,
                        "dataBaseName": dataBaseName,
                        "dataBaseType": dataBaseType,
                        "host": host,
                        "port": port,
                        "userName": userName,
                        "password": password
                    },
                    success: function (result) {
                        var jsonData = JSON.parse(result);
                        if (jsonData == '1') {
                            $("#markAddHidden").val("1");
                            $(".modal-backdrop").hide()
                            $(".modal-content").hide();
                            $(".addSuccess").show();
                            $(".mask").show();
                        } else if (jsonData == '2') {
                            $("#databaseError").show();
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
        onfocusout: function(element) {
               $(element).valid();
           },
        submitHandler: function () {
            if ($("#markEditHidden").val() != "") {

            } else {
                var dataSourceName = $("#dataSourceNameE").val();
                var dataSourceType = $("#dataSourceTypeE").val()
                var dataBaseName = $("#dataBaseNameE").val();
                var dataBaseType = $("#dataBaseTypeE").val();
                var host = $("#hostE").val();
                var port = $("#portE").val();
                var userName = $("#userNameE").val();
                var password = $("#passwordE").val();
                var dataSourceId = $("#idHidden").val();
                $.ajax({
                    type: 'post',
                    async: false,
                    url: "/relationship/edit",
                    data: {
                        "dataSourceName": dataSourceName,
                        "dataSourceType" : dataSourceType,
                        "dataBaseName": dataBaseName,
                        "dataBaseType": dataBaseType,
                        "host": host,
                        "port": port,
                        "userName": userName,
                        "password": password,
                        "dataSourceId": dataSourceId,
                    },
                    success: function (result) {
                        var jsonData = JSON.parse(result);
                        if (jsonData == '1') {
                            $("#markEditHidden").val("1");
                            $("#editModal").hide();
                            $(".addSuccess").show();
                            $(".mask").show();
                        }else if(jsonData == '2') {
                            $("#databaseErrorE").show();
                        }else {
                            $("#editModal").hide();
                            $(".addFail").show();
                            $(".mask").show();
                        }
                    }
                })
            }
        }
    });

function conFalseClose(){
    $(".deleteAlert").hide();
    $(".mask").hide();
    $(".modal-backdrop").hide();
    window.location.href = "/relationship/indexTest";
}

function testAddSubmit(){
    $("#commentForm").validate({
        debug: true,//只验证不提交表单
        onfocusout: function(element) {
            $(element).valid();
        },
        submitHandler: function () {
            if ($("#markAddHidden").val() != "") {

            } else {
                var dataSourceName = $("#dataSourceName").val();
                var dataSourceType = $("#dataSourceType").val();
                var dataBaseName = $("#databaseName").val();
                var dataBaseType = $("#dataBaseType").val();
                var host = $("#host").val();
                var port = $("#port").val();
                var userName = $("#userName").val();
                var password = $("#password").val();
                $.ajax({
                    type: 'post',
                    url: "/relationship/add",
                    async: false,
                    data: {
                        "dataSourceName": dataSourceName,
                        "dataSourceType": dataSourceType,
                        "dataBaseName": dataBaseName,
                        "dataBaseType": dataBaseType,
                        "host": host,
                        "port": port,
                        "userName": userName,
                        "password": password
                    },
                    success: function (result) {
                        var jsonData = JSON.parse(result);
                        if (jsonData == '1') {
                            $("#markAddHidden").val("1");
                            $(".modal-backdrop").hide()
                            $(".modal-content").hide();
                            $(".addSuccess").show();
                            $(".mask").show();
                        } else if (jsonData == '2') {
                            $("#databaseError").show();
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

}

