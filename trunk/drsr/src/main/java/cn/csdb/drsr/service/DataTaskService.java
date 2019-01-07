package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataSrcDao;
import cn.csdb.drsr.repository.DataTaskDao;
import cn.csdb.drsr.utils.ZipUtils;
import cn.csdb.drsr.utils.dataSrc.DDL2SQLUtils;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import com.google.common.io.Files;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.*;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * @program: DataSync
 * @description: DataTask Service
 * @author: xiajl
 * @create: 2018-09-30 16:29
 **/

@Service
public class DataTaskService {
    @Resource
    private DataTaskDao dataTaskDao;

    @Resource
    private DataSrcDao dataSrcDao;

//    @Value("#{prop['SqlFilePath']}")
//    private String sqlFilePath;

    private Logger logger = LoggerFactory.getLogger(DataTaskService.class);

    @Transactional(readOnly = true)
    public DataTask get(String dataTaskId) {
        return dataTaskDao.get(dataTaskId);
    }


    public JSONObject executeTask(DataTask dataTask) {
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
            try {
                fw = new FileWriter(file, true);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        PrintWriter pw = new PrintWriter(fw);
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
        String current = dateFormat.format(now);
        pw.println(current+":"+"=========================导出流程开始========================");
        dataTaskDao.insertLogPath(dataTask.getDataTaskId(),"true");
/*
        logger.info("=========================导出流程开始========================" + "\n");
*/
        JSONObject jsonObject = new JSONObject();
        try {
            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
            Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(),
                    dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());

            //导出表结构
            String tableName = dataTask.getTableName();
            //20181008可能有多个表,用","连接: t_metastruct,t_conceptword
            String[] tables = tableName.split(";");

            String sqlString = dataTask.getSqlString();
            if (StringUtils.isNoneBlank(sqlString)) {
                sqlString = sqlString.substring(0, sqlString.length() - 1);
            }
            String sqlTableNameEn = dataTask.getSqlTableNameEn();
            if (StringUtils.isNoneBlank(sqlTableNameEn)) {
                sqlTableNameEn = sqlTableNameEn.substring(0, sqlTableNameEn.length() - 1);
            }
            StringBuilder sqlSb = new StringBuilder();
            StringBuilder dataSb = new StringBuilder();
            for (String table : tables) {
                if (StringUtils.isNotEmpty(table)) {
                    sqlSb.append(DDL2SQLUtils.generateDDLFromTable(connection, null, null, table));
                    dataSb.append(DDL2SQLUtils.generateInsertSqlFromTable(connection, null, null, table));
                    dataSb.append("\n");
                }
            }

            //xiajl20181130修改 (多条sql语句,多个表名)
            String[] sqlArray = sqlString.split(";");
            String[] sqlTableArray = sqlTableNameEn.split(";");
            for (int i=0;i<sqlArray.length;i++){
                if (StringUtils.isNotEmpty(sqlArray[i]) && StringUtils.isNotEmpty(sqlTableArray[i])) {
                    sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection, sqlArray[i], sqlTableArray[i]));
                    dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection, sqlArray[i], sqlTableArray[i]));
                }
            }
            //if (StringUtils.isNotEmpty(sqlString) && StringUtils.isNotEmpty(sqlTableNameEn)) {
            //    sqlSb.append(DDL2SQLUtils.generateDDLFromSql(connection, sqlString, sqlTableNameEn));
            //    dataSb.append(DDL2SQLUtils.generateInsertSqlFromSQL(connection, sqlString, sqlTableNameEn));
            //}
            pw.println("###########SQL数据表结构:###########\n" + sqlSb.toString() + "\n");
            pw.println("###########SQL数据内容:###########\n" + dataSb.toString() + "\n");
            logger.info("=========================SQL数据表结构:========================\n" + sqlSb.toString() + "\n");
            logger.info("=========================SQL数据内容:==========================\n" + dataSb.toString() + "\n");

            File sqlFilePath  = new File(System.getProperty("drsr.framework.root")+"exportSql");
            if(!sqlFilePath.exists()){
                sqlFilePath.mkdirs();
            }
            File filePath = new File(sqlFilePath + File.separator + dataTask.getDataTaskId());

            if (!filePath.exists() || !filePath.isDirectory()) {
                filePath.mkdirs();
            }
            DDL2SQLUtils.generateFile(filePath.getPath(), "struct.sql", sqlSb.toString());

            //导出表数据
            DDL2SQLUtils.generateFile(filePath.getPath(), "data.sql", dataSb.toString());

            //保存 sql文件路径到datatask表中的sqlfilePath路径中，用分号隔开
            String sqlFilePathStr = filePath.getPath() + File.separator + "struct.sql;" + filePath.getPath() + File.separator + "data.sql";
            dataTask.setSqlFilePath(sqlFilePathStr.replace(File.separator,"%_%"));
            boolean result = dataTaskDao.update(dataTask);
            jsonObject.put("result", "true");
            jsonObject.put("filePath", filePath.getPath());
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            current = dateFormat.format(now);
            pw.println("导出成功，result = " + result+ "\n");
            logger.info("导出成功，result = " + result+ "\n");
            pw.println(current+":"+"=========================导出流程结束========================" + "\n");
            logger.info("=========================导出流程结束========================" + "\n");
        } catch (Exception ex) {
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            current = dateFormat.format(now);
            jsonObject.put("result", "false");
            logger.error(current+":"+"导出失败，result = false" + "\n");
            pw.println(current+":"+"=========================导出流程结束========================" + "\n");
            logger.info("=========================导出流程结束========================" + "\n");
        }finally {
            try {
                fw.flush();
                pw.close();
                fw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return jsonObject;
    }

    @Transactional
    public int update(DataTask dataTask) {
        boolean flag =  dataTaskDao.update(dataTask);
        if(flag == true){
            return 1;
        }else{
            return -1;
        }
    }

    @Transactional(readOnly = true)
    public List<DataTask> getAllData() {
        return dataTaskDao.getAll();
    }

    public List<DataTask> getDatataskByPage(int start, int pageSize, String datataskType, String status,String subjectCode) {

        List<DataTask> dataTasks = dataTaskDao.getDatataskByPage(start, pageSize, datataskType, status, subjectCode);
        for (DataTask dataTask : dataTasks) {
            DataSrc dataSrc = dataSrcDao.findById(dataTask.getDataSourceId());
            dataTask.setDataSrc(dataSrc);
        }
        return dataTasks;
    }

    public int getCount(String datataskType, String status,String subjectCode) {
        return dataTaskDao.getCount(datataskType, status,subjectCode);
    }

    public int deleteDatataskById(String datataskId) {
        return dataTaskDao.deleteDatataskById(datataskId);
    }

    public int insertDatatask(DataTask datatask) {


        return dataTaskDao.insertDatatask(datatask);
    }

    public String packDataResource(final String fileName ,final List<String> filePaths,DataTask dataTask) {
//        dbFlag.await();
//        String zipFilePath = "zipFile";
//        File dir  = new File(System.getProperty("drsr.framework.root") + zipFilePath );
//        if(!dir.exists()){
//            dir.mkdirs();
//        }
//        String zipFile = System.getProperty("drsr.framework.root") + zipFilePath + File.separator + fileName + ".zip";
        String fileName1 = dataTask.getDataTaskName()+"log.txt";//文件名及类型
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
        ZipArchiveOutputStream outputStream = null;
        try {
//            if (new File(dirName).exists()) {
//                new File(dirName).delete();
//            }
            Files.createParentDirs(new File(fileName));
            outputStream = new ZipArchiveOutputStream(new File(fileName));
            outputStream.setEncoding("utf-8"); //23412
            outputStream.setCreateUnicodeExtraFields(ZipArchiveOutputStream.UnicodeExtraFieldPolicy.ALWAYS);
            outputStream.setFallbackToUTF8(true);
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current = dateFormat.format(now);
            pw.println(current+":"+"=========================打包流程开始========================" + "\n");
            now = new Date();
            dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current2 = dateFormat.format(now);
            pw.println(current2+":"+".zip:文件数据源,开始打包文件...\"+ \"\n");
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
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+"打包成功" + "\n");
        } catch (Exception e) {
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+"打包失败"+ e+"\n");
            return "error";
        } finally {
            Date now = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//可以方便地修改日期格式
            String current1 = dateFormat.format(now);
            pw.println(current1+":"+"=========================打包流程结束========================" + "\n");
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

    public boolean hasDatataskName(String datataskName,String datataskId){
        return dataTaskDao.hasDatataskName(datataskName,datataskId);
    }

    //将文件或者sql路径插入日志字段中
    public void insertLog(String dataTaskId,String path){
        try {
            int flag = dataTaskDao.insertLogPath(dataTaskId,path);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
