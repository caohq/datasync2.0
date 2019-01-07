package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.*;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.PropertiesUtil;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.omg.CORBA.DATA_CONVERSION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.text.FieldPosition;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.regex.Matcher;


/**
 * @program: DataSync
 * @description: 数据任务执行处理控制器
 * @author: xiajl
 * @create: 2018-10-10 10:12
 **/
@Controller
@RequestMapping("/datatask")
public class DataTaskController {
    @Resource
    private DataTaskService dataTaskService;
    @Resource
    private FileResourceService fileResourceService;
    @Resource
    private DataSrcService dataSrcService;

    private static final FieldPosition HELPER_POSITION = new FieldPosition(0);


    /**
     * Function Description:执行一个数据任务，导出SQL文件后返回执行状态
     *
     * @param:  id: 任务Id
     * @return: 执行结果JsonObject
     * @auther: xiajl
     * @date:   2018/10/18 13:36
     */
    @ResponseBody
    @RequestMapping(value="/{id}")
    public JSONObject executeTask(@PathVariable("id") String id){
        JSONObject jsonObject = new JSONObject();
        DataTask dataTask = dataTaskService.get(id);
        jsonObject = dataTaskService.executeTask(dataTask);
        dataTaskService.packDataResource(jsonObject.get("filePath").toString()+File.separator+dataTask.getDataTaskId()+".zip",Arrays.asList(dataTask.getSqlFilePath().split(";")),dataTask);
        String fp = jsonObject.get("filePath").toString()+File.separator+dataTask.getDataTaskId()+".zip";
        dataTask.setFilePath(fp.replace(File.separator,"%_%"));
        dataTaskService.update(dataTask);
        return jsonObject;
    }


    /**
     * Function Description: 获取所有的任务列表信息
     *
     * @param:
     * @return: Json 字符串
     * @auther: xiajl
     * @date:   2018/10/18 13:45
     */
    @ResponseBody
    @RequestMapping(value="/getAll")
    public JSONObject getAll(){
        JSONObject jsonObject = new JSONObject();
        List<DataTask> list = dataTaskService.getAllData();
        jsonObject.put("data",list);
        return jsonObject;
    }


    /**
     *
     * Function Description: 数据任务页面跳转
     *
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @auther: hw
     * @date: 2018/10/23 14:56
     */
    @RequestMapping("/")
    public ModelAndView datatask() {
        ModelAndView modelAndView = new ModelAndView("datatask");
        return modelAndView;
    }

    /**
     *
     * Function Description: 数据任务展示、查询列表
     *
     * @param: [pageNo, pageSize, datataskType, status]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/24 10:37
     */
    @RequestMapping(value="/list")
    @ResponseBody
    public JSONObject datataskList(@RequestParam(name = "pageNo", defaultValue = "1", required = false) int pageNo,
                                   @RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
                                   @RequestParam(name = "datataskType", required = false) String datataskType,
                                   @RequestParam(name = "status", required = false) String status){
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        JSONObject jsonObject = new JSONObject();
        List<DataTask> dataTasks = dataTaskService.getDatataskByPage((pageNo-1)*pageSize,pageSize,datataskType,status, subjectCode);
        int totalCount = dataTaskService.getCount(datataskType,status,subjectCode);
        jsonObject.put("dataTasks",dataTasks);
        jsonObject.put("totalCount",totalCount);
        jsonObject.put("pageNum",totalCount%pageSize==0?totalCount/pageSize:totalCount/pageSize+1);
        jsonObject.put("pageSize",pageSize);
        return jsonObject;
    }

    /**
     *
     * Function Description:
     *
     * @param: [id]
     * @return: int >0 删除成功 否则失败
     * @auther: hw
     * @date: 2018/10/24 10:47
     */
    @RequestMapping(value="/delete")
    @ResponseBody
    public int deleteDatatask(String datataskId){
        return dataTaskService.deleteDatataskById(datataskId);
    }

    /**
     *
     * Function Description: 查看数据任务信息
     *
     * @param: [id]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/24 10:54
     */
    @RequestMapping(value="detail")
    @ResponseBody
    public JSONObject datataskDetail(String datataskId){
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = dataTaskService.get(datataskId);
        DataSrc dataSrc = dataSrcService.findById(datatask.getDataSourceId());
        jsonObject.put("datatask",datatask);
        jsonObject.put("dataSrc",dataSrc);
        return jsonObject;
    }

    /**
     *
     * Function Description:关系型数据任务保存
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value="saveRelationDatatask",method = RequestMethod.POST)
    public JSONObject saveRelationDatatask(int dataSourceId,
                                           String datataskName,
                                           String dataRelTableList,
                                           String sqlTableNameEnList,
                                           @RequestParam(name = "dataRelSqlList", required = false)String dataRelSqlList) {
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = new DataTask();
        datatask.setDataSourceId(dataSourceId);
        datatask.setDataTaskName(datataskName);
        datatask.setTableName(dataRelTableList);
        datatask.setSqlString(dataRelSqlList);
        datatask.setSqlTableNameEn(sqlTableNameEnList);
        datatask.setCreateTime(new Date());
        datatask.setDataTaskType("mysql");
        datatask.setStatus("0");
        datatask.setSubjectCode(subjectCode);
        /*Calendar rightNow = Calendar.getInstance();
        StringBuffer sb = new StringBuffer();
        Format dateFormat = new SimpleDateFormat("MMddHHmmssS");
        dateFormat.format(rightNow.getTime(), sb, HELPER_POSITION );*/
        datatask.setDataTaskId(datataskName);
        int flag = dataTaskService.insertDatatask(datatask);
        jsonObject.put("result",flag);
        if(flag < 0){
            return  jsonObject;
        }
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value="saveFileDatatask",method = RequestMethod.POST)
    public JSONObject saveFileDatatask(int dataSourceId, String datataskName,String[] nodes){
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = new DataTask();
        datatask.setDataSourceId(dataSourceId);
        StringBuffer filePath = new StringBuffer("");
        String str1 = "";
        for (String nodeId : nodes){
            String str = nodeId.replaceAll("%_%", Matcher.quoteReplacement(File.separator));
            File file = new File(str);
            if(file.isDirectory()) {
                str1 = fileResourceService.traversingFiles(str);
            }else{
                str1 = str + ";";
            }
            if(filePath.indexOf(str+";")!=-1){

            }else{
                filePath.append(str1);
            }
        }
        datatask.setFilePath(filePath.toString());
        datatask.setDataTaskName(datataskName);
        datatask.setCreateTime(new Date());
        datatask.setDataTaskType("file");
        datatask.setStatus("0");
        datatask.setSubjectCode(subjectCode);
        /*Calendar rightNow = Calendar.getInstance();
        StringBuffer sb = new StringBuffer();
        Format dateFormat = new SimpleDateFormat("MMddHHmmssS");
        dateFormat.format(rightNow.getTime(), sb, HELPER_POSITION );
        String datataskId = sb.toString();*/
        datatask.setDataTaskId(datataskName);
        dataTaskService.insertDatatask(datatask);
        if(dataSourceId <0 ){
            jsonObject.put("result",false);
            return  jsonObject;
        }
        List<String> filepaths = Arrays.asList(filePath.toString().split(";"));

        String fileName = subjectCode+"_"+datataskName;
        fileResourceService.packDataResource(fileName,filepaths,datatask);
        String zipFile = System.getProperty("drsr.framework.root") + "zipFile" + File.separator + fileName + ".zip";
        DataTask dt = dataTaskService.get(datataskName);
        dt.setSqlFilePath(zipFile.replace(File.separator,"%_%"));
        int upresult = dataTaskService.update(dt);
        jsonObject.put("result",true);
        return  jsonObject;
    }

    /**
     *
     * Function Description: sql语句校验
     *
     * @param: [sqlStr, dataSourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/27 14:14
     */
    @RequestMapping(value = "sqlValidation", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject validateSql(@RequestParam("sqlStr") String sqlStr, @RequestParam("dataSourceId") int dataSourceId) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", dataSrcService.validateSql(sqlStr, dataSourceId));
        return jsonObject;
    }

    /**
     *
     * Function Description: 判断是否包含datataskname
     *
     * @param: [datataskName]
     * @return: boolean
     * @auther: hw
     * @date: 2018/11/27 14:51
     */
    @ResponseBody
    @RequestMapping("hasDatataskName")
    public boolean hasDatataskName(String datataskName,
                                   @RequestParam(value = "datataskId", defaultValue = "", required = false)String datataskId){
        return dataTaskService.hasDatataskName(datataskName,datataskId);
    }

    /**
     *
     * Function Description: datatask编辑页面跳转
     *
     * @param: [datataskId]
     * @return: org.springframework.web.servlet.ModelAndView
     * @auther: hw
     * @date: 2018/11/27 15:14
     */
    @RequestMapping(value = "editDatatask")
    public ModelAndView editDatatask(String datataskId) {
        ModelAndView mv = new ModelAndView("editDatatask");
        mv.addObject("datataskId",datataskId);
        return mv;
    }

    /**
     *
     * Function Description: 编辑页面通过id获得datatask信息
     *
     * @param: [datataskId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/27 15:26
     */
    @ResponseBody
    @RequestMapping("")
    public JSONObject getDatataskById(String datataskId){
        JSONObject jsonObject = new JSONObject();
        DataTask dataTask = dataTaskService.get(datataskId);
        jsonObject.put("datatask",dataTask);
        return jsonObject;
    }


    @ResponseBody
    @RequestMapping(value="updateRelationDatatask",method = RequestMethod.POST)
    public JSONObject updateRelationDatatask(String datataskId,
                                             int dataSourceId,
                                             String datataskName,
                                             String dataRelTableList,
                                             String sqlTableNameEnList,
                                             @RequestParam(name = "dataRelSqlList", required = false)String dataRelSqlList) {
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = dataTaskService.get(datataskId);
        datatask.setDataSourceId(dataSourceId);
        datatask.setDataTaskName(datataskName);
        datatask.setTableName(dataRelTableList);
        datatask.setSqlString(dataRelSqlList);
        datatask.setSqlTableNameEn(sqlTableNameEnList);
        datatask.setCreateTime(new Date());
        datatask.setDataTaskType("mysql");
        datatask.setStatus("0");
        datatask.setSubjectCode(subjectCode);
        datatask.setCreateTime(new Date());
        int flag = dataTaskService.update(datatask);
        jsonObject.put("result",flag);
        if(flag < 0){
            return  jsonObject;
        }
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value="updateFileDatatask",method = RequestMethod.POST)
    public JSONObject updateFileDatatask(String datataskId,int dataSourceId, String datataskName,String[] nodes,String[] attr){
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = dataTaskService.get(datataskId);
        datatask.setDataSourceId(dataSourceId);
        String filePath = "";
        if(nodes!=null) {
            if(attr!=null) {
                String nodePath = "";
                for (String nodeId : nodes) {
                    String str = nodeId.replaceAll("%_%", Matcher.quoteReplacement(File.separator));
                    String str1 = fileResourceService.traversingFiles(str);
                    nodePath += str1;
                }
                for(String attrs : attr){
                    attrs.replaceAll("\\\\", Matcher.quoteReplacement(File.separator));
                    attrs.replaceAll("/", Matcher.quoteReplacement(File.separator));
                }
                String[] traversingNodes = nodePath.split(";");
                String[] unionNodes = FileResourceService.union(attr, traversingNodes);
                for (String unionNode : unionNodes) {
                    filePath += unionNode + ";";
/*
                    filePath += unionNode.replaceAll("/", "\\\\") + ";";
*/
                }
                datatask.setFilePath(filePath.toString());
            }else{
                StringBuffer filePathBuffer = new StringBuffer("");
                String str1 = "";
                for (String nodeId : nodes){
                    String str = nodeId.replaceAll("%_%", Matcher.quoteReplacement(File.separator));
                    File file = new File(str);
                    if(file.isDirectory()) {
                        str1 = fileResourceService.traversingFiles(str);
                    }else{
                        str1 = str + ";";
                    }
                    if(filePathBuffer.indexOf(str+";")!=-1){

                    }else{
                        filePathBuffer.append(str1);
                    }
                }
                filePath = filePathBuffer.toString();
                datatask.setFilePath(filePathBuffer.toString());
            }
        }else{
            for (String unionNode : attr) {
                filePath += unionNode.replaceAll("\\\\", Matcher.quoteReplacement(File.separator)) + ";";
            }
            datatask.setFilePath(filePath);
        }
        datatask.setDataTaskName(datataskName);
        datatask.setCreateTime(new Date());
        datatask.setDataTaskType("file");
        datatask.setStatus("0");
        datatask.setCreateTime(new Date());
        datatask.setSubjectCode(subjectCode);
        Calendar rightNow = Calendar.getInstance();
        dataTaskService.update(datatask);
        if(dataSourceId <0 ){
            jsonObject.put("result",false);
            return  jsonObject;
        }
        List<String> filepaths = Arrays.asList(filePath.toString().split(";"));

        String fileName = subjectCode+"_"+datataskId;
        fileResourceService.packDataResource(fileName,filepaths,datatask);
        String zipFile = System.getProperty("drsr.framework.root") + "zipFile" + File.separator + fileName + ".zip";
        DataTask dt = dataTaskService.get(datataskId);
        dt.setSqlFilePath(zipFile.replace(File.separator,"%_%"));
        int upresult = dataTaskService.update(dt);
        jsonObject.put("result",true);
        return  jsonObject;
    }

}
