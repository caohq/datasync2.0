package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.service.ConfigPropertyService;
import cn.csdb.drsr.service.DataSrcService;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.service.LoginService;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.FtpUtil;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.CookieSpecs;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.*;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-09 15:59
 **/
@Controller
public class DataSyncController {

    @Resource
    private DataTaskService dataTaskService;
    @Resource
    private DataSrcService dataSrcService;

    private Logger logger = LoggerFactory.getLogger(DataSyncController.class);



    /**
     *
     * Function Description: 数据任务文件上传到中心端
     *
     * @param: [dataTaskId, processId]
     * @return: java.lang.String
     * @auther: hw
     * @date: 2018/10/26 10:12
     */
    @ResponseBody
    @RequestMapping("/ftpUpload")
    public int ftpUpload(String dataTaskId, String processId){
        DataTask dataTask = dataTaskService.get(String.valueOf(dataTaskId));
        String fileName = dataTask.getDataTaskName()+"log.txt";//文件名及类型
        String path = "/logs/";
        FileWriter fw = null;
        File file = new File(path, fileName);
        if(!file.exists()){
            try {
                file.createNewFile();
                fw = new FileWriter(file, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            try{
                fw = new FileWriter(file, true);
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================上传流程开始========================" + "\n");
        if("file".equals(dataTask.getDataTaskType())){
            pw.println("###########上传的文件为###########" + "\n");
            String[] fileAttr = dataTask.getFilePath().split(";");
            for(String fileAttrName : fileAttr){
                pw.println(fileAttrName+ "\n");
            }
        }
        dataTaskService.insertLog(dataTask.getDataTaskId(),"true");
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        String host = ConfigUtil.getConfigItem(configFilePath, "FtpHost");
        String userName = ConfigUtil.getConfigItem(configFilePath, "FtpUser");
        String password = ConfigUtil.getConfigItem(configFilePath, "FtpPassword");
        String port = ConfigUtil.getConfigItem(configFilePath, "FrpPort");
        String ftpRootPath = ConfigUtil.getConfigItem(configFilePath, "FtpRootPath");
        String portalUrl = ConfigUtil.getConfigItem(configFilePath, "PortalUrl");
        FtpUtil ftpUtil = new FtpUtil();
/*
        DataTask dataTask = dataTaskService.get(dataTaskId);
*/
        pw.println("数据任务名称为：" + dataTask.getDataTaskName() +"\n");
        try {
            ftpUtil.connect(host, Integer.parseInt(port), userName, password);
            String result = "";
            if(dataTask.getDataTaskType().equals("file")){
                String[] localFileList = {dataTask.getSqlFilePath()};
                result = ftpUtil.upload(localFileList, processId,ftpRootPath,dataTask,subjectCode).toString();
                if(result.equals("File_Exits")){
                    ftpUtil.removeDirectory(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId());
                    ftpUtil.deleteFile(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+".zip");
                    result = ftpUtil.upload(localFileList, processId,ftpRootPath,dataTask,subjectCode).toString();
                }
                if(localFileList.length == 0){
                    now = new Date();
                    dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String current1 = dateFormat.format(now);
                    pw.println(current1+":"+"上传失败"+ "\n");
                    dataTask.setStatus("0");
                    dataTaskService.update(dataTask);
                    return 0;
                }
            }else if(dataTask.getDataTaskType().equals("mysql")){
                String remoteFilepath = ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+"_sql/";
                String[] localFileList = {dataTask.getFilePath()};
                result = ftpUtil.upload(localFileList, processId,remoteFilepath,dataTask,subjectCode+"_sql").toString();
                if(result.equals("File_Exits")){
//                    有时候会因为同一个ftp连接在删除文件后无法创建目录，所以此处重新建立连接ftp
                    ftpUtil.disconnect();
                    ftpUtil.connect(host, Integer.parseInt(port), userName, password);
                    ftpUtil.removeDirectory(ftpRootPath+subjectCode+"_"+dataTask.getDataTaskId()+"_sql");
                    result = ftpUtil.upload(localFileList, processId,remoteFilepath,dataTask,subjectCode).toString();
                }
                if(localFileList.length == 0){
                    now = new Date();
                    dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                    String current1 = dateFormat.format(now);
                    pw.println(current1+":"+"上传失败"+ "\n");
                    dataTask.setStatus("0");
                    dataTaskService.update(dataTask);
                    return 0;
                }
            }
            pw.println("ftpDataTaskId"+dataTask.getDataTaskId()+"上传状态:" + result + "\n");
            ftpUtil.disconnect();
            if(result.equals("Upload_New_File_Success")||result.equals("Upload_From_Break_Succes")){
                String dataTaskString = JSONObject.toJSONString(dataTask);
                JSONObject requestJSON = new JSONObject();
                requestJSON.put("dataTask",dataTaskString);
                requestJSON.put("subjectCode",subjectCode);
                String requestString = JSONObject.toJSONString(requestJSON);
                HttpClient httpClient = null;
                HttpPost postMethod = null;
                HttpResponse response = null;
                try {
                    if("mysql".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"=========================导入流程开始========================" + "\n");
                    }
                    if("file".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"=========================解压流程开始========================" + "\n");
                    }
                    httpClient = HttpClients.createDefault();
//                    postMethod = new HttpPost("http://localhost:8080/portal/service/getDataTask");
                    postMethod = new HttpPost("http://"+portalUrl+"/service/getDataTask");
//                    postMethod = new HttpPost(portalUrl);
                    postMethod.addHeader("Content-type", "application/json; charset=utf-8");
//                    postMethod.addHeader("X-Authorization", "AAAA");//设置请求头
                    postMethod.setEntity(new StringEntity(requestString, Charset.forName("UTF-8")));
                    response = httpClient.execute(postMethod);//获取响应
                    int statusCode = response.getStatusLine().getStatusCode();
                    System.out.println("HTTP Status Code:" + statusCode);
                    if (statusCode != HttpStatus.SC_OK) {
                        System.out.println("HTTP请求未成功！HTTP Status Code:" + response.getStatusLine());
                    }
                    HttpEntity httpEntity = response.getEntity();
                    String reponseContent = EntityUtils.toString(httpEntity);
                    EntityUtils.consume(httpEntity);//释放资源
                    System.out.println("响应内容：" + reponseContent);
                    if(reponseContent.equals("1")){
                        if("mysql".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"导入成功"+ "\n");
                            pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                        }
                        if("file".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"解压成功"+ "\n");
                            pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                        }
                        dataTask.setStatus("1");
                        dataTaskService.update(dataTask);
                        return 1;
                    }else{
                        if("mysql".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"导入失败"+ "\n");
                            pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                        }
                        if("file".equals(dataTask.getDataTaskType())){
                            now = new Date();
                            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                            String current1 = dateFormat.format(now);
                            pw.println(current1+":"+"解压失败"+ "\n");
                            pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                        }
                        dataTask.setStatus("0");
                        dataTaskService.update(dataTask);
                        return 0;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    if("mysql".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"导入失败"+ e+"\n");
                        pw.println(current1+":"+"=========================导入流程结束========================" + "\n");
                    }
                    if("file".equals(dataTask.getDataTaskType())){
                        now = new Date();
                        dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
                        String current1 = dateFormat.format(now);
                        pw.println(current1+":"+"解压失败"+ e+"\n");
                        pw.println(current1+":"+"=========================解压流程结束========================" + "\n");
                    }
                }
            }else{
                dataTask.setStatus("0");
                dataTaskService.update(dataTask);
                return 0;
            }
        } catch (IOException e) {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            current = dateFormat.format(now);
            pw.println(current+":"+"连接FTP出错:"+e+ "\n");
            System.out.println("连接FTP出错：" + e.getMessage());
            dataTask.setStatus("0");
            dataTaskService.update(dataTask);
            return 0;
        }finally {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+"=========================上传流程结束========================" + "\r\n"+"\n\n\n\n\n");
            try {
                fw.flush();
                pw.close();
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return 1;
    }

    @ResponseBody
    @RequestMapping("ftpUploadProcess")
    public Long ftpUploadProcess(String processId){
        FtpUtil ftpUtil =new FtpUtil();
        Long process =  ftpUtil.getFtpUploadProcess(processId);
        return process;
    }

}
