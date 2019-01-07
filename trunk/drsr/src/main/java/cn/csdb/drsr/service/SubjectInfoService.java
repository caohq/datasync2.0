package cn.csdb.drsr.service;

import cn.csdb.drsr.model.Subject;
import cn.csdb.drsr.utils.ConfigUtil;
import org.springframework.stereotype.Service;
import sun.security.krb5.Config;

@Service
public class SubjectInfoService {
    public Subject getSubjectInfo()
    {
        Subject subject = new Subject();

        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        subject.setSubjectName(ConfigUtil.getConfigItem(configFilePath, "SubjectName"));
        subject.setSubjectCode(ConfigUtil.getConfigItem(configFilePath, "SubjectCode"));
        subject.setAdmin(ConfigUtil.getConfigItem(configFilePath, "Admin"));
        subject.setAdminPasswd(ConfigUtil.getConfigItem(configFilePath, "AdminPasswd"));
        subject.setContact(ConfigUtil.getConfigItem(configFilePath, "Contact"));
        subject.setPhone(ConfigUtil.getConfigItem(configFilePath, "Phone"));
        subject.setEmail(ConfigUtil.getConfigItem(configFilePath, "Email"));
        subject.setFtpUser(ConfigUtil.getConfigItem(configFilePath, "FtpUser"));
        subject.setFtpPassword(ConfigUtil.getConfigItem(configFilePath, "FtpPassword"));
        subject.setBrief(ConfigUtil.getConfigItem(configFilePath, "Brief"));
        return subject;

    }
}
