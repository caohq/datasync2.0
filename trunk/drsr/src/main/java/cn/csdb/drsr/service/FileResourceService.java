package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.FileResourceDao;
import cn.csdb.drsr.repository.RelationDao;
import cn.csdb.drsr.utils.ConfigUtil;
import cn.csdb.drsr.utils.ZipUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import com.google.common.io.Files;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Matcher;

/**
 * @program: DataSync
 * @description: DataTask Service
 * @author: shibaoping
 * @create: 2018-10-09 16:29
 **/

@Service
public class FileResourceService {

    private Logger logger = LoggerFactory.getLogger(FileResourceService.class);

    @Resource
    private FileResourceDao fileResourceDao;

    @Transactional
    public String addData(DataSrc datasrc) {
        try {
            int addedRowCnt = fileResourceDao.addRelationData(datasrc);
            if (addedRowCnt == 1) {
                return "1";
            } else {
                return "0";
            }
        } catch (Exception e) {
            return "0";
        }
    }

    public List<DataSrc> queryData() {

        return fileResourceDao.queryRelationData();

    }

    public String editData(DataSrc dataSrc) {
        try {
            int addedRowCnt = fileResourceDao.editRelationData(dataSrc);
            if (addedRowCnt == 1) {
                return "1";
            } else {
                return "0";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "0";
        }
    }

    @Transactional
    public String deleteRelation(int id) {
        int deletedRowCnt = fileResourceDao.deleteRelationData(id);
        if (deletedRowCnt == 1) {
            return "1";
        } else {
            return "0";
        }
    }

    public List<DataSrc> editQueryData(int id) {
        return fileResourceDao.editQueryData(id);
    }

    public Map queryTotalPage(String SubjectCode) {
        return fileResourceDao.queryTotalPage(SubjectCode);
    }

    public List<DataSrc> queryPage(int requestedPage,String SubjectCode) {
        return fileResourceDao.queryPage(requestedPage,SubjectCode);
    }

    public List<JSONObject> fileTreeLoading(String data,String filePath) {
        String FILE_SEPARATOR = System.getProperties().getProperty("file.separator");
        File file;
        data = data.replaceAll("%_%",Matcher.quoteReplacement(File.separator));
        filePath = filePath.replaceAll("%_%",Matcher.quoteReplacement(File.separator));
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>();
        if ("#".equals(data)) {
            /*//获取服务器盘符
            String os = System.getProperty("os.name");
            if(os.toLowerCase().startsWith("win")){
                File[] roots = File.listRoots();
                logger.info("服务器盘符为："+roots);
                logger.info("子目录个数为："+roots.length);
                for (int i =0; i < roots.length; i++) {
                    String root = roots[i].toString();
                    String rootName= root.substring(0, root.indexOf("\\"));
                    JSONObject jsonObject = new JSONObject();
                    if (roots[i].isDirectory()) {
                        File file1 = roots[i];
                        File[] rootNode = file1.listFiles();
                        if (rootNode != null) {
                            if (rootNode.length == 0) {
                                jsonObject.put("children", false);
                            } else {
                                jsonObject.put("children", true);
                            }
                        } else {
                            jsonObject.put("children", false);
                        }
                        jsonObject.put("type", "directory");
                        JSONObject jo = new JSONObject();
                        jo.put("disabled", "true");
                        jsonObject.put("state", jo);
                        jsonObject.put("id", root.replaceAll("\\\\", "%_%"));
                        jsonObject.put("name", rootName);
                    } else {
                        jsonObject.put("type", "file");
                        jsonObject.put("id", root.replaceAll("\\\\", "%_%"));
                        jsonObject.put("name", rootName);
                    }
                    jsonObjects.add(jsonObject);
                }
            }else{*/
                File roots = new File(filePath);
                logger.info("服务器盘符为："+roots);
                String root = roots.toString();
                logger.info("root为："+root);
/*
                String rootName= root.substring(0, root.indexOf("\\"));
*/
/*
                logger.info("rootName为："+rootName);
*/
                JSONObject jsonObject = new JSONObject();
                JSONObject jsonObject1 = new JSONObject();
                jsonObject1.put("opened",true);
                jsonObject.put("sta",jsonObject1);
                if (roots.isDirectory()) {
                    File file1 = roots;
                    File[] rootNode = file1.listFiles();
                    if (rootNode != null) {
                        if (rootNode.length == 0) {
                            jsonObject.put("children", false);
                        } else {
                            jsonObject.put("children", true);
                        }
                    } else {
                        jsonObject.put("children", false);
                    }
                    jsonObject.put("type", "directory");
                    JSONObject jo = new JSONObject();
                    jo.put("disabled", "true");
                    jsonObject.put("state", jo);
                    jsonObject.put("id", root.replaceAll(Matcher.quoteReplacement(File.separator), "%_%"));
                    jsonObject.put("name", root);
                } else {
                    jsonObject.put("type", "file");
                    jsonObject.put("id", root.replaceAll(Matcher.quoteReplacement(File.separator), "%_%"));
                    jsonObject.put("name", root);
                }
                jsonObjects.add(jsonObject);
                return jsonObjects;
        } else {
            file = new File(data);
            if (!file.exists() || !file.isDirectory()) {
                return jsonObjects;
            } else {
                File[] fileList = file.listFiles();
                for (int i = 0; i < fileList.length; i++) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("id", fileList[i].getPath().replaceAll(Matcher.quoteReplacement(File.separator), "%_%"));
                    jsonObject.put("name", fileList[i].getName().replaceAll(Matcher.quoteReplacement(File.separator), "%_%"));
                    if (fileList[i].isDirectory()) {
                        File file1 = fileList[i];
                        File[] fileNode = file1.listFiles();
                        if (fileNode != null) {
                            if (fileNode.length == 0) {
                                jsonObject.put("children", false);
                            } else {
                                jsonObject.put("children", true);
                            }
                        } else {
                            jsonObject.put("children", false);
                        }
                        jsonObject.put("type", "directory");
                        JSONObject jo = new JSONObject();
                        jo.put("disabled", "true");
                        jsonObject.put("state", jo);
                    } else {
                        jsonObject.put("type", "file");
                    }
                    jsonObjects.add(jsonObject);
                }
                return jsonObjects;

            }
        }

/*
        Collections.sort(jsonObjects, new FileComparator());
*/
    }

    public String traversingFiles(String nodeId) {
        File file = new File(nodeId);
        StringBuffer Sb = new StringBuffer();
        if (file.isDirectory()) {
            File[] fileNode = file.listFiles();
            if (fileNode != null) {
                if (fileNode.length == 0) {
                    String str1 = file.getPath() + ";";
                    Sb.append(str1);
                } else {
                    for (int i = 0; i < fileNode.length; i++) {
                        Sb.append(traversingFiles(fileNode[i].getPath()));
                    }
                }
            } else {
                String str2 = file.getPath() + ";";
                Sb.append(str2);
            }
        } else {
            String str3 = file.getPath() + ";";
            Sb.append(str3);
        }

        System.out.print("Service层中记录的文件路径为：" + Sb.toString());
        return Sb.toString();
    }

    //求两个字符串数组的并集，利用set的元素唯一性
    public static String[] union(String[] arr1, String[] arr2) {
        Set<String> set = new HashSet<String>();
        for (String str : arr1) {
            set.add(str);
        }
        for (String str : arr2) {
            set.add(str);
        }
        String[] result = {};
        return set.toArray(result);
    }

    public Boolean checkFilePath(String filePath){
        File file = new File(filePath);
        boolean flag = file.exists();
        return flag;
    }
    /**
     * Function Description:
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/23 10:01
     */
    public List<DataSrc> findAll(String subjectCode) {

        return fileResourceDao.findAll(subjectCode);
    }

    public List<JSONObject> fileSourceFileList(String filePath) {
        return fileResourceDao.fileSourceFileList(filePath);
    }

    public DataSrc findById(int id) {
        return fileResourceDao.findById(id);
    }

    private static final ExecutorService executor = Executors.newFixedThreadPool(4);

    /**
     *
     * Function Description: 压缩文件任务包含的文件
     *
     * @param: [datasrcId, filePaths, dbFlag]
     * @return: void
     * @auther: hw
     * @date: 2018/10/23 16:11
     */
    public String packDataResource(final String fileName , final List<String> filePaths, DataTask datatask) {
        String fileName1 = datatask.getDataTaskName()+"log.txt";//文件名及类型
        String path = "/logs/";
        FileWriter fw = null;
        File file1 = new File(path, fileName1);
        if(!file1.exists()){
            try {
                file1.createNewFile();
                fw = new FileWriter(file1, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            try{
                fw = new FileWriter(file1, true);
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================打包流程开始========================" + "\n");
//        dbFlag.await();
        String zipFilePath = "zipFile";
        File dir  = new File(System.getProperty("drsr.framework.root") + zipFilePath );
        if(!dir.exists()){
            dir.mkdirs();
        }
        String zipFile = System.getProperty("drsr.framework.root") + zipFilePath + File.separator + fileName + ".zip";
        ZipArchiveOutputStream outputStream = null;
        try {
            if (new File(zipFile).exists()) {
                new File(zipFile).delete();
            }
            Files.createParentDirs(new File(zipFile));
            outputStream = new ZipArchiveOutputStream(new File(zipFile));
            outputStream.setEncoding("utf-8"); //23412
            outputStream.setCreateUnicodeExtraFields(ZipArchiveOutputStream.UnicodeExtraFieldPolicy.ALWAYS);
            outputStream.setFallbackToUTF8(true);
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+".zip:文件数据源,开始打包文件..." + "\n");
            for (String filePath : filePaths) {
                filePath = filePath.replace("%_%",File.separator);
                File file = new File(filePath);
                if (!file.exists()) {
                    continue;
                }
                ZipUtils.zipDirectory(file, "", outputStream);
            }
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"打包成功" + "\n");
        } catch (Exception e) {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"打包失败"+ e+"\n");
            return "error";
        } finally {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+"=========================打包流程结束========================" + "\n");
            try {
                fw.flush();
                pw.close();
                fw.close();
                outputStream.finish();
                outputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "ok";
    }

}








