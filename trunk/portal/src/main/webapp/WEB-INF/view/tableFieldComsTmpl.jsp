<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24 0024
  Time: 下午 4:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/html" id="editTableFieldComsTmpl">
    <div class="skin skin-minimal">
        <table class="table table-hover table-bordered">
            <thead>
            <tr>
                <th>字段名称</th>
                <th>注释</th>
            </tr>
            </thead>
            <tbody>
            {{each tableInfosList as tableInfos i }}
            {{each tableInfos.tableInfos as tableInfo i }}
            <tr>
                <td class="fieldComsKey" tableName="{{tableInfos.tableName}}" fieldName="{{tableInfo.columnName}}"
                    columnNameLabel="{{tableInfo.columnNameLabel}}"  dataType="{{tableInfo.dataType}}">
                    {{if tableInfo.columnNameLabel}}
                    {{tableInfo.columnNameLabel}}{{else}}{{tableInfo.columnName}}{{/if}}
                </td>
                <td>
                    <input type="text" class="form-control  input-sm fieldComsValue" style="width: 60%"
                           name="order_customer_name" value="{{tableInfo.columnComment}}">
                </td>
            </tr>
            {{/each}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>

<script type="text/html" id="previewTableDataAndComsTmpl">
    <div class="skin skin-minimal">
        <table class="table table-hover table-bordered">
            {{each datas as itemList i}}
            {{if i == 0}}
            <thead>
            <tr style="word-break: keep-all">
                <th>#</th>
                {{each itemList as item j}}
                <th>{{item.columnName}}
                    {{if item.columnComment}}
                    <br/>({{item.columnComment}})
                    {{/if}}
                </th>
                {{/each}}
            </tr>
            </thead>
            {{/if}}
            <tbody>
            {{if i != 0}}
            <tr>
                <td>{{i}}</td>
                {{each itemList as item j}}
                <td>{{item}}</td>
                {{/each}}
            </tr>
            {{/if}}
            {{/each}}
            </tbody>
        </table>
    </div>
</script>