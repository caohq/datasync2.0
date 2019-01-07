package cn.csdb.portal.controller;

import cn.csdb.portal.model.AuditMessage;
import cn.csdb.portal.model.Group;
import cn.csdb.portal.model.ResCatalog_Mongo;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.*;
import cn.csdb.portal.utils.FileUploadUtil;
import cn.csdb.portal.utils.ImgCut;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.Array;
import java.sql.Connection;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @program: DataSync
 * @description: Resource Controller class
 * @author: xiajl
 * @create: 2018-10-23 16:32
 **/
@Controller
@RequestMapping("/resource")
public class ResourceController {
    @Resource
    private ResourceService resourceService;
    @Resource
    private ResCatalogService resCatalogService;
    @Resource
    private GroupService groupService;

    @Resource
    private SubjectService subjectService;
    @Resource
    private AuditMessageService auditMessageService;
    @Resource
    private DataSrcService dataSrcService;

    private Logger logger = LoggerFactory.getLogger(ResourceController.class);

    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model) {
        logger.info("进入资源列表页面");
        return "resource";
    }


    /**
     * Function Description: 取得资源分页数据
     *
     * @param:
     * @return: 资源列表
     * @auther: Administrator
     * @date: 2018/10/25 16:46
     */

    @ResponseBody
    @RequestMapping("/getPageData")
    public JSONObject getPageData(/*@RequestParam(value = "subjectCode", required = false) String subjectCode,*/
                                  @RequestParam(value = "title", required = false) String title,
                                  @RequestParam(value = "publicType", required = false) String publicType,
                                  @RequestParam(value = "status", required = false) String resState,
                                  @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
                                  @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                  HttpSession session) {
        String subjectCode = "";
        Set<String> roles = (HashSet<String>)(session.getAttribute("roles"));
        if(roles.contains("系统管理员")){
            subjectCode = "";
        }else{
            subjectCode = session.getAttribute("SubjectCode").toString();
            Subject subject = subjectService.findBySubjectCode(subjectCode);
        }
        List<cn.csdb.portal.model.Resource> list = resourceService.getListByPage(subjectCode, title, publicType, resState, pageNo, pageSize);
        long count = resourceService.countByPage(subjectCode, title, publicType, resState);
        JSONObject json = new JSONObject();
        json.put("resourceList", list);
        json.put("totalCount", count);
        json.put("currentPage", pageNo);
        json.put("pageSize", pageSize);
        json.put("totalPages", count % pageSize == 0 ? count / pageSize : count / pageSize + 1);
        return json;
    }


    /**
     * Function Description: 删除一条资源记录
     *
     * @param: id
     * @return: JSONObject
     * @auther: Administrator
     * @date: 2018/10/25 16:47
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject delete(@PathVariable("id") String id) {
        JSONObject jsonObject = new JSONObject();
        resourceService.delete(id);
        jsonObject.put("result", "ok");
        return jsonObject;
    }



    /*---------------------------------------------------------------------------------------------*/

    /**
     * Function Description: 资源注册页面跳转
     *
     * @param: []
     * @return: java.lang.String
     * @auther: hw
     * @date: 2018/11/1 9:48
     */
    @RequestMapping(value = "addResource")
    public String resourceAdd() {
        return "addResource";
    }

    @RequestMapping(value = "editResource")
    public ModelAndView resourceEdit(String resourceId) {
        ModelAndView mv = new ModelAndView("editResource");
        mv.addObject("resourceId",resourceId);
        return mv;
    }

    /**
     * Function Description: 获得mysql数据库表单
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 10:36
     */
    @ResponseBody
    @RequestMapping(value = "relationalDatabaseTableList")
    public JSONObject relationalDatabaseTableList(HttpSession session) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        IDataSource dataSource = DataSourceFactory.getDataSource("mysql");
        Connection connection = dataSource.getConnection(subject.getDbHost(), subject.getDbPort(),
                subject.getDbUserName(), subject.getDbPassword(), subject.getDbName());
        if (connection == null)
            return null;
        List<String> list = dataSource.getTableList(connection);
        jsonObject.put("list", list);
//        jsonObject.put("dataSourceName", dataSrc.getDataSourceName());
        return jsonObject;
    }

    /**
     * Function Description: 获得已经选择的数据库表list
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 13:55
     */
    @ResponseBody
    @RequestMapping(value = "getCheckedTables")
    public JSONObject getCheckedTables(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        String tableList = resource.getPublicContent();
        jsonObject.put("tableList", tableList);
        return jsonObject;
    }


    /**
     * Function Description: 获取砖题库文件列表
     *
     * @param: []
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/11/1 10:43
     */
    @ResponseBody
    @RequestMapping(value = "fileSourceFileList")
    public List<JSONObject> fileSourceFileList(HttpSession session) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        List<JSONObject> jsonObjects = resourceService.fileSourceFileListFirst(subject.getFtpFilePath());
        return jsonObjects;
    }

    /**
     * Function Description: 获得已经选择文件list
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:23
     */
    @ResponseBody
    @RequestMapping(value = "getCheckedFiles")
    public JSONObject getCheckedFiles(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        String fileList = resource.getFilePath();
        jsonObject.put("fileList", fileList);
        return jsonObject;
    }

    /**
     * Function Description: 获得文件树节点下的文件结构
     *
     * @param: [filePath]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/11/1 10:58
     */
    @ResponseBody
    @RequestMapping(value = "treeNode")
    public List<JSONObject> treeNode(String filePath) {
        List<JSONObject> jsonObjects = null;
        jsonObjects = resourceService.fileSourceFileList(filePath.replace("%_%", "\\"));
        return jsonObjects;
    }

    /**
     * Function Description: 获得文件树节点下第一层的文件结构
     *
     * @param: [filePath]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: shibaoping
     * @date: 2018/11/1 10:58
     */
    @ResponseBody
    @RequestMapping(value = "treeNodeFirst")
    public List<JSONObject> treeNodeFirst(String filePath) {
        List<JSONObject> jsonObjects = null;
        jsonObjects = resourceService.fileSourceFileListFirst(filePath.replace("%_%", "\\"));
        return jsonObjects;
    }

    /**
     * Function Description: 添加资源第一步保存
     *
     * @param: [title, imagePath, introduction, keyword, catalogId, createdByOrganization]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 15:46
     */
    @ResponseBody
    @RequestMapping(value = "addResourceFirstStep")
    public JSONObject saveResourceFirstStep(HttpSession session,
                                            @RequestParam(name = "title") String title,
                                            @RequestParam(name = "imagePath", required = false) String imagePath,
                                            @RequestParam(name = "introduction") String introduction,
                                            @RequestParam(name = "keyword") String keyword,
                                            @RequestParam(name = "catalogId") String catalogId,
                                            @RequestParam(name = "createdByOrganization") String createdByOrganization,
                                            @RequestParam(name = "startTime") String startTime,
                                            @RequestParam(name = "endTime") String endTime,
                                            @RequestParam(name = "email") String email,
                                            @RequestParam(name = "phoneNum") String phoneNum,
                                            @RequestParam(name = "createTime") String createTime,
                                            @RequestParam(name = "publishOrganization") String publishOrganization,
                                            @RequestParam(name = "createOrganization") String createOrganization,
                                            @RequestParam(name = "createPerson") String createPerson
    ) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = new cn.csdb.portal.model.Resource();
        resource.setTitle(title);
        resource.setImagePath(imagePath);
        resource.setIntroduction(introduction);
        resource.setKeyword(keyword);
        resource.setCatalogId(catalogId);
        resource.setCreatedByOrganization(createdByOrganization);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        ParsePosition pos1 = new ParsePosition(0);
        ParsePosition pos2 = new ParsePosition(0);
        ParsePosition pos3 = new ParsePosition(0);
        Date startDate = formatter.parse(startTime, pos1);
        Date endDate = formatter.parse(endTime, pos2);
        Date createDate = formatter.parse(createTime,pos3);
        resource.setStartTime(startDate);
        resource.setEndTime(endDate);
        resource.setCreateTime(createDate);
        resource.setEmail(email);
        resource.setPhoneNum(phoneNum);
        resource.setSubjectCode(subject.getSubjectCode());
//        resource.setResState("未完成");
        resource.setCreationDate(new Date());
        resource.setUpdateDate(new Date());
        resource.setPublishOrgnization(publishOrganization);
        resource.setCreateOrgnization(createOrganization);
        resource.setCreatePerson(createPerson);
        resource.setStatus("-1");
        String resourceId = resourceService.save(resource);
        jsonObject.put("resourceId", resourceId);
        return jsonObject;
    }


    /**
     * Function Description: 添加资源第二步保存
     *
     * @param: [resourceId, publicType, dataList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 10:45
     */
    @ResponseBody
    @RequestMapping(value = "addResourceSecondStep")
    public JSONObject addResourceSecondStep(HttpSession session,
                                            @RequestParam(name = "resourceId") String resourceId,
                                            @RequestParam(name = "publicType") String publicType,
                                            @RequestParam(name = "dataList") String dataList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        if (publicType.equals("mysql")) {
            resource.setPublicContent(dataList);
            resource.setToFilesNumber(0);
            resource.setPublicType("mysql");
            List<String> tableList = Arrays.asList(dataList.split(";"));
            int rowCount = resourceService.getRecordCount(subject.getDbHost(),subject.getDbPort(),subject.getDbUserName(),subject.getDbPassword(),subject.getDbName(),tableList);
            resource.setToRecordNumber(rowCount);
        } else if (publicType.equals("file")) {
            resource.setPublicType("file");
            StringBuffer sb = new StringBuffer();
            long size = 0L;
            if (StringUtils.isNoneBlank(dataList)) {
                String[] s = dataList.split(";");
                for (String str : s) {
                    str = str.replaceAll("%_%", "/");
                    File file = new File(str);
                    if (file.isDirectory()) {
                        Collection<File> files = FileUtils.listFiles(file, null, true);
                        for (File file1 : files) {
                            String fp = file1.getPath();
                            size += file1.length();
                            if (fp.indexOf("\\") > -1) {
                                fp = fp.replaceAll("\\\\", "/");
                            }
                            sb.append(fp + ";");
                        }
                    }else{
                        sb.append(str+";");
                        size += file.length();
                    }
                }
            }
            resource.setFilePath(sb.toString().replace("/", "%_%"));
            resource.setToMemorySize(String.valueOf(size));

        }
        if(StringUtils.isNotBlank(resource.getUserGroupId())){
            resource.setStatus("1");
        }else{
            resource.setStatus("-1");
        }
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }


    /**
     * Function Description: 添加资源第三步保存
     *
     * @param: [resourceId, userGroupIdList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 11:19
     */
    @ResponseBody
    @RequestMapping(value = "addResourceThirdStep")
    public JSONObject addResourceThirdStep(HttpSession session,
                                           @RequestParam(name = "resourceId") String resourceId,
                                           @RequestParam(name = "userGroupIdList") String userGroupIdList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setUserGroupId(userGroupIdList);
        resource.setStatus("1");
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     * Function Description: 通过id获得resource
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:26
     */
    @ResponseBody
    @RequestMapping(value = "getResourceById")
    public JSONObject getResourceById(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        jsonObject.put("resource",resource);
        return jsonObject;
    }

    /**
     *
     * Function Description: 编辑资源保存第一步
     *
     * @param: [resourceId, title, imagePath, introduction, keyword, catalogId, createdByOrganization]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:51
     */
    @ResponseBody
    @RequestMapping(value = "editResourceFirstStep")
    public JSONObject editResourceFirstStep(HttpSession session,
                                            @RequestParam(name = "resourceId") String resourceId,
                                            @RequestParam(name = "title") String title,
                                            @RequestParam(name = "imagePath", required = false) String imagePath,
                                            @RequestParam(name = "introduction") String introduction,
                                            @RequestParam(name = "keyword") String keyword,
                                            @RequestParam(name = "catalogId") String catalogId,
                                            @RequestParam(name = "createdByOrganization") String createdByOrganization,
                                            @RequestParam(name = "startTime") String startTime,
                                            @RequestParam(name = "endTime") String endTime,
                                            @RequestParam(name = "email") String email,
                                            @RequestParam(name = "phoneNum") String phoneNum,
                                            @RequestParam(name = "createTime") String createTime,
                                            @RequestParam(name = "publishOrganization") String publishOrganization,
                                            @RequestParam(name = "createOrganization") String createOrganization,
                                            @RequestParam(name = "createPerson") String createPerson) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setTitle(title);
        resource.setImagePath(imagePath);
        resource.setIntroduction(introduction);
        resource.setKeyword(keyword);
        resource.setCatalogId(catalogId);
        resource.setCreatedByOrganization(createdByOrganization);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        ParsePosition pos1 = new ParsePosition(0);
        ParsePosition pos2 = new ParsePosition(0);
        ParsePosition pos3 = new ParsePosition(0);
        Date startDate = formatter.parse(startTime, pos1);
        Date endDate = formatter.parse(endTime, pos2);
        Date createDate = formatter.parse(endTime, pos3);
        resource.setStartTime(startDate);
        resource.setEndTime(endDate);
        resource.setCreateTime(createDate);
        resource.setEmail(email);
        resource.setPhoneNum(phoneNum);
        resource.setSubjectCode(subject.getSubjectCode());
//        resource.setResState("未完成");
        resource.setUpdateDate(new Date());
        resource.setPublishOrgnization(publishOrganization);
        resource.setCreateOrgnization(createOrganization);
        resource.setCreatePerson(createPerson);
        if(StringUtils.isNotBlank(resource.getUserGroupId())){
            resource.setStatus("1");
        }else{
            resource.setStatus("-1");
        }

        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     *
     * Function Description: 编辑资源保存第二步
     *
     * @param: [resourceId, publicType, dataList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:52
     */
    @ResponseBody
    @RequestMapping(value = "editResourceSecondStep")
    public JSONObject editResourceSecondStep(HttpSession session,
                                             @RequestParam(name = "resourceId") String resourceId,
                                            @RequestParam(name = "publicType") String publicType,
                                            @RequestParam(name = "dataList") String dataList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        if (publicType.equals("mysql")) {
            resource.setPublicContent(dataList);
            resource.setToFilesNumber(0);
            resource.setPublicType("mysql");
            List<String> tableList = Arrays.asList(dataList.split(";"));
            int rowCount = resourceService.getRecordCount(subject.getDbHost(),subject.getDbPort(),subject.getDbUserName(),subject.getDbPassword(),subject.getDbName(),tableList);
        } else if (publicType.equals("file")) {
            resource.setPublicType("file");
            StringBuffer sb = new StringBuffer();
            long size = 0L;
            if (StringUtils.isNoneBlank(dataList)) {
                String[] s = dataList.split(";");
                for (String str : s) {
                    str = str.replaceAll("%_%", "/");
                    File file = new File(str);
                    if (file.isDirectory()) {
                        Collection<File> files = FileUtils.listFiles(file, null, true);
                        for (File file1 : files) {
                            String fp = file1.getPath();
                            size += file1.length();
                            if (fp.indexOf("\\") > -1) {
                                fp = fp.replaceAll("\\\\", "/");
                            }
                            sb.append(fp + ";");
                        }
                    }
                }
            }
            resource.setFilePath(sb.toString().replace("/", "%_%"));
            resource.setToMemorySize(String.valueOf(size));
        }
        if(StringUtils.isNotBlank(resource.getUserGroupId())){
            resource.setStatus("1");
        }else{
            resource.setStatus("-1");
        }
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     *
     * Function Description: 编辑资源保存第三步
     *
     * @param: [resourceId, userGroupIdList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:53
     */
    @ResponseBody
    @RequestMapping(value = "editResourceThirdStep")
    public JSONObject editResourceThirdStep(HttpSession session,
                                            @RequestParam(name = "resourceId") String resourceId,
                                           @RequestParam(name = "userGroupIdList") String userGroupIdList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setUserGroupId(userGroupIdList);
        resource.setStatus("1");
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }
    //截图并上传
    @RequestMapping(value = "/uploadHeadImage",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject uploadHeadImage(
            HttpServletRequest request,
            @RequestParam(value = "x") String x,
            @RequestParam(value = "y") String y,
            @RequestParam(value = "h") String h,
            @RequestParam(value = "w") String w,
            @RequestParam(value = "imgFile") MultipartFile imageFile
    ) throws Exception{
        System.out.println("==========Start=============");
        String saveName = "";
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String resourcePath = "resources"+File.separator+"img"+File.separator+"images"+File.separator;
        if(imageFile!=null){
            if(FileUploadUtil.allowUpload(imageFile.getContentType())){
                String fileName = FileUploadUtil.rename(imageFile.getOriginalFilename());
                int end = fileName.lastIndexOf(".");
                saveName = fileName.substring(0,end);
                File dir = new File(realPath + resourcePath);
                if(!dir.exists()){
                    dir.mkdirs();
                }
                File file = new File(dir,saveName+"_src.jpg");
                imageFile.transferTo(file);
                String srcImagePath = realPath + resourcePath + saveName;
                int imageX = Double.valueOf(x).intValue();
                int imageY = Double.valueOf(y).intValue();
                int imageH = Double.valueOf(h).intValue();
                int imageW = Double.valueOf(w).intValue();
                //这里开始截取操作
                System.out.println("==========imageCutStart=============");
                ImgCut.imgCut(srcImagePath,imageX,imageY,imageW,imageH);
                System.out.println("==========imageCutEnd=============");
                request.getSession().setAttribute("imgSrc",resourcePath + saveName+"_src.jpg");//成功之后显示用
                request.getSession().setAttribute("imgCut",resourcePath + saveName+"_cut.jpg");//成功之后显示用
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("saveName",saveName);
        return jsonObject;
    }

    /**
     *
     * Function Description: 查看资源
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/6 14:54
     */
    @ResponseBody
    @RequestMapping(value = "resourceDetail")
    public JSONObject resourceDetail(String resourceId){
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        ResCatalog_Mongo resCatalog_mongo = resCatalogService.getLocalResCatalogNodeById(resource.getCatalogId());
        jsonObject.put("resCatalog",resCatalog_mongo);
        jsonObject.put("resource",resource);
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value = "getUserGroups")
    public JSONObject getUserGroups() {
        JSONObject jsonObject = new JSONObject();
        List<Group> groupList = groupService.getAll();
        jsonObject.put("groupList",groupList);
        return jsonObject;
    }

    /**
     *
     * Function Description: 审核资源
     *
     * @param: [resourceId, status, auditContent]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 11:15
     */
    @ResponseBody
    @RequestMapping(value="audit")
    public JSONObject audit(HttpSession session,String resourceId,String status,String auditContent){
        String auditPerson = session.getAttribute("userName").toString();
        JSONObject jo = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setStatus(status);
        AuditMessage auditMessage = new AuditMessage();
        auditMessage.setAuditTime(new Date());
        auditMessage.setAuditCom(auditContent);
        auditMessage.setResourceId(resourceId);
        auditMessage.setAuditPerson(auditPerson);
        auditMessageService.save(auditMessage);
        String returnId = resourceService.save(resource);
        if(StringUtils.isNotBlank(resourceId)){
            jo.put("result","success");
        }else{
            jo.put("result","fail");
        }
        return jo;
    }

    /**
     *
     * Function Description: 资源审核信息列表
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 11:15
     */
    @ResponseBody
    @RequestMapping("getAuditMessage")
    public JSONObject getAuditMessage(String resourceId){
        JSONObject jo = new JSONObject();
        List<AuditMessage> auditMessageList = auditMessageService.getAuditMessageListByResourceId(resourceId);
        jo.put("auditMessageList",auditMessageList);
        return jo;
    }

    /**
     *
     * Function Description: 停用
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 14:27
     */
    @ResponseBody
    @RequestMapping("stopResource")
    public JSONObject stopResource(String resourceId){
        JSONObject jo = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setStatus("1");
        String newresourceId = resourceService.save(resource);
        if(StringUtils.isNotBlank(newresourceId)){
            jo.put("result","success");
        }else{
            jo.put("result","fail");
        }
        return jo;
    }

    @RequestMapping(value = "sqlValidation", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject validateSql(@RequestParam("sqlStr") String sqlStr, @RequestParam("dataSourceId") int dataSourceId) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", dataSrcService.validateSql(sqlStr, dataSourceId));
        return jsonObject;
    }




}
