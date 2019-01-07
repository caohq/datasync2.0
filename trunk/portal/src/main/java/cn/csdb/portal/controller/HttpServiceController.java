package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataTask;
import cn.csdb.portal.model.Site;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.ConfigPropertyService;
import cn.csdb.portal.service.DataTaskService;
import cn.csdb.portal.service.SubjectMgmtService;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.ZipUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-12 10:15
 **/
@Controller
@RequestMapping("/service")
public class HttpServiceController {

    @Autowired
    private DataTaskService dataTaskService;

    @Autowired
    private SubjectMgmtService subjectMgmtService;

    @Autowired
    private ConfigPropertyService configPropertyService;

    @ResponseBody
    @RequestMapping(value = "getDataTask", method = {RequestMethod.POST, RequestMethod.GET})
    public int getDataTask(@RequestBody String requestString) {
        System.out.println(requestString);
        JSONObject requestJson = JSON.parseObject(requestString);
        String subjectCode = requestJson.get("subjectCode").toString();
        String dataTaskString = requestJson.get("dataTask").toString();
        DataTask dataTask = JSON.parseObject(dataTaskString, DataTask.class);
        Subject subject = subjectMgmtService.findByCode(subjectCode);
        String siteFtpPath = subject.getFtpFilePath();
        dataTask.setSubjectCode(subject.getSubjectCode());
        String sqlFilePath = dataTask.getSqlFilePath();
        sqlFilePath = sqlFilePath.replaceAll("%_%", File.separator);
        System.out.println("sqlFilePath========" + sqlFilePath);
        String[] sqlfilePathList = sqlFilePath.split(";");
        String filepath = dataTask.getFilePath();
        StringBuffer sqlfilePathBuffer = new StringBuffer();
        String structDBFile = "";
        String dataDBFile = "";
        String zipFile = "";
        String unZipPath = "";
        for (String fp : sqlfilePathList) {
            if (fp.equals("")) {
                continue;
            }
            String fileName = "";
            if (fp.indexOf("/") > 0) {
                fileName = fp.substring(fp.lastIndexOf("/") + 1);
            } else if (fp.indexOf("\\") > 0) {
                fileName = fp.substring(fp.lastIndexOf("\\") + 1);
            }
            sqlfilePathBuffer.append(siteFtpPath + fileName + ";");
            if (dataTask.getDataTaskType().equals("mysql")) {
                String sqlZip = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() +"_sql"+ File.separator + dataTask.getDataTaskId() + ".zip";
//                System.out.println("-------sqlZip"+sqlZip);
                File sqlfiles = new File(sqlZip);
                ZipUtil zipUtil = new ZipUtil();
                try {
                    zipUtil.unZip(sqlfiles, siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId()+"_sql");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                dataDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "data.sql";
                structDBFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + "_sql" + File.separator + "struct.sql";
                System.out.println("dataDBFile---------" + dataDBFile);
                System.out.println("structDBFile---------" + structDBFile);
            } else if (dataTask.getDataTaskType().equals("file")) {
                zipFile = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId() + ".zip";
                System.out.println("+++++++++" + zipFile);
//                System.out.println("=========="+fileName);
                unZipPath = siteFtpPath + subjectCode + "_" + dataTask.getDataTaskId();

            }
        }
        dataTask.setSqlFilePath(sqlfilePathBuffer.toString());
        if (dataTask.getDataTaskType().equals("mysql")) {
            String username = configPropertyService.getProperty("db.username");
            String password = configPropertyService.getProperty("db.password");
            String dbName = subject.getDbName();

            SqlUtil sqlUtil = new SqlUtil();
            try {
                System.out.println("passwprd------" + password);
                sqlUtil.importSql("localhost", username, password, dbName, structDBFile, dataDBFile);
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
            File file = new File(zipFile);
            ZipUtil zipUtil = new ZipUtil();
            try {
                zipUtil.unZip(file, unZipPath);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        dataTask.setDataTaskId(null);
        dataTaskService.insertDataTask(dataTask);
        return 1;


    }
}
