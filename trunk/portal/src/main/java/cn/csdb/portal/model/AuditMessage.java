package cn.csdb.portal.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-11-22 10:52
 **/
@Document(collection = "t_auditMessage")
public class AuditMessage {
    @Id
    private String id;
    @Field("resourceId")
    private String resourceId;
    @Field("auditCom")
    private String auditCom;
    @Field("auditTime")
    private Date auditTime;
    @Field("auditPerson")
    private String auditPerson;

    public String getAuditPerson() {
        return auditPerson;
    }

    public void setAuditPerson(String auditPerson) {
        this.auditPerson = auditPerson;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }

    public String getAuditCom() {
        return auditCom;
    }

    public void setAuditCom(String auditCom) {
        this.auditCom = auditCom;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }
}
