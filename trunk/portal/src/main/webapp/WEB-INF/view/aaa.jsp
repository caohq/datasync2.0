<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/25
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue" id="form_wizard_1">
                <div class="portlet-title" style="background-color:#3fd5c0">
                    <div class="caption">
                        <i class="fa fa-gift"></i> 静态数据注册 - <span class="step-title">第 1 步，共 2 步</span>
                    </div>
                </div>
                <div class="portlet-body form">
                    <div class="form-wizard">
                        <div class="form-body">
                            <ul class="nav nav-pills nav-justified steps">
                                <li class="active">
                                    <a href="#tab1" data-toggle="tab" class="step" aria-expanded="true">
												<span class="number">
												1 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 静态数据内容描述 </span>
                                    </a>
                                </li>
                                <li class="">
                                    <a href="#tab2" data-toggle="tab" class="step" aria-expanded="false">
												<span class="number">
												2 </span>
                                        <span class="desc">
												<i class="fa fa-check"></i> 核心元数据填写 </span>
                                    </a>
                                </li>
                            </ul>
                            <div id="bar" class="progress progress-striped" role="progressbar">
                                <div class="progress-bar progress-bar-success" style="width: 50%;">
                                </div>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab1" style="">
                                    <form class="form-horizontal" id="submit_form" enctype="multipart/form-data" method="POST" novalidate="novalidate">

                                        <div class="alert alert-danger display-hide">
                                            <button class="close" data-close="alert"></button>
                                            表单填写有误，请检查
                                        </div>

                                        <div class="alert alert-success display-hide">
                                            <button class="close" data-close="alert"></button>
                                            表单保存成功!
                                        </div>

                                        <input type="hidden" name="resourceId" id="resourceId" value="269">
                                        <input type="hidden" name="resState" id="resState" value="未完成">
                                        <h3 class="block">静态数据描述信息</h3>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">静态数据名称 <span class="required" aria-required="true">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="resTitle" id="resTitle" onchange="setResTitle(this)" aria-required="true" aria-describedby="resTitle-error"><span id="resTitle-error" class="help-block help-block-error"></span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">数据图片
                                            </label>
                                            <div class="col-md-9">
                                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                                    <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;">
                                                    </div>
                                                    <div>
                                                            <span class="btn default btn-file">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <span class="fileinput-exists">
                                                            换一个</span>
                                                            <input id="imagePath" type="file" name="imageFile">
                                                            </span>
                                                        <a href="#" class="btn red fileinput-exists" data-dismiss="fileinput">
                                                            删除 </a>
                                                    </div>
                                                </div>
                                                <div class="clearfix margin-top-10">
												<span class="label label-danger">
												注意! </span>
                                                    图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                    Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group dataLicenseInputGroup">
                                            <label class="control-label col-md-3">许可协议 <span class="required" aria-required="true">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <select class="form-control dataLicense" name="license" id="dataLicenseID"><option value="53">CC-BY-SA</option><option value="52">CC-BY-NC</option><option value="51">CC-BY</option></select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">发布到<span class="required" aria-required="true">
													* </span></label>
                                            <div class="checkbox-list col-md-6">
                                                <label class="checkbox-inline">
                                                    <div class="checker" id="uniform-centerCheckbox"><span class="checked"><input type="checkbox" id="centerCheckbox" name="catalogCheckbox" value="center" aria-required="true" aria-describedby="catalogCheckbox-error catalogCheckbox-error catalogCheckbox-error catalogCheckbox-error"></span></div> 中心门户</label>
                                                <label class="checkbox-inline">
                                                    <div class="checker" id="uniform-localCheckbox"><span><input type="checkbox" id="localCheckbox" name="catalogCheckbox" value="local"></span></div> 本地门户 </label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">分类选择
                                            </label>
                                            <div class="col-md-4" id="cemterCatalogDiv" style="display:none">
                                                <input type="hidden" name="centerCatalogId" id="centerCatalogId">
                                                <div id="jstree-demo" class="jstree jstree-1 jstree-default" role="tree"><ul class="jstree-container-ul jstree-children"><li role="treeitem" aria-expanded="true" id="1" class="jstree-node  jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>中心资源目录</a><ul role="group" class="jstree-children"><li role="treeitem" aria-expanded="true" id="15" class="jstree-node  jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>计算机</a><ul role="group" class="jstree-children"><li role="treeitem" id="29" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>技术讨论</a></li><li role="treeitem" id="28" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>算法研究</a></li><li role="treeitem" id="27" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>软件开发21</a></li><li role="treeitem" id="30" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>New node1</a></li></ul></li><li role="treeitem" id="26" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>物理学</a></li><li role="treeitem" aria-expanded="true" id="17" class="jstree-node  jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>生物</a><ul role="group" class="jstree-children"><li role="treeitem" id="25" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>化学生物</a></li></ul></li><li role="treeitem" aria-expanded="true" id="16" class="jstree-node  jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>金融</a><ul role="group" class="jstree-children"><li role="treeitem" id="19" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>审计</a></li><li role="treeitem" id="18" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>精算</a></li></ul></li></ul></li></ul></div>
                                            </div>
                                            <div class="col-md-4" id="localCatalogDiv" style="display:none">
                                                <input type="hidden" name="localCatalogId" id="localCatalogId">
                                                <div id="localjstree-demo" class="jstree jstree-2 jstree-default" role="tree"><ul class="jstree-container-ul jstree-children"><li role="treeitem" aria-expanded="true" id="1" class="jstree-node  jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>本地资源目录</a><ul role="group" class="jstree-children"><li role="treeitem" aria-expanded="true" id="15" class="jstree-node  jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>软件工程</a><ul role="group" class="jstree-children"><li role="treeitem" id="27" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>软件开发2</a></li><li role="treeitem" id="28" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>算法研究</a></li><li role="treeitem" id="29" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>技术讨论</a></li><li role="treeitem" id="30" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>学术交流</a></li></ul></li><li role="treeitem" aria-expanded="true" id="16" class="jstree-node  jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>经济</a><ul role="group" class="jstree-children"><li role="treeitem" id="18" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#" style="width:200px"><i class="jstree-icon jstree-themeicon jstree-folder jstree-themeicon-custom"></i>精算</a></li></ul></li></ul></li></ul></div>
                                            </div>
                                        </div>

                                        <!--       20181102 wzj          <div class="form-group">
                                                             <label class="control-label col-md-3">下载使用说明 <span class="required">
                                                                     * </span>
                                                             </label>
                                                             <div class="col-md-4">
                                                                 <textarea type="text" class="form-control" name="description"
                                                                           rows="3"></textarea>
                                                             </div>
                                                         </div>
                                                         -->
                                        <div class="form-group" style="display: none">
                                            <label class="control-label col-md-3">数据源id <span class="required" aria-required="true">
													* </span>
                                            </label>
                                            <div class="col-md-4">
                                                <input type="text" class="form-control" name="dataSourceId" id="dataSourceId">
                                            </div>
                                        </div>
                                        <!--       20181102 wzj                <div class="form-group">
                                                        <label class="control-label col-md-3">数据量描述 <span class="required">
                                                                * </span>
                                                        </label>
                                                        <div class="col-md-4">
                                                            <input type="text" class="form-control" name="dataSize"/>
                                                        </div>
                                                    </div>
                                                    -->
                                        <!--去掉该功能 20171102 wzj-->
                                        <!--  <div class="form-group">
                                              <label class="control-label col-md-3">封装类型<span class="required">
                                                      * </span>
                                              </label>
                                              <div class="col-md-4">
                                                  <div class="radio-list" data-error-container="#packType_error">
                                                      <label>
                                                          <input type="radio" name="packType" id="online"
                                                                 value="线上资源"/>
                                                          线上资源 </label>
                                                      <label>
                                                          <input type="radio" name="packType" id="offline"
                                                                 value="线下资源"/>
                                                          线下资源 </label>
                                                  </div>
                                                  <div id="packType_error">
                                                  </div>
                                              </div>
                                          </div>-->

                                        <div id="onlineDiv"><div class="form-group"><label class="control-label col-md-3">静态数据类型<span class="required" aria-required="true"> * </span> </label> <div class="col-md-4"> <div class="radio-list" data-error-container="#resourceType_error"> <label style="padding-top: 7px;display: inline-block"> <input type="radio" name="resourceType" id="relationalDatabase" value="关系数据源" onclick="showRelationalTable(1)" aria-required="true" aria-describedby="resourceType-error" aria-invalid="false"> 关系数据源 </label> <label style="padding-top: 7px;display: inline-block;margin-left: 34px"> <input type="radio" name="resourceType" id="fileSource" onclick="showFileSource(1)" value="文件数据源"> 文件数据源 </label> </div> <div id="resourceType_error"><span id="resourceType-error" class="help-block help-block-error"></span></div> </div></div></div>

                                        <div id="resourceChooseDiv"><div class="form-group"> <label class="control-label col-md-3">数据源名称 </label><label class="col-md-3" style="padding-top: 9px">10.0.86.78_usdr </label> </div><div class="form-group"><label class="control-label col-md-3">选择表资源</label><div class="col-md-9"><div class="icheck-list" style="padding-top: 7px"><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'avatar','dataResource')" value="avatar">&nbsp;avatar</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'client','dataResource')" value="client" coms="[{&quot;tableName&quot;:&quot;client&quot;,&quot;tableInfos&quot;:[{&quot;columnName&quot;:&quot;id&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;int&quot;},{&quot;columnName&quot;:&quot;username&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;client_secret&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;status&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;description&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;client_id&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;client_callback&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;reg_date&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;datetime&quot;},{&quot;columnName&quot;:&quot;client_name&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;},{&quot;columnName&quot;:&quot;client_url&quot;,&quot;columnNameLabel&quot;:&quot;&quot;,&quot;columnComment&quot;:&quot;&quot;,&quot;dataType&quot;:&quot;varchar&quot;}]}]">&nbsp;client</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_classification','dataResource')" value="t_classification">&nbsp;t_classification</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_coi','dataResource')" value="t_coi">&nbsp;t_coi</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_coi_user','dataResource')" value="t_coi_user">&nbsp;t_coi_user</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_group','dataResource')" value="t_group">&nbsp;t_group</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_group_user','dataResource')" value="t_group_user">&nbsp;t_group_user</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_log','dataResource')" value="t_log">&nbsp;t_log</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_metastruct','dataResource')" value="t_metastruct">&nbsp;t_metastruct</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_metastruct_copy','dataResource')" value="t_metastruct_copy">&nbsp;t_metastruct_copy</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_rank','dataResource')" value="t_rank">&nbsp;t_rank</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_sysrole','dataResource')" value="t_sysrole">&nbsp;t_sysrole</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_system','dataResource')" value="t_system">&nbsp;t_system</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_user','dataResource')" value="t_user">&nbsp;t_user</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_user_2016','dataResource')" value="t_user_2016">&nbsp;t_user_2016</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_user_copy','dataResource')" value="t_user_copy">&nbsp;t_user_copy</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_user_role','dataResource')" value="t_user_role">&nbsp;t_user_role</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'t_verifycode','dataResource')" value="t_verifycode">&nbsp;t_verifycode</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'token','dataResource')" value="token">&nbsp;token</label><label class="col-md-4" style="padding-left: 0px"><input type="checkbox" name="mapTable" onclick="staticSourceTableChoice(1,this,3,'user_count','dataResource')" value="user_count">&nbsp;user_count</label></div><input type="text" class="form-control" name="maptableinput" id="maptableinput" style="display:none;"></div></div></div>

                                        <div id="generateRelationalDatabase"></div>

                                        <div id="showSqlStr"><div class="form-group"> <label class="control-label col-md-3">sql查询 </label> <div class="col-md-4"> <input type="text" class="form-control" name="sqlStr" id="sqlStr" onchange="validSqlStr(this.value,this.id)"> </div><div class="col-md-5" style="margin-top:7px"><a onclick="editSqlFieldComs(0)">编辑预览&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="newSqlStr()"><span class="glyphicon glyphicon-plus"></span>&nbsp;sql查询</a></div></div></div>

                                        <div id="offlineDiv">
                                        </div>


                                    </form>
                                </div>
                                <div class="tab-pane" id="tab2" style="">
                                    <form action="#" id="coreMetaForm">
                                        <div class="form-body">

                                            <!-- xiajl20171109 选择元数据模板 -->



                                            <!-- xiajl20171109 元数据模块基础信息相关 -->
                                            <div class="row" style="padding-top:20px;padding-bottom:20px;">
                                                <div>
                                                    <div class="col-md-12">
                                                        <div class="checker" id="uniform-isSelectTemplate"><span><input type="checkbox" id="isSelectTemplate" name="isSelectTemplate"></span></div>选择从模板中填写数据
                                                    </div>
                                                </div>
                                                <div id="divSelectTemplate" style="display:none;">

                                                    <div class="table-scrollable">
                                                        <table class="table table-striped table-bordered table-advance table-hover">
                                                            <thead>
                                                            <tr>
                                                                <th style="width: 6%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">编号</th>
                                                                <th style="width: 26%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">
                                                                    元数据模板名称
                                                                </th>
                                                                <th style="text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建人</th>
                                                                <th style="width: 20%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">创建时间</th>
                                                                <th style="text-align: center;background: #64aed9;color: #FFF;font-weight: bold">备注</th>
                                                                <th style="width: 22%;text-align: center;background: #64aed9;color: #FFF;font-weight: bold">操作</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody id="metaTemplateList">
                                                            <tr>
                                                                <td style="text-align: center">1</td>
                                                                <td><a href="javascript:viewData('27');">20171118元数sssssdsssssssss</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-16 16:55:35</td>
                                                                <td style="text-align: center">元数据模板</td>
                                                                <td id="27" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('27')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">2</td>
                                                                <td><a href="javascript:viewData('26');">sxx元数据模板ssiii</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-10 17:03:36</td>
                                                                <td style="text-align: center">测试用的元数据模板</td>
                                                                <td id="26" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('26')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">3</td>
                                                                <td><a href="javascript:viewData('25');">222元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-10 16:28:48</td>
                                                                <td style="text-align: center">元数据模板2017</td>
                                                                <td id="25" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('25')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">4</td>
                                                                <td><a href="javascript:viewData('24');">第三方接口服务元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-09 11:12:42</td>
                                                                <td style="text-align: center">第三方接口服务元数据模板</td>
                                                                <td id="24" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('24')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">5</td>
                                                                <td><a href="javascript:viewData('23');">元数据模板20181111</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-09 11:11:15</td>
                                                                <td style="text-align: center">元数据模板20181111</td>
                                                                <td id="23" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('23')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">6</td>
                                                                <td><a href="javascript:viewData('21');">静态数据xiajl20171108元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-08 17:36:47</td>
                                                                <td style="text-align: center">静态数据xiajl1108元数据模板</td>
                                                                <td id="21" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('21')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">7</td>
                                                                <td><a href="javascript:viewData('20');">数据服务xiajl20171109元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-08 17:33:12</td>
                                                                <td style="text-align: center">数据服务xiajl1109元数据模板</td>
                                                                <td id="20" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('20')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">8</td>
                                                                <td><a href="javascript:viewData('19');">第三方接口服务xiajlOK元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-08 17:28:09</td>
                                                                <td style="text-align: center">第三方接口服务OK元数据模板</td>
                                                                <td id="19" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('19')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">9</td>
                                                                <td><a href="javascript:viewData('18');">sss元数据模板测试2019</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-06 10:00:35</td>
                                                                <td style="text-align: center">元数据模板测试2019</td>
                                                                <td id="18" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('18')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center">10</td>
                                                                <td><a href="javascript:viewData('17');">第三方接口服务xiajl20171105元数据模板</a>
                                                                </td>
                                                                <td style="text-align: center">admin</td>
                                                                <td style="text-align: center">2017-11-05 22:17:02</td>
                                                                <td style="text-align: center">xxxeee</td>
                                                                <td id="17" style="text-align: center">
                                                                    <button type="button" class="btn default btn-xs purple updateButton" onclick="selectData('17')"><i class="fa fa-edit"></i>&nbsp;&nbsp;选择
                                                                    </button>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="row margin-top-20">
                                                        <div class="col-md-6 margin-top-20">
                                                            当前第<span style="color:blue;" id="currentPageNo">1</span>页,共<span style="color:blue;" id="totalPages">3</span>页,<span style="color:blue;" id="totalCount">25</span>条数据
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div id="pagination" style="float: right"><ul class="pagination bootpag"><li data-lp="1" class="prev disabled"><a href="javascript:void(0);">«</a></li><li data-lp="1" class="disabled"><a href="javascript:void(0);">1</a></li><li data-lp="2"><a href="javascript:void(0);">2</a></li><li data-lp="3"><a href="javascript:void(0);">3</a></li><li data-lp="2" class="next"><a href="javascript:void(0);">»</a></li></ul></div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="note note-success">
                                                <h4 class="block">核心元数据</h4>
                                                <p id="rootDescription">定义了空军装备论证数据发现元数据关于数据集的描述信息</p>
                                            </div>
                                            <div id="coreMetaTree" class="tree-demo jstree jstree-3 jstree-default" style="min-height: 300px" role="tree" aria-activedescendant="j3_57"><ul class="jstree-container-ul jstree-children jstree-no-icons"><li role="treeitem" name="MetadataInfo" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_1" class="jstree-node required jstree-open" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">元数据信息</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="mdID" id="j3_2" class="jstree-node display-hide jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">元数据标识符<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="mdID" title="元数据标识符：元数据的唯一标识符"></div></div></div></a></li><li role="treeitem" name="mdReleasability" id="j3_3" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">元数据可见范围<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm required" valuetype="text" name="mdReleasability" title="元数据可见范围"></textarea></div></div></div></a></li><li role="treeitem" name="mdClsfi" id="j3_4" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">元数据密级<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="mdClsfi" class="form-control input-sm required"><option value="NAN" selected="">--请选择--</option><option value="绝密">绝密</option><option value="机密">机密</option><option value="秘密">秘密</option><option value="限制级">限制级</option><option value="公开级">公开级</option><option value="内部">内部</option></select></div></div></div></a></li><li role="treeitem" name="MdCont" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_5" class="jstree-node  jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">元数据维护方</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="rpOrgName" id="j3_6" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">单位<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="rpOrgName" title="单位：单位名称"></div></div></div></a></li><li role="treeitem" name="addr" id="j3_7" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">地址</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="addr" title="地址：单位的物理联系地址"></textarea></div></div></div></a></li><li role="treeitem" name="eMailAddr" id="j3_8" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电子邮件</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="eMailAddr" title="电子邮件：联系人的电子邮件地址"></div></div></div></a></li><li role="treeitem" name="telNum" id="j3_9" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电话号码</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="telNum" title="电话号码：联系人的电话号码"></div></div></div></a></li><li role="treeitem" name="contName" id="j3_10" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">联系人姓名</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="contName" title="联系人姓名：联系人的姓名"></div></div></div></a></li></ul></li><li role="treeitem" name="mdDateUpd" id="j3_11" class="jstree-node  jstree-leaf jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">元数据更新日期</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input class="form-control form-control-inline input-sm date-picker" name="mdDateUpd" size="16" type="text" value=""></div></div></div></a></li></ul></li><li role="treeitem" name="BasicInfo" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_12" class="jstree-node required jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">数据资源基础描述信息</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="resTitle" id="j3_13" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源名称<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="resTitle" title="数据资源名称：缩略描述空军装备论证数据资源内容的标题" value="asda" readonly=""></div></div></div></a></li><li role="treeitem" name="resID" id="j3_14" class="jstree-node display-hide jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源标识符<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="resID" title="数据资源标识符：空军装备论证数据资源的唯一不变的标识编码"></div></div></div></a></li><li role="treeitem" name="abstract" id="j3_15" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源摘要<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm required" valuetype="text" name="abstract" title="数据资源摘要：对数据资源内容进行概要说明的文字"></textarea></div></div></div></a></li><li role="treeitem" name="resType" id="j3_16" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源类型<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="resType" class="form-control input-sm required"><option value="NAN" selected="">--请选择--</option><option value="数据库">数据库</option><option value="数据服务">数据服务</option><option value="利益共同体（COI）">利益共同体（COI）</option></select></div></div></div></a></li><li role="treeitem" name="DesptKeys" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_17" class="jstree-node required jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">关键字说明</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="keyword" id="j3_18" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">关键字<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="keyword" title="关键字：用于概括空军装备论证数据资源主要内容的通用词、形式化词或短语"></div></div></div></a></li><li role="treeitem" name="theName" id="j3_19" class="jstree-node  jstree-leaf jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">词典名称</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="theName" title="词典名称：关键字所属的专业关键字词典的名称"></div></div></div></a></li></ul></li><li role="treeitem" name="releasAbility" id="j3_20" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源可见范围<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm required" valuetype="text" name="releasAbility" title="数据资源可见范围"></textarea></div></div></div></a></li><li role="treeitem" name="secClassfication" id="j3_21" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源密级<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="secClassfication" class="form-control input-sm required"><option value="NAN" selected="">--请选择--</option><option value="绝密">绝密</option><option value="机密">机密</option><option value="秘密">秘密</option><option value="限制级">限制级</option><option value="公开级">公开级</option><option value="内部">内部</option></select></div></div></div></a></li><li role="treeitem" name="ResCategory" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_22" class="jstree-node required jstree-open jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><div style="float:right;margin-top: 5px"><a href="#" class="copy" count="1"><i class="fa fa-plus-square"></i></a></div><span style="font-size:14px;font-weight:bold">数据资源分类</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="ctgryStdd" id="j3_23" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">分类方式<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="ctgryStdd" class="form-control input-sm required"><option value="NAN" selected="">--请选择--</option><option value="主题分类">主题分类</option><option value="机构分类">机构分类</option><option value="业务分类">业务分类</option><option value="资源类型分类">资源类型分类</option></select></div></div></div></a></li><li role="treeitem" name="ctgryName" id="j3_24" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">类目名称<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="ctgryName" title="类目名称：给出对应某种武器装备论证评估数据资源分类方式中某个具体类目"></div></div></div></a></li><li role="treeitem" name="categoryCode" id="j3_25" class="jstree-node  jstree-leaf jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">类目编码<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="categoryCode" title="类目编码：类目名称对应的编码"></div></div></div></a></li></ul></li></ul></li><li role="treeitem" name="ContentInfo" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_26" class="jstree-node  jstree-open" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">数据资源内容信息</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="pubDate" id="j3_27" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源发布日期</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input class="form-control form-control-inline input-sm date-picker" name="pubDate" size="16" type="text" value=""></div></div></div></a></li><li role="treeitem" name="PvdOfContact" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_28" class="jstree-node required jstree-open"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">数据资源提供方</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="rpOrgName" id="j3_29" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">单位<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="rpOrgName" title="单位：单位名称"></div></div></div></a></li><li role="treeitem" name="addr" id="j3_30" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">地址</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="addr" title="地址：单位的物理联系地址"></textarea></div></div></div></a></li><li role="treeitem" name="eMailAddr" id="j3_31" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电子邮件</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="eMailAddr" title="电子邮件：联系人的电子邮件地址"></div></div></div></a></li><li role="treeitem" name="telNum" id="j3_32" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电话号码</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="telNum" title="电话号码：联系人的电话号码"></div></div></div></a></li><li role="treeitem" name="contName" id="j3_33" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">联系人姓名</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="contName" title="联系人姓名：联系人的姓名"></div></div></div></a></li></ul></li><li role="treeitem" name="obtways" id="j3_34" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据来源分类</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="obtways" class="form-control input-sm"><option value="NAN" selected="">--请选择--</option><option value="试验数据">试验数据</option><option value="论证预测">论证预测</option><option value="真实数据">真实数据</option><option value="实测数据">实测数据</option><option value="预报数据">预报数据</option><option value="生产厂家数据">生产厂家数据</option><option value="文件采集数据">文件采集数据</option><option value="网络收集数据">网络收集数据</option><option value="渠道收集数据">渠道收集数据</option><option value="外文翻译数据">外文翻译数据</option><option value="官方发布数据">官方发布数据</option><option value="其它">其它</option></select></div></div></div></a></li><li role="treeitem" name="dataExmp" id="j3_35" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据示例</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="dataExmp" title="数据示例：数据示例"></div></div></div></a></li><li role="treeitem" name="updtDate" id="j3_36" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据资源更新时间</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input class="form-control form-control-inline input-sm date-picker" name="updtDate" size="16" type="text" value=""></div></div></div></a></li><li role="treeitem" name="updtFrequency" id="j3_37" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">维护与更新频率<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="updtFrequency" class="form-control input-sm required"><option value="NAN" selected="">--请选择--</option><option value="连续">连续</option><option value="按日">按日</option><option value="按周">按周</option><option value="按两周">按两周</option><option value="按月">按月</option><option value="按季">按季</option><option value="按半年">按半年</option><option value="按年">按年</option><option value="按需要">按需要</option><option value="不固定">不固定</option><option value="无计划">无计划</option><option value="未知">未知</option></select></div></div></div></a></li><li role="treeitem" name="updtScopeDescpt" id="j3_38" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">更新范围说明</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="updtScopeDescpt" title="更新范围说明：数据资源内容更新范围的说明"></textarea></div></div></div></a></li><li role="treeitem" name="numRecords" id="j3_39" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">记录数</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="numRecords" title="记录数：数据资源的记录数，以主记录为准"></div></div></div></a></li><li role="treeitem" name="memSize" id="j3_40" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">存储量</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="memSize" title="存储量：数据资源占用的存储空间"></div></div></div></a></li><li role="treeitem" name="tempRange" id="j3_41" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据时间范围</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="tempRange" title="数据时间范围：数据覆盖的时间范围"></textarea></div></div></div></a></li><li role="treeitem" name="geoName" id="j3_42" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据地理范围</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="geoName" title="数据地理范围：数据覆盖的地理范围"></textarea></div></div></div></a></li><li role="treeitem" name="structInfo" id="j3_43" class="jstree-node  jstree-leaf jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div style="float:right;margin-top: 5px"><a href="#" class="copy" count="1"><i class="fa fa-plus-square"></i></a></div><div class="form-group"><label class="control-label col-md-3">结构描述信息</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="structInfo" title="结构描述信息：数据资源中数据项的名称或定义"></textarea></div></div></div></a></li></ul></li><li role="treeitem" name="QualityInfo" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_44" class="jstree-node  jstree-open" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">数据资源质量信息</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="qualityDesc" id="j3_45" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据质量描述</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="qualityDesc" title="数据质量描述：数据的质量说明"></textarea></div></div></div></a></li><li role="treeitem" name="quality" id="j3_46" class="jstree-node  jstree-leaf jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">质量控制方法</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="quality" title="质量控制方法：数据的质量控制方法"></textarea></div></div></div></a></li></ul></li><li role="treeitem" name="DistributeInfo" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_47" class="jstree-node  jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">数据资源分发信息</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="onlLink" id="j3_48" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">在线数据资源链接地址</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="onlLink" title="在线数据资源链接地址：可以获取空军装备论证数据资源的网络地址"></div></div></div></a></li><li role="treeitem" name="dataFormat" id="j3_49" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">数据格式</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="dataFormat" title="数据格式：数据分发所使用的数据格式"></div></div></div></a></li><li role="treeitem" name="sendWay" id="j3_50" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">分发方式</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><select name="sendWay" class="form-control input-sm"><option value="NAN" selected="">--请选择--</option><option value="在线直接下载">在线直接下载</option><option value="在线审批离线传递">在线审批离线传递</option><option value="在线审批在线下载">在线审批在线下载</option><option value="离线审批离线传递">离线审批离线传递</option></select></div></div></div></a></li><li role="treeitem" name="rtState" id="j3_51" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">授权声明</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="rtState" title="授权声明：对数据分发对象的授权声明，如可任意分发、限制分发或者禁止分发"></textarea></div></div></div></a></li><li role="treeitem" name="Contact" data-jstree="{ &quot;opened&quot; : true }" aria-expanded="true" id="j3_52" class="jstree-node required jstree-open jstree-last"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor" href="#"><i class="jstree-icon jstree-themeicon"></i><span style="font-size:14px;font-weight:bold">分发人联系方式</span><span class="required" style="color: #e02222">*</span></a><ul role="group" class="jstree-children"><li role="treeitem" name="rpOrgName" id="j3_53" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">单位<span class="required" style="color: #e02222">*</span></label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm required" name="rpOrgName" title="单位：单位名称"></div></div></div></a></li><li role="treeitem" name="addr" id="j3_54" class="jstree-node  jstree-leaf"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">地址</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><textarea type="text" class="form-control input-sm" valuetype="text" name="addr" title="地址：单位的物理联系地址"></textarea></div></div></div></a></li><li role="treeitem" name="eMailAddr" id="j3_55" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电子邮件</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="eMailAddr" title="电子邮件：联系人的电子邮件地址"></div></div></div></a></li><li role="treeitem" name="telNum" id="j3_56" class="jstree-node  jstree-leaf" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">电话号码</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="telNum" title="电话号码：联系人的电话号码"></div></div></div></a></li><li role="treeitem" name="contName" id="j3_57" class="jstree-node  jstree-leaf jstree-last" aria-selected="false"><i class="jstree-icon jstree-ocl"></i><a class="jstree-anchor"><i class="jstree-icon jstree-themeicon"></i><div class="form-group"><label class="control-label col-md-3">联系人姓名</label><div class="col-md-8"><div class="input-icon right"><i class="fa"></i><input type="text" class="form-control input-sm" name="contName" title="联系人姓名：联系人的姓名"></div></div></div></a></li></ul></li></ul></li></ul></div>

                                            <!-- xiajl20171109 元数据模块基础信息相关 -->



                                            <!-- xiajl20171109 元数据模块基础信息相关 -->
                                            <div class="row" style="padding-top:20px;">
                                                <div>
                                                    <div class="col-md-12">
                                                        <div class="checker" id="uniform-isTemplate"><span><input type="checkbox" id="isTemplate" name="isTemplate"></span></div>创建模板
                                                    </div>
                                                </div>
                                                <div id="divTemplate" style="display:none;">
                                                    <div class="form-group row">
                                                        <label class="control-label col-md-3" style="text-align: right; ">模板名称
                                                        </label>
                                                        <div class="col-md-6">
                                                            <input type="text" class="form-control" name="templateName" id="templateName">
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <label class="control-label col-md-3" style="text-align: right;">模板备注
                                                        </label>
                                                        <div class="col-md-6">
                                                            <textarea type="text" class="form-control" name="memo" id="memo" rows="3"></textarea>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <a href="javascript:;" class="btn default button-previous disabled" style="display: none;">
                                        <i class="m-icon-swapleft"></i> 上一步 </a>
                                    <a href="javascript:;" class="btn blue button-next" style="display: inline-block;">
                                        下一步 <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                    <a href="javascript:;" class="btn green button-submit" style="display: none;">
                                        提交 <i class="m-icon-swapup m-icon-white"></i>
                                    </a>
                                    <div class="col-md-offset-3 col-md-3 " style="float: right">
                                        <button class="btn green button-save" disabled="disabled">
                                            保存当前页数据
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
