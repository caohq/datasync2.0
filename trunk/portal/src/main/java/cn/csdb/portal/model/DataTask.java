package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

/**
 * @program: DataSync
 * @author: huangwei
 * @create: 2018-10-12 15:37
 **/
@Document(collection = "t_datatask")
public class DataTask {
    @Id
    private String dataTaskId;
    @Field("dataSourceId")
    private int dataSourceId;
    @Field("subjectCode")
    private String subjectCode;
    @Field("dataTaskType")
    private String dataTaskType;
    @Field("tableName")
    private String tableName;
    @Field("sqlString")
    private String sqlString;
    @Field("sqlTableNameEn")
    private String sqlTableNameEn;
    @Field("sqlFilePath")
    private String sqlFilePath;
    @Field("filePath")
    private String filePath;
    @Field("createTime")
    private Date createTime;
    @Field("creator")
    private String creator;
    @Field("status")
    private String status;


    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getDataTaskType() {
        return dataTaskType;
    }

    public void setDataTaskType(String dataTaskType) {
        this.dataTaskType = dataTaskType;
    }

    public String getDataTaskId() {
        return dataTaskId;
    }

    public void setDataTaskId(String dataTaskId) {
        this.dataTaskId = dataTaskId;
    }

    public int getDataSourceId() {
        return dataSourceId;
    }

    public void setDataSourceId(int dataSourceId) {
        this.dataSourceId = dataSourceId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getSqlString() {
        return sqlString;
    }

    public void setSqlString(String sqlString) {
        this.sqlString = sqlString;
    }

    public String getSqlTableNameEn() {
        return sqlTableNameEn;
    }

    public void setSqlTableNameEn(String sqlTableNameEn) {
        this.sqlTableNameEn = sqlTableNameEn;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSqlFilePath() {
        return sqlFilePath;
    }

    public void setSqlFilePath(String sqlFilePath) {
        this.sqlFilePath = sqlFilePath;
    }
}
