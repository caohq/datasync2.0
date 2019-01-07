package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;


@Document(collection = "t_resCatalog")
public class ResCatalog_Mongo {

    @Id
    private String objectId;
    @Field("rid")
    private Integer rid;
    @Field("parentid")
    private Integer parentid;
    @Field("name")
    private String name;
    @Field("level")
    private Integer level;
    @Field("nodeorder")
    private Integer nodeorder;
    @Field("updatetime")
    private Date updatetime;
    @Field("createtime")
    private Date createtime;

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Integer getNodeorder() {
        return nodeorder;
    }

    public void setNodeorder(Integer nodeorder) {
        this.nodeorder = nodeorder;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}
