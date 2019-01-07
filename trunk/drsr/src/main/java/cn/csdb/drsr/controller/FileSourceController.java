package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.service.FileResourceService;
import cn.csdb.drsr.service.LoginService;
import cn.csdb.drsr.utils.ConfigUtil;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;

/**
 * Created by shiba on 2018/10/8.
 */
@Controller
@RequestMapping("/fileResource")
public class FileSourceController {
    private Logger logger = LoggerFactory.getLogger(FileSourceController.class);
    @Resource
    private FileResourceService fileResourceService;
    @Resource
    private DataTaskService dataTaskService;

    @RequestMapping("/deleteData")
    public
    @ResponseBody
    String delete(String dataId) {
        logger.debug("进入删除功能");
        String flag = fileResourceService.deleteRelation(Integer.valueOf(dataId));
        return flag;
    }
    @RequestMapping("/add")
    public
    @ResponseBody
    String add(String dataSourceName, String dataSourceType, String fileType, String filePath) {
        logger.debug("新增功能开始");
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String SubjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        datasrc.setCreateTime(currentTime);
        datasrc.setFilePath(filePath.replace("%_%",File.separator));
        datasrc.setSubjectCode(SubjectCode);
        return fileResourceService.addData(datasrc);

    }
    @RequestMapping("/addTask")
    public
    @ResponseBody
    String add(String dataSourceName, String dataSourceType, String fileType, String[] data) {
        logger.debug("新增功能开始");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        datasrc.setCreateTime(currentTime);
        StringBuffer filePath = new StringBuffer("");
        for (String nodeId : data){
            String str = nodeId.replaceAll("%_%",Matcher.quoteReplacement(File.separator));
            String str1 = fileResourceService.traversingFiles(str);
            filePath.append(str1);
        }
        datasrc.setFilePath(filePath.toString());
        logger.info("最终拼接的filePath为{}"+filePath.toString());
        return fileResourceService.addData(datasrc);

    }

    @RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceId, String dataSourceName, String dataSourceType,
                String fileType,String filePath) {
        logger.debug("编辑功能开始,开始插入");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setCreateTime(currentTime);
        datasrc.setFileType(fileType);
        datasrc.setFilePath(filePath.replace("%_%",File.separator));
        datasrc.setDataSourceId(Integer.valueOf(dataSourceId));
        return fileResourceService.editData(datasrc);
    }
    /*@RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceId, String dataSourceName, String dataSourceType,
                String fileType, String[] attr,String[] nodes) {
        logger.debug("编辑功能开始,开始插入");
        Date current_date = new Date();
        //设置日期格式化样式为：yyyy-MM-dd
        SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //格式化当前日期
        String currentTime = SimpleDateFormat.format(current_date.getTime());
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setCreateTime(currentTime);
        datasrc.setFileType(fileType);
        if(nodes!=null) {
            if(attr!=null) {
                String nodePath = "";
                for (String nodeId : nodes) {
                    String str = nodeId.replaceAll("%_%", "/");
                    String str1 = fileResourceService.traversingFiles(str);
                    nodePath += str1;
                }
                String[] traversingNodes = nodePath.split(";");
                String[] unionNodes = FileResourceService.union(attr, traversingNodes);
                String filePath = "";
                for (String unionNode : unionNodes) {
                    filePath += unionNode.replaceAll("/", "\\\\") + ";";
                }
                datasrc.setFilePath(filePath);
            }else{
                String nodePath = "";
                for (String nodeId : nodes) {
                    String str = nodeId.replaceAll("%_%", "/");
                    String str1 = fileResourceService.traversingFiles(str);
                    nodePath += str1;
                }
                String[] traversingNodes = nodePath.split(";");
                String filePath = "";
                for (String traversingNode : traversingNodes) {
                    filePath += traversingNode.replaceAll("/", "\\\\") + ";";
                }
                datasrc.setFilePath(filePath);
            }
        }else{
            String filePath = "";
            for (String unionNode : attr) {
                filePath += unionNode.replaceAll("/", "\\\\") + ";";
            }
            datasrc.setFilePath(filePath);
        }
        datasrc.setDataSourceId(Integer.valueOf(dataSourceId));
        return fileResourceService.editData(datasrc);
    }*/
    @RequestMapping("/queryData")
    public
    @ResponseBody
    List<DataSrc> queryData(String dataId) {
        logger.debug("编辑功能开始,开始查询");
        List<DataSrc> editData = fileResourceService.editQueryData(Integer.valueOf(dataId));
        return editData;
    }

    @RequestMapping(value = "/index")
    public ModelAndView index() {
        logger.info("进入文件数据源模块列表页");
        ModelAndView mv = new ModelAndView("fileResource");
        return mv;
    }

    @RequestMapping(value = "/indexPages")
    public
    @ResponseBody
    JSONObject indexPages(Integer num){
        if(num==null){
            num = 1;
        }
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String SubjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        Map map = fileResourceService.queryTotalPage(SubjectCode);
        List<DataSrc> fileDataOfThisPage = fileResourceService.queryPage(num,SubjectCode);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("fileDataOfThisPage", fileDataOfThisPage);
        jsonObject.put("totalPage", map.get("totalPages"));
        jsonObject.put("totalNum", map.get("totalRows"));
        jsonObject.put("currentPage", num);
        return jsonObject;
    }

    @RequestMapping("/resCatalog")
    public
    @ResponseBody
    List<JSONObject> showResCatalog(String data,Integer dataSourceId) {

        logger.info("加载文件树");
        String filePath = fileSourceFileList(dataSourceId);
        List<JSONObject> jsonObjects = fileResourceService.fileTreeLoading(data,filePath);
        return jsonObjects;
    }

    @RequestMapping("/check")
    public
    @ResponseBody
    Boolean check(String filePath) {
        logger.info("校验文件路径是否正确");
        boolean flag  = fileResourceService.checkFilePath(filePath.replace("%_%", Matcher.quoteReplacement(File.separator)));
        return flag;
    }

    @RequestMapping(value="/downloadFile")
    public String downloads(String dataTaskId,HttpServletResponse response) throws Exception{
        DataTask dataTask = dataTaskService.get(dataTaskId);
/*
        String	path = "/logs/";
*/
        String path = "/logs/";
        String  fileName = dataTask.getDataTaskName()+"log.txt";
        //1、设置response 响应头
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition",
                "attachment;fileName="+ URLEncoder.encode(fileName, "UTF-8"));

        File file = new File(path,fileName);
        //2、 读取文件--输入流
        InputStream input=new FileInputStream(file);
        //3、 写出文件--输出流
        OutputStream out = response.getOutputStream();
        byte[] buff =new byte[1024];
        int index=0;
        //4、执行 写出操作
        while((index= input.read(buff))!= -1){
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();
        return null;
    }

    /**
     *
     * Function Description: 
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/23 10:34
     */
    @RequestMapping(value="findAllFileSrc")
    public @ResponseBody List<DataSrc> findAllFileSrc(){
        String configFilePath = LoginService.class.getClassLoader().getResource("config.properties").getFile();
        String subjectCode = ConfigUtil.getConfigItem(configFilePath, "SubjectCode");
        return fileResourceService.findAll(subjectCode);
    }

    /**
     *
     * Function Description: 
     *
     * @param: [dataSourceId]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/10/23 10:06
     */

    public String fileSourceFileList(int dataSourceId) {

        DataSrc dataSrc = fileResourceService.findById(dataSourceId);
        return dataSrc.getFilePath();
        /*List<JSONObject> jsonObjects = fileResourceService.fileSourceFileList(dataSrc.getFilePath());
        return jsonObjects;*/
    }

}
