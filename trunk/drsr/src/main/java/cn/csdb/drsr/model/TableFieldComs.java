package cn.csdb.drsr.model;

import java.util.Date;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-24 16:11
 **/
public class TableFieldComs {

    private int id;
    private String uriEx; //数据库访问地址+数据库+表明
    private int uriHash;//访问地址hash，方便查找匹配
    private String fieldComs; //注解
    private Date createTime;
    private Date updateTime;
    private int status; //状态 0有效

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUriEx() {
        return uriEx;
    }

    public void setUriEx(String uriEx) {
        this.uriEx = uriEx;
    }

    public int getUriHash() {
        return uriHash;
    }

    public void setUriHash(int uriHash) {
        this.uriHash = uriHash;
    }

    public String getFieldComs() {
        return fieldComs;
    }

    public void setFieldComs(String fieldComs) {
        this.fieldComs = fieldComs;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
